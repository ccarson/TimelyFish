 Create Proc RtgTran_Cpnyid_RefNbr_Kitid_LN2 @parm1 varchar(10), @parm2 varchar (15),
	@parm3beg smallint, @parm3end smallint as
       Select * from RtgTran, Operation where
		Rtgtran.cpnyid = @parm1 and
		Rtgtran.RefNbr = @parm2 and
       	Rtgtran.LineNbr between @parm3beg and @parm3end and
		RtgTran.cpnyid = Operation.cpnyid and
       		 RtgTran.OperationId = Operation.OperationId
	     	 order by RtgTran.cpnyid , RtgTran.Refnbr, RtgTran.Kitid, RtgTran.Linenbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RtgTran_Cpnyid_RefNbr_Kitid_LN2] TO [MSDSL]
    AS [dbo];

