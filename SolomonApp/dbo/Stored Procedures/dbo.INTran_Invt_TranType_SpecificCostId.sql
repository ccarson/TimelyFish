 Create Proc INTran_Invt_TranType_SpecificCostId
	@parm1 varchar ( 30),
	@parm2 varchar ( 25),
	@parm3 varchar ( 2)
AS
SELECT Count(*) from INTran
	WHERE Invtid = @parm1
	AND SpecificCostID = @parm2
	AND TranType = @parm3
	GROUP BY InvtID,TranType,SpecificCostID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[INTran_Invt_TranType_SpecificCostId] TO [MSDSL]
    AS [dbo];

