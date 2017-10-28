
CREATE PROC SCM_PurchOrd_POAlloc_LineRef
	@CpnyID		VARCHAR( 10 ),
	@OrdNbr		VARCHAR( 15 ),
	@LineRef	VARCHAR( 5 )
AS
	SELECT DISTINCT PurchOrd.*
	FROM PurchOrd 
		JOIN POAlloc
		ON POAlloc.PONbr = PurchOrd.PONbr
		AND POAlloc.CpnyID = @CpnyID
		AND POAlloc.SOOrdNbr = @OrdNbr
		AND POAlloc.SOLineRef = @LineRef
