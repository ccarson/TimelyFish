 /****** Object:  Stored Procedure dbo.Account_AcctMask    Script Date: 4/7/98 12:38:58 PM ******/
CREATE PROCEDURE Account_AcctMask @parm1 varchar ( 10) AS
SELECT * FROM Account WHERE
Acct  LIKE @parm1 and Active  =  1     ORDER BY Acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Account_AcctMask] TO [MSDSL]
    AS [dbo];

