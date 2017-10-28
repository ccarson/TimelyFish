

-- =============================================
-- Author:		Mike Zimanski
-- Create date: 1/13/2011
-- Description:	Returns Feed Consumption per WP
-- =============================================
CREATE PROCEDURE [dbo].[cfp_SOW_FEED_CONSUMPTION_remove]
(
	
	 @PICYear_Week		varchar(20)
	,@Invtiddel			varchar(20)
	,@Region			varchar(20)
	,@SiteID			int

   
)
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @TempInvtiddel varchar(20)

	IF @Invtiddel = '%' 

	BEGIN
		SET @TempInvtiddel = '%'
	END
	
	ELSE
	BEGIN
		SET @TempInvtiddel = @Invtiddel
	END
	
	DECLARE @TempRegion varchar(20)

	IF @Region = '%' 

	BEGIN
		SET @TempRegion = '%'
	END
	
	ELSE
	BEGIN
		SET @TempRegion = @Region
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
	DRS.ContactName2 as ContactName,
	DRS.SiteID,
	DRS.Region,
	Feed.InvtIDDel,
	Feed.BegInv,
	Feed.QtyDel,
	Feed.EndInv,
	Feed.FeedConsumed,
	Sum(SGP.SowDays)/7 as Sows,
	Sum(SGP.GoodPigs) as GoodPigs,
	Sum(RSGP.SowDays)/7 as RSows,
	Sum(RSGP.GoodPigs) as RGoodPigs,
	Sum(SSGP.SowDays)/7 as SSows,
	Sum(SSGP.GoodPigs) as SGoodPigs,
	Feed.PicYear_Week 
	
	From  dbo.cft_SOW_FEED_CONSUMPTION Feed
	
	left join  dbo.cfv_SOW_DIVISION_REGION_SITE DRS
	on Feed.ContactID = DRS.ContactID
	
	left join (Select Distinct WeekOfDate, PicYear_Week from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo) WeekInfo
	on Feed.PicYear_Week = WeekInfo.PicYear_Week
	
	left join (Select 
	DRS.ContactName2, 
	DRS.ContactID, 
	DRS.SiteID, 
	DRS.Region,
	Case when SGP.GoodPigs is null then 0 else SGP.GoodPigs end as GoodPigs,
	Case when SGP.SowDays is null then 0 else SGP.SowDays end as SowDays, 
	SGP.WeekOfDate
	from  dbo.cft_SOW_SOWDAYS_GOODPIGS SGP

	left join  dbo.cfv_SOW_DIVISION_REGION_SITE DRS
	on SGP.ContactID = DRS.ContactID) SGP
	on DRS.SiteID = SGP.SiteID
	and WeekInfo.WeekOfDate = SGP.WeekOfDate
	
	left join (Select 
	DRS.Region,
	Case when Sum(SGP.GoodPigs) is null then 0 else Sum(SGP.GoodPigs) end as GoodPigs,
	Case when Sum(SGP.SowDays) is null then 0 else Sum(SGP.SowDays) end as SowDays, 
	SGP.WeekOfDate
	from  dbo.cft_SOW_SOWDAYS_GOODPIGS SGP

	left join  dbo.cfv_SOW_DIVISION_REGION_SITE DRS
	on SGP.ContactID = DRS.ContactID
	
	Group by
	DRS.Region,
	SGP.WeekOfDate) RSGP
	on DRS.Region = RSGP.Region
	and WeekInfo.WeekOfDate = RSGP.WeekOfDate
	
	left join (Select 
	Case when Sum(SGP.GoodPigs) is null then 0 else Sum(SGP.GoodPigs) end as GoodPigs,
	Case when Sum(SGP.SowDays) is null then 0 else Sum(SGP.SowDays) end as SowDays, 
	SGP.WeekOfDate
	from  dbo.cft_SOW_SOWDAYS_GOODPIGS SGP

	left join  dbo.cfv_SOW_DIVISION_REGION_SITE DRS
	on SGP.ContactID = DRS.ContactID
	
	Group by
	SGP.WeekOfDate) SSGP
	on WeekInfo.WeekOfDate = SSGP.WeekOfDate
	
	Where Feed.PicYear_Week like @PICYear_Week
	and Feed.InvtIDDel like @TempInvtIDDel
	and DRS.Region like @TempRegion
	and DRS.SiteID like @TempSiteID
	
	Group by
	
	DRS.ContactName2,
	DRS.SiteID,
	DRS.Region,
	Feed.InvtIDDel,
	Feed.BegInv,
	Feed.QtyDel,
	Feed.EndInv,
	Feed.FeedConsumed,
	Feed.PicYear_Week 
	
	END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SOW_FEED_CONSUMPTION_remove] TO [db_sp_exec]
    AS [dbo];

