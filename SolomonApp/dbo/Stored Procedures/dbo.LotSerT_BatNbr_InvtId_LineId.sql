 /****** Object:  Stored Procedure dbo.LotSerT_BatNbr_InvtId_LineId    Script Date: 4/17/98 10:58:18 AM ******/
/****** Object:  Stored Procedure dbo.LotSerT_BatNbr_InvtId_LineId    Script Date: 4/16/98 7:41:52 PM ******/
Create Proc LotSerT_BatNbr_InvtId_LineId @parm1 varchar ( 10), @parm2 varchar ( 30), @parm3 varchar ( 30), @parm4 smallint, @parm5 smallint as
    Select * from LotSerT where Batnbr = @parm1
                  and InvtId = @parm2
                  and KitID = @parm3
                  and INTranLineId between @parm4 and @parm5
                  order by BatNbr, InvtId, KitID, INTranLineId


