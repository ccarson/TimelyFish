

-- =============================================
-- Author:		Mike Zimanski
-- Create date: 12/14/2010
-- Description:	Returns Sow P&L
-- =============================================
CREATE PROCEDURE [dbo].[cfp_SOW_PL_remove]
(
	
	 @EndPeriod			int
	,@Division			varchar(20)
	,@Region			varchar(20)
	,@SiteID			int
	,@AccountRollupID	int

   
)
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @TempDivision varchar(20)

	IF @Division = '%' 

	BEGIN
		SET @TempDivision = '%'
	END
	
	ELSE
	BEGIN
		SET @TempDivision = @Division
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
	
	DECLARE @TempAccountRollupID varchar(20)

	IF @AccountRollupID = -1

	BEGIN
		SET @TempAccountRollupID = '%'
	END
	
	ELSE
	BEGIN
		SET @TempAccountRollupID = @AccountRollupID
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
	when WD.FiscalYear = 2010 and WD.FiscalPeriod in (01,02,03,04,11,12) and DRS.SiteID = 8455 then 0
	when WD.FiscalYear = 2011 and WD.FiscalPeriod in (01,02,03,04) and DRS.SiteID = 8455 then 0
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
	else Rtrim(Cast(WD.FiscalYear as char))+Rtrim(Cast(WD.FiscalPeriod as char)) end = @EndPeriod

	Group by 
	DRS.SiteID,
	DRS.Region,
	DRS.Division,
	WD.FiscalYear, 
	WD.FiscalPeriod
	
	Declare @GP Table
	
	(SiteID int,
	Region varchar (50),
	Division varchar (50),
	GoodPigs int,
	GroupPeriod Float)
	
	Insert into @GP
	
	Select 
	
	DRS.SiteID,
	DRS.Region,
	DRS.Division,
	Case when WD.FiscalYear = 2008 and WD.FiscalPeriod in (03,04,05,06,07) and DRS.SiteID in (8454,8460,8465,8466,8470,8900) then 0
	when WD.FiscalYear = 2008 and WD.FiscalPeriod in (08,09,10,11) and DRS.SiteID = 8470 then 0
	when WD.FiscalYear = 2009 and WD.FiscalPeriod in (05,06,07,08,09,10,11) and DRS.SiteID = 9820 then 0
	when WD.FiscalYear = 2008 and WD.FiscalPeriod in (02,03,04,05) and DRS.SiteID = 8455 then 0
	when WD.FiscalYear = 2009 and WD.FiscalPeriod in (11,12) and DRS.SiteID = 8455 then 0
	when WD.FiscalYear = 2010 and WD.FiscalPeriod in (01,02,03,04,11,12) and DRS.SiteID = 8455 then 0
	when WD.FiscalYear = 2011 and WD.FiscalPeriod in (01,02,03,04) and DRS.SiteID = 8455 then 0
	when WD.FiscalYear = 2008 and WD.FiscalPeriod = 02 and DRS.SiteID in (8900,8460,8420,8470) then 0
	when WD.FiscalYear = 2008 and WD.FiscalPeriod = 01 and DRS.SiteID in (9800,8420,8455,8460,8470) then 0
	else Sum(WP.GoodPigs) end as 'GoodPigs',
	Case When WD.FiscalPeriod < 10 
	Then Rtrim(Cast(WD.FiscalYear as char))+'0'+Rtrim(Cast(WD.FiscalPeriod as char)) 
	else Rtrim(Cast(WD.FiscalYear as char))+Rtrim(Cast(WD.FiscalPeriod as char)) end As GroupPeriod

	From  dbo.cft_SOW_SOWDAYS_GOODPIGS WP

	left join 
	(Select Distinct ContactName2 as ContactName, ContactID, SiteID, Division, Region
	from  dbo.cfv_SOW_DIVISION_REGION_SITE) DRS
	on WP.ContactID = DRS.ContactID

	left join [$(SolomonApp)].dbo.cftWeekDefinition WD
	on WP.WeekOfDate = WD.WeekOfDate

	Where Case When WD.FiscalPeriod < 10 
	Then Rtrim(Cast(WD.FiscalYear as char))+'0'+Rtrim(Cast(WD.FiscalPeriod as char)) 
	else Rtrim(Cast(WD.FiscalYear as char))+Rtrim(Cast(WD.FiscalPeriod as char)) end = @EndPeriod

	Group by 
	DRS.SiteID,
	DRS.Region,
	DRS.Division,
	DRS.SiteID,
	WD.FiscalYear, 
	WD.FiscalPeriod

	Select 
	
	DRS.ContactName,
	DRS.SiteID,
	DRS.Division,
	DRS.Region,
	PL.GroupPeriod,
	Case when PL.AccountRollup is null then 'Other' else PL.AccountRollup end as AccountRollup,
	Case when PL.AccountRollupID is null then 0 else PL.AccountRollupID end as AccountRollupID,
	PL.Descr,
	PL.TranDesc,
	Sum(PL.Amt) Amt,
	Sum(PL.Qty*1.00) Qty,
	Sow.Sows,
	GP.GoodPigs,
	Case when Sow.Sows=0 then 0
	else ((Sum(PL.Amt)/Sow.Sows)/WK.Weeks)*52 end as AmtSow,
	Case when Sow.Sows=0 then 0
	else ((Sum(PL.Qty*1.00)/(Sow.Sows*1.0))/WK.Weeks)*52 end as QtySow,
	Case when GP.GoodPigs=0 then 0
	else Sum(PL.Amt)/GP.GoodPigs end as AmtGP,
	Case when GP.GoodPigs=0 then 0
	else Sum(PL.Qty*1.00)/(GP.GoodPigs*1.0) end as QtyGP,
	RegSow.Sows as RegSow,
	RegGP.GoodPigs as RegGP,
	Case when RegSow.Sows=0 then 0
	else ((Sum(PL.Amt)/RegSow.Sows)/WK.Weeks)*52 end as RegAmtSow,
	Case when RegSow.Sows=0 then 0
	else ((Sum(PL.Qty*1.00)/(RegSow.Sows*1.0))/WK.Weeks)*52 end as RegQtySow,
	Case when RegGP.GoodPigs=0 then 0
	else Sum(PL.Amt)/RegGP.GoodPigs end as RegAmtGP,
	Case when RegGP.GoodPigs=0 then 0
	else Sum(PL.Qty*1.00)/(RegGP.GoodPigs*1.0) end as RegQtyGP,
	DivSow.Sows as DivSow,
	DivGP.GoodPigs as DivGP,
	Case when DivSow.Sows=0 then 0
	else ((Sum(PL.Amt)/DivSow.Sows)/WK.Weeks)*52 end as DivAmtSow,
	Case when DivSow.Sows=0 then 0
	else ((Sum(PL.Qty*1.00)/(DivSow.Sows*1.0))/WK.Weeks)*52 end as DivQtySow,
	Case when DivGP.GoodPigs=0 then 0
	else Sum(PL.Amt)/DivGP.GoodPigs end as DivAmtGP,
	Case when DivGP.GoodPigs=0 then 0
	else Sum(PL.Qty*1.00)/(DivGP.GoodPigs*1.0) end as DivQtyGP
	From  dbo.cft_SOW_PL PL

	left join 
	(Select Distinct ContactName2 as ContactName, SiteID, Division, Region
	from  dbo.cfv_SOW_DIVISION_REGION_SITE) DRS
	on DRS.SiteID = right(rtrim(PL.Sub),4)

	left join 
	(Select 
	Sow.SiteID,
	Sum(Sow.SowDays)/PD.Days as Sows,
	Sow.GroupPeriod

	FROM @Sow Sow

	left join 
	(Select 
	Count(DD.DayDate) Days,
	Case When WD.FiscalPeriod < 10 
	Then Rtrim(Cast(WD.FiscalYear as char))+'0'+Rtrim(Cast(WD.FiscalPeriod as char)) 
	else Rtrim(Cast(WD.FiscalYear as char))+Rtrim(Cast(WD.FiscalPeriod as char)) end as GroupPeriod
	from [$(SolomonApp)].dbo.cftDayDefinition DD
	left join [$(SolomonApp)].dbo.cftWeekDefinition WD
	on DD.WeekOfDate = WD.WeekOfDate
	
	Group by
	WD.FiscalYear,
	WD.FiscalPeriod) PD
	on PD.GroupPeriod = Sow.GroupPeriod

	Group by 
	Sow.SiteID,
	PD.Days,
	Sow.GroupPeriod) Sow
	on Sow.SiteID = DRS.SiteID
	and Sow.GroupPeriod = PL.GroupPeriod

	left join
	(Select
	GP.SiteID,
	Sum(GP.GoodPigs) as 'GoodPigs',
	GP.GroupPeriod
	
	From @GP GP

	Group by 
	GP.SiteID, 
	GP.GroupPeriod) GP
	on GP.SiteID = DRS.SiteID
	and GP.GroupPeriod = PL.GroupPeriod

	left join
	(Select 
	Count(WeekOfDate) Weeks,
	Case When FiscalPeriod < 10 
	Then Rtrim(Cast(FiscalYear as char))+'0'+Rtrim(Cast(FiscalPeriod as char)) 
	else Rtrim(Cast(FiscalYear as char))+Rtrim(Cast(FiscalPeriod as char)) end As GroupPeriod
	from [$(SolomonApp)].dbo.cftWeekDefinition 
	Group by
	FiscalYear,
	FiscalPeriod) WK
	on WK.GroupPeriod = PL.GroupPeriod

	left join 
	(Select 
	Sow.Region,
	Sum(Sow.SowDays)/PD.Days as Sows,
	Sow.GroupPeriod

	FROM @Sow Sow

	left join 
	(Select 
	Count(DD.DayDate) Days,
	Case When WD.FiscalPeriod < 10 
	Then Rtrim(Cast(WD.FiscalYear as char))+'0'+Rtrim(Cast(WD.FiscalPeriod as char)) 
	else Rtrim(Cast(WD.FiscalYear as char))+Rtrim(Cast(WD.FiscalPeriod as char)) end as GroupPeriod
	from [$(SolomonApp)].dbo.cftDayDefinition DD
	left join [$(SolomonApp)].dbo.cftWeekDefinition WD
	on DD.WeekOfDate = WD.WeekOfDate
	
	Group by
	WD.FiscalYear,
	WD.FiscalPeriod) PD
	on PD.GroupPeriod = Sow.GroupPeriod

	Group by 
	Sow.Region,
	PD.Days,
	Sow.GroupPeriod) RegSow
	on RegSow.GroupPeriod = PL.GroupPeriod
	and RegSow.Region = DRS.Region 

	left join
	(Select
	GP.Region,
	Sum(GP.GoodPigs) as 'GoodPigs',
	GP.GroupPeriod
	
	From @GP GP

	Group by 
	GP.Region, 
	GP.GroupPeriod) RegGP
	on RegGP.GroupPeriod = PL.GroupPeriod
	and RegGP.Region = DRS.Region

	left join
	(Select 
	Sow.Division,
	Sum(Sow.SowDays)/PD.Days as Sows,
	Sow.GroupPeriod

	FROM @Sow Sow

	left join 
	(Select 
	Count(DD.DayDate) Days,
	Case When WD.FiscalPeriod < 10 
	Then Rtrim(Cast(WD.FiscalYear as char))+'0'+Rtrim(Cast(WD.FiscalPeriod as char)) 
	else Rtrim(Cast(WD.FiscalYear as char))+Rtrim(Cast(WD.FiscalPeriod as char)) end as GroupPeriod
	from [$(SolomonApp)].dbo.cftDayDefinition DD
	left join [$(SolomonApp)].dbo.cftWeekDefinition WD
	on DD.WeekOfDate = WD.WeekOfDate
	
	Group by
	WD.FiscalYear,
	WD.FiscalPeriod) PD
	on PD.GroupPeriod = Sow.GroupPeriod

	Group by 
	Sow.Division,
	PD.Days,
	Sow.GroupPeriod) DivSow
	on DivSow.GroupPeriod = PL.GroupPeriod
	and DivSow.Division = DRS.Division

	left join
	(Select
	GP.Division,
	Sum(GP.GoodPigs) as 'GoodPigs',
	GP.GroupPeriod
	
	From @GP GP

	Group by 
	GP.Division, 
	GP.GroupPeriod) DivGP
	on DivGP.GroupPeriod = PL.GroupPeriod
	and DivGP.Division = DRS.Division
	
	Where PL.GroupPeriod = @EndPeriod
	and DRS.Division like @TempDivision
	and DRS.Region like @TempRegion
	and DRS.SiteID like @TempSiteID
	and (PL.AccountRollupID is null or PL.AccountRollupID like @TempAccountRollupID)
	
	Group by
	DRS.ContactName,
	DRS.SiteID,
	DRS.Division,
	DRS.Region,
	PL.GroupPeriod,
	PL.AccountRollup,
	PL.AccountRollupID,
	PL.Descr,
	PL.TranDesc,
	Sow.Sows,
	GP.GoodPigs,
	WK.Weeks,
	RegSow.Sows,
	RegGP.GoodPigs,
	DivSow.Sows,
	DivGP.GoodPigs
	
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SOW_PL_remove] TO [db_sp_exec]
    AS [dbo];

