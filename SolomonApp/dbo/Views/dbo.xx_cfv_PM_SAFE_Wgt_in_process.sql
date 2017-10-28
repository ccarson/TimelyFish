
CREATE VIEW [dbo].[xx_cfv_PM_SAFE_Wgt_in_process]
AS
Select   DISTINCT
    pm.PMLoadID
  , pm.MovementDate
  , pm.comment
  , Week                =   wd.PICWeek 
  , Loadingtime         =   CAST(pm.LoadingTime as time)
  , PigType             =   pt.PigTypeDesc       
  , Flow                =   oaFlow.Flow          
  , Origin              =   SC.ContactName       
  , Dest                =   DC.ContactName       
  , TruckerName         =   trk.ContactName     
  , lw.Call_DateTime
  , GradingCount        =   lw.Grading_Count    
  , lw.GrossWgt
  , lw.TareWgt
  , Net                 =   lw.GrossWgt - lw.TareWgt
  , lw.SDI_Nbr
  , TruckerPhone        =   lw.Trucker
FROM  
    dbo.cftPM AS pm 
INNER JOIN 
    dbo.cftContact AS sc 
        on pm.SourceContactID = sc.ContactID
INNER JOIN 
    dbo.cftContact AS dc 
        on pm.DestContactID = dc.ContactID
INNER JOIN 
    dbo.cftContact AS trk
        on pm.TruckerContactID = trk.ContactID
INNER JOIN 
    dbo.cfvDayDefinition_WithWeekInfo AS wd 
        ON pm.MovementDate = wd.DayDate 
INNER JOIN 
    dbo.cftPigType AS pt 
        ON pm.pigTypeID = pt.PigTypeID
LEFT OUTER JOIN 
    dbo.cftSafeLoadWgt AS lw 
        on pm.PMLoadID = lw.PMLoadID
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







