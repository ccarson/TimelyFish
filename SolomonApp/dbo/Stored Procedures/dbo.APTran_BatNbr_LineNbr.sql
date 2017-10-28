 /****** Object:  Stored Procedure dbo.APTran_BatNbr_LineNbr    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure APTran_BatNbr_LineNbr @parm1 varchar ( 10), @parm2beg smallint, @parm2end smallint as
Select * from APTran where BatNbr = @parm1
and LineNbr between @parm2beg and @parm2end
Order by BatNbr, LineNbr


