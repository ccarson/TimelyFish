
CREATE VIEW [dbo].[cfv_PIG_GROUP_CUMULATIVE_DEATHS_CLOSED]
AS
select
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
sum(IT.Qty) CumulativePigDeaths
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
and IT.acct in ('PIG DEATH')
--and IT.PigGroupID=27889
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
rtrim(DD.PICYear_Week)
