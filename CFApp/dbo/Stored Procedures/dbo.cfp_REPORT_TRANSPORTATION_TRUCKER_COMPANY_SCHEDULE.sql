


-- =============================================
-- Author:	Doran Dahle
-- Create date:	10/17/2015
-- Description:	Trucking Company Transportation Schedule
-- Parameters: 	@StartDate, 
--		@EndDate,
--		@ContactID,
--		@PMTypeID, (specifies all(00), internal(01), or market(02)
--		@PMSystemID (specifies all(00), multiplication(01), or commericialHH(02); 
--				commercialHH has consolidated data values for IA and SE 02&03
--		NOTE: @PMSystemID is only pertinent when @PMTypeID of internal(01) is selected
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_TRANSPORTATION_TRUCKER_COMPANY_SCHEDULE] 
@StartDate DATETIME,
@EndDate DATETIME,
@ContactID INT,
@PMTypeString VARCHAR(2),
@PMSystemString VARCHAR(50),
@SendingReportChanges CHAR(1)


AS

IF @PMTypeString = '02'
BEGIN 
	SET @PMSystemString = '%'
END 

declare @ScheduleStatus varchar(50)
create table #Status
(	StatusID int
,	StatusDesc varchar(50))

declare @SundayDate datetime
set @SundayDate = dbo.getSundayDate(@StartDate)
insert into #Status
exec cfp_MARKET_SCHEDULE_CURRENT_STATUS_SELECT_BY_TYPE_AND_DATE @PMTypeString, @SundayDate

set @ScheduleStatus = (select RTRIM(StatusDesc) from #Status)
drop table #Status

CREATE TABLE #temp_xofy
(	truckercontactid	char(10)
,	sourcecontactid	int
,	pmloadid	char(10)
,	LoadingTime		datetime
,	MovementDate	datetime
,	rownbr	smallint
)

insert into #temp_xofy
 select pm.TruckerContactID, pm.SourceContactID		
 , pm.PMLoadID,pm.LoadingTime, pm.MovementDate
 , ROW_NUMBER() OVER (partition by pm.SourceContactID, pm.MovementDate ORDER BY pm.MovementDate, pm.SourceContactID, pm.LoadingTime) AS 'RowNumber' 
 from 
    (SELECT distinct TruckerContactID, SourceContactID, loadingtime, MovementDate, PMLoadID	
    FROM [$(SolomonApp)].dbo.cftPM (nolock)
    where 1=1 
	and MovementDate between @StartDate and @EndDate
	and SuppressFlg = 0
	and Highlight <> 255
	and Highlight <> -65536
	) pm
order by pm.MovementDate, pm.sourcecontactid,pm.LoadingTime, pm.PMLoadID

DECLARE @SQLString NVARCHAR(4000),@SQLString2 NVARCHAR(4000),@SQLString3 NVARCHAR(MAX)

CREATE TABLE #Schedule
(	MovementDate		smalldatetime
,	ID			int
,	Source			char(30)
,	contactid	int
,	SourcePhoneNbr		varchar(10)
,	SourceBarnNbr		char(10)
,	SourceRoomNbr		char(10)
,	LoadTime		varchar(20)--float
,	ArriveTime		varchar(20)--float
,	EstimatedQty		smallint
,	PigType			char(30)
,	Trucker			char(30)
,	TruckerContactID char(10)
,	CpnyID			char(10)
,	Destination		char(30)
,	destcontactid	char(10)
,	DestBarnNbr		char(10)
,	DestRoomNbr		char(10)
,	Trailer			char(30)
,	PICWeek			smallint
,	ScheduleStatus		char(30)
,	WeekOfDate		smalldatetime
,	Comment			char(100)
,	tattooflag		char(1)
,	TrailerWashFlag		char(1)
,	Rate			Decimal(10,2)
,	LoadingTime		smalldatetime
,	ArrivalTime		smalldatetime
,	PigGenderTypeID		char(6)
,	Highlight		int
,   TruckingCompanyName varchar(50)
,	PMID			char(10)
,	PMLoadID		char(10)
,	Miles decimal(10,6)
,	FuelRate decimal(10,3)
,	Stops decimal(5,2)
,	SourceComment	char(2000)
,	DestComment		char(2000))

SET @SQLString = 
N'INSERT INTO #Schedule
Select 
	cftPM.MovementDate,
	cftPM.ID, 
	SC.ShortName as Source, 
	SC.ContactID as contactid,
	[$(CentralData)].dbo.GetSMPhoneNbr_mkt(cftpm.sourcecontactid) as SourcePhoneNbr,
	cftPM.SourceBarnNbr, 
	cftPM.SourceRoomNbr,
	Case when LEN(RTRIM(cftPM.LoadingTime))>0 
		then SUBSTRING(CONVERT(CHAR(19),cftPM.LoadingTime,100),13,19) 
		else '''' 
	end  as LoadTime,
	Case when LEN(RTRIM(cftPM.ArrivalTime))>0 
		then SUBSTRING(CONVERT(CHAR(19),cftPM.ArrivalTime,100),13,19) 
		else '''' 
	end  as ArriveTime,
	EstimatedQty,
	Case when cftPM.PigTypeID<>''04'' 
		then PigT.PigTypeDesc 
		else MST.Description 
	end as PigType,
	LEFT(RTRIM(TC.ShortName),30) as DriverName,
	TC.ContactID,
	cftPM.CpnyID,
	DC.ShortName as Destination,
	cftPM.destcontactid,
	cftPM.DestBarnNbr,
	cftPM.DestRoomNbr, 
	cftPT.Description as Trailer, 
	cftWD.PICWeek,'''
	+ RTRIM(@ScheduleStatus) + N''' as ScheduleStatus,
	PMWS.WeekOfDate,
	case when rtrim(cftPM.Comment)='''' 
		then Null 
		else cftPM.comment 
	end as Comment,
	case when cftPM.tattooflag = 0
		then ''''
		else ''Y''
	end ''tattooflag'',
	case when cftPM.TrailerWashFlag = 0
		then ''''
		else ''Y''
	end ''TrailerWashFlag'',
	Rate = [$(SolomonApp)].dbo.getRate(cftPM.PMLoadID,cftPM.PMID,cftWD.WeekOfDate,cftPM.PigTypeID,cftPM.PMSystemID,cftPM.PigTrailerID,cftPM.TranSubTypeID),
	cftPM.LoadingTime,
	cftPM.ArrivalTime,
	cftPM.PigGenderTypeID,
	cftPM.highlight,
	StdC.ContactName as TruckingCompanyName,
	cftPM.PMID,
	cftPM.PMLoadID,

	Miles = [$(SolomonApp)].dbo.getRateMiles(cftPM.PMLoadID,cftPM.PMID),
	FuelRate = [$(SolomonApp)].dbo.getRateFuelSurcharge(cftPM.PMLoadID,cftPM.PMID,cftWD.WeekOfDate), 
	Stops = [$(SolomonApp)].dbo.getStopsPay(cftPM.PMLoadID,cftPM.PMID),
	case when rtrim(scc.Comments)='''' 
		then Null 
		else scc.Comments 
	end as SourceComments,
	case when rtrim(dcc.Comments)='''' 
		then Null 
		else dcc.Comments 
	end as DestComments
from [$(SolomonApp)].dbo.cftPM cftPM (NOLOCK)
LEFT JOIN [$(SolomonApp)].dbo.cftContact SC (NOLOCK) on cftPM.SourceContactID = SC.ContactID
LEFT JOIN [$(SolomonApp)].dbo.cftContact DC (NOLOCK) on cftPM.DestContactID = DC.ContactID
LEFT JOIN [$(SolomonApp)].dbo.cftContact TC (NOLOCK) on cftPM.TruckerContactID = TC.ContactID
LEFT JOIN [$(SolomonApp)].dbo.cftContact StdC (NOLOCK) on ' + cast(@ContactID as varchar) + N' = StdC.ContactID
LEFT JOIN [$(SolomonApp)].dbo.cftPigType PigT (NOLOCK) on cftPM.PigTypeID = PigT.PigTypeID
LEFT JOIN [$(SolomonApp)].dbo.cftPigTrailer cftPT (NOLOCK) on cast(cftPM.PigTrailerID as int) = cast(cftPT.PigTrailerID as int)
LEFT JOIN [$(SolomonApp)].dbo.cftPacker cftPacker (NOLOCK) on cftPM.DestContactID = cftPacker.ContactID
LEFT JOIN [$(SolomonApp)].dbo.cftMarketSaleType MST (NOLOCK) on cftPM.MarketSaleTypeID = MST.MarketSaleTypeID
LEFT JOIN [$(CentralData)].dbo.cfv_ContactComments scc (NOLOCK) ON cast(cftPM.SourceContactID as int) = scc.ContactID 
LEFT JOIN [$(CentralData)].dbo.cfv_ContactComments dcc (NOLOCK) ON cast(cftPM.DestContactID as int) = dcc.ContactID
LEFT JOIN [$(SolomonApp)].dbo.cftWeekDefinition cftWD (NOLOCK) on cftPM.MovementDate between cftWD.WeekOfDate and cftWD.WeekEndDate
LEFT JOIN [$(SolomonApp)].dbo.cftPMWeekStatus PMWS (NOLOCK) on cftWD.WeekOfDate = PMWS.WeekOfDate 
	and PMWS.PMTypeID = ''02'' 
	and PMWS.PigSystemID = ''01'' 
	and PMWS.CpnyID=''CFF''
left join (select s.contactid, c.contactname		
	from [$(SolomonApp)].dbo.cftSite s (nolock)
	inner join [$(CentralData)].dbo.Contact c (nolock) on c.contactid = s.contactid
	where s.pigsystemid = ''01'') mulip on mulip.contactid = cftPM.destcontactid'

SET @SQLString2 = 
 N' WHERE cftPM.MovementDate between ''' + CAST(@StartDate AS VARCHAR) + ''' and ''' + CAST(@EndDate AS VARCHAR) + N''''


IF @PMTypeString = '02'
BEGIN
	SET @SQLString2 = @SQLString2 + N' and cftPM.PMSystemID like ''' + @PMSystemString + N''' and cftPM.PMTypeID = ''' + @PMTypeString + N''''
END
ELSE
BEGIN
	SET @SQLString2 = @SQLString2 + N' and cftPM.PMSystemID in (''' + @PMSystemString + N''') and cftPM.PMTypeID = ''' + @PMTypeString + N''''
END

SET @SQLString2 = @SQLString2 
+	N' and (cast(cftPM.TruckerContactID as int) in (select DriverContactID From [$(CentralData)].dbo.cfv_DriverCompany dcpy (NOLOCK) WHERE dcpy.TruckingCompanyContactID = ' + CAST(@ContactID AS VARCHAR)+ N')
	OR cast(cftPM.TruckerContactID as int) = ' + CAST(@ContactID AS VARCHAR)+ N')
	and cftPM.SuppressFlg = 0
	and cftPM.Highlight <> 255
	and cftPM.Highlight <> -65536'

SET @SQLString3 = CAST(@SQLString AS NVARCHAR(MAX)) + CAST(@SQLString2 AS NVARCHAR(MAX))
print LEN(@SQLString3)
print @SQLString3

exec sp_executesql @SQLString3

SELECT
	SH.MovementDate		
,	ID			
,	Source	
,	contactid
,	que_of_tot
,	SUBSTRING(sourcephonenbr,1,3)+'-'+SUBSTRING(sourcephonenbr,4,3)+'-'+SUBSTRING(sourcephonenbr,7,4)	as SourcePhoneNbr	
,	SourceBarnNbr		
,	SourceRoomNbr		
,	LoadTime		
,	ArriveTime		
,	EstimatedQty		
,	PigType			
,	Trucker		
,	SH.TruckerContactID	
,	CpnyID			
,	Destination
,	SH.destcontactid
,	DestBarnNbr		
,	DestRoomNbr		
,	Trailer			
,	PICWeek			
,	ScheduleStatus		
,	WeekOfDate		
,	Comment			
,	tattooflag		
,	TrailerWashFlag		
,	Rate			
,	SH.LoadingTime		
,	ArrivalTime		
,	PigGenderTypeID		
,	Highlight		
,	TruckingCompanyName	
,	sh.PMID			
,	sh.PMLoadID
,	Miles
,	FuelRate
,	Stops
,	SourceComment
,	DestComment
FROM #Schedule SH (nolock)
inner join 
	(select xofy.truckercontactid, cast(xofy.rownbr - maxx.strt as varchar)+' of '+ CAST(maxx.totloads as varchar) que_of_tot
	, xofy.MovementDate, xofy.sourcecontactid, xofy.loadingtime, xofy.pmloadid	
	 from #temp_xofy xofy (nolock)
		inner join 
		(select movementdate,sourcecontactid, min(x.rownbr) strt, (max(rownbr) - min(rownbr)) Totloads
		from #temp_xofy x (nolock)
		group by movementdate,sourcecontactid) maxx
			on maxx.sourcecontactid = xofy.sourcecontactid
			and maxx.MovementDate = xofy.MovementDate) XY 
		--where xofy.truckercontactid = SH.truckercontactid) XY 
	on XY.LoadingTime = SH.LoadingTime 
	and XY.movementdate = SH.MovementDate
	and XY.sourcecontactid = SH.contactid
	and XY.pmloadid = SH.PMLoadID
	and XY.truckercontactid = SH.TruckerContactID
ORDER BY SH.MovementDate, SH.LoadingTime
	

drop table #temp_xofy

IF (@SendingReportChanges = 'Y')
BEGIN
	UPDATE cft_PM_History
	SET SentChanges = 1
	FROM dbo.cft_PM_History cft_PM_History
	INNER JOIN #Schedule Schedule
		ON Schedule.PMID = cft_PM_History.PMID
		AND Schedule.PMLoadID = cft_PM_History.PMLoadID
END




GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_TRANSPORTATION_TRUCKER_COMPANY_SCHEDULE] TO [db_sp_exec]
    AS [dbo];

