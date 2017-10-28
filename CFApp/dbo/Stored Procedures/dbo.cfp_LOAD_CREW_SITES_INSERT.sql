

-- ==================================================
-- Author:	mdawson
-- Create date: 11/5/2007
-- Description:	Inserts Sites associated with Load Crews
-- ==================================================
CREATE PROCEDURE [dbo].[cfp_LOAD_CREW_SITES_INSERT]
(
	@LoadCrewID				int,
	@AssignedFromDate		datetime,
	@AssignedToDate			datetime,
	@ContactID				int,
	@CreatedBy				varchar(50)
)	
AS
BEGIN
	INSERT INTO dbo.cft_LOAD_CREW_SITES
	(   
		LoadCrewID
		,AssignedFromDate
		,AssignedToDate
		,ContactID
		,CreatedBy
	)
	VALUES 
	(	
		@LoadCrewID
		,@AssignedFromDate
		,@AssignedToDate
		,@ContactID
		,@CreatedBy
	)
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_LOAD_CREW_SITES_INSERT] TO [db_sp_exec]
    AS [dbo];

