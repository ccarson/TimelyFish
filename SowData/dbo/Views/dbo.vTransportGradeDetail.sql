
----------------------------------------------------------------------------------------
--	Purpose: Select the transport grade qty detail from SolomonApp
--	Author: Timothy Jones
--	Date: 
--	Program Usage: Essbase File Builder for Sow Data
--	Parms: 
--  Revised : Sue Matter
--  Date:  8/13/2007
--  Purpose:  Use Temp tables in SowData that are prefilled at run time
----------------------------------------------------------------------------------------

Create VIEW [dbo].[vTransportGradeDetail] 	
	(FarmID, ContactID, WeekOfDate, MovementDate, PigGradeCatTypeID,
	 GradeDescr,Qty)
	AS 	
	SELECT FarmID=dbo.GetSowFarmIDFromContactID(tr.SourceContactID,tr.MovementDate),
		ContactID = tr.SourceContactID, 
		dd.WeekOfDate, tr.MovementDate, gq.PigGradeCatTypeID, 
		GradeDescr=CASE gq.PigGradeCatTypeID 
				WHEN '01' THEN 'Standards' 
				WHEN '02' THEN 'Subs'
				WHEN '03' THEN 'NVs'
				WHEN '04' THEN 'DBG'
				WHEN '05' THEN 'DOT'
				WHEN '06' THEN 'Boars'
				ELSE 'NA' END,
		gq.Qty 
		FROM cftPMGradeQtyTemp gq
		JOIN cftPMTranspRecordTemp tr ON gq.BatchNbr = tr.BatchNbr AND gq.RefNbr = tr.RefNbr
		JOIN DayDefinition dd ON dd.DayDate = tr.MovementDate
		JOIN FarmSetup fs ON fs.FarmID = dbo.GetSowFarmIDFromContactID(tr.SourceContactID,tr.MovementDate)
		LEFT JOIN cftPMTranspRecordTemp re on tr.RefNbr=re.OrigRefNbr
		WHERE (tr.RecountQty>0 or tr.DestFarmQty>0) 
		AND tr.PigTypeID='02' -- Only want weaned pigs
		AND re.RefNbr IS NULL -- Filters out reversals
		AND tr.DocType='TR'


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vTransportGradeDetail] TO [se\analysts]
    AS [dbo];

