 /****** Object:  Stored Procedure dbo.INTran_Invt_Site_Lot_Type_1    Script Date: 4/17/98 10:58:17 AM ******/
/****** Object:  Stored Procedure dbo.INTran_Invt_Site_Lot_Type_1    Script Date: 4/16/98 7:41:51 PM ******/
Create Proc INTran_Invt_Site_Lot_Type_1 @parm1 varchar ( 30), @parm2 varchar ( 10) as
Select * from INTran
	where INTran.Invtid = @parm1
	and INTran.Siteid = @parm2
	and InSuffQty = 1
Order by InvtId, SiteId, Trandate,RefNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[INTran_Invt_Site_Lot_Type_1] TO [MSDSL]
    AS [dbo];

