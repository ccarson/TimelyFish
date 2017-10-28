CREATE PROCEDURE INProjAllocLot_all_qty
	@cpnyid			varchar( 10 ),
	@refnbr			varchar( 15 ),
	@Tranlineref		varchar( 5 )
AS
	SELECT CpnyId, RefNbr, AllocLineRef, Sum(Quantity)
	FROM InProjAllocLot
	WHERE CpnyID LIKE @cpnyid
	  	   AND RefNbr LIKE @refnbr
	   AND AllocLineRef LIKE @Tranlineref
	Group BY CpnyID,
	   RefNbr,
	   AllocLineRef
