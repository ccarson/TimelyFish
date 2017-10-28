



-- =============================================
-- Author:		Mike Zimanski
-- Create date: 12/14/2010
-- Description:	Returns Market Schedule with Actuals and Weight Distribution
-- =============================================
CREATE PROCEDURE [dbo].[cfp_SOLOMON_SCHEDULE_TEST_disable]
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
	,From349to340 int
	,From339to330 int
	,From329to320 int
	,From319to310 int
	,From309to300 int
	,From299to290 int
	,From289to280 int
	,From279to270 int
	,From269to260 int
	,From259to250 int
	,From249to240 int
	,From239to230 int
	,From229to220 int
	,Minus219 int)
	
	Insert Into @WeightDist
	
	Select 
	
	PSW.PMLoadID,
	PSW.SiteContactID,
	PSW.PkrContactID,
	Sum(PSW.Plus350) as 'Plus350',
	Sum(PSW.From349to340) as 'From349to340',
	Sum(PSW.From339to330) as 'From339to330',
	Sum(PSW.From329to320) as 'From329to320',
	Sum(PSW.From319to310) as 'From319to310',
	Sum(PSW.From309to300) as 'From309to300',
	Sum(PSW.From299to290) as 'From299to290',
	Sum(PSW.From289to280) as 'From289to280',
	Sum(PSW.From279to270) as 'From279to270',
	Sum(PSW.From269to260) as 'From269to260',
	Sum(PSW.From259to250) as 'From259to250',
	Sum(PSW.From249to240) as 'From249to240',
	Sum(PSW.From239to230) as 'From239to230',
	Sum(PSW.From229to220) as 'From229to220',
	Sum(PSW.Minus219) as 'Minus219'
	
	from (
	
	Select  
	
	pd.CarcassID,
	pd.PMLoadID,
	pd.SiteContactID,
	pd.PkrContactID,
	Case when Case when pd.PkrContactID = 2936 then Round(pd.HotWgt/@TriumphPct,0)
	else Round(pd.HotWgt/pd.YldPct,0) end >= 350 then Sum(pd.TotalHead) else 0 end as 'Plus350',
	Case when Case when pd.PkrContactID = 2936 then Round(pd.HotWgt/@TriumphPct,0)
	else Round(pd.HotWgt/pd.YldPct,0) end between 340 and 349 then Sum(pd.TotalHead) else 0 end as 'From349to340',
	Case when Case when pd.PkrContactID = 2936 then Round(pd.HotWgt/@TriumphPct,0)
	else Round(pd.HotWgt/pd.YldPct,0) end between 330 and 339 then Sum(pd.TotalHead) else 0 end as 'From339to330',
	Case when Case when pd.PkrContactID = 2936 then Round(pd.HotWgt/@TriumphPct,0)
	else Round(pd.HotWgt/pd.YldPct,0) end between 320 and 329 then Sum(pd.TotalHead) else 0 end as 'From329to320',
	Case when Case when pd.PkrContactID = 2936 then Round(pd.HotWgt/@TriumphPct,0)
	else Round(pd.HotWgt/pd.YldPct,0) end between 310 and 319 then Sum(pd.TotalHead) else 0 end as 'From319to310',
	Case when Case when pd.PkrContactID = 2936 then Round(pd.HotWgt/@TriumphPct,0)
	else Round(pd.HotWgt/pd.YldPct,0) end between 300 and 309 then Sum(pd.TotalHead) else 0 end as 'From309to300',
	Case when Case when pd.PkrContactID = 2936 then Round(pd.HotWgt/@TriumphPct,0)
	else Round(pd.HotWgt/pd.YldPct,0) end between 290 and 299 then Sum(pd.TotalHead) else 0 end as 'From299to290',
	Case when Case when pd.PkrContactID = 2936 then Round(pd.HotWgt/@TriumphPct,0)
	else Round(pd.HotWgt/pd.YldPct,0) end between 280 and 289 then Sum(pd.TotalHead) else 0 end as 'From289to280',
	Case when Case when pd.PkrContactID = 2936 then Round(pd.HotWgt/@TriumphPct,0)
	else Round(pd.HotWgt/pd.YldPct,0) end between 270 and 279 then Sum(pd.TotalHead) else 0 end as 'From279to270',
	Case when Case when pd.PkrContactID = 2936 then Round(pd.HotWgt/@TriumphPct,0)
	else Round(pd.HotWgt/pd.YldPct,0) end between 260 and 269 then Sum(pd.TotalHead) else 0 end as 'From269to260',
	Case when Case when pd.PkrContactID = 2936 then Round(pd.HotWgt/@TriumphPct,0)
	else Round(pd.HotWgt/pd.YldPct,0) end between 250 and 259 then Sum(pd.TotalHead) else 0 end as 'From259to250',
	Case when Case when pd.PkrContactID = 2936 then Round(pd.HotWgt/@TriumphPct,0)
	else Round(pd.HotWgt/pd.YldPct,0) end between 240 and 249 then Sum(pd.TotalHead) else 0 end as 'From249to240',
	Case when Case when pd.PkrContactID = 2936 then Round(pd.HotWgt/@TriumphPct,0)
	else Round(pd.HotWgt/pd.YldPct,0) end between 230 and 239 then Sum(pd.TotalHead) else 0 end as 'From239to230',
	Case when Case when pd.PkrContactID = 2936 then Round(pd.HotWgt/@TriumphPct,0)
	else Round(pd.HotWgt/pd.YldPct,0) end between 220 and 229 then Sum(pd.TotalHead) else 0 end as 'From229to220',
	Case when Case when pd.PkrContactID = 2936 then Round(pd.HotWgt/@TriumphPct,0)
	else Round(pd.HotWgt/pd.YldPct,0) end <= 219 then Sum(pd.TotalHead) else 0 end as 'Minus219'
	
	From (Select Distinct CarcassID, PMLoadID, SiteContactID, PkrContactID, TotalHead, HotWgt, YldPct
	from  dbo.cft_PACKER_DETAIL) pd
	
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

	Select Distinct
	 
	pm.PMID,
	pm.MovementDate, 
	Case when left(rtrim(pm.TranSubTypeID),1)='O' then olsc.ContactName 
	else sc.ContactName end as 'Source',
	Case when left(rtrim(pm.TranSubTypeID),1)='O' then pmol.SourceBarnNbr
	else pm.SourceBarnNbr end as 'SourceBarn',
	dc.ContactName as 'Destination',
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
	Case when psr.DeadOnArrival is null then 0 else psr.DeadOnArrival end as 'DeadOnArrival',
	Case when psr.DeadInYard is null then 0 else psr.DeadInYard end as 'DeadInYard',
	Case when psr.Condemns is null then 0 else psr.Condemns end as 'Condemns',
	Case when psr.ReSale is null then 0 else psr.ReSale end as 'ReSale',
	SvcMgrC.ContactName as 'SvcMgr',
	MktMgrS.ContactName as 'MrktMgr',
	TC.ContactName as 'Trucker',
	pm.Comment,
	Case when PSWR.Plus350 is null then PSWRO.Plus350 else PSWR.PLus350 end as 'Plus350',
	Case when PSWR.From349to340 is null then PSWRO.From349to340 else PSWR.From349to340 end as 'From349to340',
	Case when PSWR.From339to330 is null then PSWRO.From339to330 else PSWR.From339to330 end as 'From339to330',
	Case when PSWR.From329to320 is null then PSWRO.From329to320 else PSWR.From329to320 end as 'From329to320',
	Case when PSWR.From319to310 is null then PSWRO.From319to310 else PSWR.From319to310 end as 'From319to310',
	Case when PSWR.From309to300 is null then PSWRO.From309to300 else PSWR.From309to300 end as 'From309to300',
	Case when PSWR.From299to290 is null then PSWRO.From299to290 else PSWR.From299to290 end as 'From299to290',
	Case when PSWR.From289to280 is null then PSWRO.From289to280 else PSWR.From289to280 end as 'From289to280',
	Case when PSWR.From279to270 is null then PSWRO.From279to270 else PSWR.From279to270 end as 'From279to270',
	Case when PSWR.From269to260 is null then PSWRO.From269to260 else PSWR.From269to260 end as 'From269to260',
	Case when PSWR.From259to250 is null then PSWRO.From259to250 else PSWR.From259to250 end as 'From259to250',
	Case when PSWR.From249to240 is null then PSWRO.From249to240 else PSWR.From249to240 end as 'From249to240',
	Case when PSWR.From239to230 is null then PSWRO.From239to230 else PSWR.From239to230 end as 'From239to230',
	Case when PSWR.From229to220 is null then PSWRO.From229to220 else PSWR.From229to220 end as 'From229to220',
	Case when PSWR.Minus219 is null then PSWRO.Minus219 else PSWR.Minus219 end as 'Minus219'

	from [$(SolomonApp)].dbo.cftPM pm (nolock)
	
	left join (
	
	Select 
	psr.PMLoadID,
	Sum(psr.HCTot) as 'HCTot',
	Case when Sum(psr.HCTot) = 0 then Sum(psr.DelvLiveWgt) else Sum(psr.DelvLiveWgt)/Sum(psr.HCTot) end as 'AvgWgt',
	Sum(psls.DeadOnArrival) as 'DeadOnArrival',
	Sum(psls.DeadInYard) as 'DeadInYard',
	Sum(psls.Condemns) as 'Condemns',
	Sum(psls.Boars+psls.Subjects+psls.Abcess+psls.BellyBust+psls.RearRupture+psls.Heavy+psls.Lites+psls.InsectBite+psls.Tailbite) as 'ReSale'
	From [$(SolomonApp)].dbo.cfvPigSaleRev psr
	left join [$(SolomonApp)].dbo.cfv_PIG_SALE_LOAD_STATS psls
	on psr.PMLoadID = psls.PMLoadID
	and psr.PigGroupID = psls.PigGroupID
	and psr.PkrContactID = psls.PkrContactID 
	Where psr.SaleTypeID = 'MS'
	Group by
	psr.PMLoadID) psr 
	on pm.PMLoadID = psr.PMLoadID 
	
	left join [$(SolomonApp)].dbo.cfv_PIG_SALE_LOAD_STATS psls
	on pm.PMLoadID = psls.PMLoadID
	
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
	on pm.PMLoadID = PSWR.PMLoadID
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
	
	left join [$(SolomonApp)].dbo.cfvCrtMktMgrName MktMgrS (nolock)
	on pm.SourceContactID = MktMgrS.SiteContactID
	and MktMgrS.effectivedate =
		
		(select max(effectivedate)
		from [$(SolomonApp)].dbo.cfvCrtMktMgrName
		where sitecontactid=pm.sourcecontactid
		and effectivedate <= pm.movementdate)
	
	left join [$(SolomonApp)].dbo.cftContact TC (nolock)
	on pm.TruckerContactID = TC.ContactID 

	where pm.pigtypeid = 04
	and pm.DeleteFlag = 0
	and pm.Highlight <> 255
	and pm.MovementDate between @StartDate and @EndDate
	
	order by
	Case when left(rtrim(pm.TranSubTypeID),1)='O' then olsc.ContactName 
	else sc.ContactName end,
	pm.MovementDate
	
END





GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SOLOMON_SCHEDULE_TEST_disable] TO [db_sp_exec]
    AS [dbo];

