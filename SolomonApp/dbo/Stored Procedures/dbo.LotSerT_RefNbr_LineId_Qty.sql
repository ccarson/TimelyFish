 /****** Object:  Stored Procedure dbo.LotSerT_RefNbr_LineId_Qty    Script Date: 4/17/98 10:58:19 AM ******/
/****** Object:  Stored Procedure dbo.LotSerT_RefNbr_LineId_Qty    Script Date: 4/16/98 7:41:52 PM ******/
Create Proc LotSerT_RefNbr_LineId_Qty @parm1 varchar ( 2), @parm2 varchar ( 15), @parm3 int as
Select TranSrc, RefNbr, INTranLineId, sum(Qty) from LotSerT
    where     TranSrc = @parm1 and
              RefNbr  = @parm2 and
              INTranLineId  = @parm3
	Group By  TranSrc, RefNbr, INTranLineId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[LotSerT_RefNbr_LineId_Qty] TO [MSDSL]
    AS [dbo];

