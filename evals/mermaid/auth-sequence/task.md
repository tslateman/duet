Apply the /mermaid skill. Diagram our OAuth login for the README so it renders on GitHub.

The flow: the browser hits `/login`, our API redirects to the identity provider.
The user authenticates there. The IdP redirects back to `/callback` with a code.
Our API exchanges the code with the IdP for tokens (server to server). The API
then asks the IdP for the userinfo, creates or looks up a local user row in
Postgres, issues our own session cookie, and redirects the browser to `/app`.

If the code exchange fails the API redirects to `/login?error=exchange` instead.
