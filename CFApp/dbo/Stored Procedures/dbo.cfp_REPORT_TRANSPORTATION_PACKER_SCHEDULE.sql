



-- =============================================
-- Author:	Matt Dawson
-- Create date:	1/2/2008
-- Description:	Packer Transportation Schedule
-- *********************************************
/* 
===========================================================================================
Change Log: 
Date        Author		 	   Change 
----------- ------------------ ------------------------------------------------------------ 
4/21/2015  Nick Honetschlager	Sort by Packer Desc first
9/10/2015  ddahle  				Added company check on driver name.
12/10/2015 Nick Honetschlager	Replaced MovementDate with ArrivalDate in sort order	
1/28/2016  Nick Honetschlager	Added REPLACE to change 'SBF' to 'CF' in PackerDesc
2/17/2016  Nick Honetschlager	Added Case statement to remove 'CF' or 'SBF' in PackerDesc
03/28/2016 DDahle				Increased Trucker field to char(50) from (30)
===========================================================================================
*/

CREATE PROCEDURE [dbo].[cfp_REPORT_TRANSPORTATION_PACKER_SCHEDULE] 
@StartDate DATETIME,
@EndDate DATETIME,
@ContactID INT,
@SendingReportChanges CHAR(1)

AS

declare @ScheduleStatus varchar(50)
create table #Status
(	StatusID int
,	StatusDesc varchar(50))

insert into #Status
exec cfp_MARKET_SCHEDULE_CURRENT_STATUS_SELECT_BY_TYPE_AND_DATE '02', @StartDate

set @ScheduleStatus = (select RTRIM(StatusDesc) from #Status)
drop table #Status

DECLARE @SQLString NVARCHAR(4000)

CREATE TABLE #Schedule
(	MovementDate		smalldatetime
,	ArrivalDate		smalldatetime
,	ID			int
,	Source			char(30)
,	SourceBarnNbr		char(10)
,	SourceRoomNbr		char(10)
,	LoadTime		varchar(20)--float
,	ArriveTime		varchar(20)--float
,	EstimatedQty		smallint
,	PigType			char(30)
,	Trucker			char(50)
,	CpnyID			char(10)
,	Destination		char(30)
,	DestBarnNbr		char(10)
,	DestRoomNbr		char(10)
,	Trailer			char(30)
,	PICWeek			smallint
,	ScheduleStatus		char(30)
,	WeekOfDate		smalldatetime
,	Comment			char(100)
,	tattooflag		char(1)
,	TrkPaidFlg		smallint
,	TrailerWashFlag		char(1)
,	DisinfectFlg		char(1)
,	State			char(3)
,	EstimatedWgt		char(7)
,	Rate			Decimal(10,2)
,	LoadingTime		smalldatetime
,	ArrivalTime		smalldatetime
,	Highlight		int
,	PFEU			smallint
,	PMID			char(10)
,	PMLoadID		char(10)
,	PackerDesc		char(30))

SET @SQLString = 
N'INSERT INTO #Schedule
Select 
	cftPM.MovementDate,
	cftPM.ArrivalDate,
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
	cftMarketSaleType.Description as PigType,
	CASE WHEN dcpy.TruckingCompanyName IS NULL THEN TruckerContact.ShortName ELSE dcpy.TruckingCompanyName END as Trucker,
	cftPM.CpnyID,
	DestContact.ShortName as Destination,
	cftPM.DestBarnNbr,
	cftPM.DestRoomNbr, 
	cftPigTrailer.Description as Trailer, 
	cftWeekDefinition.PICWeek,'''
	+ RTRIM(@ScheduleStatus) + N''' as ScheduleStatus,
	cftPMWeekStatus.WeekOfDate,
	case when rtrim(cftPM.Comment)='''' 
		then Null 
		else cftPM.comment 
	end as Comment,
	case when cftPM.tattooflag = 0
		then ''''
		else ''Y''
	end ''tattooflag'',
	cftPacker.TrkPaidFlg,
	case when cftPM.TrailerWashFlag = 0
		then ''''
		else ''Y''
	end ''TrailerWashFlag'',
	case when cftPM.DisinfectFlg = 0
		then ''''
		else ''Y''
	end ''DisinfectFlg'',
	cftAddress.State,
	cftPM.EstimatedWgt,
	Rate = [$(SolomonApp)].dbo.getRate(cftPM.PMLoadID,cftPM.PMID,cftWeekDefinition.WeekOfDate,cftPM.PigTypeID,cftPM.PMSystemID,cftPM.PigTrailerID,cftPM.TranSubTypeID),
	cftPM.LoadingTime,
	cftPM.ArrivalTime,
	cftPM.Highlight, 
	cftPM.PFEUEligible as PFEU,
	cftPM.PMID,
	cftPM.PMLoadID,
	CASE WHEN ord.Descr LIKE ''CF%'' THEN REPLACE(ord.Descr, ''CF '', '''') WHEN ord.Descr LIKE ''SBF%'' THEN REPLACE(ord.Descr, ''SBF '', '''') ELSE ord.Descr END AS PackerDesc
from [$(SolomonApp)].dbo.cftPM cftPM (NOLOCK)
LEFT JOIN [$(SolomonApp)].dbo.cftContact SourceContact (NOLOCK) on cftPM.SourceContactID = SourceContact.ContactID
LEFT JOIN [$(SolomonApp)].dbo.cftContact DestContact (NOLOCK) on cftPM.DestContactID = DestContact.ContactID
LEFT JOIN [$(CentralData)].dbo.cfv_DriverCompany dcpy (NOLOCK) on cast(cftPM.TruckerContactID as Integer) = dcpy.DriverContactID
LEFT JOIN [$(SolomonApp)].dbo.cftContact TruckerContact (NOLOCK) on cftPM.TruckerContactID = TruckerContact.ContactID
LEFT JOIN [$(SolomonApp)].dbo.cftMarketSaleType cftMarketSaleType (NOLOCK) on cftPM.MarketSaleTypeID = cftMarketSaleType.MarketSaleTypeID
LEFT JOIN [$(SolomonApp)].dbo.cftPigTrailer cftPigTrailer (NOLOCK) on cast(cftPM.PigTrailerID as int) = cast(cftPigTrailer.PigTrailerID as int)
LEFT JOIN [$(SolomonApp)].dbo.cftPacker cftPacker (NOLOCK) on cftPM.DestContactID = cftPacker.ContactID
LEFT JOIN [$(SolomonApp)].dbo.cftWeekDefinition cftWeekDefinition (NOLOCK) on cftPM.MovementDate between cftWeekDefinition.WeekOfDate and cftWeekDefinition.WeekEndDate
LEFT JOIN [$(SolomonApp)].dbo.cftPMWeekStatus cftPMWeekStatus (NOLOCK) on cftWeekDefinition.WeekOfDate = cftPMWeekStatus.WeekOfDate and cftPMWeekStatus.PMTypeID = ''02'' 
	and cftPMWeekStatus.PigSystemID = ''01'' and cftPMWeekStatus.CpnyID = ''CFF''
LEFT JOIN [$(SolomonApp)].dbo.cftContactAddress cftContactAddress (nolock) on cftPM.SourceContactID = cftContactAddress.ContactID and cftContactAddress.AddressTypeID = ''01''
LEFT JOIN [$(SolomonApp)].dbo.cftAddress cftAddress (NOLOCK) on cftContactAddress.AddressID = cftAddress.AddressID
left join [$(SolomonApp)].dbo.cftPSOrdHdr ord WITH (NOLOCK) on cftPM.OrdNbr = ord.OrdNbr
WHERE cftPM.MovementDate between ''' + CAST(@StartDate AS VARCHAR) + ''' and ''' + CAST(@EndDate AS VARCHAR) + N'''
	and cast(cftPM.DestContactID as int) = ''' + CAST(@ContactID AS VARCHAR) + '''
	and cftPM.SuppressFlg = 0
	and cftPM.Highlight <> 255
	and cftPM.Highlight <> -65536
ORDER BY											
	cftPM.ArrivalDate,
	cftPM.ArrivalTime,
	SourceContact.ShortName'

print @SQLString
exec sp_executesql @SQLString

SELECT
	MovementDate		
,	ArrivalDate		
,	ID			
,	Source			
,	SourceBarnNbr		
,	SourceRoomNbr		
,	LoadTime		
,	ArriveTime		
,	EstimatedQty		
,	PigType			
,	Trucker			
,	CpnyID			
,	Destination		
,	DestBarnNbr		
,	DestRoomNbr		
,	Trailer			
,	PICWeek			
,	ScheduleStatus		
,	WeekOfDate		
,	Comment			
,	tattooflag		
,	TrkPaidFlg		
,	TrailerWashFlag		
,	DisinfectFlg		
,	State			
,	EstimatedWgt		
,	Rate			
,	LoadingTime		
,	ArrivalTime		
,	Highlight		
,	PFEU			
,	PMID			
,	PMLoadID
,   PackerDesc	
FROM #Schedule
ORDER BY											
	#Schedule.ArrivalDate,
	#Schedule.ArrivalTime,
	#Schedule.Source

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
    ON OBJECT::[dbo].[cfp_REPORT_TRANSPORTATION_PACKER_SCHEDULE] TO [db_sp_exec]
    AS [dbo];

