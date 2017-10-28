CREATE VIEW [dbo].[vPM_CalcDeath] (FarmID, WeekOfDate, SowID, SowParity,SortCode, NextWeanCode, FirstONCode)
	As
Select swe.FarmID, swe.WeekOfDate, swe.SowID, swe.SowParity, swe.SortCode, min(nw.SortCode) as NextWean,
	max(ba.SortCode) as FirstON
	From SowWeanEventTemp swe 
	LEFT JOIN SowWeanEventTemp nw 
	ON swe.SowID=nw.SowID 
	AND swe.SowParity=nw.SowParity
	AND swe.SortCode<nw.SortCode
	LEFT JOIN (Select SowID, SowParity, SortCode
				from SowFarrowEventTemp 
				UNION
			   Select SowID, SowParity, SortCode
				From SowNurseEventTemp
				where EventType='NURSE ON') ba
		ON swe.SowID=ba.SowID 
		AND swe.SowParity=ba.SowParity
		AND swe.SortCode>ba.SortCode

--where swe.SowID='012377'	
Group by swe.FarmID, swe.WeekOFDate,swe.SowID, swe.SowParity, swe.SortCode

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM_CalcDeath] TO [se\analysts]
    AS [dbo];

