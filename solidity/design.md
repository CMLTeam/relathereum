
### Overview

Right after scanning
QR code of capsule (`capsule_id`) user (`user_address`) has 2 options: 
+ either report an issue and don't start the stay 
+ OR start his stay.

For simplicity let's assume that **insurance payment** and **stay payment** parts to be fixed pre-configured,
though in reality **stay payment** will be determined by the stay time.

### Issue Scenario

1. `report_an_issue(report_user_address, capsule_id, string description)` -
user reports issue for the capsule. 
This means that **previous** user will **not** receive his insurance payment.

### Usual Scenario

1. `payable check_in(user_address, capsule_id, amount)` - user checks in into capsule. 
    + Sending the money means user approves the capsule is OK and he starts his check in.
    + `amount` must be a fixed value of **stay payment** + **insurance payment**.
    + Later the user will be reimbursed with insurance payment (if he didn't break anything).

1. `check_out(user_address, capsule_id)` - user checks out the capsule after successful stay.
    + **previous** user received his insurance payment back.
