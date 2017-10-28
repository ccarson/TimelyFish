 /****** Object:  Stored Procedure dbo.AR_Batch_BankAcctSub    Script Date: 4/7/98 12:49:19 PM ******/
create Proc AR_Batch_BankAcctSub @parm1 smalldatetime, @parm2 varchar ( 10), @parm3 varchar ( 10), @parm4 varchar ( 24) as
Select * from batch
Where module = 'AR'
and battype <> 'C'
and dateent = @parm1
and CpnyID like @parm2
and BankAcct = @parm3
and BankSub = @Parm4
Order by Batnbr
option (fast 100)


