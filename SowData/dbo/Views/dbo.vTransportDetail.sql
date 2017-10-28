----------------------------------------------------------------------------------------
--	Purpose: Select the transportation detail from SolomonApp
--	Author: Timothy Jones
--	Date: 
--	Program Usage: Essbase File Builder for Sow Data
--	Parms: 
--  Revised : Sue Matter
--  Date:  8/13/2007
--  Purpose:  Use Temp tables in SowData that are prefilled at run time
----------------------------------------------------------------------------------------

CREATE view [dbo].[vTransportDetail] 	
	(FarmID, ContactID, WeekOfDate, MovementDate, SourceQty,
	 DestQty,RecountQty)
	AS 	
	SELECT --FarmID=dbo.GetSowFarmIDFromContactID(tr.SourceContactID,tr.MovementDate),
	    farmid = f.farm_name,
		ContactID = tr.SourceContactID, 
		dd.WeekOfDate, tr.MovementDate, 
		tr.SourceFarmQty, tr.DestFarmQty,
		RecountQty = CASE tr.RecountRequired WHEN 1 THEN tr.RecountQty ELSE tr.DestFarmQty END
		FROM cftPMTranspRecordTemp tr 
		JOIN [$(SolomonApp)].dbo.cftDayDefinition dd ON dd.DayDate = tr.MovementDate
--		JOIN FarmSetup fs ON fs.FarmID = dbo.GetSowFarmIDFromContactID(tr.SourceContactID,tr.MovementDate)
		join[$(PigCHAMP)].[careglobal].[FARMS] f (nolock)
		--	on '00'+f.farm_number =  tr.sourcecontactid
			on f.farm_number = right(rtrim(tr.sourcecontactid),4)
--do this when filling temp table		
--LEFT JOIN cftPMTranspRecordTemp re on tr.RefNbr=re.OrigRefNbr
		WHERE (tr.RecountQty>0 or tr.DestFarmQty>0) 
		AND tr.PigTypeID='02' -- Only want weaned pigs
		--AND re.RefNbr IS NULL -- Filters out reversals
		AND tr.DocType='TR'

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vTransportDetail] TO [se\analysts]
    AS [dbo];

