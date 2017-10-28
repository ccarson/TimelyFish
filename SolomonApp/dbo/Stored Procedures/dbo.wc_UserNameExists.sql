 CREATE Procedure wc_UserNameExists(
    @UserName   varchar(60) -- A Web Order user name.
)As
    IF EXISTS ( SELECT UserName FROM WCUser WHERE UserName = @UserName )
        SELECT RESULT = CAST(1 AS INT)
    ELSE
        SELECT RESULT = CAST(0 AS INT)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[wc_UserNameExists] TO [MSDSL]
    AS [dbo];

