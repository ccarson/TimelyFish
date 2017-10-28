


-- =====================================================================================================
-- Author:		Nick Honetschlager
-- Create date: 10/11/2016
-- Description:	This procedure creates the primary dataset for the Transport Missing Load Weight Report
--	            in the Transportation folder. Based on [cfp_REPORT_TRANSPORTATION_LOAD_WGT]
-- =====================================================================================================
CREATE PROCEDURE [dbo].[cfp_REPORT_MISSING_TRANSPORTATION_LOAD_WGT]
		@StartDate as Datetime = NULL,
		@EndDate as Datetime = NULL,
		@PigType as varchar(30),
		@Contractor as varchar(6)
AS
		
BEGIN

SET NOCOUNT ON;

SELECT DISTINCT 
pm.PMLoadID, 
pm.MovementDate,
pm.LoadingTime,
pm.ArrivalTime,
pm.comment,
pt.PigTypeDesc as PigType,
--SolomonApp.dbo.getSiteFlow(pm.SourceContactID,pm.MovementDate) as Flow, 
SC.ContactName as Origin,
DC.ContactName as Dest,
cn.TruckingCompanyName,
trk.ContactName as TruckerName,
lw.Grading_Count as GradingCount,
lw.GrossWgt, 
lw.TareWgt, 
lw.GrossWgt - lw.TareWgt as Net
FROM  [dbo].[cftPM] pm (NOLOCK)
JOIN cftContact sc (NOLOCK) on pm.SourceContactID = sc.ContactID
JOIN cftContact dc (NOLOCK) on pm.DestContactID = dc.ContactID
JOIN cftContact trk (NOLOCK) on pm.TruckerContactID = trk.ContactID
LEFT JOIN cfv_DriverCompany cn (NOLOCK) ON pm.TruckerContactID = cn.DriverContactID
JOIN [SolomonApp].[dbo].[cftWeekDefinition] wd on pm.MovementDate between wd.WeekOfDate and wd.WeekEndDate
JOIN [dbo].[cftPigType] pt (NOLOCK) on pm.pigTypeID = pt.PigTypeID
LEFT JOIN [dbo].[cftSafeLoadWgt] lw (NOLOCK) on pm.PMLoadID = lw.PMLoadID
WHERE (PM.Highlight <> 255 and PM.Highlight <> -65536)

AND pm.MovementDate BETWEEN CASE WHEN @StartDate = null Then convert(date, getdate()) Else convert(date, @StartDate) End 
							AND CASE WHEN @EndDate = null Then convert(date, getdate()) Else convert(date, @EndDate) End
And pt.PigTypeDesc Like Case When lTrim(rTrim(@PigType)) LIKE '- All -' Then '%' Else @PigType End
AND cn.TruckingCompanyContactID LIKE @Contractor
AND ( GrossWgt IS NULL OR TareWgt IS NULL)
 
ORDER BY MovementDate, LoadingTime

END





