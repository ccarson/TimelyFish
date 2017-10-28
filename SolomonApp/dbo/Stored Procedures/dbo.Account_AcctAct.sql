 /****** Object:  Stored Procedure dbo.Account_AcctAct    Script Date: 4/7/98 12:38:58 PM ******/
CREATE PROCEDURE Account_AcctAct @parm1 varchar ( 10) AS
SELECT * FROM Account WHERE
 Acct  Like @parm1 and Active  =  1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Account_AcctAct] TO [MSDSL]
    AS [dbo];

