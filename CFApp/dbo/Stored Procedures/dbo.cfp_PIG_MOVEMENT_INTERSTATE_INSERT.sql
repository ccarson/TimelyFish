CREATE PROCEDURE [dbo].[cfp_PIG_MOVEMENT_INTERSTATE_INSERT]
(
	@PMID					varchar(10),
	@PMLoadID				varchar(10),
	@SourceContactID		char(10),
	@MovementDate			smalldatetime,
	@DestContactID			char(10)
)	
AS
BEGIN
	INSERT INTO dbo.cft_PIG_MOVEMENT_INTERSTATE_TEMP
	(    		
		 PMID
		,PMLoadID
		,SourceContactID
		,MovementDate
		,DestContactID
	)
	VALUES 
	(	
		 @PMID
		,@PMLoadID
		,@SourceContactID
		,@MovementDate
		,@DestContactID
	)
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_MOVEMENT_INTERSTATE_INSERT] TO [db_sp_exec]
    AS [dbo];

