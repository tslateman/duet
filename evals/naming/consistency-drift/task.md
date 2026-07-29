Apply the /naming skill. Review these exported functions from our billing package. Each one is fine on its own; I want to know about the set.

```go
func GetInvoice(id string) (*Invoice, error)
func FetchCustomer(id string) (*Customer, error)
func LoadSubscription(id string) (*Subscription, error)
func RetrievePayment(id string) (*Payment, error)

func CreateInvoice(in InvoiceInput) (*Invoice, error)
func NewCustomer(in CustomerInput) (*Customer, error)
func MakeSubscription(in SubscriptionInput) (*Subscription, error)

func UpdateInvoice(id string, in InvoiceInput) error
func SaveCustomer(c *Customer) error

func DeleteInvoice(id string) error
func RemoveCustomer(id string) error
func CancelSubscription(id string) error
```
