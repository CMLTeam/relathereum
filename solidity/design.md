
### Overview

Right after scanning
QR code of capsule (`capsule_id`) user (`user_address`) has 2 options: 
+ either report an issue and don't start the stay 
+ OR start his stay.

For simplicity let's consider the **insurance payment** part to be fixed pre-configured
and **stay payment** part to be determined by the stay time.

### Issue Scenario

1. `report_an_issue(report_user_address, capsule_id, string description)` -
user reports issue for the capsule. 
This means that **previous** user will **not** receive his insurance payment.

### Usual Scenario

1. `payable check_in(user_address, capsule_id, amount)` user sends initial payment `amount` 
(including insurance payment). 
    + Sending the money means user approves the capsule is OK and he starts his check in.
    + (`amount` + current user's `balance`) could not be less than some minimum value (which is the cost of 24h stay + insurance payment).
    + Later the user will be reimbursed with insurance payment (if he didn't break anything) and unspent stay cost.
The rest will be kept on his `balance`.     

1. `check_out(user_address, capsule_id, real_stay_payment_amount)` - user checks out the capsule after successful stay.
In this case **previous** user received his insurance payment back.
    + The previous user's `balance` gets subtracted by insurance payment
    + The user's `balance` gets subtracted by `real_stay_payment_amount`
