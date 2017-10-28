 /****** Object:  Stored Procedure dbo.CA_Find_AR_Batch    Script Date: 4/7/98 12:49:20 PM ******/
create Proc CA_Find_AR_Batch @parm1 varchar ( 10), @parm2 varchar ( 10), @parm3 varchar ( 24), @parm4 varchar ( 10) as
Select * from batch
Where module = 'AR'
and CpnyID = @parm1
and BankAcct = @parm2
and BankSub = @parm3
and Batnbr = @parm4



GO
GRANT CONTROL
    ON OBJECT::[dbo].[CA_Find_AR_Batch] TO [MSDSL]
    AS [dbo];

