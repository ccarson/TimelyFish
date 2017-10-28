



-- =============================================
-- Author:		Mike Zimanski
-- Create date: 11/2/2011
-- Description:	Returns Market Schedule with Actuals 
-- =============================================
CREATE PROCEDURE [dbo].[cfp_DAILY_LOAD_REPORT]
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


	Select
	 
	pm.PMID,
	pm.TranSubTypeID,
	pm.MovementDate, 
	Case when left(rtrim(pm.TranSubTypeID),1)='O' then 
	Case when olkd.KillDate is null then olkd2.KillDate else olkd.KillDate end
	else psr.KillDate end as 'KillDate',
	Case when left(rtrim(pm.TranSubTypeID),1)='O' then olsc.ContactName 
	else sc.ContactName end as 'Source',
	Case when left(rtrim(pm.TranSubTypeID),1)='O' then pmol.SourceBarnNbr
	else pm.SourceBarnNbr end as 'SourceBarn',
	Case when psr.CustID is Null then rtrim(dc.ContactName) else rtrim(psr.CustID) end as 'Destination',
	mst.Description as 'MarketSaleType',
	case when psr.ActHead is Null then 
	case when pm.ActualQty = '' then 0 else pm.ActualQty end else psr.ActHead end as 'ActHead',
	case when pm.EstimatedQty = '' then 0 else pm.EstimatedQty end as 'EstHead',
	
	case when psr.ActHead is Null then 
	case when pm.DestContactID = 2936 then case when pm.ActualWgt = '' then 0 
	else (pm.ActualWgt/@TriumphPct)*0.77 end else case when pm.ActualWgt = '' 
	then 0 else pm.ActualWgt end end else psr.ActualWgt/psr.ActHead end as 'AvgWgt',
	
	case when pm.EstimatedWgt = '' then 0 else pm.EstimatedWgt end as 'EstWgt',
	SvcMgrC.ContactName as 'SvcMgr',
	MktMgrS.ContactName as 'MrktMgr',
	TC.ContactName as 'Trucker',
	pm.Comment

	from Earth.[$(SolomonApp)].dbo.cftPM pm (nolock)
	
	left join (
	
	Select Distinct
	PMLoadID,
	SiteContactID,
	--BarnNbr,
	--PigGroupID,
	PkrContactID,
	CustId,
	KillDate,
	SUM(HCTot) as 'ActHead',
	Case when SaleBasis = 'CW' then SUM(DelvCarcWgt) else 
	Case when PkrContactID = 2936 then SUM(DelvLiveWgt) * @TriumphPct
	else SUM(DelvLiveWgt) * 0.77 end end as 'ActualWgt'
	
	from Earth.[$(SolomonApp)].dbo.cfvPigSaleREV
	
	Group by
	PMLoadId,
	SiteContactID,
	PkrContactId,
	CustId,
	KillDate,
	SaleBasis) psr 
	on pm.PMLoadID = psr.PMLoadID 
	and pm.SourceContactID = psr.SiteContactID
	--and pm.SourceBarnNbr = psr.BarnNbr
	--and pm.SourcePigGroupID = psr.PigGroupID
	and pm.DestContactID = psr.PkrContactID 

	left join [$(SolomonApp)].dbo.cftContact sc (nolock)
	on pm.sourcecontactid = sc.contactid

	left join [$(SolomonApp)].dbo.cftContact dc (nolock)
	on pm.destcontactid = dc.contactid 
	
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
	
	from Earth.[$(SolomonApp)].dbo.cftPigOffload ol (nolock)
	
	left join Earth.[$(SolomonApp)].dbo.cfvPigSaleRev psr (nolock)
	on ol.SrcPMId = psr.PMLoadId) olkd
	on ol.SrcPMId = olkd.SrcPMId
	and pm.DestContactID = olkd.PkrContactId
	
	left join (
	
	Select Distinct
	ol.DestPMId,
	psr.PkrContactId,
	psr.KillDate
	
	from Earth.[$(SolomonApp)].dbo.cftPigOffload ol (nolock)
	
	left join Earth.[$(SolomonApp)].dbo.cfvPigSaleRev psr (nolock)
	on ol.DestPMId = psr.PMLoadId) olkd2
	on ol.DestPMId = olkd2.DestPMId
	and pm.DestContactID = olkd2.PkrContactId

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

	where pm.ActualQty > 0 
	and pm.pigtypeid = 04
	and pm.DeleteFlag = 0
	and pm.Highlight <> 255
	and (pm.Lupd_DateTime between @StartDate and @EndDate
	or pm.Crtd_DateTime between @StartDate and @EndDate)
	
	order by
	Case when left(rtrim(pm.TranSubTypeID),1)='O' then olsc.ContactName 
	else sc.ContactName end,
	pm.MovementDate
	
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_DAILY_LOAD_REPORT] TO [db_sp_exec]
    AS [dbo];

