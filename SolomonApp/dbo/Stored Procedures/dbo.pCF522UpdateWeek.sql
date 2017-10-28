
/****** Object:  Stored Procedure dbo.pCF522UpdateWeek    Script Date: 12/20/2005 11:54:04 AM ******/

/****** Object:  Stored Procedure dbo.pCF522UpdateWeek    Script Date: 12/19/2005 3:15:45 PM ******/

CREATE   Procedure pCF522UpdateWeek 
AS 
Update cftPigMktValue 
Set WkDet = Right(RTrim(wd.PICYEAR),2) + RTrim(wd.PICWeek)
From cftWeekDefinition wd
JOIN cftPigMktValue mv ON mv.MktDate < = wd.WeekEndDate AND mv.MktDate >= wd.WeekOfDate
 




GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF522UpdateWeek] TO [MSDSL]
    AS [dbo];

