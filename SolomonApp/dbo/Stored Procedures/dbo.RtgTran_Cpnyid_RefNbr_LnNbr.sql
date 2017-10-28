 Create Proc RtgTran_Cpnyid_RefNbr_LnNbr @parm1 varchar ( 15),
	@parm2 varchar (10), @parm3beg smallint, @parm3end smallint as
       Select * from RtgTran,Operation where
	Rtgtran.Cpnyid = @parm1 and
	Rtgtran.RefNbr = @parm2 and
	Rtgtran.LineNbr between @parm3beg and @parm3end and
	RtgTran.OperationID = Operation.OperationID  and
	Rtgtran.Cpnyid = Operation.Cpnyid
	order by Rtgtran.Cpnyid, Rtgtran.RefNbr, Rtgtran.LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RtgTran_Cpnyid_RefNbr_LnNbr] TO [MSDSL]
    AS [dbo];

