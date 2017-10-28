 /****** Object:  Stored Procedure dbo.INTran_Invt_Site_Ref_Type_1    Script Date: 4/17/98 10:58:17 AM ******/
/****** Object:  Stored Procedure dbo.INTran_Invt_Site_Ref_Type_1    Script Date: 4/16/98 7:41:51 PM ******/
Create Proc INTran_Invt_Site_Ref_Type_1 @parm1 varchar ( 30) , @parm2 varchar ( 10) , @parm3 varchar ( 15) , @parm4 varchar ( 10) , @parm5 varchar ( 10)  as
Select * from INTran
	where InvtID = @parm1
	and Siteid = @parm2
	and Rlsed = 1
	and RefNbr <> @parm3
	and InSuffQty = 2
	and (TranType = 'RC' or TranType = 'TR' or TranType = 'OS' or (TranType = 'CG' and Acct = @parm5
	and RcptNbr > '0' and RcptNbr <> 'DP'))
Order By InvtID, Siteid, TranDate, RefNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[INTran_Invt_Site_Ref_Type_1] TO [MSDSL]
    AS [dbo];

