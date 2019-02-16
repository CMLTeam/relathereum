
### Overview

Right after scanning
QR code of capsule (`capsule_id`) user (`user_address`) has 2 options: 
+ either report an issue and don't start the stay 
+ OR start his stay.

For simplicity let's assume that

+ **insurance payment** part to be fixed pre-configured
+ **stay payment** part to be determined by the stay time.

### Issue Scenario

1. `report_an_issue(report_user_address, capsule_id, string description)` -
user reports issue for the capsule. 
This means that **previous** user will **not** receive his insurance payment.

### Usual Scenario

1. `payable check_in(user_address, capsule_id, amount)` user sends initial payment `amount` 
(including insurance payment). 
    + Sending the money means user approves the capsule is OK and he starts his check in.
    + `amount` can't be less than some minimum value (which is `stay_of_8h_cost` + insurance payment).
    + Later the user will be reimbursed with insurance payment (if he didn't break anything) and unspent stay cost
    or he will be charged additional cost if he stays longer than 8h.

1. `payable check_out(user_address, capsule_id, real_stay_payment_amount, overstay_mount)` - user checks out the capsule after successful stay.
In this case **previous** user received his insurance payment back.
    + if user stays more than 8h: check_out receives positive `overstay_amount` ETH transfer 
    + if user stays less than 8h: user receives back a payment of (`stay_of_8h_cost` - `real_stay_payment_amount`)
