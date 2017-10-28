



-- =============================================
-- Author:		Mike Zimanski
-- Create date: 3/14/2012
-- Description:	Returns Market Schedule with Actuals
-- update
--	20140929 sripley   order by clause needed fix after compat 100 change or SP2 upgrade
-- =============================================
CREATE PROCEDURE [dbo].[cfp_TRANSPORTATION_LOG]
(
	
	 @StartDate		datetime
	--,@EndDate		datetime
	--,@TysonPct	decimal(19,2)
	--,@SwiftPct	decimal(19,2)
	,@TriumphPct	decimal(19,4)
   
)
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Select Distinct 
	 
	pm.PMLoadID, 
	pm.PMID,
	dd.PICWeek,
	Convert(date,pm.MovementDate) as 'MovementDate', 
	Convert(time(0),pm.LoadingTime) as 'LoadingTime',
	Convert(date,pm.ArrivalDate) as 'ArrivalDate',
	Convert(time(0),pm.ArrivalTime) as 'TransportationLog',
	rtrim(Case when left(rtrim(pm.TranSubTypeID),1)='O' then olsc.ContactName 
	else sc.ContactName end)+' '+rtrim(Case when left(rtrim(pm.TranSubTypeID),1)='O' then pmol.SourceBarnNbr
	else pm.SourceBarnNbr end) as 'Source&Barn',
	dc.ContactName as 'Destination',
	mst.Description as 'MarketSaleType',
	Case when pm.ActualQty = '' then 0 else pm.ActualQty end as 'ActHead',
	Case when pm.EstimatedQty = '' then 0 else pm.EstimatedQty end as 'EstHead',
	
	Convert(integer, case when pm.DestContactID = 2936 then case when pm.ActualWgt = '' then 0 
	else (pm.ActualWgt/@TriumphPct)*0.77 end else case when pm.ActualWgt = '' 
	then 0 else pm.ActualWgt end end) as 'AvgWgt',
	
	Case when pm.EstimatedWgt = '' then 0 else pm.EstimatedWgt end as 'EstWgt',
	SvcMgrC.ContactName as 'SvcMgr',
	TC.ContactName as 'Trucker',
	pm.Comment,
	ActualLoadWgt = (psls.DOA+psls.DIY+Case when pm.ActualQty = '' then 0 else pm.ActualQty end)*
	Convert(integer, case when pm.DestContactID = 2936 then case when pm.ActualWgt = '' then 0 
	else (pm.ActualWgt/@TriumphPct)*0.77 end else case when pm.ActualWgt = '' 
	then 0 else pm.ActualWgt end end),
	psls.DOA,
	psls.DIY,
	psls.Slows

	from [$(SolomonApp)].dbo.cftPM pm (nolock)
	
	left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dd (nolock)
	on pm.MovementDate = dd.DayDate
	
	left join (Select b.PMLoadID, b.PMID, doa.DOA, doa.DIY, doa.Slows
	
	from (

	Select a.PMLoadID, a.PMID, a.Actual, 
	Row_Number() Over 
	(Partition by a.PMLoadID Order by a.Actual desc) as 'Rank'

	from (
		
	Select PMLoadID, PMID, Sum(ActualQty) as 'Actual'
	from [$(SolomonApp)].dbo.cftPM
	where pigtypeid = 04 and DeleteFlag = 0 and Highlight <> 255
	and MovementDate between @StartDate and (Select Distinct WeekEndDate
	from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo
	where daydate = dateadd(dd,7,convert(date,getdate())))
	group by PMLoadID, PMID) a) b
	
	left join (
	
	Select PMLoadID, Sum(DeadOnArrival) as 'DOA', Sum(DeadInYard) as 'DIY', Sum(Subjects) as 'Slows'
	from [$(SolomonApp)].dbo.cfv_PIG_SALE_LOAD_STATS Group by PMLoadID) doa
	on b.PMLoadID = doa.PMLoadID 
	and b.Rank = 1) psls
	on pm.PMLoadID = psls.PMLoadID
	and pm.PMID = psls.PMID 
	
	left join [$(SolomonApp)].dbo.cftPigOffload ol (nolock)
	on pm.PMID = ol.DestPMId
	
	left join [$(SolomonApp)].dbo.cftPM pmol (nolock)
	on ol.SrcPMId = pmol.PMID
	
	left join [$(SolomonApp)].dbo.cftContact olsc (nolock)
	on pmol.sourcecontactid = olsc.contactid
	
	left join (
	
	Select Distinct
	ol.SrcPMId,
	psr.PkrContactId,
	psr.KillDate
	
	from [$(SolomonApp)].dbo.cftPigOffload ol (nolock)
	
	left join [$(SolomonApp)].dbo.cfvPigSaleRev psr (nolock)
	on ol.SrcPMId = psr.PMLoadId) olkd
	on ol.SrcPMId = olkd.SrcPMId
	and pm.DestContactID = olkd.PkrContactId
	
	left join (
	
	Select Distinct
	ol.DestPMId,
	psr.PkrContactId,
	psr.KillDate
	
	from [$(SolomonApp)].dbo.cftPigOffload ol (nolock)
	
	left join [$(SolomonApp)].dbo.cfvPigSaleRev psr (nolock)
	on ol.DestPMId = psr.PMLoadId) olkd2
	on ol.DestPMId = olkd2.DestPMId
	and pm.DestContactID = olkd2.PkrContactId

	left join [$(SolomonApp)].dbo.cftContact sc (nolock)
	on pm.sourcecontactid = sc.contactid

	left join [$(SolomonApp)].dbo.cftContact dc (nolock)
	on pm.destcontactid = dc.contactid 

	left join [$(SolomonApp)].dbo.cftMarketSaleType mst (nolock)
	on pm.marketsaletypeid = mst.marketsaletypeid

	left join [$(SolomonApp)].dbo.cftSiteSvcMgrAsn SvcMgrS (nolock)
	on pm.SourceContactID = SvcMgrS.SiteContactID
	and SvcMgrS.effectivedate =
		
		(Select max(effectivedate)
		from [$(SolomonApp)].dbo.cftSiteSvcMgrAsn 
		where sitecontactid=pm.sourcecontactid
		and effectivedate <= pm.movementdate)

	left join [$(SolomonApp)].dbo.cftContact SvcMgrC (nolock)
	on SvcMgrS.SvcMgrContactId = SvcMgrC.ContactID
	
	left join [$(SolomonApp)].dbo.cftContact TC (nolock)
	on pm.TruckerContactID = TC.ContactID 

	where pm.pigtypeid = 04
	and pm.DeleteFlag = 0
	and pm.Highlight <> 255
	and pm.MovementDate between @StartDate and (Select Distinct WeekEndDate
	from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo
	where daydate = dateadd(dd,7,convert(date,getdate())))
	--@EndDate
	
	order by
	pm.PMLoadID,
	pm.PMID,
	rtrim(Case when left(rtrim(pm.TranSubTypeID),1)='O' then olsc.ContactName 
	else sc.ContactName end)+' '+rtrim(Case when left(rtrim(pm.TranSubTypeID),1)='O' then pmol.SourceBarnNbr
	else pm.SourceBarnNbr end),
	Convert(date,pm.MovementDate)	--pm.MovementDate		-- 2014/09/29 sripley  fix required for compat100 or sp2 upgrade  
	
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_TRANSPORTATION_LOG] TO [db_sp_exec]
    AS [dbo];

