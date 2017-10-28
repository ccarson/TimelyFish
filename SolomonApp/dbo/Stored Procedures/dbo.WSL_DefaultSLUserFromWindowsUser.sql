
CREATE PROCEDURE WSL_DefaultSLUserFromWindowsUser (@WindowsUser VARCHAR(85))
AS
SELECT UserID FROM vs_userrec WHERE RecType = 'U' AND WindowsUserAcct = @WindowsUser AND DefaultUser = 1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_DefaultSLUserFromWindowsUser] TO [MSDSL]
    AS [dbo];

