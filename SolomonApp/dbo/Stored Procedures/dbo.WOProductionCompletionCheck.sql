 create proc WOProductionCompletionCheck
   	@Mode		varchar(1),	-- 'S'et flag, 'G'et flag
   	@WONbr		varchar(16),
   	@Flag		smallint
as

	-- If DBProcessStatus = 1, then this WO is having Production Completion run
	If @Mode = 'G'
		-- Get the flag value for the WO
		SELECT	DBProcessStatus
		FROM	WOHeader (nolock)
		WHERE	WONbr = @WONbr
	else
		-- Set the flag value for the WO
		UPDATE	WOHeader
		SET	DBProcessStatus = @Flag
		WHERE	WONbr = @WONbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOProductionCompletionCheck] TO [MSDSL]
    AS [dbo];

