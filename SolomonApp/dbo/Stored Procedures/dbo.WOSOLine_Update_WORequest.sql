 CREATE PROCEDURE WOSOLine_Update_WORequest
	@CpnyID		varchar( 10 ),
	@OrdNbr		varchar( 15 ),
	@LineRef	varchar( 5 ),
	@WONbr		varchar( 16 ),
	@TaskID		varchar( 32 )

AS
	UPDATE		SOLine
	SET		ProjectID = @WONbr,
			TaskID = @TaskID
	WHERE		CpnyID = @CpnyID and
			OrdNbr = @OrdNbr and
			LineRef LIKE @LineRef
	DELETE		WORequest
	WHERE		CpnyID = @CpnyID and
			OrdNbr = @OrdNbr and
			LineRef LIKE @LineRef



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOSOLine_Update_WORequest] TO [MSDSL]
    AS [dbo];

