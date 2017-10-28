 CREATE PROCEDURE WOSOShipLine_OrdNbr_LineRef
	@CpnyID		varchar( 10 ),
	@OrdNbr		varchar( 15 ),
	@LineRef	varchar( 5 )

AS
	SELECT		*
	FROM		SOShipLine
	WHERE		CpnyID = @CpnyID and
			OrdNbr = @OrdNbr and
			OrdLineRef LIKE @LineRef



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOSOShipLine_OrdNbr_LineRef] TO [MSDSL]
    AS [dbo];

