 CREATE PROCEDURE SCM_SOLot_Status
	@CpnyID 	varchar(10),
	@OrdNbr 	varchar(15),
	@LineRef 	varchar(5),
	@SchedRef	varchar(5),
	@LotSerRef 	varchar(5),
	@Status		varchar(1)
AS
	SELECT * FROM SOLot
	WHERE CpnyID = @CpnyID
	   AND OrdNbr = @OrdNbr
	   AND LineRef LIKE @LineRef
	   AND SchedRef LIKE @SchedRef
	   AND LotSerRef LIKE @LotSerRef
	   AND Status = @Status
	ORDER BY CpnyID, OrdNbr, SchedRef, LineRef, LotSerRef



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_SOLot_Status] TO [MSDSL]
    AS [dbo];

