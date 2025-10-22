# MagicMenu Website Testing

**Type:** Freelance / Exploratory Website Testing
**Scope:** Tested website functionality, registration, login, and dashboard modules.
**Tools:** Manual browser testing
**Testing Types:** Functional, UI, Negative, and Usability Testing

---

## 🧩 Overview
This project involved testing the MagicMenu web app to ensure proper user registration, login validation, and dashboard accuracy. During testing, critical issues were found in the email verification process and member dietary data display.

---

## ⚙️ Key Findings

1. **Email Verification Issue**
- When the user registers and the verification code isn’t entered, the email remains unverified.
- On trying to log in again, the site shows *“Already Registered.”*
- If you use “Forgot Password,” the reset link never arrives since the account wasn’t verified.
- 🔍 **Impact:** Users can’t complete registration or recover accounts.

2. **Dashboard Dietary Display Issue**
- Even when dietary preferences are set for members, the dashboard still shows:
> Member 1, 2, 3, 4 — all with “0 dietary needs.”
- 🔍 **Impact:** Incorrect data representation in member dashboard.

---

## 🧪 Sample Test Cases

| ID | Test Scenario | Steps | Expected Result | Actual Result | Status |
|----|----------------|--------|-----------------|----------------|---------|
| TC001 | Email Verification | Register with a valid email → Check for verification code | Verification email should arrive with code | No code received | ❌ Fail |
| TC002 | Forgot Password | Use “Forgot Password” with registered email | Reset email sent | No reset email received | ❌ Fail |
| TC003 | Dashboard Dietary Data | Set dietary preferences for members | Dashboard reflects selected options | Dashboard shows “0 dietary needs” | ❌ Fail |

---

## 🧭 Conclusion
The MagicMenu website needs improvement in the email verification process and dashboard data validation.
Testing confirmed registration and account recovery are blocked when verification fails, and dietary preferences aren’t reflected in the dashboard.
