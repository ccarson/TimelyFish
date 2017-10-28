-- =====================================================================
-- Author:		Brian Cesafsky
-- Create date: 06/25/2008
-- Description:	Returns all the sites a service manger is in charge of
-- =====================================================================
CREATE PROCEDURE [dbo].[cfp_SERVICE_MANAGER_SITES_BY_USER_NAME_SELECT]
(
	@UserID		varchar(20)
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
                        ,Employee.UserID
                        ,MAX(SiteHealth.SiteContactDate) SiteContactDate
      FROM [$(CentralData)].dbo.SiteSvcMgrAssignment SiteSvcMgrAssignment(NOLOCK)
      inner JOIN [$(CentralData)].dbo.Contact ContactMgr (NOLOCK)
            ON cast(ContactMgr.ContactID as int) = cast(SiteSvcMgrAssignment.SvcMgrContactID as int)
      left outer  JOIN [$(CentralData)].dbo.Contact Contact (NOLOCK)
            ON cast(Contact.ContactID as int) = cast(SiteSvcMgrAssignment.SiteContactID as int)
      left outer JOIN [$(CentralData)].dbo.Employee Employee (NOLOCK)
            ON cast(Employee.ContactID as int) = cast(ContactMgr.ContactID as int)
      left outer  JOIN dbo.cft_SITE_HEALTH SiteHealth (NOLOCK)
            ON cast(SiteHealth.SiteContactID as int) = cast(SiteSvcMgrAssignment.SiteContactID as int) 
      inner join (select SiteContactID, max(EffectiveDate) EffDate from [$(CentralData)].dbo.SiteSvcMgrAssignment SiteSvcMgrAssignment2
      where SiteContactID = SiteSvcMgrAssignment2.SiteContactID
      group by SiteContactID) Sites
            on Sites.SiteContactID = SiteSvcMgrAssignment.SiteContactID
            and Sites.EffDate = SiteSvcMgrAssignment.EffectiveDate
      WHERE SiteSvcMgrAssignment.SvcMgrContactID Is Not Null
      and rtrim(Employee.UserID) = @UserID
      group by Contact.ContactName
                        ,ContactMgr.ContactName
                        ,SiteSvcMgrAssignment.SiteSvcMgrAssignmentID
                        ,SiteSvcMgrAssignment.EffectiveDate
                        ,SiteSvcMgrAssignment.SiteContactID
                        ,SiteSvcMgrAssignment.SvcMgrContactID 
                        ,Employee.UserID
      ORDER BY SiteName ASC;
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SERVICE_MANAGER_SITES_BY_USER_NAME_SELECT] TO [db_sp_exec]
    AS [dbo];

