-- =============================================
-- Author:		Matt Brandt
-- Create date: 01/26/2011
-- Description:	This procedure makes the Inventory dataset for the Marketing Site Plan report.
-- =============================================
CREATE PROCEDURE dbo.cfp_REPORT_MARKETING_SITE_PLAN_ELIGIBILITY 
	-- Add the parameters for the stored procedure here
	@SiteName Char(50) 
	
AS
BEGIN

SET NOCOUNT ON;

Declare @SiteContactID Char(6)
Select @SiteContactID = SiteContactID From  dbo.cfv_Site Where RTrim(SiteContactName) = RTrim(@SiteName)

-------------
--Eligibility
-------------

Declare @Eligibility Table

(BarnNumber Char(6)
, PigGroupID Char(10)
, TriumphEligible Char(3)
, WithdrawalDate Datetime
, EligibleToBeMarketedDate Datetime
, ChosenMarketingStrategy Int
)

Insert Into @Eligibility

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
, Null
, Null
, Null

From [$(SolomonApp)].dbo.cftPigGroup pg

Where pg.CF03 = (Select Top 1 CF03 --Current MastergroupID
				From [$(SolomonApp)].dbo.cftPigGroup 
				Where SiteContactID = @SiteContactID 
				Order By ActStartDate Desc)
				
Order By BarnNumber

Select *
From @Eligibility

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_MARKETING_SITE_PLAN_ELIGIBILITY] TO [db_sp_exec]
    AS [dbo];

