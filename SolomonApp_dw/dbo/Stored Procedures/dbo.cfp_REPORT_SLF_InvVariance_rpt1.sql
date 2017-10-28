











-- =============================================
-- Author:		SRipley, dbo.cfp_REPORT_SLF_InvVariance_rpt1
-- Create date: 08/03/2010
-- Description:	This procedure provides the data for the StraightLineFlow Report

-- a nursery version and a (wtf - fin ) version?????
--
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_SLF_InvVariance_rpt1]
@PicYear_Week char(6), @SiteContactid char(6)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @phase char(3)
	
select top 1 @phase = phase from cft_rpt_pig_master_group_dw mpg (nolock)
where picyear_week = @picyear_week and sitecontactid = @sitecontactid

	DECLARE @EndDate char(6)
	
select @enddate = picyear_week
from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dw (NOLOCK)
where daydate = (select top 1 DATEADD(d,-364,weekofdate) from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dw (NOLOCK) where PicYear_week = @picyear_week)

	DECLARE @mastergroup char(6)

select @mastergroup = mastergroup from [dbo].[cft_RPT_PIG_MASTER_GROUP_DW]  flow (nolock)
where picyear_week =  @picyear_week and phase = @phase and sitecontactid = @sitecontactid
-- (nursery phase)
-- Head started
-- total mortality %
-- transfer out
-- #dead recorded in nursery
-- DBG  (dead before grade)
-- DOT
-- Euthanized (% no value)
-- Inv Var
-- VAR expl
select --top 1 
taskid as [Group #]
,HeadStarted
,PigDeath_Qty as Mortality
,TransferOut_Qty as [Transfer Out]
,TransferToTailender_Qty as [Transfer to TE]
,Prim_Qty as [Primary]
,Cull_Qty as [Cull]
,DeadPigsToPacker_Qty + TransportDeath_Qty as [DOT/DIY]	
,Condemned_qty as [Condemned]
--,TransportDeath_Qty as [Transport Death]
, (cast(prim_qty as float)/(cast(headstarted as float) - cast(transferout_qty as float)))*100  as pctsoldtoPrimPacker
,InventoryAdjustment_Qty as [Inventory Var]
, case when InventoryAdjustment_Qty < 0 then '(Missing)'
       when InventoryAdjustment_qty > 0 then '(Extra)' end as vardesc
,0 grp
from cft_RPT_PIG_GROUP_DW mgr
where PICYear_Week = @picyear_week 
and mastergroup = @mastergroup
--order by mastergroup, taskid
union
select --top 1 
'MG' + mastergroup as [Group #]
,HeadStarted
,PigDeath_Qty as Mortality
,TransferOut_Qty as [Transfer Out]
,TransferToTailender_Qty as [Transfer to TE]
,Prim_Qty as [Primary]
,Cull_Qty as [Cull]
,DeadPigsToPacker_Qty + TransportDeath_Qty as [DOT/DIY]	
,Condemned_qty as [Condemned]
--,TransportDeath_Qty as [Transport Death]
, (cast(prim_qty as float)/(cast(headstarted as float) - cast(transferout_qty as float)))*100  as pctsoldtoPrimPacker
,InventoryAdjustment_Qty as [Inventory Var]
, case when InventoryAdjustment_Qty < 0 then '(Missing)' 
       when InventoryAdjustment_qty > 0 then '(Extra)' end as vardesc
,1 grp
from cft_RPT_PIG_master_GROUP_DW mgr
--left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dd
--on mgr.actclosedate = dd.DayDate
where PICYear_Week = @picyear_week
and mastergroup = @mastergroup

order by grp,[Group #]

END


















GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_SLF_InvVariance_rpt1] TO [CorpReports]
    AS [dbo];

