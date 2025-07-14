PowerShell script to onboard new users from a CSV file named 'new_hires.csv'.
The script must perform the following actions for each user:
1. Import the CSV which contains columns: FirstName, LastName, Department, Title.
2. Generate a secure, random initial password.
3. Create an Active Directory user in the Organizational Unit that matches the user's Department.
4. Construct the UserPrincipalName using the format 'firstname.lastname@yourcompany.com'.
5. Assign a Microsoft 365 E5 license to the new user account.
6. Add the user to the 'All-Staff' Microsoft Teams group.
7. Include robust error handling with try/catch blocks for each major operation.
8. Log all actions, including successes and failures, to a transcript file.