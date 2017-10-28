-- =============================================
-- Author:		Matt Brandt
-- Create date: 10/11/2010
-- Description:	This procedure makes the Pig Group dataset for the Mastergroup Marketing Distribution report.
-- =============================================
CREATE PROCEDURE dbo.cfp_REPORT_MASTERGROUP_MARKETING_DISTRIBUTION_PIGGROUP 
	-- Add the parameters for the stored procedure here
	@PigGroupID Char(6) 
	
AS
BEGIN

SET NOCOUNT ON;

Declare @PigGroup Table
(CloseoutDate smalldatetime
, PigGroupID char(10)
, MasterGroupID char(10)
, SiteContactID  Char(6)
, Site char(50)
, MarketingManagerID int)

Insert Into @PigGroup

Select (Select MIN(KillDate) 
	from SolomonApp.dbo.cfvPIGSALEREV ps
		Inner Join SolomonApp.dbo.cftContact c on c.ContactID=ps.PkrContactID
		Inner Join SolomonApp.dbo.cftPM pm on pm.PMLoadId = ps.PMLoadID
		Inner Join SolomonApp.dbo.cftMarketSaleType mst on pm.MarketSaleTypeID = mst.MarketSaleTypeID
		Inner Join SolomonApp.dbo.cftPigGroup pg on ps.PigGroupID = pg.PigGroupID
	Where pg.CF03 = (Select CF03 From SolomonApp.dbo.cftPigGroup Where PigGroupID = @PigGroupID)
		and ps.SaleTypeID='MS'
		and RTrim(mst.Description) = 'Closeout') As CloseoutDate
, @PigGroupID As PigGroupID
, (Select CF03 From SolomonApp.dbo.cftPigGroup Where PigGroupID = @PigGroupID) As MasterGroupID
, pg.SiteContactID
, RTrim(sc.ContactName) As Site
, Null

from SolomonApp.dbo.cftPigGroup pg
	Inner Join SolomonApp.dbo.cftContact sc On pg.SiteContactID = sc.ContactID

where pg.PigGroupID = @PigGroupID

Update p
Set MarketingManagerID = SolomonApp_dw.dbo.cffn_GET_SITE_MARKETING_MANAGER(Cast(SiteContactID As Int),CloseoutDate)
From @PigGroup p

Select p.CloseoutDate, p.PigGroupID, p.MasterGroupID, p.Site
, (Select c.ContactName From SolomonApp.dbo.cftContact c Where Cast(c.ContactID As Int) = p.MarketingManagerID) As MarketingManager
From @PigGroup p


END
