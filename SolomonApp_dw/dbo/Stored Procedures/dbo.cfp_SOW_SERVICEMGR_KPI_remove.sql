
-- =============================================
-- Author:		Mike Zimanski
-- Create date: 11/22/2010
-- Description:	Returns KPI Performance by Site & Svc Mgr
-- =============================================
CREATE PROCEDURE [dbo].[cfp_SOW_SERVICEMGR_KPI_remove]
(
	
	 @FYPeriod			int
	,@SvcMgrID			varchar(20)
	,@SiteID			varchar(20)

   
)
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @TempSvcMgrID varchar(20)

	IF @SvcMgrID = -1 

	BEGIN
		SET @TempSvcMgrID = '%'
	END
	
	ELSE
	BEGIN
		SET @TempSvcMgrID = @SvcMgrID
	END
	
	DECLARE @TempSiteID varchar(20)

	IF @SiteID = -1 

	BEGIN
		SET @TempSiteID = '%'
	END
	
	ELSE
	BEGIN
		SET @TempSiteID = @SiteID
	END

	Select 
	
	SowKPI.Site,
	SowKPI.Siteid,
	SowKPI.Contactid,
	SowKPI.SvcMgr,
	SowKPI.SvcMgrID,
	SowKPI.FYPeriod,
	SowKPI.FarrowTarget,
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
	SowKPI.SowDays,
	SowKPI.Amt

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

	Where
	SowKPI.FYPeriod like @FYPeriod
	and SowKPI.SvcMgrID like @TempSvcMgrID
	and SowKPI.SiteID like @TempSiteID

	Order by
	SowKPI.Site,
	SowKPI.FYPeriod	
	
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SOW_SERVICEMGR_KPI_remove] TO [db_sp_exec]
    AS [dbo];

