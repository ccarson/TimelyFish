 Create Proc RtgTran_RefNbr_Kitid_LnNbr @parm1 varchar ( 15), @parm2 varchar (30), @parm3beg smallint , @parm3end smallint  as
       Select * from RtgTran, Operation where
		RefNbr = @parm1 and
		KitId = @parm2 and
		LineNbr between @parm3beg and @parm3end and
		Operation.OperationId = RtgTran.OperationId
		 order by Rtgtran.Refnbr,Rtgtran.Kitid, Rtgtran.LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RtgTran_RefNbr_Kitid_LnNbr] TO [MSDSL]
    AS [dbo];

