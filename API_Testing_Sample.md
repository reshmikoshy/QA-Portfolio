API Testing Sample — QA Logic Demonstration

1️⃣ Login API
Request:
POST https://api.example.com/auth/login
Content-Type: application/json
{
"email": "test@example.com",
"password": "Password123"
}

Response:
Status: 200 OK
{
"token": "eyJhbGciOiJIUzI1NiIsInR...",
"user": {
"id": 101,
"name": "Test User",
"email": "test@example.com"
}
}

QA Checks:
- Verify status code is 200
- Ensure token and user details are returned

2️⃣ Get User Details API
Request:
GET https://api.example.com/users/101
Authorization: Bearer <token>

Response:
Status: 200 OK
{
"id": 101,
"name": "Test User",
"email": "test@example.com",
"role": "QA Tester"
}

QA Checks:
- Verify status code is 200
- Confirm all expected fields are present
- Validate authorization using token
