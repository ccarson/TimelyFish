-- =============================================
-- Author:	Matt Dawson
-- Create date:	1/2/2008
/*
	2012/01/12  SMR:  user request for change
	1.  add disinfectflag
	2.  add trucker phone number
	3.  remove actuals
*/
--	8/28/2015 DDAHLE,  Added Trucking company name.
-- Change:  Increased Trucker field to char(50) from (30) (ddahle) 03/28/2016
-- =============================================

CREATE PROCEDURE [dbo].[cfp_REPORT_TRANSPORTATION_SITE_SCHEDULE] 
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

DECLARE @SiteName as varchar(30)
SET @SiteName=(Select replace(ContactName, '''', '''''') ContactName from [$(SolomonApp)].dbo.cftContact where cast(ContactID as int)=@ContactID)

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
--,	ActualQty			smallint
,	EstimatedWgt		char(7)
--,	ActualWgt			char(7)
,	PigType			char(30)
,	CpnyID			char(10)
,	Destination		char(30)
,	DestBarnNbr		char(10)
,	DestRoomNbr		char(10)
,	truckercontactid char(6)
,	phcontactid		varchar(10)
,	Trucker			char(50)
,	TruckerPhone	varchar(10)
,	Trailer			char(30)
,	PICWeek			smallint
,	ScheduleStatus		char(30)
,	WeekOfDate		smalldatetime
,	Comment			char(100)
,	SiteName		char(30)
,	tattooflag		char(1)
,	LoadingTime		smalldatetime
,	ArrivalTime		smalldatetime
,	PigGenderTypeID		char(6)
,	TrailerWashFlag		char(1)
,	GiltAge			char(10)
,	disinfectflg	char(1)
,	Highlight		int
,	SelectedContact		char(30)
,	PMID			char(10)
,	PMLoadID		char(10))

SET @SQLString = 
N'INSERT INTO #Schedule
Select 
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
	EstimatedQty,
	EstimatedWgt,
	Case when cftPM.PigTypeID<>''04'' 
		then cftPigType.PigTypeDesc 
		else cftMarketSaleType.Description 
	end as PigType,
	cftPM.CpnyID,
	DestContact.ShortName as Destination,
	cftPM.DestBarnNbr,
	cftPM.DestRoomNbr,
	cftPM.truckercontactid,
	TruckerContact.contactid,
	CASE WHEN dcpy.TruckingCompanyName IS NULL THEN TruckerContact.ShortName ELSE dcpy.TruckingCompanyName END as Trucker,
	CASE WHEN dcpy.TruckingCompanyName IS NULL 
		THEN [$(CentralData)].dbo.GetTphonenbr(cftpm.truckercontactid) 
		ELSE [$(CentralData)].dbo.GetTphonenbr(dcpy.TruckingCompanyContactID) 
	END as TruckerPhoneNbr,
	cftPigTrailer.Description as Trailer, 
	cftWeekDefinition.PICWeek,'''
	+ RTRIM(@ScheduleStatus) + N'''  as ScheduleStatus,
	cftPMWeekStatus.WeekOfDate,
	case when rtrim(cftPM.Comment)='''' 
		then Null 
		else cftPM.comment 
	end as Comment,'''
	+ RTRIM(@SiteName) + N''' as SiteName,
	case when cftPM.tattooflag = 0
		then ''''
		else ''Y''
	end ''tattooflag'',
	cftPM.LoadingTime,
	cftPM.ArrivalTime,
	cftPM.PigGenderTypeID,
	case when cftPM.TrailerWashFlag = 0
		then ''''
		else ''Y''
	end ''TrailerWashFlag'',
	cftPM.GiltAge,
	case when cftPM.disinfectflg = 0
		then ''''
		else ''Y''
	end ''disinfectflg'',
	cftPM.Highlight,
	SelectedContact.ShortName as SelectedContact,
	cftPM.PMID,
	cftPM.PMLoadID
from [$(SolomonApp)].dbo.cftPM cftPM (NOLOCK)
LEFT JOIN [$(SolomonApp)].dbo.cftContact SourceContact (NOLOCK) on cftPM.SourceContactID = SourceContact.ContactID
LEFT JOIN [$(SolomonApp)].dbo.cftContact DestContact (NOLOCK) on cftPM.DestContactID = DestContact.ContactID
left join [$(CentralData)].dbo.cfv_DriverCompany dcpy (NOLOCK) on cast(cftPM.TruckerContactID as Integer) = dcpy.DriverContactID
LEFT JOIN [$(SolomonApp)].dbo.cftContact SelectedContact (NOLOCK) on ' + cast(@ContactID as varchar) + N' = SelectedContact.ContactID
LEFT JOIN [$(SolomonApp)].dbo.cftPigType cftPigType (NOLOCK) on cast(COALESCE(cftPM.PigTypeID,0) as int)= cftPigType.PigTypeID
LEFT JOIN [$(SolomonApp)].dbo.cftMarketSaleType cftMarketSaleType (NOLOCK) on cast(cftPM.MarketSaleTypeID as int) = cast(cftMarketSaleType.MarketSaleTypeID as int)
LEFT JOIN [$(SolomonApp)].dbo.cftContact TruckerContact (NOLOCK)
	on cftPM.TruckerContactID = TruckerContact.ContactID
LEFT JOIN [$(SolomonApp)].dbo.cftPigTrailer cftPigTrailer (NOLOCK) on cast(cftPM.PigTrailerID as int) = cast(cftPigTrailer.PigTrailerID as int)
LEFT JOIN [$(SolomonApp)].dbo.cftWeekDefinition cftWeekDefinition (NOLOCK) 
	on cftPM.MovementDate between cftWeekDefinition.WeekOfDate and cftWeekDefinition.WeekEndDate
LEFT JOIN [$(SolomonApp)].dbo.cftPMWeekStatus cftPMWeekStatus (NOLOCK) 
	on cftWeekDefinition.WeekOfDate = cftPMWeekStatus.WeekOfDate 
	and cftPMWeekStatus.PMTypeID = ''02'' 
	and cftPMWeekStatus.PigSystemID = ''01'' 
	and cftPMWeekStatus.CpnyID = ''CFF'''

+ N' WHERE cftPM.MovementDate between ''' + CAST(@StartDate AS VARCHAR) + ''' and ''' + CAST(@EndDate AS VARCHAR) + N''''


IF CAST(@PMTypeString AS INT) = 2
BEGIN
	SET @SQLString = @SQLString + N' and cftPM.PMSystemID like ''' + @PMSystemString + N''' and cftPM.PMTypeID = ''' + @PMTypeString + N''''
END
ELSE
BEGIN
	SET @SQLString = @SQLString + N' and cftPM.PMSystemID in (''' + @PMSystemString + N''') and cftPM.PMTypeID = ''' + @PMTypeString + N''''
END


SET @SQLString = @SQLString 
+ ' and (cast(cftPM.DestContactID as int)= ''' + CAST(@ContactID AS VARCHAR) + ''' or cast(cftPM.SourceContactID as int)= ''' + CAST(@ContactID AS VARCHAR) + ''')
and cftPM.SuppressFlg = 0
and cftPM.Highlight <> 255
and cftPM.Highlight <> -65536
ORDER BY
	cftPM.MovementDate,
	cftPM.LoadingTime'

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
--,	ActualQty
,	EstimatedWgt
--,	ActualWgt
,	PigType
,	CpnyID
,	Destination
,	DestBarnNbr
,	DestRoomNbr
,	truckercontactid 
,	phcontactid		
,	Trucker
--,   TruckerPhone
, SUBSTRING(Truckerphone,1,3)+'-'+SUBSTRING(Truckerphone,4,3)+'-'+SUBSTRING(Truckerphone,7,4)	as TruckerPhone
,	Trailer
,	PICWeek
,	ScheduleStatus
,	WeekOfDate
,	Comment
,	SiteName
,	tattooflag
,	LoadingTime
,	ArrivalTime
,	PigGenderTypeID
,	TrailerWashFlag
,	GiltAge
,	disinfectflg
,	Highlight
,	SelectedContact
,	PMID
,	PMLoadID
FROM #Schedule
ORDER BY MovementDate, LoadingTime

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
    ON OBJECT::[dbo].[cfp_REPORT_TRANSPORTATION_SITE_SCHEDULE] TO [db_sp_exec]
    AS [dbo];

