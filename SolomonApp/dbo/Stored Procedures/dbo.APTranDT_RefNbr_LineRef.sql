 /****** Object:  Stored Procedure dbo.APTranDT_RefNbr_LineRef    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure APTranDT_RefNbr_LineRef @parm1 varchar ( 10), @parm2 varchar ( 05), @parm3beg smallint, @parm3end smallint As
	Select * from APTranDT where
		RefNbr = @parm1 And
		APLineRef Like @parm2 And
	        LineNbr between @parm3beg and @parm3end
	Order By RefNbr, APLineRef, LineNbr


