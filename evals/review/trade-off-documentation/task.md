Review the following PR diff. Apply the /review skill — structured code review that captures context for future maintainers.

**PR title:** feat: Switch session store from Redis to signed cookies
**PR description:** Moves session storage from Redis to encrypted, signed cookies using iron-session. Removes the Redis dependency for the web tier. We hit Redis connection storms during last month's outage (see INC-4421) and decided the session data (user ID, role, preferences) is small enough for cookie storage. Trade-off: 4KB cookie size limit means we can't expand session data without migrating back.

```diff
diff --git a/src/lib/session.ts b/src/lib/session.ts
index 7f1a2b3..c4d5e6f 100644
--- a/src/lib/session.ts
+++ b/src/lib/session.ts
@@ -1,35 +1,44 @@
-import RedisStore from 'connect-redis';
-import { createClient } from 'redis';
-import session from 'express-session';
+import { getIronSession, IronSessionData } from 'iron-session';
+import { NextApiRequest, NextApiResponse } from 'next';

-const redisClient = createClient({
-  url: process.env.REDIS_URL,
-  socket: {
-    reconnectStrategy: (retries) => Math.min(retries * 100, 5000),
-  },
-});
+export const sessionOptions = {
+  password: process.env.SESSION_SECRET!,
+  cookieName: 'app_session',
+  cookieOptions: {
+    secure: process.env.NODE_ENV === 'production',
+    httpOnly: true,
+    sameSite: 'lax' as const,
+    maxAge: 60 * 60 * 24 * 7, // 7 days
+  },
+};

-redisClient.on('error', (err) => console.error('Redis session error:', err));
-redisClient.connect();
+declare module 'iron-session' {
+  interface IronSessionData {
+    userId?: string;
+    role?: 'user' | 'admin' | 'editor';
+    preferences?: Record<string, string>;
+  }
+}

-export const sessionMiddleware = session({
-  store: new RedisStore({ client: redisClient }),
-  secret: process.env.SESSION_SECRET!,
-  resave: false,
-  saveUninitialized: false,
-  cookie: {
-    secure: process.env.NODE_ENV === 'production',
-    httpOnly: true,
-    maxAge: 1000 * 60 * 60 * 24 * 7,
-  },
-});
+export async function getSession(req: NextApiRequest, res: NextApiResponse) {
+  return getIronSession<IronSessionData>(req, res, sessionOptions);
+}

-export function destroySession(req: Express.Request): Promise<void> {
-  return new Promise((resolve, reject) => {
-    req.session.destroy((err) => (err ? reject(err) : resolve()));
-  });
+export async function destroySession(req: NextApiRequest, res: NextApiResponse) {
+  const session = await getSession(req, res);
+  session.destroy();
 }

diff --git a/src/middleware/auth.ts b/src/middleware/auth.ts
index 2a3b4c5..d6e7f89 100644
--- a/src/middleware/auth.ts
+++ b/src/middleware/auth.ts
@@ -1,18 +1,15 @@
-import { Request, Response, NextFunction } from 'express';
+import { getSession } from '../lib/session';
+import { NextApiRequest, NextApiResponse } from 'next';

-export function requireAuth(req: Request, res: Response, next: NextFunction) {
-  if (!req.session?.userId) {
-    return res.status(401).json({ error: 'Authentication required' });
-  }
-  next();
+export async function requireAuth(req: NextApiRequest, res: NextApiResponse) {
+  const session = await getSession(req, res);
+  if (!session.userId) {
+    res.status(401).json({ error: 'Authentication required' });
+    return null;
+  }
+  return session;
 }

diff --git a/package.json b/package.json
index 1b2c3d4..e5f6a7b 100644
--- a/package.json
+++ b/package.json
@@ -12,8 +12,7 @@
     "dependencies": {
-    "connect-redis": "^7.1.0",
     "express-session": "^1.17.3",
+    "iron-session": "^6.3.1",
     "next": "^14.0.0",
-    "redis": "^4.6.0",
     "react": "^18.2.0"
   }
```
