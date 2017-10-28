


-- =============================================
-- Author:	Matt Dawson
-- Create date:	1/4/2008
-- Description:	Service Manager Transportation Schedule
-- Parameters: 	@StartDate, 
--		@EndDate,
--		@ContactID,
--		@UserName, (@ContactID's username)
--		@PMTypeID, (specifies all(00), internal(01), or market(02)
--		@PMSystemID (specifies all(00), multiplication(01), or commericialHH(02); 
--				commercialHH has consolidated data values for IA and SE 02&03
--		NOTE: @PMSystemID is only pertinent when @PMTypeID of internal(01) is selected
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_TRANSPORTATION_SVCMANAGER_SCHEDULE_old] 
@StartDate DATETIME,
@EndDate DATETIME,
@ContactID INT,
@UserName VARCHAR(10),
@PMTypeString VARCHAR(2),
@PMSystemString VARCHAR(50),
@SendingReportChanges CHAR(1)
AS


IF @PMTypeString = '02' 
BEGIN 
	SET @PMSystemString = '%'
END 

DECLARE @UserName_wc VARCHAR(11)
SET @UserName_wc = RTRIM(@UserName) + '%'

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

DECLARE @SQLString NVARCHAR(4000)

CREATE TABLE #Schedule
(	MovementDate		smalldatetime
,	ID			int
,	Source			char(30)
,	SourceBarnNbr		char(10)
,	SourceRoomNbr		char(10)
,	LoadTime		varchar(20)--float
,	ArriveTime		varchar(20)--float
,	EstimatedQty		smallint
,	EstimatedWgt		char(7)
,	MarketType		char(30)
,	TrailerWashFlag	char(1)
,	Destination		char(30)
,	DestBarnNbr		char(10)
,	DestRoomNbr		char(10)
,	Trucker			char(30)
,	Trailer			char(30)
,	PICWeek			smallint
,	ScheduleStatus		char(30)
,	WeekOfDate		smalldatetime
,	Comment			char(100)
,	DisinfectFlg	char(1)
,	CpnyID			char(10)
,	LoadingTime		smalldatetime
,	ArrivalTime		smalldatetime
,	Highlight		int
,	ActualQty		smallint
,	ActualWgt		smallint
,	PFEU			smallint
,	SelectedContact		char(30)
,	PigType			char(30)
,	tattooflag		char(1)
,	GiltAge			char(10)
,	PMID			char(10)
,	PMLoadID		char(10))



SET @SQLString = 
N'INSERT INTO #Schedule
	Select distinct
	cftPM.MovementDate,
	cftPM.ID, 
	SourceContact.ShortName as Source, 
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
	cftPM.EstimatedQty,
	cftPM.EstimatedWgt,
	cftMarketSaleType.Description as MarketType,
	case when cftPM.TrailerWashFlag = 0
		then ''''
		else ''Y''
	end ''TrailerWashFlag'',
	DestContact.ShortName as Destination,
	cftPM.DestBarnNbr,
	cftPM.DestRoomNbr, 
	TruckerContact.ShortName as Trucker,
	cftPigTrailer.Description as Trailer, 
	cftWeekDefinition.PICWeek,'''
	+ RTRIM(@ScheduleStatus) + N''' as ScheduleStatus,
	cftPMWeekStatus.WeekOfDate,
	case when rtrim(cftPM.Comment)='''' 
		then Null 
		else cftPM.comment 
	end as Comment,
	cftPM.DisinfectFlg,
	cftPM.CpnyID,
	cftPM.LoadingTime,
	cftPM.ArrivalTime,
	cftPM.Highlight,
	cftPM.ActualQty, 
	cftPM.ActualWgt, 
	cftPM.PFEUEligible as PFEU,
	SelectedContact.ShortName as SelectedContact,
	Case when cftPM.PigTypeID<>''04'' 
		then cftPigType.PigTypeDesc 
		else cftMarketSaleType.Description 
	end as PigType,
	case when cftPM.tattooflag = 0
		then ''''
		else ''Y''
	end ''tattooflag'',
	cftPM.GiltAge,
	cftPM.PMID,
	cftPM.PMLoadID
from [$(SolomonApp)].dbo.cftPM cftPM (NOLOCK)
LEFT JOIN [$(SolomonApp)].dbo.cftContact SourceContact (NOLOCK) 
	on cftPM.SourceContactID = SourceContact.ContactID
LEFT JOIN [$(SolomonApp)].dbo.cftContact DestContact (NOLOCK) 
	on cftPM.DestContactID = DestContact.ContactID
LEFT JOIN [$(SolomonApp)].dbo.cftPigType cftPigType (NOLOCK) on cftPM.PigTypeID = cftPigType.PigTypeID
LEFT JOIN [$(SolomonApp)].dbo.cftMarketSaleType cftMarketSaleType (NOLOCK) 
	on cftPM.MarketSaleTypeID = cftMarketSaleType.MarketSaleTypeID
LEFT JOIN [$(SolomonApp)].dbo.cftContact TruckerContact (NOLOCK) 
	on cftPM.TruckerContactID = TruckerContact.ContactID
LEFT JOIN [$(SolomonApp)].dbo.cftContact SelectedContact (NOLOCK) on ' + cast(@ContactID as varchar) + N' = SelectedContact.ContactID
LEFT JOIN [$(SolomonApp)].dbo.cftPigTrailer cftPigTrailer (NOLOCK) 
	on cast(cftPM.PigTrailerID as int) = cast(cftPigTrailer.PigTrailerID as int)
LEFT JOIN [$(SolomonApp)].dbo.cftWeekDefinition cftWeekDefinition (NOLOCK) 
	on cftPM.MovementDate between cftWeekDefinition.WeekOfDate and cftWeekDefinition.WeekEndDate
LEFT JOIN [$(SolomonApp)].dbo.cftPMWeekStatus cftPMWeekStatus (NOLOCK) 
	on cftWeekDefinition.WeekOfDate = cftPMWeekStatus.WeekOfDate 
	and cftPMWeekStatus.PMTypeID = ''02''' --leave this cuz doyle said so
	+ N' and cftPMWeekStatus.PigSystemID = ''01'''--previously hardcoded
	+ N' and cftPMWeekStatus.CpnyID = ''CFF'''

+ N' WHERE cftPM.MovementDate between ''' + cast(@StartDate as varchar) + N''' and ''' + cast(@EndDate as varchar) + N''''

IF @PMTypeString = '02'
BEGIN
	SET @SQLString = @SQLString + N' and cftPM.PMSystemID like ''' + @PMSystemString + N''' and cftPM.PMTypeID = ''' + @PMTypeString + N''''
END
ELSE
BEGIN
	SET @SQLString = @SQLString + N' and cftPM.PMSystemID in (''' + @PMSystemString + N''') and cftPM.PMTypeID = ''' + @PMTypeString + N''''
END


SET @SQLString = @SQLString 
+ N' and (COALESCE([$(SolomonApp)].dbo.GetMarketSvcManager(cftPM.SourceContactID,''' + cast(@EndDate as varchar) + N''',''''),''NA'') like ''' + @UserName_wc + N''''
+ N' OR COALESCE([$(SolomonApp)].dbo.GetSvcManager(cftPM.SourceContactID,''' + cast(@EndDate as varchar) + N''',''''),''NA'') like ''' + @UserName_wc + N''''
+ N' or COALESCE([$(SolomonApp)].dbo.GetMarketSvcManager(cftPM.DestContactID,''' + cast(@EndDate as varchar) + N''',''''),''NA'') like ''' + @UserName_wc + N''''
+ N' or COALESCE([$(SolomonApp)].dbo.GetSvcManager(cftPM.DestContactID,''' + cast(@EndDate as varchar) + N''',''''),''NA'') like ''' + @UserName_wc + N''''
+ N' or cftPM.Crtd_User like ''' + cast(@UserName as nvarchar) + N''')'
+ N' and cftPM.Highlight <> 255 and cftPM.Highlight <> -65536'
+ N' ORDER BY
	cftPM.MovementDate,
	cftPM.LoadingTime,
	SourceContact.ShortName'

print @SQLString
exec sp_executesql @SQLString

SELECT
	MovementDate
,	ID
,	Source
,	SourceBarnNbr
,	SourceRoomNbr
,	LoadTime
,	ArriveTime
,	EstimatedQty
,	EstimatedWgt
,	MarketType
,	TrailerWashFlag
,	Destination
,	DestBarnNbr
,	DestRoomNbr
,	Trucker
,	Trailer
,	PICWeek
,	ScheduleStatus
,	WeekOfDate
,	Comment
,	DisinfectFlg
,	CpnyID
,	LoadingTime
,	ArrivalTime
,	Highlight
,	ActualQty
,	ActualWgt
,	PFEU
,	SelectedContact
,	PigType
,	tattooflag
,	GiltAge
,	PMID
,	PMLoadID
FROM #Schedule

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
    ON OBJECT::[dbo].[cfp_REPORT_TRANSPORTATION_SVCMANAGER_SCHEDULE_old] TO [db_sp_exec]
    AS [dbo];

