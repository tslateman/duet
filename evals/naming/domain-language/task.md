Apply the /naming skill. Our support and ops teams say the code doesn't match how they talk.

How the business talks: a guest makes a *booking* for a *stay*. A stay has a
*check-in* and *check-out*. If the guest leaves early that's an *early departure*.
If they don't show up it's a *no-show*. Money the guest owes at the end is the
*folio balance*.

How the code names things:

```typescript
interface ReservationRecord {
  resId: string;
  userId: string;
  startDt: Date;
  endDt: Date;
  status: "ACTIVE" | "CANCELLED" | "FLAG_1" | "FLAG_2";
  computedTotal: number;
  tblVersion: number;
}

function updateRecordStatus(r: ReservationRecord, s: string): void {}
function calcTotal(r: ReservationRecord): number {}
function getUserRecords(uid: string): ReservationRecord[] {}
```
