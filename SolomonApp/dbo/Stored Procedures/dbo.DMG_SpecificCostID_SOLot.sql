 CREATE PROCEDURE DMG_SpecificCostID_SOLot
	@CpnyID		VARCHAR(10),
	@OrdNbr 	VARCHAR(15),
	@LineRef 	VARCHAR(5),
	@SpecificCostID VARCHAR(25)
AS
	SELECT	DISTINCT *
	FROM	SOLot
	WHERE CpnyID = @CpnyID
		and OrdNbr = @OrdNbr
		and LineRef like @LineRef
		and SpecificCostID like @SpecificCostID
	ORDER BY SpecificCostID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SpecificCostID_SOLot] TO [MSDSL]
    AS [dbo];

