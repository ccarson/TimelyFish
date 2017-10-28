 Create Proc RtgTran_RefNbr_LnNbr @parm1 varchar ( 15), @parm2beg smallint, @parm2end smallint as
       Select * from RtgTran,Operation where RefNbr = @parm1 and LineNbr between
       @parm2beg and @parm2end and Operation.OperationID = RtgTran.OperationID
	order by RefNbr, LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RtgTran_RefNbr_LnNbr] TO [MSDSL]
    AS [dbo];

