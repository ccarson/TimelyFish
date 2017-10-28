CREATE PROCEDURE InProjAllocLot_all
	@cpnyid			varchar( 10 ),
	@refnbr			varchar( 15 ),
    @AllocLineref   varchar(5),
    @LotSerRef      varchar (5)
	
AS
	SELECT *
	FROM InProjAllocLot
	WHERE CpnyID = @cpnyid
	   AND RefNbr = @refnbr
       AND AllocLineRef LIKE @AllocLineRef
       AND LotSerRef LIKE @LotSerRef
	ORDER BY CpnyID,
	   RefNbr,
       AllocLineRef,
       LotSerRef
