# 🐞 Bug Report – MagicMenu Website

**Tester:** Reshmi Koshy
**Type:** Manual / Exploratory Website Testing
**Test Environment:** Browser (Chrome), Desktop
**Date:** 10/14/2025

---

## 1️⃣ Bug ID: MM-001
**Title:** Email verification code not received during registration
**Module:** User Registration
**Severity:** Critical
**Priority:** High

**Steps to Reproduce:**
1. Open MagicMenu website.
2. Click *Register* and enter a valid email and password.
3. Submit the form but do not receive any verification email.
4. Try logging in with the same email.

**Expected Result:**
Verification code should be sent to the registered email for account activation.

**Actual Result:**
No verification code received. On re-login attempt, site says *“Already Registered”*.

**Impact:**
User can’t complete registration or recover the account.

---

## 2️⃣ Bug ID: MM-002
**Title:** “Forgot Password” email link not sent
**Module:** Login / Account Recovery
**Severity:** Major
**Priority:** Medium

**Steps to Reproduce:**
1. Go to the login page.
2. Click on *Forgot Password*.
3. Enter the registered email and submit.

**Expected Result:**
A reset password email should be sent with a valid link.

**Actual Result:**
No email or reset link is received.

**Impact:**
Registered users can’t reset passwords, leading to login failure.

---

## 3️⃣ Bug ID: MM-003
**Title:** Dashboard not showing correct dietary preferences
**Module:** Dashboard – Member Section
**Severity:** Major
**Priority:** Medium

**Steps to Reproduce:**
1. Log in to the website.
2. Set dietary preferences for each member (e.g., vegetarian, gluten-free).
3. Go to the Dashboard.

**Expected Result:**
Dashboard should display correct dietary preferences for each member.

**Actual Result:**
Dashboard shows all members (1, 2, 3, 4) with “0 dietary needs.”

**Impact:**
Incorrect user data displayed; impacts trust and usability.

---

## 🧭 Summary
The major issues found include registration blockage due to missing email verification, failure in the “Forgot Password” process, and inaccurate data display on the Dashboard.
These are critical functional issues that need backend and front-end validation fixes.

---

## 🧰 Recommendation
- Check backend email service or API integration for verification and reset links.
- Validate user verification logic before setting account status.
- Re-test dashboard logic for dietary preference mapping
