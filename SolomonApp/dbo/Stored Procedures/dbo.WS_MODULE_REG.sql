
CREATE PROCEDURE WS_MODULE_REG @ModuleID CHAR(2)
AS
    SELECT Active
    FROM   vs_modules
    WHERE  ModuleID = @ModuleID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_MODULE_REG] TO [MSDSL]
    AS [dbo];

