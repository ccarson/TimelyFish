 CREATE PROCEDURE ADG_Whse_SOLot
	@CpnyID 		varchar(10),
	@OrdNbr 		varchar(15),
	@LineRef 		varchar(5)
AS
	DECLARE @WhseCount	int,
		@LotCount	int,
		@WhseLoc	varchar(10),
		@LotSerNbr	varchar(25)

	SELECT 	@WhseCount = Count(DISTINCT WhseLoc),
		@LotCount = Count(DISTINCT LotSerNbr)
	FROM 	SOLot
	WHERE 	SOLot.CpnyID = @CpnyID
	  AND	SOLot.OrdNbr = @OrdNbr
	  AND	SOLot.LineRef = @LineRef
		If @WhseCount > 1
		SELECT 	@WhseLoc = '*'
	else
		SELECT 	@WhseLoc = WhseLoc
		FROM	SOLot
		WHERE 	SOLot.CpnyID = @CpnyID
		  AND	SOLot.OrdNbr = @OrdNbr
		  AND	SOLot.LineRef = @LineRef

	If @LotCount > 1
		SELECT	@LotSerNbr = '*'
	else
		SELECT 	@LotSerNbr = LotSerNbr
		FROM	SOLot
		WHERE 	SOLot.CpnyID = @CpnyID
		  AND	SOLot.OrdNbr = @OrdNbr
		  AND	SOLot.LineRef = @LineRef

	SELECT @WhseLoc WhseLoc, @LotSerNbr LotSerNbr

