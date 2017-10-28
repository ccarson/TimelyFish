




-- ======================================================================================
-- Author:	Matt Dawson
-- Create date:	1/2/2008
-- Description:	Full Transportation Schedule
-- Parameters: 	@StartDate, 
--		@EndDate,
--		@PMTypeID, (specifies all(00), internal(01), or market(02)
--		@PMSystemID (specifies all(00), multiplication(01), or commericialHH(02); 
--				commercialHH has consolidated data values for IA and SE 02&03
--		NOTE: @PMSystemID is only pertinent when @PMTypeID of internal(01) is selected
-- ======================================================================================
/* 
========================================================================================================
Change Log: 
Date        Author		 	   Change 
----------- ------------------ ------------------------------------------------------------ 
2014-09-26	smr					compat100 or SP2 caused order by to fail, this has been fixed
08/28/2015	DDAHLE,				Added Trucking company name.
10/23/2015	nhonetschlager		Added trailername back into select, and changed trucker to just trucker
03/25/2016	nhonetschlager		Added "SundayDate" so "ScheduleStatus" calcs correctly
04/01/2016	nhonetschlager		Changed OrderBy to MovementDate, PigType Desc, Source, LoadingTime
========================================================================================================
*/
CREATE PROCEDURE [dbo].[cfp_REPORT_TRANSPORTATION_FULL_SCHEDULE] 
@StartDate DATETIME,
@EndDate DATETIME,
@PMTypeString VARCHAR(2),
@PMSystemString VARCHAR(50)

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
,   ActualQty			smallint
,	EstimatedWgt		char(7)
,	ActualWgt			smallint
,	PigType			char(30)
,	CpnyID			char(10)
,	Destination		char(30)
,	DestBarnNbr		char(10)
,	DestRoomNbr		char(10)
,	DisinfectFlg	char(1)
,	Trucker			char(30)
,	Trailer			char(30)
,	PICWeek			smallint
,	ScheduleStatus	char(30)
,	WeekOfDate		smalldatetime
,	Comment			char(100)
,	tattooflag		char(1)
,	LoadingTime		smalldatetime
,	ArrivalTime		smalldatetime
,	PigGenderTypeID		char(6)
,	TrailerWashFlag		char(1)
,	GiltAge			char(10)
,	Highlight		int
,	PMID			char(10)
,	PMLoadID		char(10)
,   TruckingCompanyName varchar(50))

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
	cftPM.ActualQty,
	EstimatedWgt,
	cftPM.ActualWgt,
	Case when cftPM.PigTypeID<>''04'' 
		then cftPigType.PigTypeDesc 
		else cftMarketSaleType.Description 
	end as PigType,
	cftPM.CpnyID,
	DestContact.ShortName as Destination,
	cftPM.DestBarnNbr,
	cftPM.DestRoomNbr, 
	case when cftPM.DisinfectFlg = 0
		then ''''
		else ''Y''
	end ''DisinfectFlg'',
	TruckerContact.ShortName as Trucker,
	cftPigTrailer.Description as Trailer, 
	cftWeekDefinition.PICWeek,'''
	+ RTRIM(@ScheduleStatus) + N'''  as ScheduleStatus,
	cftPMWeekStatus.WeekOfDate,
	case when rtrim(cftPM.Comment)='''' 
		then Null 
		else cftPM.comment 
	end as Comment,
	case when cftPM.tattooflag = 0
		then ''''
		else ''Y''
	end ''tattooflag'',
	Case when LEN(RTRIM(cftPM.LoadingTime))>0 
		then CONVERT(CHAR(19),cftPM.LoadingTime,108)
		else '''' 
	end  as LoadingTime,
	cftPM.ArrivalTime,
	cftPM.PigGenderTypeID,
	case when cftPM.TrailerWashFlag = 0
		then ''''
		else ''Y''
	end ''TrailerWashFlag'',
	cftPM.GiltAge,
	cftPM.Highlight,
	cftPM.PMID,
	cftPM.PMLoadID,
	dcpy.TruckingCompanyName
FROM [$(SolomonApp)].dbo.cftPM cftPM (NOLOCK)
LEFT JOIN [$(SolomonApp)].dbo.cftContact SourceContact (NOLOCK) on cftPM.SourceContactID = SourceContact.ContactID
LEFT JOIN [$(SolomonApp)].dbo.cftContact DestContact (NOLOCK) on cftPM.DestContactID = DestContact.ContactID
LEFT JOIN [$(CentralData)].dbo.cfv_DriverCompany dcpy (NOLOCK) on cast(cftPM.TruckerContactID as Integer) = dcpy.DriverContactID
LEFT JOIN [$(SolomonApp)].dbo.cftPigType cftPigType (NOLOCK) on cftPM.PigTypeID = cftPigType.PigTypeID
LEFT JOIN [$(SolomonApp)].dbo.cftMarketSaleType cftMarketSaleType (NOLOCK) on cftPM.MarketSaleTypeID = cftMarketSaleType.MarketSaleTypeID
LEFT JOIN [$(SolomonApp)].dbo.cftContact TruckerContact (NOLOCK) on cftPM.TruckerContactID = TruckerContact.ContactID
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
+ ' and cftPM.SuppressFlg = 0
and cftPM.Highlight <> 255
and cftPM.Highlight <> -65536
ORDER BY
	cftPM.MovementDate,
	Case when LEN(RTRIM(cftPM.LoadingTime))>0 
		then CONVERT(CHAR(19),cftPM.LoadingTime,108)
		else '''' 
	end'
--	cftPM.LoadTime'		-- 20140916 smr compat100 or sp2 upgrade issue, requires the case statement rather then the alias

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
,	ActualQty
,	EstimatedWgt
,	ActualWgt
,	PigType
,	CpnyID
,	Destination
,	DestBarnNbr
,	DestRoomNbr
,	DisinfectFlg
,	Trucker				-- 20151023 changed this back to just use trucker name
,	Trailer				-- 20151023 added this back in. was previously commented out
,	PICWeek
,	ScheduleStatus
,	WeekOfDate
,	Comment
,	tattooflag
,	LoadingTime
,	ArrivalTime
,	PigGenderTypeID
,	TrailerWashFlag
,	GiltAge
,	Highlight
,	PMID
,	PMLoadID
,	TruckingCompanyName	
FROM #Schedule
ORDER BY MovementDate, PigType Desc, Source, LoadingTime --MovementDate,LoadTime





GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_TRANSPORTATION_FULL_SCHEDULE] TO [db_sp_exec]
    AS [dbo];

