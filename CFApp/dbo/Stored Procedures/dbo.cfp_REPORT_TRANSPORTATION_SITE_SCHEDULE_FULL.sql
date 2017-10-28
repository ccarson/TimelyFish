
-- =====================================================
-- Author:	Nick Honetschlager
-- Create date:	10/23/2015
-- Description:	Full Site Schedule
-- Parameters: 	@StartDate, 
--				@EndDate,
--				@ContactID
--				@PMSystemString
--	Adapted from cfp_REPORT_TRANSPORTATION_SITE_SCHEDULE
-- ======================================================
CREATE PROCEDURE [dbo].[cfp_REPORT_TRANSPORTATION_SITE_SCHEDULE_FULL] 
@StartDate DATETIME,
@EndDate DATETIME,
@ContactID INT,
@PMSystemString VARCHAR(50)

AS

DECLARE @SiteName as varchar(30)
SET @SiteName=(Select replace(ContactName, '''', '''''') ContactName from [$(SolomonApp)].dbo.cftContact where cast(ContactID as int)=@ContactID)

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
,	PigType			char(30)
,	CpnyID			char(10)
,	Destination		char(30)
,	DestBarnNbr		char(10)
,	DestRoomNbr		char(10)
,	truckercontactid char(6)
,	phcontactid		varchar(10)
,	Trucker			char(30)
,	TruckerPhone	varchar(10)
,	Trailer			char(30)
,	PICWeek			smallint
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
,	PMLoadID		char(10)
,	PackerDesc		char(30))

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
--	cftPM.ActualQty,
	EstimatedWgt,
--	cftPM.ActualWgt,
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
	TruckerContact.ShortName as Trucker,
	[$(CentralData)].dbo.GetTphonenbr(cftpm.truckercontactid) as TruckerPhoneNbr,
	cftPigTrailer.Description as Trailer, 
	cftWeekDefinition.PICWeek,

	
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
	cftPM.PMLoadID,
	ord.Descr AS PackerDesc
from [$(SolomonApp)].dbo.cftPM cftPM (NOLOCK)
LEFT JOIN [$(SolomonApp)].dbo.cftContact SourceContact (NOLOCK) on cftPM.SourceContactID = SourceContact.ContactID
LEFT JOIN [$(SolomonApp)].dbo.cftContact DestContact (NOLOCK) on cftPM.DestContactID = DestContact.ContactID
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
	and cftPMWeekStatus.CpnyID = ''CFF''
	LEFT JOIN [$(SolomonApp)].dbo.cftPSOrdHdr ord WITH (NOLOCK) ON cftPM.OrdNbr = ord.OrdNbr'

+ N' WHERE cftPM.MovementDate between ''' + CAST(@StartDate AS VARCHAR) + ''' and ''' + CAST(@EndDate AS VARCHAR) + N''''

	SET @SQLString = @SQLString + N' and cftPM.PMSystemID in (''' + @PMSystemString + N''')'


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
,	EstimatedWgt
,	PigType
,	CpnyID
,	Destination
,	DestBarnNbr
,	DestRoomNbr
,	truckercontactid 
,	phcontactid		
,	Trucker
, SUBSTRING(Truckerphone,1,3)+'-'+SUBSTRING(Truckerphone,4,3)+'-'+SUBSTRING(Truckerphone,7,4)	as TruckerPhone
,	Trailer
,	PICWeek
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
,	PackerDesc
FROM #Schedule
ORDER BY MovementDate, LoadingTime




GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_TRANSPORTATION_SITE_SCHEDULE_FULL] TO [ApplicationCenter]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_TRANSPORTATION_SITE_SCHEDULE_FULL] TO [db_sp_exec]
    AS [dbo];

