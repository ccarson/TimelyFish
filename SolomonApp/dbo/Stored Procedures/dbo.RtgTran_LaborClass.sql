 Create Proc RtgTran_LaborClass @parm1 varchar ( 10) as
	Select * from RtgTran,BomDoc where
	RtgTran.RefNbr = BomDoc.RefNbr and
	RtgTran.LaborClassID = @parm1 and
	BomDoc.Status <> 'C'
	order by RtgTran.RefNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RtgTran_LaborClass] TO [MSDSL]
    AS [dbo];

