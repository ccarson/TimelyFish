
CREATE PROCEDURE XDDBatch_Status_Update
	@BatNbr		varchar( 10 ),
	@Module		varchar( 2 ),
	@Status		varchar( 1 )
AS
	UPDATE		Batch
	SET		Status = @Status
	WHERE		Module = @Module
			and BatNbr = @BatNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDBatch_Status_Update] TO [MSDSL]
    AS [dbo];

