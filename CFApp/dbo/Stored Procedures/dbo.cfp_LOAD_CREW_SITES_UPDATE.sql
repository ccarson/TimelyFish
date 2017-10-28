

-- =============================================
-- Author:	mdawson
-- Create date: 11/8/2007
-- Description:	Updates Site Wash Schedule Record
-- =============================================
CREATE PROCEDURE [dbo].[cfp_LOAD_CREW_SITES_UPDATE] 
(
	@LoadCrewID				int,
	@AssignedFromDate		datetime,
	@AssignedToDate			datetime,
	@ContactID				int,
	@NewContactID			int,
	@UpdatedBy				varchar(50)
)
AS
BEGIN
	UPDATE dbo.cft_LOAD_CREW_SITES
	SET AssignedFromDate = @AssignedFromDate
		,AssignedToDate = @AssignedToDate
		,ContactID = @NewContactID
		,UpdatedBy = @UpdatedBy
		,UpdatedDateTime = getdate()
	WHERE 	LoadCrewID = @LoadCrewID
	AND	ContactID = @ContactID
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_LOAD_CREW_SITES_UPDATE] TO [db_sp_exec]
    AS [dbo];

