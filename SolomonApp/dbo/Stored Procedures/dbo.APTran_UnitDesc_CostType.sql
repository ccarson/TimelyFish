 /****** Object:  Stored Procedure dbo.APTran_UnitDesc_CostType    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure APTran_UnitDesc_CostType @parm1 varchar ( 10), @parm2 varchar ( 8) As
Select * from APTran Where
APTran.UnitDesc = @parm1 and
APTran.CostType = @parm2 and
APTran.AcctDist = 0 and
APTran.Rlsed = 0 and
APTran.DrCr = 'S'


