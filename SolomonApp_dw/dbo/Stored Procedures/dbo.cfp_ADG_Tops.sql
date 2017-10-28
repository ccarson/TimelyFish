



-- =============================================
-- Author:		Mike Zimanski
-- Create date: 7/11/2012
-- Description:	Returns Market Schedule with Actuals and Start Weight 
-- =============================================
CREATE PROCEDURE [dbo].[cfp_ADG_Tops]
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
	a.PMID,
	a.MovementDate,
	a.SourcePigGroupID,
	a.Source,
	a.SourceBarn,
	a.PhaseDesc,
	pf.PigFlowDescription,
	a.StartDate,
	a.Wgt,
	a.Destination,
	a.MarketSaleType,
	a.ActHead,
	a.EstHead,
	a.AvgWgt,
	a.EstWgt,
	a.Comment,
	b.DOA,
	b.DIY,
	b.Condemns,
	b.ReSale
	
	from (
	
	Select Distinct
	 
	pm.PMID,
	pm.MovementDate, 
	pm.SourcePigGroupID, 
	Case when left(rtrim(pm.TranSubTypeID),1)='O' then olsc.ContactName 
	else sc.ContactName end as 'Source',
	Case when left(rtrim(pm.TranSubTypeID),1)='O' then pmol.SourceBarnNbr
	else pm.SourceBarnNbr end as 'SourceBarn',
	ps.PhaseDesc,
	(Select Top 1 pf.PigFlowID From  dbo.cft_PIG_GROUP_CENSUS pf Where pm.SourcePigGroupID = pf.PigGroupID Order By pf.CurrentInv Desc) as 'PigFlowID',
	gs.StartDate, 
	gs.Wgt,
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
	pm.Comment

	from [$(SolomonApp)].dbo.cftPM pm (nolock)
	
	left join (
	
	Select pg.PigGroupID, min(tr.TranDate) as StartDate,
    Round(sum(tr.TotalWgt*tr.inveffect)/
    case when sum (tr.Qty*tr.inveffect) = 0 
    then 1 else sum (tr.Qty*tr.inveffect) end,2) AS Wgt
    From [$(SolomonApp)].dbo.cftPigGroup pg WITH (NOLOCK)
    JOIN [$(SolomonApp)].dbo.cftPGInvTran tr WITH (NOLOCK) ON pg.PigGroupID=tr.PigGroupID AND tr.Reversal<>'1' 
    Where pg.PGStatusID<>'X'
	AND tr.Reversal<>'1' 
	AND (tr.acct In('PIG TRANSFER IN','PIG PURCHASE') 
	OR (tr.acct In('PIG MOVE IN','PIG MOVE OUT') 
	AND tr.trandate<=DateAdd(day,7,(select Min(TranDate) from [$(SolomonApp)].dbo.cftPGInvTran Where PigGroupID=pg.PigGroupID AND Reversal<>'1' AND acct In('PIG TRANSFER IN','PIG MOVE IN','PIG PURCHASE')))))	
   Group by pg.PigGroupID) gs 
	on pm.SourcePigGroupID = gs.PigGroupID
	
	left join [$(SolomonApp)].dbo.cfv_PigGroupSummary_All ps (nolock)
	on pm.SourcePigGroupID = ps.GroupID
	
	left join (
	
	Select 
	PMLoadID,
	Sum(HCTot) as 'HCTot',
	Case when Sum(HCTot) = 0 then Sum(DelvLiveWgt) else Sum(DelvLiveWgt)/Sum(HCTot) end as 'AvgWgt'
	From [$(SolomonApp)].dbo.cfvPigSaleRev 
	Where SaleTypeID = 'MS'
	Group by
	PMLoadID) psr 
	on pm.PMID = psr.PMLoadID 
	
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
	
	left join [$(SolomonApp)].dbo.cftContact TC (nolock)
	on pm.TruckerContactID = TC.ContactID 

	where pm.pigtypeid = 04
	and pm.DeleteFlag = 0
	and pm.Highlight <> 255
	and pm.MovementDate between @StartDate and @EndDate) a
	
	left join (Select PMLoadID, Sum(DeadOnArrival) as 'DOA', Sum(DeadInYard) as 'DIY', Sum(Condemns) as 'Condemns',
	Sum(Boars+Subjects+Abcess+BellyBust+RearRupture+Heavy+Lites+InsectBite+Tailbite) as 'ReSale'
	from [$(SolomonApp)].dbo.cfv_PIG_SALE_LOAD_STATS Group by PMLoadID) b
	on a.PMID = b.PMLoadID 
	
	left join [$(CFApp_PigManagement)].dbo.cft_PIG_FLOW pf (nolock)
	on a.PigFlowID = pf.PigFlowID
	
	order by
	a.Source,
	a.MovementDate
	
	
END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_ADG_Tops] TO [db_sp_exec]
    AS [dbo];

