 /****** Object:  Stored Procedure dbo.INTran_Invt_Site_Ref_Desc    Script Date: 4/17/98 10:58:17 AM ******/
/****** Object:  Stored Procedure dbo.INTran_Invt_Site_Ref_Desc    Script Date: 4/16/98 7:41:51 PM ******/
Create Proc INTran_Invt_Site_Ref_Desc @parm1 varchar ( 30) , @parm2 varchar ( 10) , @parm3 varchar ( 15)  as
Select * from INTran
	where InvtID = @parm1
	and Siteid = @parm2
	and (TranType = 'RC' or TranType = 'CM' or TranType = 'TR' or (TranType = 'AS' and DrCr = 'D'))
	and Rlsed = 1
	and RefNbr <> @parm3
Order by InvtID desc, Siteid desc, TranDate desc, RefNbr desc



GO
GRANT CONTROL
    ON OBJECT::[dbo].[INTran_Invt_Site_Ref_Desc] TO [MSDSL]
    AS [dbo];

