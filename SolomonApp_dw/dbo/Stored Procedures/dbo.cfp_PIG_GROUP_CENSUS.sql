

CREATE PROCEDURE [dbo].[cfp_PIG_GROUP_CENSUS]
AS
BEGIN

-------------------------------------------------------------------------------------------------------
-- this is dependent on replication finishing, so should be run directly after log shipping completes
-------------------------------------------------------------------------------------------------------

--clear table for new data
truncate table  dbo.cft_PIG_GROUP_CENSUS

--------------------------------------------------------------------------
-- BASE INFO
--------------------------------------------------------------------------
INSERT INTO  dbo.cft_PIG_GROUP_CENSUS
(	PigGroupID
,	PigProdPhaseID
,	PhaseDesc
,	SiteContactID
,	SvcManager
,	SrSvcManager
,	Description
,	PICYear_Week
,	CurrentInv
,	PigDeaths
)
SELECT
	cfv_PIG_GROUP_CENSUS.PigGroupID
,	cfv_PIG_GROUP_CENSUS.PigProdPhaseID
,	cfv_PIG_GROUP_CENSUS.PhaseDesc
,	cfv_PIG_GROUP_CENSUS.SiteContactID
,	cfv_PIG_GROUP_CENSUS.SvcManager
,	cfv_PIG_GROUP_CENSUS.SrServManager
,	cfv_PIG_GROUP_CENSUS.Description
,	cfv_PIG_GROUP_CENSUS.PICYear_Week
,	cfv_PIG_GROUP_CENSUS.CurrentInv
,	cfv_PIG_GROUP_CENSUS.PigDeaths

FROM [$(CFApp_PigManagement)].dbo.cfv_PIG_GROUP_CENSUS cfv_PIG_GROUP_CENSUS

-- set pods
UPDATE cft_PIG_GROUP_CENSUS
SET PodDescription = cftPigProdPod.Description
FROM  dbo.cft_PIG_GROUP_CENSUS cft_PIG_GROUP_CENSUS (NOLOCK)
JOIN [$(SolomonApp)].dbo.cftPigGroup cftPigGroup (NOLOCK)
	ON cftPigGroup.PigGroupID = cft_PIG_GROUP_CENSUS.PigGroupID
JOIN [$(SolomonApp)].dbo.cftPigProdPod cftPigProdPod (NOLOCK)
	ON cftPigProdPod.PodID = cftPigGroup.PigProdPodID

-- set nursery sources (not nur)
UPDATE dbo.cft_PIG_GROUP_CENSUS
SET NurserySource = [$(SolomonApp)].dbo.PGGetSource(PigGroupID)
WHERE PigProdPhaseID <> 'NUR'

-- set nursery sources (nur)
UPDATE	cft_PIG_GROUP_CENSUS
SET	NurserySource = cft_PIG_GROUP_BASE_SOURCE.BaseSource
FROM	dbo.cft_PIG_GROUP_CENSUS cft_PIG_GROUP_CENSUS (NOLOCK)
JOIN	dbo.cft_PIG_GROUP_BASE_SOURCE cft_PIG_GROUP_BASE_SOURCE (NOLOCK)
	ON cft_PIG_GROUP_BASE_SOURCE.PigGroupID = cft_PIG_GROUP_CENSUS.PigGroupID
WHERE	cft_PIG_GROUP_CENSUS.PigProdPhaseID = 'NUR'

-- pig flow start date
UPDATE cft_PIG_GROUP_CENSUS
SET	PigFlowStartDate = cfv_GroupStart.StartDate
FROM dbo.cft_PIG_GROUP_CENSUS cft_PIG_GROUP_CENSUS (nolock)
LEFT JOIN [$(SolomonApp)].dbo.cfv_GroupStart cfv_GroupStart (nolock)
	ON cfv_GroupStart.PigGroupID = cft_PIG_GROUP_CENSUS.PigGroupID


-- head started open
UPDATE dbo.cft_PIG_GROUP_CENSUS
SET HeadStarted = sub.HeadStarted
FROM dbo.cft_PIG_GROUP_CENSUS cft_PIG_GROUP_CENSUS (NOLOCK)
JOIN
(select
rtrim(IT.PigGroupID) 'PigGroupID',
pg.PigProdPhaseID,
case
when PG.SingleStock <> 0
and FT.Description='WF'
then 'SS WF '
when PG.SingleStock = 0
and FT.Description='WF'
and PG.PigProdPhaseID='NUR'
then 'WF '
else ''
end
+
rtrim(P.PhaseDesc) PhaseDesc,
pg.SiteContactID,
rtrim(pg.Description) Description,
rtrim(DD.PICYear_Week) PICYear_Week,
sum(IT.Qty*IT.InvEffect) HeadStarted
from [$(SolomonApp)].dbo.cftWeekDefinition WD (nolock)
join [$(SolomonApp)].dbo.cftPGInvTran IT (nolock) 
on IT.TranDate<=WD.WeekEndDate
left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo DD (nolock)
on WD.WeekOfDate=DD.DayDate
left join [$(SolomonApp)].dbo.cftPigGroup PG
on IT.PigGroupID=PG.PigGroupID
left join [$(SolomonApp)].dbo.cfv_GroupStart ST
on ST.PigGroupID = PG.PigGroupID
left join [$(SolomonApp)].dbo.cftPigProdPhase P
on P.PigProdPhaseID = PG.PigProdPhaseID
left join [$(SolomonApp)].dbo.cftPGStatus S
on S.PGStatusID = PG.PGStatusID
left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo DD2 (nolock)
on ST.StartDate=DD2.DayDate
left join [$(SolomonApp)].dbo.cftBarn B
on B.ContactID=PG.SiteContactID and B.BarnNbr=PG.BarnNbr
left join [$(SolomonApp)].dbo.cftFacilityType FT
on FT.FacilityTypeID=B.FacilityTypeID
left join [$(SolomonApp)].dbo.cfvPIGSALEREV psa
on psa.BatNbr=IT.SourceBatNbr and psa.RefNbr=IT.SourceRefNbr
where 
IT.Reversal = '0'
/*THIS IS WHERE WE WANT TO INPUT THE ENDDATE VARIABLE*/
and DD.DayDate <=DATEADD(DD,-DATEPART(DW,GETDATE()),GETDATE()) --LastSaturday 
/*THIS IS WHERE WE WANT TO INPUT THE ENDDATE VARIABLE*/
--and PG.PGStatusID = 'I'
and PG.PGStatusID in ('A','T')
and ST.StartDate >='12/28/2008'
and IT.acct in ('PIG PURCHASE','PIG TRANSFER IN','PIG MOVE IN','PIG MOVE OUT')
--and IT.PigGroupID = 27772     
group by
rtrim(IT.PigGroupID),
pg.PigProdPhaseID,
rtrim(P.PhaseDesc),
case
when PG.SingleStock <> 0
and FT.Description='WF'
then 'SS WF '
when PG.SingleStock = 0
and FT.Description='WF'
and PG.PigProdPhaseID='NUR'
then 'WF '
else ''
end
+
rtrim(P.PhaseDesc),
pg.SiteContactID,
rtrim(pg.Description),
rtrim(DD.PICYear_Week)) sub
	ON sub.PigGroupID = cft_PIG_GROUP_CENSUS.PigGroupID
	AND sub.PICYear_Week = cft_PIG_GROUP_CENSUS.PICYear_Week


-- head started closed
UPDATE dbo.cft_PIG_GROUP_CENSUS
SET HeadStarted = sub.HeadStarted
FROM dbo.cft_PIG_GROUP_CENSUS cft_PIG_GROUP_CENSUS (NOLOCK)
JOIN
(select
rtrim(IT.PigGroupID) 'PigGroupID',
pg.PigProdPhaseID,
case
when PG.SingleStock <> 0
and FT.Description='WF'
then 'SS WF '
when PG.SingleStock = 0
and FT.Description='WF'
and PG.PigProdPhaseID='NUR'
then 'WF '
else ''
end
+
rtrim(P.PhaseDesc) PhaseDesc,
pg.SiteContactID,
rtrim(pg.Description) Description,
rtrim(DD.PICYear_Week) PICYear_Week,
sum(IT.Qty*IT.InvEffect) HeadStarted
from [$(SolomonApp)].dbo.cftWeekDefinition WD (nolock)
join [$(SolomonApp)].dbo.cftPGInvTran IT (nolock) 
on IT.TranDate<=WD.WeekEndDate
left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo DD (nolock)
on WD.WeekOfDate=DD.DayDate
left join [$(SolomonApp)].dbo.cftPigGroup PG
on IT.PigGroupID=PG.PigGroupID
left join [$(SolomonApp)].dbo.cfv_GroupStart ST
on ST.PigGroupID = PG.PigGroupID
left join [$(SolomonApp)].dbo.cftPigProdPhase P
on P.PigProdPhaseID = PG.PigProdPhaseID
left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo DD2 (nolock)
on ST.StartDate=DD2.DayDate
left join [$(SolomonApp)].dbo.cftBarn B
on B.ContactID=PG.SiteContactID and B.BarnNbr=PG.BarnNbr
left join [$(SolomonApp)].dbo.cftFacilityType FT
on FT.FacilityTypeID=B.FacilityTypeID
where 
IT.Reversal = '0'
and PG.PGStatusID = 'I'
and DD.DayDate <= PG.ActCloseDate
and ST.StartDate >='12/28/2008'
and IT.acct in ('PIG PURCHASE','PIG TRANSFER IN','PIG MOVE IN','PIG MOVE OUT')
--and IT.PigGroupID=27358
group by
rtrim(IT.PigGroupID),
pg.PigProdPhaseID,
rtrim(P.PhaseDesc),
case
when PG.SingleStock <> 0
and FT.Description='WF'
then 'SS WF '
when PG.SingleStock = 0
and FT.Description='WF'
and PG.PigProdPhaseID='NUR'
then 'WF '
else ''
end
+
rtrim(P.PhaseDesc),
pg.SiteContactID,
rtrim(pg.Description),
rtrim(DD.PICYear_Week)) sub
	ON sub.PigGroupID = cft_PIG_GROUP_CENSUS.PigGroupID
	AND sub.PICYear_Week = cft_PIG_GROUP_CENSUS.PICYear_Week

-- cumulative pig deaths open
UPDATE cft_PIG_GROUP_CENSUS
SET	CumulativePigDeaths = cfv_PIG_GROUP_CUMULATIVE_DEATHS_OPEN.CumulativePigDeaths
FROM dbo.cft_PIG_GROUP_CENSUS cft_PIG_GROUP_CENSUS (nolock)
JOIN [$(CFApp_PigManagement)].dbo.cfv_PIG_GROUP_CUMULATIVE_DEATHS_OPEN cfv_PIG_GROUP_CUMULATIVE_DEATHS_OPEN
	ON cfv_PIG_GROUP_CUMULATIVE_DEATHS_OPEN.PigGroupID = cft_PIG_GROUP_CENSUS.PigGroupID
	AND cfv_PIG_GROUP_CUMULATIVE_DEATHS_OPEN.PICYear_Week = cft_PIG_GROUP_CENSUS.PICYear_Week

-- cumulative pig deaths closed
UPDATE cft_PIG_GROUP_CENSUS
SET	CumulativePigDeaths = cfv_PIG_GROUP_CUMULATIVE_DEATHS_CLOSED.CumulativePigDeaths
FROM dbo.cft_PIG_GROUP_CENSUS cft_PIG_GROUP_CENSUS (nolock)
JOIN [$(CFApp_PigManagement)].dbo.cfv_PIG_GROUP_CUMULATIVE_DEATHS_CLOSED cfv_PIG_GROUP_CUMULATIVE_DEATHS_CLOSED
	ON cfv_PIG_GROUP_CUMULATIVE_DEATHS_CLOSED.PigGroupID = cft_PIG_GROUP_CENSUS.PigGroupID
	AND cfv_PIG_GROUP_CUMULATIVE_DEATHS_CLOSED.PICYear_Week = cft_PIG_GROUP_CENSUS.PICYear_Week




END



