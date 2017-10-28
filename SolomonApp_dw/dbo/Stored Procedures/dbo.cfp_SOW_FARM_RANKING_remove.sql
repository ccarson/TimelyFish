
-- =============================================
-- Author:		Mike Zimanski
-- Create date: 1/27/2011
-- Description:	Returns Farm Rankings Data
-- =============================================
CREATE PROCEDURE [dbo].[cfp_SOW_FARM_RANKING_remove]
(
	
	 @FYPeriod			int

   
)
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	Declare @SowKPI Table
	(Site char(30)
	,SiteID int
	,ContactID int
	,SvcMgr char(30)
	,SvcMgrID int
	,FYPeriod char(6)
	,FarrowTarget int
	,Farrows int
	,ServeFarrow int
	,BornAlive int
	,PreWeanBA int
	,StillBorn int
	,Mummy int
	,GoodPigs int
	,PreWeanGP int
	,AmtGoodPigs int
	,SowWeaned int
	,SowGiltDeath int
	,SowDays int
	,Amt float)
	
	Insert Into @SowKPI
	
	Select 
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
	Where FYPeriod = @FYPeriod
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
	Amt

	Select 
	
	rtrim(SowKPI.Site) as 'Site',
	SowKPI.Farrows,
	SowKPI.ServeFarrow,
	SowKPI.BornAlive,
	SowKPI.PreWeanBA,
	SowKPI.StillBorn,
	SowKPI.Mummy,
	SowKPI.GoodPigs,
	SowKPI.PreWeanGP,
	SowKPI.SowWeaned,
	SowKPI.SowGiltDeath,
	SowKPI.SowDays,
	SowKPIYTD.Farrows as 'YTDFarrows',
	SowKPIYTD.ServeFarrow as 'YTDServeFarrow',
	SowKPIYTD.BornAlive as 'YTDBornAlive',
	SowKPIYTD.PreWeanBA as 'YTDPreWeanBA',
	SowKPIYTD.StillBorn as 'YTDStillBorn',
	SowKPIYTD.Mummy as 'YTDMummy',
	SowKPIYTD.GoodPigs as 'YTDGoodPigs',
	SowKPIYTD.PreWeanGP as 'YTDPreWeanGP',
	SowKPIYTD.SowWeaned as 'YTDSowWeaned',
	SowKPIYTD.SowGiltDeath as 'YTDSowGiltDeath',
	SowKPIYTD.SowDays as 'YTDSowDays',
	'Sites' = (Select COUNT(Site) from @SowKPI)

	From @SowKPI SowKPI 
	
	left join 
	
	(Select 
	Site,
	Sum(FarrowTarget) FarrowTarget,
	Sum(Farrows) Farrows,
		Sum(ServeFarrow) ServeFarrow,
	Sum(BornAlive) BornAlive,
	Sum(PreWeanBA) PreWeanBA,
	Sum(StillBorn) StillBorn,
	Sum(Mummy) Mummy,
	Sum(GoodPigs) GoodPigs,
	Sum(PreWeanGP) PreWeanGP,
	Sum(SowWeaned) SowWeaned,
	Sum(SowGiltDeath) SowGiltDeath,
	Sum(SowDays) SowDays
	from  dbo.cft_SOW_SERVICEMGR_KPI_RESULTS (nolock)
	Where FYPeriod between LEFT(RTRIM(@FYPeriod),4)+'01' and @FYPeriod
	Group by
	Site) SowKPIYTD
	on SowKPI.Site = SowKPIYTD.Site 

	Group by
	rtrim(SowKPI.Site),
	SowKPI.Farrows,
	SowKPI.ServeFarrow,
	SowKPI.BornAlive,
	SowKPI.PreWeanBA,
	SowKPI.StillBorn,
	SowKPI.Mummy,
	SowKPI.GoodPigs,
	SowKPI.PreWeanGP,
	SowKPI.SowWeaned,
	SowKPI.SowGiltDeath,
	SowKPI.SowDays,
	SowKPIYTD.Farrows,
	SowKPIYTD.ServeFarrow,
	SowKPIYTD.BornAlive,
	SowKPIYTD.PreWeanBA,
	SowKPIYTD.StillBorn,
	SowKPIYTD.Mummy,
	SowKPIYTD.GoodPigs,
	SowKPIYTD.PreWeanGP,
	SowKPIYTD.SowWeaned,
	SowKPIYTD.SowGiltDeath,
	SowKPIYTD.SowDays 

	Order by
	SowKPI.Site
	
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SOW_FARM_RANKING_remove] TO [db_sp_exec]
    AS [dbo];

