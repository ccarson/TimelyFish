
-- =============================================
-- Author:		Mike Zimanski
-- Create date: 1/27/2011
-- Description:	Returns YTD Sow Farm Rankings Data
-- =============================================
CREATE PROCEDURE [dbo].[cfp_SOW_FARM_RANKING_YTD_remove]
(
	
	 @FYPeriod			int

   
)
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Select 
	
	SowKPI.Site,
	SowKPI.Siteid,
	SowKPI.Contactid,
	RIGHT(DW.FiscalYear, 2) + 'Per' + REPLICATE('0', 2 - LEN(RTRIM(CONVERT(char(2), RTRIM(DW.FiscalPeriod))))) + RTRIM(CONVERT(char(2), RTRIM(DW.FiscalPeriod))) as FYPeriod,
	SowKPI.Farrows,
	SowKPI.ServeFarrow,
	SowKPI.BornAlive,
	SowKPI.PreWeanBA,
	SowKPI.StillBorn,
	SowKPI.Mummy,
	SowKPI.GoodPigs,
	SowKPI.PreWeanGP,
	SowKPI.AmtGoodPigs,
	SowKPI.SowWeaned,
	SowKPI.SowGiltDeath,
	SowKPI.SowDays

	From (Select 
	Site,
	SiteID,
	ContactID,
	SvcMgr,
	SvcMgrID,
	FYPeriod,
	Sum(FarrowTarget) FarrowTarget,
	Sum(Farrows) Farrows,
	Sum(ServeFarrow) ServeFarrow,
	Sum(BornAlive) BornAlive,
	PreWeanBA,
	Sum(StillBorn) StillBorn,
	Sum(Mummy) Mummy,
	GoodPigs,
	PreWeanGP,
	AmtGoodPigs,
	Sum(SowWeaned) SowWeaned,
	Sum(SowGiltDeath) SowGiltDeath,
	Sum(SowDays) SowDays,
	Amt
	from  dbo.cft_SOW_SERVICEMGR_KPI_RESULTS (nolock)
	Where FYPeriod between LEFT(RTRIM(@FYPeriod),4)+'01' and @FYPeriod
	Group by
	Site,
	SiteID,
	ContactID,
	SvcMgr,
	SvcMgrID,
	FYPeriod,
	PreWeanBA,
	GoodPigs,
	PreWeanGP,
	AmtGoodPigs,
	Amt) SowKPI 
	
	left join (Select Distinct FiscalYear, FiscalPeriod from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo) DW
	on SowKPI.FYPeriod = Case when DW.FiscalPeriod < 10 
	then Rtrim(CAST(DW.FiscalYear AS char)) + '0' + Rtrim(CAST(DW.FiscalPeriod AS char)) 
	else Rtrim(CAST(DW.FiscalYear AS char)) + Rtrim(CAST(DW.FiscalPeriod AS char)) end 

	--Where
	--SowKPI.FYPeriod like @FYPeriod

	Order by
	SowKPI.Site,
	SowKPI.FYPeriod	
	
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SOW_FARM_RANKING_YTD_remove] TO [db_sp_exec]
    AS [dbo];

