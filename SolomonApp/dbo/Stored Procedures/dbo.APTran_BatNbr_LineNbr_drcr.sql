 /****** Object:  Stored Procedure dbo.APTran_BatNbr_LineNbr_drcr    Script Date: 2/12/99 8:36:43 AM ******/
/**** Modified 03/26/99 - MHN Defect 205942 - copied over from 2.5x.  *****/
CREATE PROCEDURE APTran_BatNbr_LineNbr_drcr @parm1 varchar (10), @parm2beg smallint, @parm2end smallint as
	Select * from APTran where BatNbr = @parm1 and
	LineNbr between @parm2beg and @parm2end and
	(drcr = "D" or drcr = "V")
	Order by BatNbr, LineNbr


