-- =============================================
-- Author:		Matt Brandt
-- Create date: 12/27/2010
-- Description:	This procedure makes the Inventory dataset for the Marketing Site Plan report.
-- =============================================
CREATE PROCEDURE dbo.cfp_REPORT_MARKETING_SITE_PLAN_SITE_INFO 
	-- Add the parameters for the stored procedure here
	@SiteContactID Char(6) 
	
AS
BEGIN

SET NOCOUNT ON;

------------------
--Site Information
------------------

Select Distinct @SiteContactID As SiteContactID
, RTrim(s.SiteContactName) As SiteName
, RTrim(s.CurrentSiteManagerName) As SiteManager
, Case 
	When Exists 
		(
		Select p.PhoneNbr 
		From SolomonApp.dbo.cftPhone p
			Inner Join SolomonApp.dbo.cftContactPhone cp On p.PhoneID = cp.PhoneID 
		Where s.CurrentSiteMgrContactID = cp.ContactID
			And cp.PhoneTypeID = '003'
		)
	Then 
		(
		Select Top 1 p.PhoneNbr 
		From SolomonApp.dbo.cftPhone p
			Inner Join SolomonApp.dbo.cftContactPhone cp On p.PhoneID = cp.PhoneID 
		Where s.CurrentSiteMgrContactID = cp.ContactID
			And cp.PhoneTypeID = '003'
		Order By cp.Lupd_DateTime Desc
		)
	Else Null End As SiteManagerPhoneNumber
, (Select Top 1 CF03 --Current MastergroupID
				From SolomonApp.dbo.cftPigGroup 
				Where SiteContactID = @SiteContactID 
				Order By ActStartDate Desc) As MasterGroupID
, RTrim(s.CurrentMktMgrName) As MarketingManager
, Case 
	When Exists 
		(
		Select p.PhoneNbr 
		From SolomonApp.dbo.cftPhone p
			Inner Join SolomonApp.dbo.cftContactPhone cp On p.PhoneID = cp.PhoneID 
		Where s.CurrentMktMgrContactID = cp.ContactID
			And cp.PhoneTypeID = '003'
		)
	Then 
		(
		Select Top 1 p.PhoneNbr 
		From SolomonApp.dbo.cftPhone p
			Inner Join SolomonApp.dbo.cftContactPhone cp On p.PhoneID = cp.PhoneID 
		Where s.CurrentMktMgrContactID = cp.ContactID
			And cp.PhoneTypeID = '003'
		Order By cp.Lupd_DateTime Desc
		)
	Else Null End As MarketingManagerPhoneNumber
, 'Not Implemented' As RecommendedMarketingStrategy
, 'Not Implemented' As ChosenMarketingStrategy
, 'Yes or No' As TriumphEligible

From SolomonApp_dw.dbo.cfv_SITE s

Where s.SiteContactID = @SiteContactID

END
