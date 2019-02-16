
Right after scanning
QR code of capsule (`capsule_id`) user (`user_address`) has 2 options: 
+ either report an issue 
+ OR start his stay.

For simplicity let's consider the payment and insurance to be fixed values.

### Usual Scenario

1. `payable check_in(user_address, capsule_id, amount)` user sends initial payment `amount` 
(including insurance payment). 
Sending the money means user approves the capsule is OK and he starts his check in.

1. `check_out(user_address, capsule_id)` - user checks out the capsule after successful stay.
In this case **previous** user received his insurance payment back.

### Issue Scenario

1. `report_an_issue(report_user_address, capsule_id, string description)` -
user reports issue for the capsule. 
This means that **previous** user will **not** receive his insurance payment.

