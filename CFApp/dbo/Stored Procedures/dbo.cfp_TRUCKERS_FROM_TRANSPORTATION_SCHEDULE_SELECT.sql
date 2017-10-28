
-- =============================================
-- Author:	mdawson
-- Create date: 12/6/2007
-- Description:	Returns Truckers in Transportation Schedule
--		based on date criteria
-- Change:  Added DriverCompany Join (ddahle) 09/19/2015
-- =============================================

CREATE PROC [dbo].[cfp_TRUCKERS_FROM_TRANSPORTATION_SCHEDULE_SELECT]
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
(	ContactID char(6)
,	ContactName varchar(50)
,	TruckingCompanyName varchar(50)
,	TransSchedMethTypeID char(2)
,	ReportType int)

DECLARE @SQLString NVARCHAR(4000)

SET @SQLString = 
N'INSERT INTO #ListGroup
Select Distinct 
	c.ContactID, 
	rtrim(c.ShortName) as ContactName,
	dcpy.TruckingCompanyName,
	c.TranSchedMethTypeID,
	CAST(cftPM.PMTypeID AS INT) as ReportType
FROM 
[$(SolomonApp)].dbo.cftPM cftPM (NOLOCK)
left join [$(CentralData)].dbo.cfv_DriverCompany dcpy (NOLOCK) on cast(cftPM.TruckerContactID as Integer) = dcpy.DriverContactID
JOIN [$(SolomonApp)].dbo.cftContact c (NOLOCK) on cftPM.TruckerContactID=c.ContactID
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
+ N' and cftPM.Highlight<>255
and cftPM.Highlight <> -65536'

print @SQLString
exec sp_executesql @SQLString

SELECT
	ContactID
,	ContactName
,	TransSchedMethTypeID
,	SUM(ReportType) ReportType
FROM	#ListGroup
GROUP BY
	ContactID
,	ContactName
,	TransSchedMethTypeID
ORDER BY
	ContactName

DROP TABLE #ListGroup


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_TRUCKERS_FROM_TRANSPORTATION_SCHEDULE_SELECT] TO [db_sp_exec]
    AS [dbo];

