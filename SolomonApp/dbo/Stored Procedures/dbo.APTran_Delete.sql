 /****** Object:  Stored Procedure dbo.APTran_Delete    Script Date: 4/7/98 12:19:55 PM ******/
/**** Modified 11/30/98 - CSS Removed @parm3beg and @parm3end.  Parameters no longer used  *****/
/*** Create Procedure APTran_Delete @parm1 Varchar ( 255), @parm2 Varchar ( 255), @parm3beg smallint, @parm3end smallint  as  ******/
Create Procedure APTran_Delete @parm1 Varchar ( 255), @parm2 Varchar ( 255)  as
Delete from APTran where APTran.RefNbr = @parm1 and APTran.TranType = @parm2


