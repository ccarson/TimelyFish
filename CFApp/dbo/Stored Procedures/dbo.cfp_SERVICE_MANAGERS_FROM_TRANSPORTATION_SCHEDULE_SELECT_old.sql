
--*************************************************************
--	Purpose:List of ServiceMen for Schedule Report
--		
--	Author: mdawson
--	Date: 12/10/2007
--	Usage: 	Return service managers from sites within the transportation
--		schedule for date range
--		*** should be looked into for performance (udf could be better?)
--	Parms: StartDate, EndDate
--*************************************************************

CREATE PROC [dbo].[cfp_SERVICE_MANAGERS_FROM_TRANSPORTATION_SCHEDULE_SELECT_old]
@StartDate as smalldatetime, 
@EndDate as smalldatetime,
@PMTypeString VARCHAR(2),
@PMSystemString VARCHAR(50)
AS

IF CAST(@PMTypeString AS INT) = '2' 
BEGIN 
	SET @PMSystemString = '%'
END 
IF CAST(@PMTypeString AS INT) = '0' 
BEGIN 
	SET @PMTypeString = '%'
	SET @PMSystemString = '%'
END 

CREATE TABLE #ListGroup
(	ContactID int
,	UserName varchar(20)
,	ServiceName varchar(20)
,	ReportType int)

DECLARE @SQLString NVARCHAR(4000)

SET @SQLString = 
N'INSERT INTO #ListGroup
Select Distinct [$(SolomonApp)].dbo.GetSvcManagerID(cftPM.SourceContactID,''' + cast(@StartDate as varchar) + N''','''') as ContactID, 
[$(SolomonApp)].dbo.GetSvcManager(cftPM.SourceContactID,''' + cast(@StartDate as varchar) + N''','''') as UserName,
[$(SolomonApp)].dbo.GetSvcManagerNm(cftPM.SourceContactID,''' + cast(@StartDate as varchar) + N''','''') as ServiceName,
CAST(cftPM.PMTypeID AS INT) as ReportType
FROM 
[$(SolomonApp)].dbo.cftPM cftPM (NOLOCK)
where cftPM.MovementDate between ''' + cast(@StartDate as varchar) + N''' and ''' + cast(@EndDate as varchar) + N''''

IF @PMTypeString in ('%','02')
BEGIN
	SET @SQLString = @SQLString + N' and cftPM.PMSystemID like ''' + @PMSystemString + N''' and cftPM.PMTypeID like ''' + @PMTypeString + N''''
END
ELSE
BEGIN
	SET @SQLString = @SQLString + N' and cftPM.PMSystemID in (''' + @PMSystemString + N''') and cftPM.PMTypeID like ''' + @PMTypeString + N''''
END
SET @SQLString = @SQLString 
+ N' and [$(SolomonApp)].dbo.GetSvcManagerID(cftPM.SourceContactID,''' + cast(@StartDate as varchar) + N''','''') is not null
UNION
Select Distinct [$(SolomonApp)].dbo.GetMarketSvcManagerID(cftPM.SourceContactID,''' + cast(@StartDate as varchar) + N''','''') as ContactID, 
[$(SolomonApp)].dbo.GetMarketSvcManager(cftPM.SourceContactID,''' + cast(@StartDate as varchar) + N''','''') as UserName,
[$(SolomonApp)].dbo.GetMktManagerNm(cftPM.SourceContactID,''' + cast(@StartDate as varchar) + N''','''') as ServiceName,
CAST(cftPM.PMTypeID AS INT) as ReportType
FROM 
[$(SolomonApp)].dbo.cftPM cftPM (NOLOCK)
where cftPM.MovementDate between ''' + cast(@StartDate as varchar) + N''' and ''' + cast(@EndDate as varchar) + N''''
IF @PMTypeString in ('%','02')
BEGIN
	SET @SQLString = @SQLString + N' and cftPM.PMSystemID like ''' + @PMSystemString + N''' and cftPM.PMTypeID like ''' + @PMTypeString + N''''
END
ELSE
BEGIN
	SET @SQLString = @SQLString + N' and cftPM.PMSystemID in (''' + @PMSystemString + N''') and cftPM.PMTypeID like ''' + @PMTypeString + N''''
END
SET @SQLString = @SQLString 
+ N' and [$(SolomonApp)].dbo.GetMarketSvcManagerID(cftPM.SourceContactID,''' + cast(@StartDate as varchar) + N''','''') is not null
and cftPM.Highlight<>255
and cftPM.Highlight <> -65536'

print @SQLString
exec sp_executesql @SQLString

SELECT
	ContactID
,	UserName
,	ServiceName
,	SUM(ReportType) ReportType
FROM	#ListGroup
GROUP BY
	ContactID
,	UserName
,	ServiceName
ORDER BY
	ServiceName

DROP TABLE #ListGroup


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SERVICE_MANAGERS_FROM_TRANSPORTATION_SCHEDULE_SELECT_old] TO [db_sp_exec]
    AS [dbo];

