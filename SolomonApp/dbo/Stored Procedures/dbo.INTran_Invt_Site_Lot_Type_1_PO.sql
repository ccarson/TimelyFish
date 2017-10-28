 /****** Object:  Stored Procedure dbo.INTran_Invt_Site_Lot_Type_1_PO    Script Date: 4/17/98 10:58:17 AM ******/
/****** Object:  Stored Procedure dbo.INTran_Invt_Site_Lot_Type_1_PO    Script Date: 4/16/98 7:41:51 PM ******/
Create Proc INTran_Invt_Site_Lot_Type_1_PO @parm1 varchar ( 30), @parm2 varchar ( 10) as
Select * from INTran
	where INTran.Invtid = @parm1
	and INTran.Siteid = @parm2
	and InSuffQty = 1
Order by BatNbr, InvtId, LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[INTran_Invt_Site_Lot_Type_1_PO] TO [MSDSL]
    AS [dbo];

