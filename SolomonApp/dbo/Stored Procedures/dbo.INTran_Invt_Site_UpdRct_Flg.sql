 /****** Object:  Stored Procedure dbo.INTran_Invt_Site_UpdRct_Flg    Script Date: 4/17/98 10:58:17 AM ******/
/****** Object:  Stored Procedure dbo.INTran_Invt_Site_UpdRct_Flg    Script Date: 4/16/98 7:41:51 PM ******/
Create Proc INTran_Invt_Site_UpdRct_Flg @parm1 varchar ( 30), @parm2 varchar ( 10) as
Update INTran Set InSuffQty = 0
	where INTran.Invtid = @parm1
	and INTran.Siteid = @parm2
	and InSuffQty = 2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[INTran_Invt_Site_UpdRct_Flg] TO [MSDSL]
    AS [dbo];

