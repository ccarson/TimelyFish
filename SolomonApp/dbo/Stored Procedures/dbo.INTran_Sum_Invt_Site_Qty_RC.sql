 /****** Object:  Stored Procedure dbo.INTran_Sum_Invt_Site_Qty_RC    Script Date: 4/17/98 10:58:17 AM ******/
/****** Object:  Stored Procedure dbo.INTran_Sum_Invt_Site_Qty_RC    Script Date: 4/16/98 7:41:51 PM ******/
Create Proc INTran_Sum_Invt_Site_Qty_RC @parm1 varchar ( 30), @parm2 varchar ( 10) as
Select Sum(Qty * CnvFact) from INTran
	where INTran.Invtid = @parm1
	and INTran.Siteid = @parm2
	and InSuffQty = 2


