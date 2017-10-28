 CREATE PROCEDURE PO_GetGLBatch
	@Cpny_ID varchar( 10 ),
	@Module varchar( 2 ),
	@OrigBatNbr varchar( 10 )

AS
	SELECT *
	FROM Batch
	WHERE CpnyID = @Cpny_ID
	   AND Module = @Module
	   AND OrigBatNbr = @OrigBatNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PO_GetGLBatch] TO [MSDSL]
    AS [dbo];

