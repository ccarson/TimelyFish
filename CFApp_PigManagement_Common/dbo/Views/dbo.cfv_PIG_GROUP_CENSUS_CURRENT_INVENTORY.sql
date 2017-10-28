
-- ==================================================================
-- Author:		mdawson
-- Create date: 1/6/2010
-- Description:	this gives the current inventory by PIC week/pig group
-- *source data from jmaas
-- ==================================================================
CREATE VIEW [dbo].[cfv_PIG_GROUP_CENSUS_CURRENT_INVENTORY]
AS
select
	pg.PigGroupID,
	pg.PigProdPhaseID,
	CASE WHEN PG.SingleStock <> 0 and FT.Description='WF'
		THEN 'SS WF '
	WHEN PG.SingleStock = 0 and FT.Description='WF' and PG.PigProdPhaseID='NUR'
		THEN 'WF '
	ELSE ''
	END + RTRIM(P.PhaseDesc) PhaseDesc,
	pg.SiteContactID,
	pg.Description,
	d.PICYear_Week,
	sum(it.InvEffect*it.Qty) CurrentInv
from (select distinct WeekOfDate, WeekEndDate, PICYear_Week
		from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo) d
left join [$(SolomonApp)].dbo.cftPGInvTran it (nolock)
	on ((it.TranTypeID in ('MI','PP','TI') and it.TranDate<=d.WeekEndDate)
	or (it.TranTypeID not in ('MI','PP','TI') and it.TranDate<d.WeekOfDate))
left join [$(SolomonApp)].dbo.cftPigGroup pg (nolock)
	on pg.PigGroupID=it.PigGroupID
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftPigProdPhase P WITH (NOLOCK)
	ON P.PigProdPhaseID = PG.PigProdPhaseID
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftBarn B WITH (NOLOCK)
	ON B.ContactID=PG.SiteContactID and B.BarnNbr=PG.BarnNbr
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftFacilityType FT WITH (NOLOCK)
	ON FT.FacilityTypeID=B.FacilityTypeID

where
	it.Reversal<>1
	and pg.ActStartDate>='12/28/2008'
	and pg.PigProdPhaseID in ('FIN','NUR','WTF','TEF')
	and pg.PGStatusID<>'X'
	and pg.PigSystemID='00'
	and (PG.ActCloseDate='' or pg.ActCloseDate>d.WeekOfDate)
	and d.PICYear_Week >= '09WK01'
group by
	pg.PigGroupID,
	pg.PigProdPhaseID,
	CASE WHEN PG.SingleStock <> 0 and FT.Description='WF'
		THEN 'SS WF '
	WHEN PG.SingleStock = 0 and FT.Description='WF' and PG.PigProdPhaseID='NUR'
		THEN 'WF '
	ELSE ''
	END + RTRIM(P.PhaseDesc),
	pg.SiteContactID,
	pg.Description,
	d.PICYear_Week
having
	sum(it.InvEffect*it.Qty)<>0
