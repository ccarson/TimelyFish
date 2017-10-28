

-- =============================================
-- Author:		Mike Zimanski
-- Create date: 09/29/2010
-- Description:	Returns Sow Site Energy Units and $
-- =============================================
CREATE PROCEDURE [dbo].[cfp_SOW_SITE_ENERGY]
(
	
	 @Descr				varchar(30)
	,@StartPeriod		int
	,@EndPeriod			int
	,@Region			varchar(8)
	,@SiteID			int

   
)
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @TempRegion varchar(8)

	IF @Region = '%' 

	BEGIN
		SET @TempRegion = '%'
	END
	
	ELSE
	BEGIN
		SET @TempRegion = @Region
	END

	DECLARE @TempSiteID varchar(8)

	IF @SiteID = -1 

	BEGIN
		SET @TempSiteID = '%'
	END
	
	ELSE
	BEGIN
		SET @TempSiteID = @SiteID
	END
	
	Declare @Sow Table
	
	(SiteID int,
	Region varchar (50),
	Division varchar (50),
	SowDays int,
	GroupPeriod Float)
	
	Insert into @Sow
	
	Select 
	
	DRS.SiteID,
	DRS.Region,
	DRS.Division,
	Case when WD.FiscalYear = 2008 and WD.FiscalPeriod in (03,04,05,06,07) and DRS.SiteID in (8454,8460,8465,8466,8470,8900) then 0
	when WD.FiscalYear = 2008 and WD.FiscalPeriod in (08,09,10,11) and DRS.SiteID = 8470 then 0
	when WD.FiscalYear = 2009 and WD.FiscalPeriod in (05,06,07,08,09,10,11) and DRS.SiteID = 9820 then 0
	when WD.FiscalYear = 2008 and WD.FiscalPeriod in (02,03,04,05) and DRS.SiteID = 8455 then 0
	when WD.FiscalYear = 2009 and WD.FiscalPeriod in (11,12) and DRS.SiteID = 8455 then 0
	when WD.FiscalYear = 2010 and WD.FiscalPeriod in (01,02,03,04,11) and DRS.SiteID = 8455 then 0
	when WD.FiscalYear = 2008 and WD.FiscalPeriod = 02 and DRS.SiteID in (8900,8460,8420,8470) then 0
	when WD.FiscalYear = 2008 and WD.FiscalPeriod = 01 and DRS.SiteID in (9800,8420,8455,8460,8470) then 0
	else Sum(SD.SowDays) end as 'SowDays',
	Case When WD.FiscalPeriod < 10 
	Then Rtrim(Cast(WD.FiscalYear as char))+'0'+Rtrim(Cast(WD.FiscalPeriod as char)) 
	else Rtrim(Cast(WD.FiscalYear as char))+Rtrim(Cast(WD.FiscalPeriod as char)) end As GroupPeriod

	FROM  dbo.cft_SOW_SOWDAYS_GOODPIGS SD

	left join 
	(Select Distinct ContactName2 as ContactName, ContactID, SiteID, Division, Region
	from  dbo.cfv_SOW_DIVISION_REGION_SITE) DRS
	on SD.ContactID = DRS.ContactID

	left join [$(SolomonApp)].dbo.cftWeekDefinition WD
	on SD.WeekOfDate = WD.WeekOfDate

	Where Case When WD.FiscalPeriod < 10 
	Then Rtrim(Cast(WD.FiscalYear as char))+'0'+Rtrim(Cast(WD.FiscalPeriod as char)) 
	else Rtrim(Cast(WD.FiscalYear as char))+Rtrim(Cast(WD.FiscalPeriod as char)) end between @StartPeriod and @EndPeriod

	Group by 
	DRS.SiteID,
	DRS.Region,
	DRS.Division,
	WD.FiscalYear, 
	WD.FiscalPeriod

	SELECT 

	DRS.ContactName,
	DRS.SiteID,
	DRS.Region, 
	DRS.Division,
	PL.Descr,
	PL.TranDesc,
	Sum(PL.Qty) as Units, 
	Sum(PL.Amt) as Dollars,
	Sow.Sows,
	Case when Sow.Sows=0 then 0
	else ((Sum(PL.Amt)/Sow.Sows)/WK.Weeks)*52 end as AmtSow,
	Case when Sow.Sows=0 then 0
	else ((Sum(PL.Qty)/Sow.Sows)/WK.Weeks)*52 end as QtySow,
	RegSow.Sows as RegSow,
	Case when RegSow.Sows=0 then 0
	else ((Sum(PL.Amt)/RegSow.Sows)/WK.Weeks)*52 end as RegAmtSow,
	Case when RegSow.Sows=0 then 0
	else ((Sum(PL.Qty)/RegSow.Sows)/WK.Weeks)*52 end as RegQtySow,
	DivSow.Sows as DivSow,
	Case when DivSow.Sows=0 then 0
	else ((Sum(PL.Amt)/DivSow.Sows)/WK.Weeks)*52 end as DivAmtSow,
	Case when DivSow.Sows=0 then 0
	else ((Sum(PL.Qty)/DivSow.Sows)/WK.Weeks)*52 end as DivQtySow,
	SysSow.Sows as SysSow,
	Case when SysSow.Sows=0 then 0
	else ((Sum(PL.Amt)/SysSow.Sows)/WK.Weeks)*52 end as SysAmtSow,
	Case when SysSow.Sows=0 then 0
	else ((Sum(PL.Qty)/SysSow.Sows)/WK.Weeks)*52 end as SysQtySow

	FROM  dbo.cft_SOW_PL PL

	left join 
	(Select Distinct ContactName2 as ContactName, SiteID, Division, Region
	from  dbo.cfv_SOW_DIVISION_REGION_SITE) DRS
	on DRS.SiteID = right(rtrim(PL.Sub),4)

	left join 
	(Select 
	Sow.SiteID,
	Sum(Sow.SowDays)/PD.Days as Sows

	FROM (Select 
	
	DRS.SiteID,
	DRS.Region,
	DRS.Division,
	Case when WD.FiscalYear = 2008 and WD.FiscalPeriod in (03,04,05,06,07) and DRS.SiteID in (8454,8460,8465,8466,8470,8900) then 0
	when WD.FiscalYear = 2008 and WD.FiscalPeriod in (08,09,10,11) and DRS.SiteID = 8470 then 0
	when WD.FiscalYear = 2009 and WD.FiscalPeriod in (05,06,07,08,09,10,11) and DRS.SiteID = 9820 then 0
	when WD.FiscalYear = 2008 and WD.FiscalPeriod in (02,03,04,05) and DRS.SiteID = 8455 then 0
	when WD.FiscalYear = 2009 and WD.FiscalPeriod in (11,12) and DRS.SiteID = 8455 then 0
	when WD.FiscalYear = 2010 and WD.FiscalPeriod in (01,02,03,04,11) and DRS.SiteID = 8455 then 0
	when WD.FiscalYear = 2008 and WD.FiscalPeriod = 02 and DRS.SiteID in (8900,8460,8420,8470) then 0
	when WD.FiscalYear = 2008 and WD.FiscalPeriod = 01 and DRS.SiteID in (9800,8420,8455,8460,8470) then 0
	else Sum(SD.SowDays) end as 'SowDays',
	Case When WD.FiscalPeriod < 10 
	Then Rtrim(Cast(WD.FiscalYear as char))+'0'+Rtrim(Cast(WD.FiscalPeriod as char)) 
	else Rtrim(Cast(WD.FiscalYear as char))+Rtrim(Cast(WD.FiscalPeriod as char)) end As GroupPeriod

	FROM  dbo.cft_SOW_SOWDAYS_GOODPIGS SD

	left join 
	(Select Distinct ContactName2 as ContactName, ContactID, SiteID, Division, Region
	from  dbo.cfv_SOW_DIVISION_REGION_SITE) DRS
	on SD.ContactID = DRS.ContactID

	left join [$(SolomonApp)].dbo.cftWeekDefinition WD
	on SD.WeekOfDate = WD.WeekOfDate

	Where Case When WD.FiscalPeriod < 10 
	Then Rtrim(Cast(WD.FiscalYear as char))+'0'+Rtrim(Cast(WD.FiscalPeriod as char)) 
	else Rtrim(Cast(WD.FiscalYear as char))+Rtrim(Cast(WD.FiscalPeriod as char)) end between @StartPeriod and @EndPeriod

	Group by 
	DRS.SiteID,
	DRS.Region,
	DRS.Division,
	WD.FiscalYear, 
	WD.FiscalPeriod) Sow

	cross join 
	(Select 
	Count(DD.DayDate) Days
	from [$(SolomonApp)].dbo.cftDayDefinition DD
	left join [$(SolomonApp)].dbo.cftWeekDefinition WD
	on DD.WeekOfDate = WD.WeekOfDate
	
	Where Case When WD.FiscalPeriod < 10 
	Then Rtrim(Cast(WD.FiscalYear as char))+'0'+Rtrim(Cast(WD.FiscalPeriod as char)) 
	else Rtrim(Cast(WD.FiscalYear as char))+Rtrim(Cast(WD.FiscalPeriod as char)) end between @StartPeriod and @EndPeriod) PD

	Group by 
	Sow.SiteID,
	PD.Days) Sow
	on Sow.SiteID = DRS.SiteID

	cross join
	(Select 
	Count(WeekOfDate) Weeks
	from [$(SolomonApp)].dbo.cftWeekDefinition
	Where Case When FiscalPeriod < 10 
	Then Rtrim(Cast(FiscalYear as char))+'0'+Rtrim(Cast(FiscalPeriod as char)) 
	else Rtrim(Cast(FiscalYear as char))+Rtrim(Cast(FiscalPeriod as char)) end between @StartPeriod and @EndPeriod) WK

	left join 
	(Select 
	Sow.Region,
	Sum(Sow.SowDays)/PD.Days as Sows

	FROM @Sow Sow

	cross join 
	(Select 
	Count(DD.DayDate) Days
	from [$(SolomonApp)].dbo.cftDayDefinition DD
	left join [$(SolomonApp)].dbo.cftWeekDefinition WD
	on DD.WeekOfDate = WD.WeekOfDate
	
	Where Case When WD.FiscalPeriod < 10 
	Then Rtrim(Cast(WD.FiscalYear as char))+'0'+Rtrim(Cast(WD.FiscalPeriod as char)) 
	else Rtrim(Cast(WD.FiscalYear as char))+Rtrim(Cast(WD.FiscalPeriod as char)) end between @StartPeriod and @EndPeriod) PD

	Group by 
	Sow.Region,
	PD.Days) RegSow
	on RegSow.Region = DRS.Region 

	left join
	(Select 
	Sow.Division,
	Sum(Sow.SowDays)/PD.Days as Sows

	FROM @Sow Sow

	cross join 
	(Select 
	Count(DD.DayDate) Days
	from [$(SolomonApp)].dbo.cftDayDefinition DD
	left join [$(SolomonApp)].dbo.cftWeekDefinition WD
	on DD.WeekOfDate = WD.WeekOfDate
	
	Where Case When WD.FiscalPeriod < 10 
	Then Rtrim(Cast(WD.FiscalYear as char))+'0'+Rtrim(Cast(WD.FiscalPeriod as char)) 
	else Rtrim(Cast(WD.FiscalYear as char))+Rtrim(Cast(WD.FiscalPeriod as char)) end between @StartPeriod and @EndPeriod) PD

	Group by 
	Sow.Division,
	PD.Days) DivSow
	on DivSow.Division = DRS.Division
	
	cross join
	(Select 
	Sum(Sow.SowDays)/PD.Days as Sows

	FROM @Sow Sow

	cross join 
	(Select 
	Count(DD.DayDate) Days
	from [$(SolomonApp)].dbo.cftDayDefinition DD
	left join [$(SolomonApp)].dbo.cftWeekDefinition WD
	on DD.WeekOfDate = WD.WeekOfDate
	
	Where Case When WD.FiscalPeriod < 10 
	Then Rtrim(Cast(WD.FiscalYear as char))+'0'+Rtrim(Cast(WD.FiscalPeriod as char)) 
	else Rtrim(Cast(WD.FiscalYear as char))+Rtrim(Cast(WD.FiscalPeriod as char)) end between @StartPeriod and @EndPeriod) PD

	Group by 
	PD.Days) SysSow

	Where PL.Descr in ('LP','Natural Gas','Electric') 
	and PL.GroupPeriod between @StartPeriod and @EndPeriod
	and PL.Descr = @Descr
	and DRS.Region like @TempRegion
	and DRS.SiteID like @TempSiteID

	GROUP BY 
	DRS.ContactName,
	DRS.SiteID,
	DRS.Region, 
	DRS.Division,
	PL.Descr,
	PL.TranDesc,
	Sow.Sows,
	WK.Weeks,
	RegSow.Sows,
	DivSow.Sows,
	SysSow.Sows

	ORDER BY 
	DRS.Contactname
	
END


