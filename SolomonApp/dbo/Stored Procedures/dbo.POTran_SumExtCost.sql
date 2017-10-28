 /****** Object:  Stored Procedure dbo.POTran_SumExtCost    Script Date: 4/16/98 7:50:26 PM ******/
Create Procedure POTran_SumExtCost @parm1 varchar ( 10) As
Select sum(curyextcost), sum(extcost) From POTran
   Where POTran.RcptNbr = @parm1 And POTran.POOriginal = 'Y'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POTran_SumExtCost] TO [MSDSL]
    AS [dbo];

