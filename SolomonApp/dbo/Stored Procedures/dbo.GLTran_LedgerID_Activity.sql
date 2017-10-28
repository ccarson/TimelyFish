 /****** Object:  Stored Procedure dbo.GLTran_LedgerID_Activity    Script Date: 4/7/98 12:38:58 PM ******/
Create Proc GLTran_LedgerID_Activity @parm1 varchar ( 10), @parm2 varchar ( 4) as
       Select * from GLTran
           where LedgerID             =  @parm1
             and Fiscyr >= @parm2
           order by LedgerID, Fiscyr, Acct, Sub



GO
GRANT CONTROL
    ON OBJECT::[dbo].[GLTran_LedgerID_Activity] TO [MSDSL]
    AS [dbo];

