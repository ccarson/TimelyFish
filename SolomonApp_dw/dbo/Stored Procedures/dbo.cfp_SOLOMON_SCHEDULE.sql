


-- =============================================
-- Author:		Mike Zimanski
-- Create date: 12/14/2010
-- Description:	Returns Market Schedule with Actuals and Weight Distribution
-- =============================================
CREATE PROCEDURE [dbo].[cfp_SOLOMON_SCHEDULE]
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
	pm.MovementDate, 
	sc.ContactName as 'Source',
	pm.SourceBarnNbr as 'SourceBarn',
	dc.ContactName as 'Destination',
	mst.Description as 'MarketSaleType',
	case when pm.ActualQty = '' then 0 else pm.ActualQty end as 'ActHead',
	case when pm.EstimatedQty = '' then 0 else pm.EstimatedQty end as 'EstHead',
	
	case when pm.DestContactID = 2936 then case when pm.ActualWgt = '' then 0 
	else (pm.ActualWgt/@TriumphPct)*0.77 end else case when pm.ActualWgt = '' 
	then 0 else pm.ActualWgt end end as 'AvgWgt',
	
	case when pm.EstimatedWgt = '' then 0 else pm.EstimatedWgt end as 'EstWgt',
	SvcMgrC.ContactName as 'SvcMgr',
	MktMgrS.ContactName as 'MrktMgr',
	TC.ContactName as 'Trucker',
	pm.Comment,
	PSWR.Plus350,
	PSWR.From349to300,
	PSWR.From299to280,
	PSWR.From279to260,
	PSWR.From259to240,
	PSWR.From239to224,
	PSWR.Minus223 

	from Earth.[$(SolomonApp)].dbo.cftPM pm (nolock)
	
	left join (
	
	Select 
	
	PSW.PMLoadID,
	PSW.SiteContactID,
	PSW.BarnNbr,
	PSW.PigGroupID,
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
	
	CarcassID,
	PMLoadID,
	SiteContactID,
	BarnNbr,
	PigGroupID,
	PkrContactID,
	Case when Case when PkrContactID = 2936 then Round(HotWgt/@TriumphPct,0)
	else Round(HotWgt/YldPct,0) end >= 350 then Sum(TotalHead) else 0 end as 'Plus350',
	Case when Case when PkrContactID = 2936 then Round(HotWgt/@TriumphPct,0)
	else Round(HotWgt/YldPct,0) end between 300 and 349 then Sum(TotalHead) else 0 end as 'From349to300',
	Case when Case when PkrContactID = 2936 then Round(HotWgt/@TriumphPct,0)
	else Round(HotWgt/YldPct,0) end between 280 and 299 then Sum(TotalHead) else 0 end as 'From299to280',
	Case when Case when PkrContactID = 2936 then Round(HotWgt/@TriumphPct,0)
	else Round(HotWgt/YldPct,0) end between 260 and 279 then Sum(TotalHead) else 0 end as 'From279to260',
	Case when Case when PkrContactID = 2936 then Round(HotWgt/@TriumphPct,0)
	else Round(HotWgt/YldPct,0) end between 240 and 259 then Sum(TotalHead) else 0 end as 'From259to240',
	Case when Case when PkrContactID = 2936 then Round(HotWgt/@TriumphPct,0)
	else Round(HotWgt/YldPct,0) end between 224 and 239 then Sum(TotalHead) else 0 end as 'From239to224',
	Case when Case when PkrContactID = 2936 then Round(HotWgt/@TriumphPct,0)
	else Round(HotWgt/YldPct,0) end <= 223 then Sum(TotalHead) else 0 end as 'Minus223'
	
	--Case when Round(HotWgt/Case when PkrContactID = 823 then @TysonPct
	--when PkrContactID in (554,555) then @SwiftPct
	--when PkrContactID = 2936 then @TriumphPct end,0) >= 350 then Sum(TotalHead) else 0 end as 'Plus350',
	--Case when Round(HotWgt/Case when PkrContactID = 823 then @TysonPct
	--when PkrContactID in (554,555) then @SwiftPct
	--when PkrContactID = 2936 then @TriumphPct end,0) between 300 and 349 then Sum(TotalHead) else 0 end as 'From349to300',
	--Case when Round(HotWgt/Case when PkrContactID = 823 then @TysonPct
	--when PkrContactID in (554,555) then @SwiftPct
	--when PkrContactID = 2936 then @TriumphPct end,0) between 280 and 299 then Sum(TotalHead) else 0 end as 'From299to280',
	--Case when Round(HotWgt/Case when PkrContactID = 823 then @TysonPct
	--when PkrContactID in (554,555) then @SwiftPct
	--when PkrContactID = 2936 then @TriumphPct end,0) between 260 and 279 then Sum(TotalHead) else 0 end as 'From279to260',
	--Case when Round(HotWgt/Case when PkrContactID = 823 then @TysonPct
	--when PkrContactID in (554,555) then @SwiftPct
	--when PkrContactID = 2936 then @TriumphPct end,0) between 240 and 259 then Sum(TotalHead) else 0 end as 'From259to240',
	--Case when Round(HotWgt/Case when PkrContactID = 823 then @TysonPct
	--when PkrContactID in (554,555) then @SwiftPct
	--when PkrContactID = 2936 then @TriumphPct end,0) between 224 and 239 then Sum(TotalHead) else 0 end as 'From239to224',
	--Case when Round(HotWgt/Case when PkrContactID = 823 then @TysonPct
	--when PkrContactID in (554,555) then @SwiftPct
	--when PkrContactID = 2936 then @TriumphPct end,0) <= 223 then Sum(TotalHead) else 0 end as 'Minus223'
	
	From  dbo.cft_PACKER_DETAIL 
	
	Group by
	CarcassID,
	PMLoadID,
	SiteContactID,
	BarnNbr,
	PigGroupID,
	PkrContactID,
	HotWgt,
	YldPct) PSW
	
	Group by
	PSW.PMLoadID,
	PSW.SiteContactID,
	PSW.BarnNbr,
	PSW.PigGroupID,
	PSW.PkrContactID) PSWR
	on pm.PMLoadID = PSWR.PMLoadID 
	and pm.SourceContactID = PSWR.SiteContactID
	and pm.SourceBarnNbr = PSWR.BarnNbr
	and pm.SourcePigGroupID = PSWR.PigGroupID
	and pm.DestContactID = PSWR.PkrContactID 
	and pm.ActualQty > 0

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
	sc.ContactName,
	pm.MovementDate
	
END




GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SOLOMON_SCHEDULE] TO [db_sp_exec]
    AS [dbo];

