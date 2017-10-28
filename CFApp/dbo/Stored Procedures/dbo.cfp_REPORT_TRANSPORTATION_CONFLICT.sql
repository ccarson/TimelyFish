
--*************************************************************
--	Author: Nick Honetschlager
--	Date: 01/18/2016
--	Usage: Transportation Conflicts
--	Parms: @StartDate as Date, @EndDate as Date      
--*************************************************************

CREATE PROC [dbo].[cfp_REPORT_TRANSPORTATION_CONFLICT]
	@StartDate as Date, @EndDate as Date
	
AS

DECLARE @MovementDate as date

CREATE TABLE #Schedule
(	
	SiteName		char(30)
,	MovementDate	smalldatetime
,	ID				int
,	Source			char(30)
,	SourceBarnNbr	char(10)
,	SourceRoomNbr	char(10)
,	LoadTime		varchar(20)
,	ArriveTime		varchar(20)
,	EstimatedQty	smallint
,	EstimatedWgt	char(7)
,	PigType			char(30)
,	Trucker			char(30)
,	CpnyID			char(10)
,	Destination		char(30)
,	DestBarnNbr		char(10)
,	DestRoomNbr		char(10)
,	Trailer			char(30)
,	Comment			char(100)
,	LoadingTime		smalldatetime
,	ArrivalTime		smalldatetime
,	Highlight		int
,	PMID			char(10)
,	PMLoadID		char(10))

SET @MovementDate = @StartDate

WHILE @MovementDate BETWEEN @StartDate AND @EndDate

BEGIN
INSERT INTO #Schedule

Select 
	SiteName.ShortName AS SiteName,
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
	Case when cftPM.PigTypeID<>'04'
		then cftPigType.PigTypeDesc 
		else cftMarketSaleType.Description 
	end as PigType,
	TruckerContact.ShortName as Trucker,
	cftPM.CpnyID,
	DestContact.ShortName as Destination,
	cftPM.DestBarnNbr,
	cftPM.DestRoomNbr,
	cftPigTrailer.Description as Trailer, 
	case when rtrim(cftPM.Comment)='' 
		then Null 
		else cftPM.comment 
	end as Comment,
	cftPM.LoadingTime,
	cftPM.ArrivalTime,
	cftPM.Highlight,
	cftPM.PMID,
	cftPM.PMLoadID
FROM	(
		SELECT SourceContactID AS Site, *
		FROM [$(SolomonApp)].dbo.cftPM
		WHERE PMID IN	(
									SELECT DISTINCT pm.PMID
									FROM	(
											SELECT *
											FROM [$(SolomonApp)].dbo.cftPM pm
											WHERE pm.MovementDate = @MovementDate
											AND pm.SourceContactID <> pm.DestContactID
											AND pm.DestContactID <> ''
											AND pm.SourceContactID <> ''
											) pm
									JOIN (
											SELECT *
											FROM [$(SolomonApp)].dbo.cftPM pm
											WHERE pm.MovementDate = @MovementDate
											AND pm.SourceContactID <> pm.DestContactID
											AND pm.DestContactID <> ''
											AND pm.SourceContactID <> ''
											) pm1 ON (pm.SourceContactID = pm1.DestContactID AND pm.SourceBarnNbr = pm1.DestBarnNbr)
									WHERE pm.MovementDate = @MovementDate
									AND pm1.MovementDate = @MovementDate
									AND (pm.SourceBarnNbr <> '' OR pm1.DestBarnNbr <> '')
									)
		AND MovementDate = @MovementDate

		UNION

		SELECT DestContactID AS Site, *
		FROM [$(SolomonApp)].dbo.cftPM
		WHERE PMID IN	(									
									SELECT DISTINCT pm.PMID
									FROM	(
											SELECT *
											FROM [$(SolomonApp)].dbo.cftPM pm
											WHERE pm.MovementDate = @MovementDate
											AND pm.SourceContactID <> pm.DestContactID
											AND pm.DestContactID <> ''
											AND pm.SourceContactID <> ''
											) pm
									JOIN (
											SELECT *
											FROM [$(SolomonApp)].dbo.cftPM pm
											WHERE pm.MovementDate = @MovementDate
											AND pm.SourceContactID <> pm.DestContactID
											AND pm.DestContactID <> ''
											AND pm.SourceContactID <> ''
											) pm1 ON (pm.DestContactID = pm1.SourceContactID AND pm.DestBarnNbr = pm1.SourceBarnNbr)
									WHERE pm.MovementDate = @MovementDate
									AND pm1.MovementDate = @MovementDate
									AND (pm.DestBarnNbr <> '' AND pm1.SourceBarnNbr <> '')
									)
		AND MovementDate = @MovementDate
		) as cftPM
LEFT JOIN [$(SolomonApp)].dbo.cftContact SourceContact (NOLOCK) on cftPM.SourceContactID = SourceContact.ContactID
LEFT JOIN [$(SolomonApp)].dbo.cftContact DestContact (NOLOCK) on cftPM.DestContactID = DestContact.ContactID
LEFT JOIN [$(SolomonApp)].dbo.cftContact SiteName (NOLOCK) on cftPM.Site = SiteName.ContactID
LEFT JOIN [$(SolomonApp)].dbo.cftPigType cftPigType (NOLOCK) on cast(COALESCE(cftPM.PigTypeID,0) as int)= cftPigType.PigTypeID
LEFT JOIN [$(SolomonApp)].dbo.cftMarketSaleType cftMarketSaleType (NOLOCK) on cast(cftPM.MarketSaleTypeID as int) = cast(cftMarketSaleType.MarketSaleTypeID as int)
LEFT JOIN [$(SolomonApp)].dbo.cftContact TruckerContact (NOLOCK)
	on cftPM.TruckerContactID = TruckerContact.ContactID
LEFT JOIN [$(SolomonApp)].dbo.cftPigTrailer cftPigTrailer (NOLOCK) on cast(cftPM.PigTrailerID as int) = cast(cftPigTrailer.PigTrailerID as int)
LEFT JOIN [$(SolomonApp)].dbo.cftWeekDefinition cftWeekDefinition (NOLOCK) 
	on cftPM.MovementDate between cftWeekDefinition.WeekOfDate and cftWeekDefinition.WeekEndDate
LEFT JOIN [$(SolomonApp)].dbo.cftPMWeekStatus cftPMWeekStatus (NOLOCK) 
	on cftWeekDefinition.WeekOfDate = cftPMWeekStatus.WeekOfDate 
	and cftPMWeekStatus.PMTypeID = '02'
	and cftPMWeekStatus.PigSystemID = '01' 
	and cftPMWeekStatus.CpnyID = 'CFF'
	
SET @MovementDate = DATEADD(d, 1, @MovementDate)
END	
	


SELECT *
FROM #Schedule
ORDER BY MovementDate, SiteName

DROP TABLE #Schedule