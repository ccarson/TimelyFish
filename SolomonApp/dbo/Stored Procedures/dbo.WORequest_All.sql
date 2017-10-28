 CREATE PROCEDURE WORequest_All
	@CpnyID		varchar( 10 ),
	@OrdNbr		varchar( 15 ),
	@LineRef	varchar( 5 )

AS
	SELECT		*
	FROM		WORequest
	WHERE		CpnyID = @CpnyID and
			OrdNbr = @OrdNbr and
			LineRef LIKE @LineRef



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WORequest_All] TO [MSDSL]
    AS [dbo];

