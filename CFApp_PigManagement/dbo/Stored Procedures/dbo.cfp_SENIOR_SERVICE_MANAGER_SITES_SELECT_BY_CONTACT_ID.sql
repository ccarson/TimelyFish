-- ===========================================================================
-- Author:		Brian Cesafsky
-- Create date: 07/01/2008
-- Description:	Returns all the sites a SENIOR service manager is in charge of
-- ===========================================================================
CREATE PROCEDURE [dbo].[cfp_SENIOR_SERVICE_MANAGER_SITES_SELECT_BY_CONTACT_ID]
(
	@SrSvcMgrContactID				INT
	,@SiteSvcMgrContactID			INT
	,@StatusTypeID					INT
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @SiteSvcMgrContactID = 0
BEGIN
      SELECT  
          ProdSvcMgrAssignment.ProdSvcMgrContactID 
          ,ContactMgr.ContactName as SeniorServiceManager
          ,SiteSvcMgrContact.ContactID as SiteSvcMgrContactID
          ,SiteSvcMgrContact.ContactName as SiteServiceManager
          ,ProdSvcMgrAssignment.SiteContactID
          ,Contact.ContactName as SiteName
          ,MAX(SiteHealth.SiteContactDate) SiteContactDate
      FROM [$(CentralData)].dbo.ProdSvcMgrAssignment ProdSvcMgrAssignment(NOLOCK)
      INNER JOIN [$(CentralData)].dbo.Contact ContactMgr (NOLOCK)
            ON cast(ContactMgr.ContactID as int) = cast(ProdSvcMgrAssignment.ProdSvcMgrContactID as int)
      LEFT OUTER JOIN [$(CentralData)].dbo.Contact Contact (NOLOCK)
            ON cast(Contact.ContactID as int) = cast(ProdSvcMgrAssignment.SiteContactID as int)
      LEFT OUTER JOIN dbo.cft_SITE_HEALTH SiteHealth (NOLOCK)
            ON cast(SiteHealth.SiteContactID as int) = cast(ProdSvcMgrAssignment.SiteContactID as int) 
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
      LEFT OUTER JOIN [$(CentralData)].dbo.Contact SiteSvcMgrContact (NOLOCK)
            ON SiteSvcMgrContact.ContactID = SiteSvcMgrAssignment.SvcMgrContactID
      WHERE ProdSvcMgrAssignment.ProdSvcMgrContactID Is Not Null
      AND ProdSvcMgrAssignment.ProdSvcMgrContactID = @SrSvcMgrContactID
	  AND Contact.StatusTypeID = @StatusTypeID
      GROUP BY Contact.ContactName
                              ,ContactMgr.ContactName
                              ,ProdSvcMgrAssignment.ProdSvcMgrAssignmentID
                              ,ProdSvcMgrAssignment.EffectiveDate
                              ,ProdSvcMgrAssignment.SiteContactID
                              ,ProdSvcMgrAssignment.ProdSvcMgrContactID 
                              ,SiteSvcMgrContact.ContactID
                              ,SiteSvcMgrContact.ContactName
      ORDER BY SiteName ASC
END
ELSE
BEGIN
      SELECT  
          ProdSvcMgrAssignment.ProdSvcMgrContactID 
          ,ContactMgr.ContactName as SeniorServiceManager
          ,SiteSvcMgrContact.ContactID as SiteSvcMgrContactID
          ,SiteSvcMgrContact.ContactName as SiteServiceManager
          ,ProdSvcMgrAssignment.SiteContactID
          ,Contact.ContactName as SiteName
          ,MAX(SiteHealth.SiteContactDate) SiteContactDate
      FROM [$(CentralData)].dbo.ProdSvcMgrAssignment ProdSvcMgrAssignment(NOLOCK)
      INNER JOIN [$(CentralData)].dbo.Contact ContactMgr (NOLOCK)
            ON cast(ContactMgr.ContactID as int) = cast(ProdSvcMgrAssignment.ProdSvcMgrContactID as int)
      LEFT OUTER JOIN [$(CentralData)].dbo.Contact Contact (NOLOCK)
            ON cast(Contact.ContactID as int) = cast(ProdSvcMgrAssignment.SiteContactID as int)
      LEFT OUTER JOIN dbo.cft_SITE_HEALTH SiteHealth (NOLOCK)
            ON cast(SiteHealth.SiteContactID as int) = cast(ProdSvcMgrAssignment.SiteContactID as int) 
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
      LEFT OUTER JOIN [$(CentralData)].dbo.Contact SiteSvcMgrContact (NOLOCK)
            ON SiteSvcMgrContact.ContactID = SiteSvcMgrAssignment.SvcMgrContactID
      WHERE ProdSvcMgrAssignment.ProdSvcMgrContactID Is Not Null
      AND ProdSvcMgrAssignment.ProdSvcMgrContactID = @SrSvcMgrContactID
      AND SiteSvcMgrContact.ContactID = @SiteSvcMgrContactID
	  AND Contact.StatusTypeID = @StatusTypeID
      GROUP BY Contact.ContactName
                              ,ContactMgr.ContactName
                              ,ProdSvcMgrAssignment.ProdSvcMgrAssignmentID
                              ,ProdSvcMgrAssignment.EffectiveDate
                              ,ProdSvcMgrAssignment.SiteContactID
                              ,ProdSvcMgrAssignment.ProdSvcMgrContactID 
                              ,SiteSvcMgrContact.ContactID
                              ,SiteSvcMgrContact.ContactName
      ORDER BY SiteName ASC
END
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SENIOR_SERVICE_MANAGER_SITES_SELECT_BY_CONTACT_ID] TO [db_sp_exec]
    AS [dbo];

