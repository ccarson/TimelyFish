
-- ==================================================================
-- Author:		Matt Brandt
-- Create date: 1/14/2011
-- Description:	This View populates the cft_SITE_VISIT table.
-- ==================================================================
CREATE VIEW [dbo].[cfv_SITE_VISIT]
AS

Select sv.PigGroupID, pg.SiteContactID, pg.BarnNbr, sv.CurrentFeedBinInventory, sv.MedicationWithdrawalDate
, sv.PigHealth, sv.GrowthRate, sv.MarketingPlan, sv.DateOfVisit, sv.Datestamp, sv.UserID

From  dbo.cft_SITE_VISIT sv
	Inner Join [$(SolomonApp)].dbo.cftPigGroup pg On sv.PigGroupID = pg.PigGroupID 
