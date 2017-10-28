-- =====================================================================
-- Author:		Brian Cesafsky
-- Create date: 06/25/2008
-- Description:	Returns all the sites a service manger is in charge of
-- =====================================================================
CREATE PROCEDURE [dbo].[cfp_SERVICE_MANAGER_SITES_BY_CONTACT_ID_SELECT]
(
	@ContactID			int
	,@StatusTypeID		int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT  Contact.ContactName as SiteName
            ,ContactMgr.ContactName as ServiceManager
            ,SiteSvcMgrAssignment.SiteSvcMgrAssignmentID
            ,SiteSvcMgrAssignment.EffectiveDate
            ,SiteSvcMgrAssignment.SiteContactID
            ,SiteSvcMgrAssignment.SvcMgrContactID 
            ,MAX(SiteHealth.SiteContactDate) SiteContactDate
	FROM [$(CentralData)].dbo.SiteSvcMgrAssignment SiteSvcMgrAssignment(NOLOCK)
	INNER JOIN [$(CentralData)].dbo.Contact ContactMgr (NOLOCK)
		ON cast(ContactMgr.ContactID as int) = cast(SiteSvcMgrAssignment.SvcMgrContactID as int)
	LEFT OUTER JOIN [$(CentralData)].dbo.Contact Contact (NOLOCK)
		ON cast(Contact.ContactID as int) = cast(SiteSvcMgrAssignment.SiteContactID as int)
	LEFT OUTER JOIN dbo.cft_SITE_HEALTH SiteHealth (NOLOCK)
		ON cast(SiteHealth.SiteContactID as int) = cast(SiteSvcMgrAssignment.SiteContactID as int) 
	INNER JOIN (select SiteContactID, max(EffectiveDate) EffDate from [$(CentralData)].dbo.SiteSvcMgrAssignment SiteSvcMgrAssignment2
	WHERE SiteContactID = SiteSvcMgrAssignment2.SiteContactID
	GROUP BY SiteContactID) Sites
		ON Sites.SiteContactID = SiteSvcMgrAssignment.SiteContactID
		AND Sites.EffDate = SiteSvcMgrAssignment.EffectiveDate
	WHERE SiteSvcMgrAssignment.SvcMgrContactID Is Not Null
	AND SiteSvcMgrAssignment.SvcMgrContactID = @ContactID
	AND Contact.StatusTypeID = @StatusTypeID
	GROUP BY Contact.ContactName
					,ContactMgr.ContactName
					,SiteSvcMgrAssignment.SiteSvcMgrAssignmentID
					,SiteSvcMgrAssignment.EffectiveDate
					,SiteSvcMgrAssignment.SiteContactID
					,SiteSvcMgrAssignment.SvcMgrContactID 
	ORDER BY SiteName ASC;
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SERVICE_MANAGER_SITES_BY_CONTACT_ID_SELECT] TO [db_sp_exec]
    AS [dbo];

