 Create Proc APAdjust_Select_VC @parm1 varchar ( 10), @parm2 varchar ( 24), @parm3 varchar ( 10)as
Select * from APAdjust
Where adjgacct = @parm1
and adjgsub = @parm2
and adjgrefnbr = @parm3
Order by adjgrefnbr, adjbatnbr


