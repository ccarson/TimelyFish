-- =============================================
-- Author:		Matt Brandt
-- Create date: 01/26/2011
-- Description:	This procedure makes the Triumph Eligibility dataset for the Triumph Site Eligibility report.
-- =============================================
CREATE PROCEDURE dbo.cfp_REPORT_TRIUMPH_SITE_ELIGIBLITY 
	@SiteName Char(50) 
	
AS
BEGIN

SET NOCOUNT ON;

Declare @SiteContactID Char(6)

Select @SiteContactID = SiteContactID From  dbo.cfv_Site Where RTrim(SiteContactName) = RTrim(@SiteName)

Select RTrim(pg.BarnNbr) As BarnNumber
, RTrim(pg.PigGroupID) As PigGroupID
, Case When Exists (
				Select f.* 
				From [$(SolomonApp)].dbo.cftFeedOrder f 
				Where f.PigGroupID = pg.PigGroupID
					And f.InvtIdDel In('053M-NT','054M-NT','055M-NT')
					And f.Reversal = '0'
					)
		Then 'No' Else 'Yes' End As TriumphEligible

From [$(SolomonApp)].dbo.cftPigGroup pg
	Inner Join  dbo.cfv_SITE s On pg.SiteContactID = s.SiteContactID

Where pg.CF03 = (Select Top 1 CF03 --Current MastergroupID
				From [$(SolomonApp)].dbo.cftPigGroup 
				Where SiteContactID = @SiteContactID 
				Order By ActStartDate Desc)
				
Order By BarnNumber


END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_TRIUMPH_SITE_ELIGIBLITY] TO [db_sp_exec]
    AS [dbo];

