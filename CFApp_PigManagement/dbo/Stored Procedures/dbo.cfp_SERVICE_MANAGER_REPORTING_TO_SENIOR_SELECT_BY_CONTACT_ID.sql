-- =====================================================================================
-- Author:		Brian Cesafsky
-- Create date: 07/01/2008
-- Description:	Returns all the service managers a SENIOR service manger is in charge of
-- =====================================================================================
CREATE PROCEDURE [dbo].[cfp_SERVICE_MANAGER_REPORTING_TO_SENIOR_SELECT_BY_CONTACT_ID]
(
	@ContactID		int
	,@StatusTypeID  int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT  SvcMgrContact.ContactID as SiteServiceManagerContactID
			,SvcMgrContact.ContactName as SiteServiceManager
	FROM [$(CentralData)].dbo.ProdSvcMgrAssignment ProdSvcMgrAssignment(NOLOCK)
	INNER JOIN [$(CentralData)].dbo.Contact ContactMgr (NOLOCK)
		  ON cast(ContactMgr.ContactID as int) = cast(ProdSvcMgrAssignment.ProdSvcMgrContactID as int)
	LEFT OUTER JOIN [$(CentralData)].dbo.Contact Contact (NOLOCK)
		  ON cast(Contact.ContactID as int) = cast(ProdSvcMgrAssignment.SiteContactID as int)
	INNER JOIN (select SiteContactID, max(EffectiveDate) EffDate from [$(CentralData)].dbo.ProdSvcMgrAssignment ProdSvcMgrAssignment2  
	WHERE SiteContactID = ProdSvcMgrAssignment2.SiteContactID
	GROUP BY SiteContactID) Sites
		  ON Sites.SiteContactID = ProdSvcMgrAssignment.SiteContactID
		  AND Sites.EffDate = ProdSvcMgrAssignment.EffectiveDate
	LEFT OUTER JOIN (SELECT SiteContactID, MAX(EffectiveDate) EffectiveDate
				FROM [$(CentralData)].dbo.SiteSvcMgrAssignment (NOLOCK)
				GROUP BY SiteContactID) SvcMgrSites
		  ON SvcMgrSites.SiteContactID = ProdSvcMgrAssignment.SiteContactID
	INNER JOIN [$(CentralData)].dbo.SiteSvcMgrAssignment SiteSvcMgrAssignment (NOLOCK)
		  ON SiteSvcMgrAssignment.SiteContactID = SvcMgrSites.SiteContactID
		  AND SiteSvcMgrAssignment.EffectiveDate = SvcMgrSites.EffectiveDate
	LEFT OUTER JOIN [$(CentralData)].dbo.Contact SvcMgrContact (NOLOCK)
		  ON SvcMgrContact.ContactID = SiteSvcMgrAssignment.SvcMgrContactID
	WHERE ProdSvcMgrAssignment.ProdSvcMgrContactID Is Not Null
	AND ProdSvcMgrAssignment.ProdSvcMgrContactID = @ContactID
	AND Contact.StatusTypeID = @StatusTypeID
	GROUP BY
		  SvcMgrContact.ContactID
		  ,SvcMgrContact.ContactName
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SERVICE_MANAGER_REPORTING_TO_SENIOR_SELECT_BY_CONTACT_ID] TO [db_sp_exec]
    AS [dbo];

