
-- =============================================
-- Author:		SRipley, dbo.cfp_REPORT_SLF_InvVariance2_rpt1
-- Create date: 08/03/2010
-- Description:	This procedure provides the data for the StraightLineFlow Report
-- 2/25/2016, BMD, Excluded SBF PigGroups from report
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_SLF_InvVariance2_rpt1]
@PicYear_Week char(6), @SiteContactid char(6)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @phase char(3)
	
select top 1 @phase = phase from cft_rpt_pig_master_group_dw mpg (nolock)
inner join [$(SolomonApp)].dbo.cftPigGroup cpg on cpg.PigGroupID=mpg.MasterGroup and cpg.PigProdPodID!=53 -- Ignore SBF pig groups
where picyear_week = @picyear_week and mpg.sitecontactid = @sitecontactid

	DECLARE @EndDate char(6)
	
select @enddate = picyear_week
from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dw (NOLOCK)
where daydate = (select top 1 DATEADD(d,-364,weekofdate) from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dw (NOLOCK) where PicYear_week = @picyear_week)

-- CONCATENATE
DECLARE @mastergroup as varchar(100)

SELECT @mastergroup = isnull(@mastergroup + ', ', '') + ltrim(rtrim(mastergroup))
from [dbo].[cft_RPT_PIG_MASTER_GROUP_DW]  flow (nolock)
inner join [$(SolomonApp)].dbo.cftPigGroup cpg on cpg.PigGroupID=flow.MasterGroup and cpg.PigProdPodID!=53 -- Ignore SBF pig groups
	where picyear_week =  @picyear_week and phase = @phase and flow.sitecontactid = @sitecontactid

select --top 1 
mgr.taskid as [Group #]
,HeadStarted
,PigDeath_Qty as Mortality	-- fin & wtf
,mortality as [Total Mortality %] -- nur
,TransferOut_Qty as [Transfer Out]
,TransferToTailender_Qty as [Transfer to TE]	-- fin & wtf	
,PigDeath_pretot_Qty as [#Dead Recorded in Nur] -- nur
,Prim_Qty as [Primary]	-- fin & wtf
,deadb4grade_death_qty as DBG -- nur
,Cull_Qty as [Cull]	-- fin & wtf
,deadontruck_qty + deadinyard_qty + TransportDeath_Qty as [DOT/DIY]	-- fin & wtf	
,TransportDeath_qty as DOT -- nur
,Condemned_qty as [Condemned]	-- fin & wtf
,euthanized_qty as [Euthanized (%NoValue)] -- nur
, cast(prim_qty as float)/( cast(headstarted as float) - cast(transferout_qty as float) )  as pctsoldtoPrimPacker	-- fin & wtf
,InventoryAdjustment_Qty as [Inventory Var]
, case when InventoryAdjustment_Qty < 0 then '(Missing)'
       when InventoryAdjustment_qty > 0 then '(Extra)' end as vardesc
,0 grp
from cft_RPT_PIG_GROUP_DW mgr
inner join [$(SolomonApp)].dbo.cftPigGroup cpg on cpg.PigGroupID=mgr.MasterGroup and cpg.PigProdPodID!=53 -- Ignore SBF pig groups
where mastergroup in (select mastergroup from cft_RPT_PIG_GROUP_DW where PICYear_Week = @picyear_week
and sitecontactid = @sitecontactid
and phase = @phase)
union
select 
'MG-' + @mastergroup [Group #]
,sum(HeadStarted) as headstarted
,sum(PigDeath_Qty) as Mortality	-- fin & wtf
,sum(mortality) as [Total Mortality %] -- nur
,sum(TransferOut_Qty) as [Transfer Out]
,sum(TransferToTailender_Qty) as [Transfer to TE]	-- fin & wtf	
,sum(PigDeath_pretot_Qty) as [#Dead Recorded in Nur] -- nur
,sum(Prim_Qty) as [Primary]	-- fin & wtf
,sum(deadb4grade_death_qty) as DBG -- nur
,sum(Cull_Qty) as [Cull]	-- fin & wtf
,sum(deadontruck_qty) + sum(deadinyard_qty) + sum(TransportDeath_Qty) as [DOT/DIY]	-- fin & wtf	
,sum(TransportDeath_qty) as DOT -- nur
,sum(Condemned_qty) as [Condemned]	-- fin & wtf
,sum(euthanized_qty) as [Euthanized (%NoValue)] -- nur
,sum(cast(prim_qty as float))/ ( sum(cast(headstarted as float)) - sum(cast(transferout_qty as float)) )  as pctsoldtoPrimPacker	-- fin & wtf
,sum(InventoryAdjustment_Qty) as [Inventory Var]
, case when sum(InventoryAdjustment_Qty) < 0 then '(Missing)' 
       when sum(InventoryAdjustment_qty) > 0 then '(Extra)' end as vardesc
,1 as grp
from cft_RPT_PIG_master_GROUP_DW mgr
inner join [$(SolomonApp)].dbo.cftPigGroup cpg on cpg.PigGroupID=mgr.MasterGroup and cpg.PigProdPodID!=53 -- Ignore SBF pig groups
where PICYear_Week = @picyear_week
and mgr.sitecontactid = @sitecontactid
and phase = @phase

order by grp,[Group #]

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_SLF_InvVariance2_rpt1] TO [CorpReports]
    AS [dbo];

