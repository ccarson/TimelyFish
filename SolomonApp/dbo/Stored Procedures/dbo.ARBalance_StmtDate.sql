 /****** Object:  Stored Procedure dbo.ARBalance_StmtDate    Script Date: 4/7/98 12:30:32 PM ******/
Create proc ARBalance_StmtDate @parm1 varchar ( 15), @parm2 smalldatetime as
 Select * from AR_Balances WHERE
        AR_Balances.CustId = @parm1
        and AR_Balances.lastStmtDate <= @parm2
        Order By CustId, CpnyID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARBalance_StmtDate] TO [MSDSL]
    AS [dbo];

