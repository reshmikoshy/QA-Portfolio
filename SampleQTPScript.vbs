' LoginAutomation.vbs - Sample QTP/UFT script

' Launch the browser and open the application
SystemUtil.Run "iexplore.exe", "http://example.com/login"

' Set the username and password
Browser("LoginPage").Page("LoginPage").WebEdit("username").Set "testuser"
Browser("LoginPage").Page("LoginPage").WebEdit("password").Set "password123"

' Click the Login button
Browser("LoginPage").Page("LoginPage").WebButton("Login").Click

' Verification: Check if login was successful
If Browser("LoginPage").Page("Dashboard").WebElement("WelcomeMessage").Exist(5) Then
MsgBox "Login successful"
Else
MsgBox "Login failed"
End If
