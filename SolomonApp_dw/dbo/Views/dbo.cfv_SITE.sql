
-- ==================================================================
-- Author:		Matt Brandt
-- Create date: 12/7/2010
-- Description:	This View returns basic Site information.
-- ==================================================================
CREATE VIEW [dbo].[cfv_SITE]
AS

Select Distinct
s.SiteID 
, s.ContactID as SiteContactID 
, (Select c.ContactName From [$(SolomonApp)].dbo.cftContact c Where c.ContactID = s.ContactID) As SiteContactName 
, s.FeedMillContactID 
, s.SiteMgrContactID as CurrentSiteMgrContactID
, (Select c.ContactName From [$(SolomonApp)].dbo.cftContact c Where c.ContactID = s.SiteMgrContactID) As CurrentSiteManagerName 
, (Select Top 1 svm.SvcMgrContactID 
	From [$(SolomonApp)].dbo.cftSiteSvcMgrAsn svm 
	Where svm.SiteContactID = s.ContactID 
	Order By svm.EffectiveDate Desc) As CurrentSvcMgrContactID 
, (Select c.ContactName 
	From [$(SolomonApp)].dbo.cftContact c 
	Where c.ContactID = (Select Top 1 svm.SvcMgrContactID 
						From [$(SolomonApp)].dbo.cftSiteSvcMgrAsn svm 
						Where svm.SiteContactID = s.ContactID 
						Order By svm.EffectiveDate Desc)
	) As CurrentSvcMgrName 
, (Select Top 1 prod.ProdSvcMgrContactID 
	From [$(SolomonApp)].dbo.cftProdSvcMgr prod 
	Where prod.SiteContactID = s.ContactID 
	Order By prod.EffectiveDate Desc) As CurrentSrSvcMgrContactID 
, (Select c.ContactName 
	From [$(SolomonApp)].dbo.cftContact c 
	Where c.ContactID =  (Select Top 1 prod.ProdSvcMgrContactID 
								From [$(SolomonApp)].dbo.cftProdSvcMgr prod 
								Where prod.SiteContactID = s.ContactID 
								Order By prod.EffectiveDate Desc)
	) As CurrentSrSvcMgrContactName 
, (Select Top 1 m.MktMgrContactID From [$(SolomonApp)].dbo.cftMktMgrAssign m Where m.SiteContactID = s.ContactID Order By m.EffectiveDate Desc) As CurrentMktMgrContactID 
, (Select c.ContactName 
	From [$(SolomonApp)].dbo.cftContact c 
	Where c.ContactID = (Select Top 1 m.MktMgrContactID 
							From [$(SolomonApp)].dbo.cftMktMgrAssign m 
							Where m.SiteContactID = s.ContactID 
							Order By m.EffectiveDate Desc) 
	) As CurrentMktMgrName
, (Select Top 1 ca.AddressID 
	From [$(SolomonApp)].dbo.cftContactAddress ca 
	Where s.ContactID = ca.ContactID And ca.AddressTypeID = '01'
	Order By ca.Lupd_DateTime Desc) As PhysicalSiteAddressID 
, (Select Top 1 ca.AddressID 
	From [$(SolomonApp)].dbo.cftContactAddress ca 
	Where s.ContactID = ca.ContactID And ca.AddressTypeID = '02'
	Order By ca.Lupd_DateTime Desc) As MailingSiteAddressID
, a.Longitude 
, a.Latitude 
, s.FacilityTypeID 
, ft.Description As FacilityTypeDescription 
, c.StatusTypeID 

From [$(SolomonApp)].dbo.cftSite s
	Left Join [$(SolomonApp)].dbo.cftContactAddress ca On s.ContactID = ca.ContactID
	Left Join [$(SolomonApp)].dbo.cftContact c On s.ContactID = c.ContactID
	Left Join [$(SolomonApp)].dbo.cftFacilityType ft On s.FacilityTypeID = ft.FacilityTypeID
	Left Join [$(SolomonApp)].dbo.cftAddress a On ca.AddressID = a.AddressID
	
Where a.Longitude Is Not Null And a.Longitude != 0
	And a.Latitude Is Not Null And a.Latitude != 0
