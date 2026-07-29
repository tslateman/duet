Apply the /design skill. Review and redesign this client interface before we publish it as our public SDK.

```typescript
export class NotificationClient {
  constructor(apiKey: string, baseUrl: string, timeout: number, retries: number,
              debug: boolean, cache: Map<string, unknown>, logger: Logger) {}

  async createNotification(payload: object): Promise<object> {}
  async addBulkNotifications(payloads: object[]): Promise<object> {}
  async pushUrgent(payload: object): Promise<object> {}

  getNotification(id: string): Promise<object> {}
  async fetchNotificationList(filter?: object): Promise<object[]> {}

  public cacheRef: Map<string, unknown>;
  public lastResponse: object | null;
  public internalRetryCount: number;

  async doDelete(id: string): Promise<void> {}
  async updateNotificationStatusById(id: string, status: string): Promise<void> {}

  public rawRequest(method: string, path: string, body?: unknown): Promise<Response> {}
  public getHttpAgent(): HttpAgent {}
}
```
