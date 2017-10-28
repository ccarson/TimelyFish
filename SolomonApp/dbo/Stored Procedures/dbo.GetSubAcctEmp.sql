
CREATE PROCEDURE GetSubAcctEmp @SubAcct VARCHAR(24)
AS
    SELECT Employee
    FROM   PJEMPLOY
    WHERE  gl_subacct = @SubAcct


GO
GRANT CONTROL
    ON OBJECT::[dbo].[GetSubAcctEmp] TO [MSDSL]
    AS [dbo];

