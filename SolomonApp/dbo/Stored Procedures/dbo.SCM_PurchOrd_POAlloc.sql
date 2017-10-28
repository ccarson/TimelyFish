 create proc SCM_PurchOrd_POAlloc
	@CpnyID		varchar( 10 ),
	@OrdNbr		varchar( 15 )
	AS

	SELECT		DISTINCT PurchOrd.*
	FROM		PurchOrd
			Join POAlloc
			On POAlloc.PONbr = PurchOrd.PONbr
			and POAlloc.CpnyID = @CpnyID
			and POAlloc.SOOrdNbr = @OrdNbr


