

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

Create VIEW [dbo].[vTransportDetail] 	
	(FarmID, ContactID, WeekOfDate, MovementDate, SourceQty,
	 DestQty,RecountQty)
	AS 	
	SELECT --FarmID=dbo.GetSowFarmIDFromContactID(tr.SourceContactID,tr.MovementDate),
	    farmid = left(c.contactname,1) + right(c.contactname,2),
		ContactID = tr.SourceContactID, 
		dd.WeekOfDate, tr.MovementDate, 
		tr.SourceFarmQty, tr.DestFarmQty,
		RecountQty = CASE tr.RecountRequired WHEN 1 THEN tr.RecountQty ELSE tr.DestFarmQty END
		FROM cftPMTranspRecordTemp tr 
		JOIN [$(SolomonApp)].dbo.cftDayDefinition dd ON dd.DayDate = tr.MovementDate
		join [$(CentralData)].dbo.contact c (nolock) on c.solomoncontactid = tr.sourcecontactid
--		JOIN FarmSetup fs ON fs.FarmID = dbo.GetSowFarmIDFromContactID(tr.SourceContactID,tr.MovementDate)
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

