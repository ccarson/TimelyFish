
-- =============================================
-- Author:		SRipley, dbo.cfp_REPORT_SLF_InvVariance_MG_rpt1
-- Create date: 08/03/2010
-- Description:	This procedure provides the data for the StraightLineFlow Report

-- a nursery version and a (wtf - fin ) version?????
-- 20150305, changed definition of [DOT/DIY] sripley
-- 2/25/2016, BMD, Excluded SBF PigGroups from report
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_SLF_InvVariance2_MG_rpt1]
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

select --top 1 
'MG %' as [Group #]
,sum(HeadStarted) as headstarted
,sum(cast(PigDeath_Qty as float))/sum(cast(HeadStarted as float)) as Mortality	-- fin & wtf
,sum(cast(mortality as float))/sum(cast(HeadStarted as float)) as [Total Mortality %] -- nur        this is not correct, ignoring in the report (mort is a %)
,sum(cast(TransferOut_Qty as float))/sum(cast(HeadStarted as float)) as [Transfer Out]
,sum(cast(TransferToTailender_Qty as float))/sum(cast(HeadStarted as float)) as [Transfer to TE]	-- fin & wtf	
,sum(cast(PigDeath_pretot_Qty as float))/sum(cast(HeadStarted as float)) as [#Dead Recorded in Nur] -- nur
,null as [Primary]	-- fin & wtf
,sum(cast(deadb4grade_death_qty as float))/sum(cast(HeadStarted as float)) as DBG -- nur
,sum(cast(Cull_Qty as float))/sum(cast(HeadStarted as float)) as [Cull]	-- fin & wtf
,(sum(deadontruck_qty) + sum(deadinyard_qty) + sum(TransportDeath_Qty) ) /sum(cast(HeadStarted as float))  as [DOT/DIY]	-- fin & wtf	-- added 20150305
,sum(cast(TransportDeath_qty as float))/sum(cast(HeadStarted as float)) as DOT -- nur
,sum(cast(Condemned_qty as float))/sum(cast(HeadStarted as float)) as [Condemned]	-- fin & wtf
,sum(cast(euthanized_qty as float))/sum(cast(HeadStarted as float)) as [Euthanized (%NoValue)] -- nur
,sum(cast(prim_qty as float))/ (  sum(cast(headstarted as float)) - sum(cast(transferout_qty as float)) )  as pctsoldtoPrimPacker	-- fin & wtf
,sum(cast(inventoryAdjustment_qty as float))/sum(cast(HeadStarted as float)) as [Inventory Var]
,null as vardesc
,2 grp
from cft_RPT_PIG_master_GROUP_DW mgr
inner join [$(SolomonApp)].dbo.cftPigGroup cpg on cpg.PigGroupID=mgr.MasterGroup and cpg.PigProdPodID!=53 -- Ignore SBF pig groups
where mgr.PICYear_Week = @picyear_week
	and mgr.SiteContactid = @SiteContactid
	and phase = @phase

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_SLF_InvVariance2_MG_rpt1] TO [CorpReports]
    AS [dbo];

