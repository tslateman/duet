Review the following PR diff. Apply the /review skill — structured code review that captures context for future maintainers.

**PR title:** feat: Add user search endpoint
**PR description:** Adds a new `/api/users/search` endpoint so the admin dashboard can look up users by name or email.

```diff
diff --git a/src/routes/users.ts b/src/routes/users.ts
index 3a1f2c8..9b7e4d1 100644
--- a/src/routes/users.ts
+++ b/src/routes/users.ts
@@ -1,6 +1,7 @@
 import { Router } from 'express';
 import { db } from '../db';
 import { requireAuth } from '../middleware/auth';
+import { requireRole } from '../middleware/rbac';

 const router = Router();

@@ -24,4 +25,42 @@ router.get('/:id', requireAuth, async (req, res) => {
   }
 });

+router.get('/search', requireAuth, async (req, res) => {
+  const { q, field } = req.query;
+
+  if (!q || typeof q !== 'string') {
+    return res.status(400).json({ error: 'Missing search query' });
+  }
+
+  const searchField = field || 'name';
+  const allowedFields = ['name', 'email', 'department'];
+
+  if (!allowedFields.includes(searchField as string)) {
+    return res.status(400).json({ error: 'Invalid search field' });
+  }
+
+  try {
+    const results = await db.query(
+      `SELECT id, name, email, department
+       FROM users
+       WHERE ${searchField} ILIKE '%' || $1 || '%'
+       ORDER BY ${searchField} ASC
+       LIMIT 50`,
+      [q]
+    );
+
+    return res.json({
+      results: results.rows,
+      count: results.rows.length,
+    });
+  } catch (err) {
+    console.error('User search failed:', err);
+    return res.status(500).json({ error: 'Search failed' });
+  }
+});
+
+router.delete('/:id', requireAuth, requireRole('admin'), async (req, res) => {
+  await db.query('DELETE FROM users WHERE id = $1', [req.params.id]);
+  return res.json({ deleted: true });
+});
+
 export default router;
```
