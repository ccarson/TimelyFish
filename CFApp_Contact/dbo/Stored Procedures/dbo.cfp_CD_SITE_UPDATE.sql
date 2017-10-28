
-- ===================================================================
-- Author:	Brian Cesafsky
-- Create date: 09/28/2009
-- Description:	CENTRAL DATA - Updates a site record 
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CD_SITE_UPDATE
(
	@SiteID										int,
	@AutomateInterstatePigMovementReport		bit
)
AS
BEGIN
	UPDATE [$(CentralData)].dbo.Site
	SET [AutomateInterstatePigMovementReport] = @AutomateInterstatePigMovementReport
	WHERE 
		[SiteID] = @SiteID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CD_SITE_UPDATE] TO [db_sp_exec]
    AS [dbo];

