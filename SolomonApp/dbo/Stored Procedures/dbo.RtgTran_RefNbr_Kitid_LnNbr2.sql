 Create Proc RtgTran_RefNbr_Kitid_LnNbr2 @parm1 varchar(15), @parm2beg smallint, @parm2end smallint as
       Select * from RtgTran, Operation where RefNbr = @parm1 and
       		 LineNbr between @parm2beg and @parm2end and
       		 Operation.OperationId = RtgTran.OperationId
	     	 order by Refnbr,Kitid,Linenbr


GO
GRANT CONTROL
    ON OBJECT::[dbo].[RtgTran_RefNbr_Kitid_LnNbr2] TO [MSDSL]
    AS [dbo];

