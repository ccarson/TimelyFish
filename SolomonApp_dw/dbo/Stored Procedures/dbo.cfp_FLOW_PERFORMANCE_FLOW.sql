


CREATE PROCEDURE [dbo].[cfp_FLOW_PERFORMANCE_FLOW]
	@PhaseID CHAR(3)
,	@StartPeriod CHAR(6)
,	@EndPeriod CHAR(6)
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

-----------------------------------------------------------------
-- Report Data
-----------------------------------------------------------------
SELECT DISTINCT

	RTRIM(pf.PigFlowDescription) as PigFlow

FROM dbo.cft_PIG_MASTER_GROUP_ROLLUP mgr

left join (

	Select
	PigCost.MasterGroup,
	Sum(PigCost.PIGS_TRUCKING_COST) PIGS_TRUCKING_COST,
	Sum(PigCost.PIGS_SITE_COST) PIGS_SITE_COST,
	Sum(PigCost.PIGS_RM_COST) PIGS_RM_COST,
	Sum(PigCost.PIGS_VET_COST) PIGS_VET_COST,
	Sum(PigCost.PIGS_SUPPLY_COST) PIGS_SUPPLY_COST,
	Sum(PigCost.PIGS_DEATH) PIGS_DEATH,
	Sum(PigCost.PIGS_TRANSPORT_COST) PIGS_TRANSPORT_COST,
	Sum(PigCost.PIGS_OVR_HD_COST) PIGS_OVR_HD_COST,
	Sum(PigCost.PIGS_OVR_HD_CHG) PIGS_OVR_HD_CHG,
	Sum(PigCost.PIGS_INT_WC_CHG) PIGS_INT_WC_CHG,
	Sum(PigCost.PIGS_MISC_EXP_CHG) PIGS_MISC_EXP_CHG

	from (
	
	Select
	pg.CF03 as 'MasterGroup',
	case when pjp.Acct in ('PIG TRUCKING IN','PIG TRUCKING CHG') then sum(pjp.act_amount) else 0 end as PIGS_TRUCKING_COST,
	case when pjp.Acct in ('PIG SITE CHG') then sum(pjp.act_amount) else 0 end as PIGS_SITE_COST,
	case when pjp.Acct in ('REPAIR & MAINT') then sum(pjp.act_amount) else 0 end as PIGS_RM_COST,
	case when pjp.Acct in ('PIG VET CHG') then sum(pjp.act_amount) else 0 end as PIGS_VET_COST,
	case when pjp.Acct in ('SUPPLIES') then sum(pjp.act_amount) else 0 end as PIGS_SUPPLY_COST,
	case when pjp.Acct in ('PIG DEATH')	then sum(pjp.act_amount) else 0 end as PIGS_DEATH,
	case when pjp.Acct in ('TRANSPORT DEATH') then sum(pjp.act_amount) else 0 end as PIGS_TRANSPORT_COST,
	case when pjp.Acct in ('PIG OVR HD COST') then sum(pjp.act_amount) else 0 end as PIGS_OVR_HD_COST,
	case when pjp.Acct in ('PIG OVR HD CHG') then sum(pjp.act_amount) else 0 end as PIGS_OVR_HD_CHG,
	case when pjp.Acct in ('PIG INT WC CHG') then sum(pjp.act_amount) else 0 end as PIGS_INT_WC_CHG,
	case when pjp.Acct in ('PIG MISC EXP') then sum(pjp.act_amount) else 0 end as PIGS_MISC_EXP_CHG
	FROM [$(SolomonApp)].dbo.cftPigGroup AS pg WITH (NOLOCK)
	LEFT OUTER JOIN [$(SolomonApp)].dbo.cftPigProdPhase AS p WITH (NOLOCK)
	ON pg.PigProdPhaseID = p.PigProdPhaseID
	LEFT OUTER JOIN [$(SolomonApp)].dbo.PJPTDSUM pjp WITH (NOLOCK)
	on pjp.pjt_entity = pg.TaskID
	WHERE
	pg.PGStatusID='I'
	and PG.ActCloseDate>='12/28/2008'
	--and pg.PigProdPhaseID in ('FIN','NUR')
	and PG.PigSystemID = '00'
	--and pjp.Acct in ('PIG TRUCKING IN','PIG TRUCKING CHG')
	group by
	pg.CF03,
	pjp.Acct) PigCost
	
	Group by
	PigCost.MasterGroup) COG 
on mgr.MasterGroup = COG.MasterGroup

left join [$(SolomonApp)].dbo.cftContact c
on mgr.SiteContactID = c.ContactID 
left join [$(CFApp_PigManagement)].dbo.cft_PIG_FLOW pf
on mgr.PigFlowID = pf.PigFlowID
left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dd
on mgr.ActCloseDate = dd.DayDate
Where Case when dd.FiscalPeriod < 10 
then Rtrim(CAST(dd.FiscalYear AS char)) + '0' + Rtrim(CAST(dd.FiscalPeriod AS char)) 
else Rtrim(CAST(dd.FiscalYear AS char)) + Rtrim(CAST(dd.FiscalPeriod AS char)) end between @StartPeriod and @EndPeriod
and mgr.Phase = @PhaseID
--	RTRIM(MasterGroup) = '26570'
--GROUP BY
--	mgr.SiteContactID
--,	c.ContactName
--,	mgr.PigFlowID
--,	pf.PigFlowDescription
----,	mgr.ActCloseDate
----,	mgr.ActStartDate
--,	mgr.SrSvcManager
--,	mgr.SvcManager
--,	mgr.Phase
--ORDER BY mgr.SiteContactID

----PRINT 'PicStartDate = ' + cast(@PicStartDate as varchar)
----PRINT 'PicEndDate = ' + cast(@PicEndDate as varchar)

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_FLOW_PERFORMANCE_FLOW] TO [db_sp_exec]
    AS [dbo];

