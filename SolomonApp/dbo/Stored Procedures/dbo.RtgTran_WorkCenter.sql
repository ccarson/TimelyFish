 Create Proc RtgTran_WorkCenter @parm1 varchar ( 10) as
	Select * from RtgTran,BomDoc where
	RtgTran.RefNbr = BomDoc.RefNbr and
	RtgTran.Workcenterid = @parm1 and
	BomDoc.Status <> 'C'
	order by Rtgtran.RefNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RtgTran_WorkCenter] TO [MSDSL]
    AS [dbo];

