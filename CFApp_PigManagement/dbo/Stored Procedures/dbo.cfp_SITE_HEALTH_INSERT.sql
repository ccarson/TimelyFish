
-- ===================================================================
-- Author:	Brian Cesafsky
-- Create date: 06/26/2008
-- Description:	Creates new Site Health record and returns it's ID.
-- ===================================================================
CREATE PROCEDURE dbo.cfp_SITE_HEALTH_INSERT
(
	@SiteHealthID				int		OUT,
	@SiteContactID				int,
	@SiteContactDate			smalldatetime,
	@HealthConcern				bit,
	@CreatedBy					varchar(50)
)
AS
BEGIN
	SET NOCOUNT ON

	INSERT dbo.cft_SITE_HEALTH
	(
		[SiteContactID]
		,[SiteContactDate]
		,[HealthConcern]
		,[CreatedBy]
	) 
	VALUES 
	(
		@SiteContactID
		,@SiteContactDate
		,@HealthConcern
		,@CreatedBy
	)
	set @SiteHealthID = @@identity
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SITE_HEALTH_INSERT] TO [db_sp_exec]
    AS [dbo];

