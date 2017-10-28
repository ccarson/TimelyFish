
Create PROCEDURE Get_InProjAllocLot
	@cpnyid			varchar( 10 ),
	@refnbr			varchar( 15 ),
    @AllocLineref   varchar(5),
    @LotSerRef      varchar (5)
	
AS
	SELECT *
	FROM InProjAllocLot
	WHERE CpnyID = @cpnyid
	   AND RefNbr = @refnbr
       AND AllocLineRef = @AllocLineRef
       AND LotSerRef = @LotSerRef
	ORDER BY CpnyID,
	   RefNbr,
       AllocLineRef,
       LotSerRef
