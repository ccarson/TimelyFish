
-- =============================================
-- Author:		SRipley, dbo.cfp_REPORT_SLF_InvVariance_rpt1_nur
-- Create date: 08/03/2010
-- Description:	This procedure provides the data for the StraightLineFlow Report

-- a nursery version 
--
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_SLF_InvVariance_rpt1_NUR]
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

	select --top 1
	taskid as [Group #]
	,HeadStarted
	,mortality as [Total Mortality %]
	,TransferOut_Qty as [Transfer Out]
	,PigDeath_pretot_Qty as [#Dead Recorded in Nur]
	,deadb4grade_death_qty as DBG
	,TransportDeath_qty as DOT
	,euthanized_qty as [Euthanized (%NoValue)]
	,InventoryAdjustment_Qty as [Inventory Var]
	, case when InventoryAdjustment_Qty < 0 then '(Missing)'
		   when InventoryAdjustment_qty > 0 then '(Extra)' end as vardesc
	,0 grp
	from cft_RPT_PIG_GROUP_DW mgr
	where PICYear_Week = @picyear_week 
	and mastergroup = @mastergroup
	union
	select --top 1	
	'MG' + mgr.mastergroup as [Group #]
	,sum(mgr.HeadStarted) HeadStarted
	,case when isnull(sum(mgr.HeadStarted),0) <> 0			
		then ((cast(isnull(sum(mgr.PigDeath_Qty),0) as numeric(14,2)) )
				/ cast(sum(mgr.HeadStarted) as numeric(14,2))) * 100
		else 0
	 end as [Total Mortality %]
	,sum(mgr.TransferOut_Qty) as [Transfer Out]
	,sum(mgr.PigDeath_pretot_Qty) as [#Dead Recorded in Nur]
	,sum(mgr.deadb4grade_death_qty) as DBG
	,sum(mgr.TransportDeath_qty) as DOT
	,sum(mgr.euthanized_qty) as [Euthanized (%NoValue)]
	,sum(mgr.InventoryAdjustment_Qty) as [Inventory Var]
	, case when sum(mgr.InventoryAdjustment_Qty) < 0 then '(Missing)' 
		   when sum(mgr.InventoryAdjustment_Qty) > 0 then '(Extra)' end as vardesc
	,1 grp
	from cft_RPT_PIG_master_GROUP_DW mgr
	where mgr.PICYear_Week = @picyear_week
	and mgr.mastergroup = @mastergroup   
	group by mgr.picyear_week, mgr.mastergroup
	order by grp,[Group #]


END



















GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_SLF_InvVariance_rpt1_NUR] TO [CorpReports]
    AS [dbo];

