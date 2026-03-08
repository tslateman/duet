Vibe check this Express handler for a user invitation flow.

```typescript
// src/invitations/handler.ts
import express from "express";
import { db } from "../db";
import { sendEmail } from "../email";

const router = express.Router();

interface RequestData {
  email: string;
  role: string;
  teamId: string;
}

class InvitationService {
  async processInvitation(data: RequestData) {
    const user = await db.query("SELECT * FROM users WHERE email = $1", [
      data.email,
    ]);
    if (user.rows.length > 0) {
      return { status: "exists" };
    }

    const token = Math.random().toString(36).substring(2);
    await db.query(
      "INSERT INTO invitations (email, role, team_id, token) VALUES ($1, $2, $3, $4)",
      [data.email, data.role, data.teamId, token],
    );

    await sendEmail(data.email, "You've been invited!", `Token: ${token}`);
    return { status: "sent" };
  }
}

const service = new InvitationService();

router.post("/invite", async (req, res) => {
  const data: RequestData = req.body;
  const result = await service.processInvitation(data);
  res.json(result);
});

router.get("/accept/:token", async (req, res) => {
  const invitation = await db.query(
    "SELECT * FROM invitations WHERE token = $1",
    [req.params.token],
  );
  if (invitation.rows.length === 0) {
    res.status(404).json({ error: "Not found" });
    return;
  }
  await db.query("UPDATE invitations SET accepted = true WHERE token = $1", [
    req.params.token,
  ]);
  await db.query(
    "INSERT INTO team_members (email, role, team_id) VALUES ($1, $2, $3)",
    [
      invitation.rows[0].email,
      invitation.rows[0].role,
      invitation.rows[0].team_id,
    ],
  );
  res.json({ status: "accepted" });
});

export default router;
```
