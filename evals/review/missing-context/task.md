Review the following PR diff. Apply the /review skill — structured code review that captures context for future maintainers.

**PR title:** refactor: Clean up order processing
**PR description:** _(empty)_

```diff
diff --git a/src/services/order-processor.ts b/src/services/order-processor.ts
index 8c2d1a0..f4e9b32 100644
--- a/src/services/order-processor.ts
+++ b/src/services/order-processor.ts
@@ -1,52 +1,38 @@
-import { validateOrder } from './validation';
-import { calculateTax } from './tax';
-import { applyDiscount } from './discounts';
-import { chargePayment } from './payments';
-import { sendConfirmation } from './notifications';
-import { updateInventory } from './inventory';
+import { OrderPipeline } from './pipeline';
+import { OrderContext } from './types';
 import { logger } from '../utils/logger';

-export async function processOrder(order: RawOrder): Promise<OrderResult> {
-  logger.info('Processing order', { orderId: order.id });
+const pipeline = new OrderPipeline()
+  .use(validateStep)
+  .use(taxStep)
+  .use(discountStep)
+  .use(paymentStep)
+  .use(inventoryStep)
+  .use(confirmationStep);

-  const validated = await validateOrder(order);
-  if (!validated.ok) {
-    return { status: 'rejected', reason: validated.error };
-  }
-
-  const taxed = await calculateTax(validated.order);
-  const discounted = await applyDiscount(taxed);
-
-  const payment = await chargePayment(discounted);
-  if (!payment.success) {
-    return { status: 'payment_failed', reason: payment.error };
-  }
-
-  await updateInventory(discounted.items);
-  await sendConfirmation(order.customerEmail, discounted);
-
-  return { status: 'completed', orderId: order.id, total: discounted.total };
+export async function processOrder(order: RawOrder): Promise<OrderResult> {
+  const ctx: OrderContext = { order, metadata: {} };
+  return pipeline.execute(ctx);
 }

diff --git a/src/services/pipeline.ts b/src/services/pipeline.ts
new file mode 100644
index 0000000..a3d7c12
--- /dev/null
+++ b/src/services/pipeline.ts
@@ -0,0 +1,34 @@
+import { OrderContext, StepFn } from './types';
+import { logger } from '../utils/logger';
+
+export class OrderPipeline {
+  private steps: StepFn[] = [];
+
+  use(step: StepFn): this {
+    this.steps.push(step);
+    return this;
+  }
+
+  async execute(ctx: OrderContext): Promise<OrderResult> {
+    for (const step of this.steps) {
+      const result = await step(ctx);
+      if (result.halt) {
+        return { status: result.status, reason: result.reason };
+      }
+    }
+    return { status: 'completed', orderId: ctx.order.id, total: ctx.metadata.total };
+  }
+}
+
diff --git a/src/services/steps/payment-step.ts b/src/services/steps/payment-step.ts
index 1a2b3c4..d5e6f78 100644
--- a/src/services/steps/payment-step.ts
+++ b/src/services/steps/payment-step.ts
@@ -1,12 +1,10 @@
-import { chargePayment } from '../payments';
+import { chargePayment } from '../payments';
+import { OrderContext, StepResult } from '../types';

-export async function handlePayment(order: TaxedOrder): Promise<PaymentResult> {
-  const result = await chargePayment(order);
-  if (!result.success) {
-    throw new PaymentError(result.error);
-  }
-  return result;
+export async function paymentStep(ctx: OrderContext): Promise<StepResult> {
+  const result = await chargePayment(ctx.metadata.discountedOrder);
+  if (!result.success) return { halt: true, status: 'payment_failed', reason: result.error };
+  ctx.metadata.paymentId = result.id;
+  return { halt: false };
 }
```
