 Create Proc INTran_Invt_TranType
	@parm1 varchar ( 30),
	@parm2 varchar ( 2)
AS
SELECT Count(*) from INTran
	WHERE Invtid = @parm1
	AND TranType = @parm2
	GROUP BY InvtID,TranType



GO
GRANT CONTROL
    ON OBJECT::[dbo].[INTran_Invt_TranType] TO [MSDSL]
    AS [dbo];

