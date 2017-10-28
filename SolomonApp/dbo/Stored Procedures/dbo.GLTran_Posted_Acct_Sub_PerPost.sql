 /****** Object:  Stored Procedure dbo.GLTran_Posted_Acct_Sub_PerPost    Script Date: 4/7/98 12:38:59 PM ******/
Create Proc GLTran_Posted_Acct_Sub_PerPost @parm1 varchar ( 10), @parm2 varchar ( 24), @parm3 varchar ( 10), @parm4 varchar ( 6), @parm5 varchar ( 10) as
       Select * from GLTran
           where Posted   = 'P'
             and Acct     = @parm1
             and Sub      = @parm2
             and LedgerID like @parm3
             and PerPost  = @parm4
             and cpnyid   = @parm5
           order by acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[GLTran_Posted_Acct_Sub_PerPost] TO [MSDSL]
    AS [dbo];

