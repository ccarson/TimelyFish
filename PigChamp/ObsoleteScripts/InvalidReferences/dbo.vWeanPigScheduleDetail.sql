
----------------------------------------------------------------------------------------
--	Purpose: Detail view for schedule weaned pigs on the flowboard/transportation schedule
--  This information is summarized in vPM2_WeanedPigScheduledQty
--	Author: Timothy Jones
--	Date: 
--	Program Usage: Essbase File Builder for Sow Data
--	Parms: 
--  Revised : Sue Matter
--  Date:  8/13/2007
--  Purpose:  Use Temp tables in SowData that are prefilled at run time
----------------------------------------------------------------------------------------
CREATE VIEW [dbo].[vWeanPigScheduleDetail] 	
	(FarmID, ContactID, WeekOfDate, MovementDate, EstimatedQty)
	AS 	
	SELECT --FarmID=dbo.GetSowFarmIDFromContactID(pm.SourceContactID,pm.MovementDate),
		farmid = left(c.contactname,1) + right(c.contactname,2),
		ContactID = pm.SourceContactID, 
		dd.WeekOfDate, pm.MovementDate, 
		pm.EstimatedQty
		FROM cftPMTemp pm
		JOIN [$(SolomonApp)].dbo.cftDayDefinition dd ON dd.DayDate = pm.MovementDate
		join [$(CentralData)].dbo.contact c (nolock) on c.solomoncontactid = pm.sourcecontactid
		--JOIN FarmSetup fs ON fs.FarmID = dbo.GetSowFarmIDFromContactID(pm.SourceContactID,pm.MovementDate)
		WHERE 
		pm.PigTypeID='02' -- Only want weaned pigs



GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vWeanPigScheduleDetail] TO [se\analysts]
    AS [dbo];

