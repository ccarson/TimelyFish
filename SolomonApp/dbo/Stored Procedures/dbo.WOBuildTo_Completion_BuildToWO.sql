 CREATE PROCEDURE WOBuildTo_Completion_BuildToWO
	@WONbr		varchar( 16 ),
	@BuildToLineRef	varchar( 5 ),
	@Status		varchar( 1 )

AS
	SELECT		*
	FROM		WOBuildTo
	WHERE		BuildToWO = @WONbr
			and BuildToLineRef LIKE @BuildToLineRef
			and Status LIKE @Status


