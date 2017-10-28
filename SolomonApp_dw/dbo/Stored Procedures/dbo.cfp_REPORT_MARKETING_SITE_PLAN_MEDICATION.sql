-- =============================================
-- Author:		Matt Brandt
-- Create date: 03/18/2010
-- Description:	This procedure makes the Inventory dataset for the Marketing Site Plan report.
-- =============================================
CREATE PROCEDURE dbo.cfp_REPORT_MARKETING_SITE_PLAN_MEDICATION 
	-- Add the parameters for the stored procedure here
	@SiteName Char(50) 
	
AS
BEGIN

SET NOCOUNT ON;
 
Declare @SiteContactID Char(6)
Select @SiteContactID = SiteContactID From  dbo.cfv_Site Where RTrim(SiteContactName) = RTrim(@SiteName)

-------------
--Medications
-------------

Select RTrim(pg.BarnNbr) As BarnNumber
, RTrim(pg.PigGroupID) As PigGroupID
, RTrim(IsNull(m.Medication,'None')) As Medication
, m.EndDate
, DateAdd(dd,m.TriWithdrawalDays,m.EndDate) As MarketableToTriumph
, DateAdd(dd,m.NonTriWithdrawalDays,m.EndDate) As MarketableElsewhere

From [$(SolomonApp)].dbo.cftPigGroup pg
	Left Join (--Medication List
		Select med.PigGroupID, med.Medication, med.EndDate, w.TriWithdrawalDays, w.NonTriWithdrawalDays
		From  dbo.cft_MARKETING_SITE_PLAN_MEDICATIONS med
			Inner Join [$(SolomonApp)].dbo.cftPigGroup pg On med.PigGroupID = pg.PigGroupID
			Left Join  dbo.cft_MARKETING_SITE_PLAN_MED_WITHDRAWAL w On med.Medication = w.Medication
				) m On m.PigGroupID = pg.PigGroupID
				
Where pg.CF03 = (Select Top 1 CF03 --Current MastergroupID
				From [$(SolomonApp)].dbo.cftPigGroup 
				Where SiteContactID = @SiteContactID 
				Order By ActStartDate Desc)
				
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_MARKETING_SITE_PLAN_MEDICATION] TO [db_sp_exec]
    AS [dbo];

