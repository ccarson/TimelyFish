 /****** Object:  Stored Procedure dbo.APTran_RefNbr_TranType_LineMax    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure APTran_RefNbr_TranType_LineMax
@parm1 varchar ( 10), @parm2beg smallint, @parm2end smallint as
Select MAX(LineNbr) from APTran where RefNbr = @parm1
and (((TranType = 'AC' or TranType = 'VO') and DrCr = 'D')
or (TranType = 'AD' and DrCr = 'C'))
and LineNbr between @parm2beg and @parm2end


