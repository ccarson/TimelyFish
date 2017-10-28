 /****** Object:  Stored Procedure dbo.AR_Batch_Select_ReconDate    Script Date: 4/7/98 12:49:19 PM ******/
create Proc AR_Batch_Select_ReconDate @parm1 smalldatetime, @parm2 smalldatetime as
Select * from batch
Where module = 'AR'
and ((Cleared = 0 and DateEnt <= @parm1)
or (Cleared <> 0 and (DateClr <= @parm1 and DateClr > @parm2)))
and Rlsed = 1
Order by Batnbr


