CREATE proc WS_GetWindowsUserAcct @parm1 VarChar(10) --Project Employee ID
AS  
   SELECT WindowsUserAcct 
     FROM vs_userrec v JOIN PJEMPLOY p
                         ON v.UserId = p.user_id
    WHERE p.employee = @parm1


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_GetWindowsUserAcct] TO [MSDSL]
    AS [dbo];

