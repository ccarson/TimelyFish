



CREATE VIEW [dbo].[cfv_PM_SAFE_Wgt]
AS
Select distinct 
pm.PMLoadID, 
pm.MovementDate,
pm.comment, 
wd.PICWeek AS 'Week', 
CAST(pm.LoadingTime as time) as Loadingtime,
pt.PigTypeDesc as PigType,
oaFlow.Flow AS Flow, 
SC.ContactName as Origin,
DC.ContactName as Dest,
trk.ContactName as TruckerName, 
lw.Call_DateTime, 
lw.Grading_Count as GradingCount,
lw.GrossWgt, 
lw.TareWgt, 
lw.GrossWgt - lw.TareWgt as Net, 
lw.SDI_Nbr, 
lw.Trucker as TruckerPhone
from  [dbo].[cftPM] pm (NOLOCK)
Join cftContact sc (NOLOCK) on pm.SourceContactID = sc.ContactID
Join cftContact dc (NOLOCK) on pm.DestContactID = dc.ContactID
Join cftContact trk (NOLOCK) on pm.TruckerContactID = trk.ContactID
join [SolomonApp].[dbo].[cftWeekDefinition] wd on pm.MovementDate between wd.WeekOfDate and wd.WeekEndDate
join [dbo].[cftPigType] pt (NOLOCK) on pm.pigTypeID = pt.PigTypeID
LEFT join [dbo].[cftSafeLoadWgt] lw (NOLOCK) on pm.PMLoadID = lw.PMLoadID
OUTER APPLY ( 
    select top 1 
        Flow = rg.reporting_group_description 
    FROM 
        CFApp_PigManagement.dbo.cft_PIG_FLOW pf (NOLOCK)
    JOIN 
        CFApp_PigManagement.dbo.cft_PIG_FLOW_FARM pff (NOLOCK)  
            on pf.[PigFlowID] = pff.[PigFlowID]
    join 
        cfapp_pigmanagement.dbo.cft_pig_flow_reporting_group rg (nolock)
	        on rg.reportinggroupid = pf.reportinggroupid
    where 
        pm.MovementDate between pf.pigflowfromdate and isnull(pf.[PigFlowToDate],getdate())
            AND pff.ContactID = pm.SourceContactID 
            AND rg.reportinggroupid <> 0) AS oaFlow
Where (PM.Highlight <> 255 and PM.Highlight <> -65536) 





