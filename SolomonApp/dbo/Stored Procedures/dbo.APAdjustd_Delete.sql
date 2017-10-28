 /****** Object:  Stored Procedure dbo.APAdjustd_Delete    Script Date: 4/7/98 12:19:54 PM ******/
Create Procedure APAdjustd_Delete @parm1 varchar ( 255), @parm2 varchar ( 255) as
Delete from APAdjust where APAdjust.AdjdRefNbr = @parm1 and
APAdjust.AdjdDocType = @parm2


