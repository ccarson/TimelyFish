 create Proc AR_Batch_Recon_CA @parm1 smalldatetime, @parm2 varchar ( 10), @parm3 varchar (10), @parm4 varchar (24) as
Select * from batch
Where module = 'AR'
and ((Cleared = 0 and DateEnt <= @parm1)
or (Cleared <> 0 and DateEnt <= @parm1 and DateClr > @parm1))
and CpnyID = @parm2
and BankAcct = @parm3
and BankSub = @parm4
and Rlsed = 1
Order by Batnbr


