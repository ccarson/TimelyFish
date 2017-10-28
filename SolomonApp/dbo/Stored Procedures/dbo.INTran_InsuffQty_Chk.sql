 /****** Object:  Stored Procedure dbo.INTran_InsuffQty_Chk    Script Date: 4/17/98 10:58:17 AM ******/
/****** Object:  Stored Procedure dbo.INTran_InsuffQty_Chk    Script Date: 4/16/98 7:41:51 PM ******/
Create Proc INTran_InsuffQty_Chk as
    Select count(*) From INTran Where InsuffQty = 1 Or InsuffQty = 2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[INTran_InsuffQty_Chk] TO [MSDSL]
    AS [dbo];

