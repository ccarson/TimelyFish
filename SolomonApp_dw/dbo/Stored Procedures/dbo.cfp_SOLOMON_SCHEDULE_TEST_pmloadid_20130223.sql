










-- =============================================
-- Author:		Mike Zimanski
-- Create date: 12/14/2010
-- Description:	Returns Market Schedule with Actuals and Weight Distribution
-- 2012-07-25  sripley addes pmloadid to _b and created _pmloadid
-- 2013-05-13  sripley changed
--				Where SaleTypeID = 'MS' to 	Where SaleTypeID in ('MS', 'MC')
-- 2013-11-18	bmd - Added in Load Crew to result set
-- 2013-12-11	bmd - Added in join to [$(CentralData)].Site to get bio-security level
-- 2014-10-01	smr - change dc.contactname to   rtrim(dc.ContactName)
-- 2014-11-14   smr - change to use reporting group rather than pig flow desc
-- 2015-01-10	smr - added daysonpaylean to results
-- =============================================
CREATE PROCEDURE [dbo].[cfp_SOLOMON_SCHEDULE_TEST_pmloadid_20130223]
(
	
	 @StartDate		datetime
	,@EndDate		datetime
	--,@TysonPct		decimal(19,2)
	--,@SwiftPct		decimal(19,2)
	,@TriumphPct	decimal(19,4)
   
)
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	Declare @WeightDist Table
	(PMLoadID int
	,SiteContactID int
	,PkrContactID int
	,Plus350 int
	,From349to300 int
	,From299to280 int
	,From279to260 int
	,From259to240 int
	,From239to224 int
	,Minus223 int)
	
	Insert Into @WeightDist
	
	Select 
	
	PSW.PMLoadID,
	PSW.SiteContactID,
	PSW.PkrContactID,
	Sum(PSW.Plus350) as 'Plus350',
	Sum(PSW.From349to300) as 'From349to300',
	Sum(PSW.From299to280) as 'From299to280',
	Sum(PSW.From279to260) as 'From279to260',
	Sum(PSW.From259to240) as 'From259to240',
	Sum(PSW.From239to224) as 'From239to224',
	Sum(PSW.Minus223) as 'Minus223'
	
	from (
	
	Select  
	
	pd.CarcassID,
	pd.PMLoadID,
	pd.SiteContactID,
	pd.PkrContactID,
	Case when Case when pd.PkrContactID = 2936 then Round(pd.HotWgt/@TriumphPct,0)
	else Round(pd.HotWgt/pd.YldPct,0) end >= 350 then Sum(pd.TotalHead) else 0 end as 'Plus350',
	Case when Case when pd.PkrContactID = 2936 then Round(pd.HotWgt/@TriumphPct,0)
	else Round(pd.HotWgt/pd.YldPct,0) end between 300 and 349 then Sum(pd.TotalHead) else 0 end as 'From349to300',
	Case when Case when pd.PkrContactID = 2936 then Round(pd.HotWgt/@TriumphPct,0)
	else Round(pd.HotWgt/pd.YldPct,0) end between 280 and 299 then Sum(pd.TotalHead) else 0 end as 'From299to280',
	Case when Case when pd.PkrContactID = 2936 then Round(pd.HotWgt/@TriumphPct,0)
	else Round(pd.HotWgt/pd.YldPct,0) end between 260 and 279 then Sum(pd.TotalHead) else 0 end as 'From279to260',
	Case when Case when pd.PkrContactID = 2936 then Round(pd.HotWgt/@TriumphPct,0)
	else Round(pd.HotWgt/pd.YldPct,0) end between 240 and 259 then Sum(pd.TotalHead) else 0 end as 'From259to240',
	Case when Case when pd.PkrContactID = 2936 then Round(pd.HotWgt/@TriumphPct,0)
	else Round(pd.HotWgt/pd.YldPct,0) end between 224 and 239 then Sum(pd.TotalHead) else 0 end as 'From239to224',
	Case when Case when pd.PkrContactID = 2936 then Round(pd.HotWgt/@TriumphPct,0)
	else Round(pd.HotWgt/pd.YldPct,0) end <= 223 then Sum(pd.TotalHead) else 0 end as 'Minus223'
	
	From (Select distinct 
	pd.CarcassID,
	pd.PMLoadID,
	pd.SiteContactID,
	pd.PkrContactID,
	--pd.TotalHead,
	--ph.PercentHead,
	Case when pd.SplitDup = 1 then 
	Case when ph.PercentHead is null then pd.TotalHead else 
	pd.TotalHead * ph.PercentHead end else pd.TotalHead end as 'TotalHead',
	pd.HotWgt,
	pd.YldPct
	
	from (
	
	Select Distinct 
	sd.CarcassID,
	--sd.KillDate,
	sd.PMLoadID,
	sd.SiteContactID,
	--sd.BarnNbr,
	--sd.PigGroupID,
	sd.PkrContactID,
	sd.TotalHead,
	sd.HotWgt,
	sd.YldPct,
	Case when d.Split > 1 then 1 else 0 end as 'SplitDup'
	
	From  dbo.cft_PACKER_DETAIL sd
	
	left join (
	
	Select Distinct
	CarcassID,
	KillDate,
	SiteContactID,
	PkrContactID,
	TotalHead,
	HotWgt,
	Count(PMLoadID) as 'Split'
	from  dbo.cft_PACKER_DETAIL
	Group by
	CarcassID,
	KillDate,
	SiteContactID,
	PkrContactID,
	TotalHead,
	HotWgt) d
	on sd.CarcassID = d.CarcassID
	and sd.KillDate = d.KillDate
	and sd.SiteContactID = d.SiteContactID
	and sd.PkrContactID = d.PkrContactID
	and sd.TotalHead = d.TotalHead
	and sd.HotWgt = d.HotWgt) pd
	
	left join (
	
	Select
	pmid.PMLoadID,
	pmid.PMID,
	pmid.ActHead as 'PMIDHead',
	pmloadid.ActHead as 'PMLoadIDHead',
	Case when pmloadid.ActHead = 0 then 0 else (pmid.ActHead * 1.00/pmloadid.ActHead) end as 'PercentHead'

	from (
	
	Select Distinct 
	pm.PMLoadID,

	Sum(Case when psr.HCTot is null then 
	Case when pm.ActualQty = '' then 0 else pm.ActualQty end 
	else psr.HCTot end) as 'ActHead'

	from [$(SolomonApp)].dbo.cftPM pm (nolock)
	
	left join (
	
	Select 
	PMLoadID,
	Sum(HCTot) as 'HCTot',
	Case when Sum(HCTot) = 0 then Sum(DelvLiveWgt) else Sum(DelvLiveWgt)/Sum(HCTot) end as 'AvgWgt'
	From [$(SolomonApp)].dbo.cfvPigSaleRev 
--	Where SaleTypeID = 'MS'
	Where SaleTypeID in ('MS', 'MC')
	Group by
	PMLoadID) psr 
	on pm.PMID = psr.PMLoadID 
	
	where pm.pigtypeid in ('04','08')	-- sripley:  20130422, was = 04, was excluding needed data.
	and pm.DeleteFlag = 0
	and pm.Highlight <> 255
	and pm.MovementDate between @StartDate and @EndDate
	Group by
	pm.PMLoadID) pmloadid
	
	left join (

	Select Distinct 
	pm.PMLoadID,
	pm.PMID,

	Case when psr.HCTot is null then 
	Case when pm.ActualQty = '' then 0 else pm.ActualQty end 
	else psr.HCTot end as 'ActHead'

	from [$(SolomonApp)].dbo.cftPM pm (nolock)
	
	left join (
	
	Select 
	PMLoadID,
	Sum(HCTot) as 'HCTot',
	Case when Sum(HCTot) = 0 then Sum(DelvLiveWgt) else Sum(DelvLiveWgt)/Sum(HCTot) end as 'AvgWgt'
	From [$(SolomonApp)].dbo.cfvPigSaleRev 
--	Where SaleTypeID = 'MS'
	Where SaleTypeID in ('MS', 'MC')
	Group by
	PMLoadID) psr 
	on pm.PMID = psr.PMLoadID 
	
	where pm.pigtypeid in ('04','08')	-- sripley:  20130422, was = 04, was excluding needed data.
	and pm.DeleteFlag = 0
	and pm.Highlight <> 255
	and pm.MovementDate between @StartDate and @EndDate
	) pmid
	
	on pmloadid.pmloadid = pmid.pmloadid) ph
	
	on pd.PMLoadID = ph.PMID) pd
	
	Group by
	pd.CarcassID,
	pd.PMLoadID,
	pd.SiteContactID,
	pd.PkrContactID,
	pd.HotWgt,
	pd.YldPct) PSW
	
	Group by
	PSW.PMLoadID,
	PSW.SiteContactID,
	PSW.PkrContactID
	
--------------------------------------------------------------

	Select Distinct
	Cast(pm.PMLoadID as int) as 'PMLoadID', 
	Cast(pm.PMID as int) as 'PMID',
	pm.MovementDate,
--	convert(time,pm.loadingtime,0) loadingtime
	substring(CONVERT(char(20),pm.loadingtime, 0),13,7) loadingtime		-- 20130710 smr requested by users shannon
	, substring(CONVERT(char(20),pm.arrivaltime, 0),13,7) arrivaltime		-- 20130710 smr requested by users shannon
	, OH.psordtype,  -- 20130710 smr requested by users shannon
	Case when left(rtrim(pm.TranSubTypeID),1)='O' then olsc.ContactName 
	else sc.ContactName end as 'Source',
	Case when left(rtrim(pm.TranSubTypeID),1)='O' then pmol.SourceBarnNbr
	else pm.SourceBarnNbr end as 'SourceBarn',
	--dc.ContactName as 'Destination',		-- 2014 modify to break out Swift-Worthington-Exetare
	case
		when dc.contactid = '000555'  and et.contrnbr = '000023' then rtrim(dc.contactname)+ ' Clarkfield'
		else rtrim(dc.ContactName)	-- 20141001 added rtrim to take out blank
	end as 'Destination',
	mst.Description as 'MarketSaleType',
	Case when psr.HCTot is null then 
	Case when pm.ActualQty = '' then 0 else pm.ActualQty end 
	else psr.HCTot end as 'ActHead',
	Case when pm.EstimatedQty = '' then 0 else pm.EstimatedQty end as 'EstHead',
	
	Case when psr.AvgWgt is null then
	
	Case when pm.DestContactID = 2936 then 
	Case when pm.ActualWgt = '' then 0 
	else (pm.ActualWgt/@TriumphPct)*0.77 end else Case when pm.ActualWgt = '' 
	then 0 else pm.ActualWgt end end
	
	else Case when pm.DestContactID = 2936 then (psr.AvgWgt/@TriumphPct)*0.77 
	else psr.AvgWgt end end as 'AvgWgt',
	
	Case when pm.EstimatedWgt = '' then 0 else pm.EstimatedWgt end as 'EstWgt',
	Case when psls.DOA is null then 0 else psls.DOA end as 'DOA',
	Case when psls.DIY is null then 0 else psls.DIY end as 'DIY',
	Case when psls.Condemns is null then 0 else psls.Condemns end as 'Condemns',
	Case when psls.Slows is null then 0 else psls.Slows end as 'Slows',
	Case when psls.ReSale is null then 0 else psls.ReSale end as 'ReSale',
	SvcMgrC.ContactName as 'SvcMgr',
	ct.ContactName as 'MrktMgr',
	TC.ContactName as 'Trucker',
	clc.LoadCrewName as 'LoadCrew',
	pm.Comment,
	Case when PSWR.Plus350 is null then PSWRO.Plus350 else PSWR.PLus350 end as 'Plus350',
	Case when PSWR.From349to300 is null then PSWRO.From349to300 else PSWR.From349to300 end as 'From349to300',
	Case when PSWR.From299to280 is null then PSWRO.From299to280 else PSWR.From299to280 end as 'From299to280',
	Case when PSWR.From279to260 is null then PSWRO.From279to260 else PSWR.From279to260 end as 'From279to260',
	Case when PSWR.From259to240 is null then PSWRO.From259to240 else PSWR.From259to240 end as 'From259to240',
	Case when PSWR.From239to224 is null then PSWRO.From239to224 else PSWR.From239to224 end as 'From239to224',
	Case when PSWR.Minus223 is null then PSWRO.Minus223 else PSWR.Minus223 end as 'Minus223',
	rg.reporting_group_description	as pigflowdescription,	--pf.PigFlowDescription,	--20141114 smr
	case When s.BioSecurityLevel is null then 'G' else s.BioSecurityLevel end as 'BioSecurityLevel'
	, isnull(PayLn.DaysonPaylean,0) DaysonPaylean	-- 20150210 added smr

	from [$(SolomonApp)].dbo.cftPM pm (nolock)
	-- added 20140213 sripley exetare breakout
	left join (  SELECT contrnbr, custid, descr, ordnbr, pkrcontactid, psordtype, salebasis  FROM [$(SolomonApp)].[dbo].[cftPSOrdHdr]
				 where contrnbr = '000023') et
		on et.ordnbr = pm.ordnbr
	-- Added 11/18/2013 - BMD
	left join [CFApp].[dbo].[cft_LOAD_CREW_SITES] lcs (nolock) on lcs.contactid=pm.sourcecontactid
				and pm.movementdate between lcs.[AssignedFromDate] and case when lcs.[AssignedToDate] is null then pm.movementdate else [AssignedToDate] end
	left join [$(CFApp)].dbo.cft_load_crew clc (nolock) on clc.loadcrewid=lcs.loadcrewid 
	-- End add - gets load crew name
	-- Added 12/11/2013 - BMD
	LEFT JOIN [$(CentralData)].dbo.site s (nolock) on s.contactid=pm.sourcecontactid
	-- End add - get bio-security level of site
	left join (
	
	Select 
	PMLoadID,
	Sum(HCTot) as 'HCTot',
	Case when Sum(HCTot) = 0 then Sum(DelvLiveWgt) else Sum(DelvLiveWgt)/Sum(HCTot) end as 'AvgWgt'
	From [$(SolomonApp)].dbo.cfvPigSaleRev 
	Where SaleTypeID in ('MS', 'MC')
	Group by
	PMLoadID) psr 
	on pm.PMID = psr.PMLoadID 
	
	left join (Select b.PMLoadID, b.PMID, doa.DOA, doa.DIY, doa.Condemns, doa.Slows, doa.ReSale
	
	from (
		
	Select PMLoadID, PMID
	from [$(SolomonApp)].dbo.cftPM
	where pigtypeid in ('04','08') and DeleteFlag = 0 and Highlight <> 255	-- sripley:  20130422, was = 04, was excluding needed data.
	and MovementDate between @StartDate and @EndDate
	group by PMLoadID, PMID) b
	
	left join (
	
	Select PMLoadID, Sum(DeadOnArrival) as 'DOA', Sum(DeadInYard) as 'DIY', Sum(Condemns) as 'Condemns',
	Sum(Boars+Abcess+BellyBust+RearRupture+Heavy+Lites+InsectBite+Tailbite+Lame+PoorQuality+OpenWound+MiscReSale) as 'ReSale',
	Sum(Subjects) as 'Slows'
	from [$(SolomonApp)].dbo.cfv_PIG_SALE_LOAD_STATS Group by PMLoadID) doa
	on b.PMID = doa.PMLoadID) psls
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
	
	left join @WeightDist PSWR
	on pm.PMID = PSWR.PMLoadID
	and pm.SourceContactID = PSWR.SiteContactID
	and pm.DestContactID = PSWR.PkrContactID 
	--and pm.ActualQty > 0
	
	left join @WeightDist PSWRO
	on ol.SrcPMId = PSWRO.PMLoadID
	and olsc.ContactID = PSWRO.SiteContactID
	and pm.DestContactID = PSWRO.PkrContactID 
	--and pm.ActualQty > 0

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
	
	-- 20130805 sripley code not returning data
	--left join [$(SolomonApp)].dbo.cfvCrtMktMgrName MktMgrS (nolock)
	--on pm.SourceContactID = MktMgrS.SiteContactID
	--and MktMgrS.effectivedate =
		
	--	(select max(effectivedate)
	--	from [$(SolomonApp)].dbo.cfvCrtMktMgrName
	--	where sitecontactid=pm.sourcecontactid
	--	and effectivedate <= pm.movementdate)

/* 20130805 sripley replacing the code above */
left join [$(SolomonApp)].dbo.cftMktMgrAssign MktMgrS (nolock)
	on pm.SourceContactID = MktMgrS.SiteContactID
	and MktMgrS.effectivedate =
		(select max(effectivedate)
		from [$(SolomonApp)].dbo.cftMktMgrAssign
		where sitecontactid=pm.sourcecontactid
		and effectivedate <= pm.movementdate)
left join [$(SolomonApp)].dbo.cftContact ct (nolock) 
	ON MktMgrS.MktMgrContactID=ct.ContactID
/* 20130805 sripley  replacing the code above */

	
	left join [$(SolomonApp)].dbo.cftContact TC (nolock)
	on pm.TruckerContactID = TC.ContactID 
	
	left join [$(SolomonApp)].dbo.cftPSOrdhdr OH(nolock)   -- 20130710 smr requested by users shannon
	on OH.ordnbr =  pm.ordnbr
	
	left join [$(CFApp_PigManagement)].dbo.cft_PIG_FLOW pf (nolock)
	on (Select Top 1 pf.PigFlowID From  dbo.cft_PIG_GROUP_CENSUS pf Where pm.SourcePigGroupID = pf.PigGroupID Order By pf.CurrentInv Desc) = pf.PigFlowID

	left join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW_REPORTING_GROUP] rg (nolock)	-- added 20141114 smr as per user request wanted reporting group desc
		on rg.reportinggroupid = pf.reportinggroupid
	/* 20150210 added days on paylean join */
	left join (Select f.piggroupid,
				f.FQ_75 as FeedQuantity_75,
				f.FirstPLDate,
				pg.actclosedate,
				CASE WHEN f.FirstPLDate > '1/1/1900' THEN DateDiff(d, f.FirstPLDate, 
									  case when pg.ActCloseDate = '1/1/1900' then f.firstpldate + 1 else pg.actclosedate end) ELSE 0 END AS DaysonPaylean
				from (
					Select
					PigGroupID,
					Min(DateDel) FirstPLDate,
					Sum(QtyDel) FQ_75
					From [$(SolomonApp)].dbo.cftFeedOrder with (nolock)
					Where InvtIdDel like '%75%'
					and Reversal=0
					group by PigGroupID) f
				left join [$(SolomonApp)].dbo.cftpiggroup pg (nolock)
					on pg.taskid ='PG'+rtrim(f.PigGroupId)
				where f.FQ_75 is not null
				) PayLn
	--left join 
	--(Select f.piggroupid,
	--			f.FQ_75 as FeedQuantity_75,
	--			f.FirstPLDate,
	--			m.movementdate,m.pmloadid,m.pmid,
	--			CASE WHEN f.FirstPLDate > '1/1/1900' THEN DateDiff(d, f.FirstPLDate, 
	--								  case when m.movementdate = '1/1/1900' then f.firstpldate + 1 else m.movementdate end) ELSE 0 END AS DaysonPaylean
	--			from (
	--				Select
	--				PigGroupID,
	--				Min(DateDel) FirstPLDate,
	--				Sum(QtyDel) FQ_75
	--				From [$(SolomonApp)].dbo.cftFeedOrder with (nolock)
	--				Where InvtIdDel like '%75%'
	--				and Reversal=0
	--				group by PigGroupID) f
	--			left join [$(SolomonApp)].dbo.cftpm m (nolock)
	--				on m.sourcepiggroupid =f.PigGroupId
	--			where f.FQ_75 is not null and isnull(m.sourcepiggroupid,'') > ''
	--) PayLn
	--	 on PayLn.pmid = pm.pmid and PayLn.piggroupid = pm.sourcepiggroupid
		on PayLn.piggroupid = pm.SourcePigGroupID
	/* 20150210 added days on paylean join */
	
	where pm.pigtypeid in ('04','08')	-- sripley:  20130422, was = 04, was excluding needed data.
	and pm.DeleteFlag = 0
	and pm.Highlight <> 255
	and pm.MovementDate between @StartDate and @EndDate
	
	order by
	Case when left(rtrim(pm.TranSubTypeID),1)='O' then olsc.ContactName 
	else sc.ContactName end,
	pm.MovementDate
	
END











