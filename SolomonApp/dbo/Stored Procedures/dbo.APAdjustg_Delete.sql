 /****** Object:  Stored Procedure dbo.APAdjustg_Delete    Script Date: 4/7/98 12:19:54 PM ******/
Create Procedure APAdjustg_Delete @parm1 varchar ( 255), @parm2 varchar ( 255),
@parm3 varchar ( 255), @parm4 varchar ( 255) as
Delete from APAdjust where APAdjust.AdjgRefNbr = @parm1 and
APAdjust.AdjgDocType = @parm2 and APAdjust.AdjgAcct = @parm3 and
APAdjust.AdjgSub = @parm4


