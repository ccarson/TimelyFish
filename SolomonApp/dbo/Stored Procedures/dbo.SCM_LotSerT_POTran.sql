 create proc SCM_LotSerT_POTran
	@CpnyID		varchar( 10 ),
	@RecordID	int,
	@LotSerNbr	varchar( 25 )
	AS

	SELECT		Distinct POTran.*
	FROM 		POTran
			INNER JOIN LotSerT
			ON POTran.CpnyId = LotSerT.CpnyID
			AND POTran.BatNbr = LotSerT.BatNbr
			AND POTran.RcptNbr = LotSerT.RefNbr
			AND POTran.Lineref = LotSert.InTRANLineRef

	WHERE 		LotSerT.CpnyID = @CpnyID
			AND LotSerT.RecordID = @RecordID
			AND LotSerT.LotSerNbr Like @LotSerNbr


