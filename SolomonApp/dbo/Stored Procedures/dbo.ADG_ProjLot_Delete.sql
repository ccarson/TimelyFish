
CREATE PROCEDURE ADG_ProjLot_Delete
	@CpnyID		varchar(10),
	@RefNbr		varchar(15),
	@LineRef	varchar(5),
	@LotSerRef	varchar(5)
AS
	DELETE FROM InProjAllocLot
	WHERE	CpnyID = @CpnyID AND
		RefNbr = @RefNbr AND
		AllocLineRef = @LineRef AND
		LotSerRef = @LotSerRef

GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_ProjLot_Delete] TO [MSDSL]
    AS [dbo];

