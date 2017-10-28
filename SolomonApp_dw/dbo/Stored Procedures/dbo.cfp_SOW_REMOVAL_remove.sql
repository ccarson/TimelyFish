

-- =============================================
-- Author:		Mike Zimanski
-- Create date: 5/17/2012
-- Description:	Returns Removal Percent by Removal Type and Std Deviation
-- =============================================
CREATE PROCEDURE [dbo].[cfp_SOW_REMOVAL_remove]
(
	
	 @StFYPeriod		char(7),
	 @EnFYPeriod		char(7)

   
)
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	Declare @RP Table
	(FiscalPeriod smallint
	,FiscalYear smallint
	,ContactName char(50)
	,RemovalType varchar(20)
	,Removal int
	,SowDays int
	,RemovalPercent decimal(10,2))
	
	Insert Into @RP

	Select 
	sr.FiscalPeriod,
	sr.FiscalYear,
	sr.ContactName,
	sr.RemovalType,
	sr.Removal,
	sow.SowDays,
	Cast(((Cast(sr.Removal as decimal(10,2))/Cast(sow.SowDays as decimal (10,2)))*365)*100 as decimal (10,2)) as 'RemovalPercent'
	from (Select FiscalPeriod, FiscalYear, ContactID, ContactName, RemovalType, Sum(HeadCount) as 'Removal'
	from  dbo.cft_SOW_REMOVAL where ContactID not in ('002286','001455','002287')
	group by FiscalPeriod, FiscalYear, ContactID, ContactName, RemovalType) sr

	left join 

	(Select dw.FiscalPeriod, dw.FiscalYear, sd.ContactID, Sum(sd.SowDays) as 'SowDays'
	from (Select Distinct WeekOfDate, FiscalPeriod, FiscalYear 
	from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo) dw
	left join  dbo.cft_SOW_SOWDAYS_GOODPIGS sd
	on dw.WeekOfDate = sd.WeekOfDate
	where sd.ContactID is not null
	Group by dw.FiscalPeriod, dw.FiscalYear, sd.ContactID) sow

	on sr.FiscalPeriod = sow.FiscalPeriod
	and sr.FiscalYear = sow.FiscalYear
	and sr.ContactID = sow.ContactID 

	Order by
	sr.FiscalYear,
	sr.FiscalPeriod,
	sr.ContactName

	Select 
	RIGHT(ss.FiscalYear, 2) + 'Per' + REPLICATE('0', 2 - LEN(RTRIM(CONVERT(char(2), RTRIM(ss.FiscalPeriod))))) + RTRIM(CONVERT(char(2), RTRIM(ss.FiscalPeriod))) as 'FYPeriod',
	sr.RemovalType,
	Cast(((Cast(sr.Removal as decimal(10,2))/Cast(ss.SowDays as decimal (10,2)))*365)*100 as decimal (10,2)) as 'RemovalPercent',
	Cast(((Cast(lr.Removal as decimal(10,2))/Cast(ls.SowDays as decimal (10,2)))*365)*100 as decimal (10,2)) as 'LYRemovalPercent',
	Cast(Cast(((Cast(sr.Removal as decimal(10,2))/Cast(ss.SowDays as decimal (10,2)))*365)*100 as decimal (10,2))+std.StdDev as decimal(10,2)) as 'Top',
	Cast(Cast(((Cast(sr.Removal as decimal(10,2))/Cast(ss.SowDays as decimal (10,2)))*365)*100 as decimal (10,2))-std.StdDev as decimal(10,2)) as 'Bottom'
	
	from (

	Select dw.FiscalPeriod, dw.FiscalYear, Sum(sd.SowDays) as 'SowDays'
	from (Select Distinct WeekOfDate, FiscalPeriod, FiscalYear 
	from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo) dw
	left join  dbo.cft_SOW_SOWDAYS_GOODPIGS sd
	on dw.WeekOfDate = sd.WeekOfDate
	where sd.ContactID is not null
	and sd.ContactID not in ('002286','001455','002287')
	Group by dw.FiscalPeriod, dw.FiscalYear) ss
	
	left join 
	
	(Select dw.FiscalPeriod, dw.FiscalYear+1 as 'FiscalYear', Sum(sd.SowDays) as 'SowDays'
	from (Select Distinct WeekOfDate, FiscalPeriod, FiscalYear 
	from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo) dw
	left join  dbo.cft_SOW_SOWDAYS_GOODPIGS sd
	on dw.WeekOfDate = sd.WeekOfDate
	where sd.ContactID is not null
	and sd.ContactID not in ('002286','001455','002287')
	Group by dw.FiscalPeriod, dw.FiscalYear) ls
	on ss.FiscalYear = ls.FiscalYear
	and ss.FiscalPeriod = ls.FiscalPeriod 
	
	left join 

	(Select FiscalPeriod, FiscalYear, RemovalType, Sum(HeadCount) as 'Removal'
	from  dbo.cft_SOW_REMOVAL where ContactID not in ('002286','001455','002287')
	group by FiscalPeriod, FiscalYear, RemovalType) sr
	on ss.FiscalYear = sr.FiscalYear
	and ss.FiscalPeriod = sr.FiscalPeriod
	
	left join 

	(Select FiscalPeriod, FiscalYear+1 as 'FiscalYear', RemovalType, Sum(HeadCount) as 'Removal'
	from  dbo.cft_SOW_REMOVAL where ContactID not in ('002286','001455','002287')
	group by FiscalPeriod, FiscalYear, RemovalType) lr
	on ss.FiscalYear = lr.FiscalYear
	and ss.FiscalPeriod = lr.FiscalPeriod
	and sr.RemovalType = lr.RemovalType
	
	left join (
	
	Select 
	FiscalYear,
	FiscalPeriod,
	RemovalType,
	Cast(STDEV(RemovalPercent) as decimal(10,2)) as 'StdDev'
	from @RP
	Group by
	FiscalYear,
	FiscalPeriod,
	RemovalType) std
	on ss.FiscalYear = std.FiscalYear
	and ss.FiscalPeriod = std.FiscalPeriod
	and sr.RemovalType = std.RemovalType
	
	Where RIGHT(ss.FiscalYear, 2) + 'Per' + REPLICATE('0', 2 - LEN(RTRIM(CONVERT(char(2), RTRIM(ss.FiscalPeriod))))) + RTRIM(CONVERT(char(2), RTRIM(ss.FiscalPeriod))) between @StFYPeriod and @EnFYPeriod
	
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SOW_REMOVAL_remove] TO [db_sp_exec]
    AS [dbo];

