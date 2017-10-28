 CREATE PROCEDURE ADG_SOLot_Delete
		@CpnyID		varchar(10),
	@OrdNbr		varchar(15),
	@LineRef	varchar(5),
	@SchedRef	varchar(5),
	@LotSerRef	varchar(5)
AS
	DELETE FROM SOLot
	WHERE	CpnyID = @CpnyID AND
		OrdNbr = @OrdNbr AND
		LineRef LIKE @LineRef AND
		SchedRef LIKE @SchedRef AND
		LotSerRef LIKE @LotSerRef



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SOLot_Delete] TO [MSDSL]
    AS [dbo];

