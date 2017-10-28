CREATE PROCEDURE
    [dbo].[cfp_SERVICE_MANAGERS_FROM_TRANSPORTATION_SCHEDULE_SELECT_CHANGES] (
        @StartDate         smalldatetime
      , @EndDate           smalldatetime
      , @PMTypeString      varchar(02)
      , @PMSystemString    varchar(50) )
AS


SET NOCOUNT, XACT_ABORT ON ;

DECLARE
    @lStartDate         smalldatetime   =   @StartDate
  , @lEndDate           smalldatetime   =   @EndDate
  , @lPMTypeString      varchar(02)     =   @PMTypeString
  , @lPMSystemString    varchar(50)     =   @PMSystemString ;
  
DECLARE 
	@lSystemStrings		TABLE	( PMSystemID char(02) ) ; 
	

IF  @lPMTypeString = '01'
BEGIN 
	SELECT  @lPMSystemString = REPLACE( @lPMSystemString, '''', '' ) ;
	INSERT INTO @lSystemStrings
	SELECT * FROM [$(SolomonApp)].dbo.cffn_SPLIT_STRING( @lPMSystemString , ',' ) ;
END

CREATE TABLE #ListGroup
(   ContactID int
  , UserName varchar(20)
  , ServiceName varchar(20)
  , ReportType int)


INSERT INTO
    #ListGroup

SELECT
    ContactID   =   CONVERT( int, serviceManager.ContactID )
  , UserName    =   CONVERT( varchar(20), serviceManager.UserID )
  , ServiceName =   CONVERT( varchar(20), serviceManager.ContactName )
  , ReportType  =   CAST( cftPM.PMTypeID AS INT )
FROM
    [$(SolomonApp)].dbo.cftPM AS cftPM
INNER JOIN 
    dbo.cft_PM_HISTORY AS cft_PM_HISTORY 
	    ON RTRIM( cft_PM_HISTORY.PMID ) = RTRIM( cftPM.PMID )
OUTER APPLY [$(SolomonApp)].dbo.cff_tvf_GetServiceManager( cftPM.SourceContactID, @lStartDate ) AS serviceManager
WHERE
    cftPM.MovementDate BETWEEN @lStartDate AND @lEndDate
        AND cft_PM_HISTORY.SentChanges != 1
        AND serviceManager.ContactID IS NOT NULL
        AND @lPMTypeString IN( '00', '02' )
        AND ISNULL( NULLIF( @lPMTypeString, '00' ), cftPM.PMTypeID ) = cftPM.PMTypeID

UNION

SELECT
    ContactID   =   CONVERT( int, serviceManager.ContactID )
  , UserName    =   CONVERT( varchar(20), serviceManager.UserID )
  , ServiceName =   CONVERT( varchar(20), serviceManager.ContactName )
  , ReportType  =   CAST( cftPM.PMTypeID AS INT )
FROM
    [$(SolomonApp)].dbo.cftPM AS cftPM
INNER JOIN 
    dbo.cft_PM_HISTORY AS cft_PM_HISTORY 
	    ON RTRIM( cft_PM_HISTORY.PMID ) = RTRIM( cftPM.PMID )
OUTER APPLY [$(SolomonApp)].dbo.cff_tvf_GetServiceManager( cftPM.SourceContactID, @lStartDate ) AS serviceManager
WHERE
    cftPM.MovementDate BETWEEN @lStartDate AND @lEndDate
        AND cft_PM_HISTORY.SentChanges != 1
        AND serviceManager.ContactID IS NOT NULL
        AND @lPMTypeString = cftPM.PMTypeID
        AND cftPM.PMSystemID IN( SELECT PMSystemID FROM @lSystemStrings )
        AND cftPM.PMTypeID = '01'

UNION

SELECT
    ContactID   =   CONVERT( int, marketManager.ContactID )
  , UserName    =   CONVERT( varchar(20), marketManager.UserID )
  , ServiceName =   CONVERT( varchar(20), marketManager.ContactName )
  , ReportType  =   CAST( cftPM.PMTypeID AS INT )
FROM
    [$(SolomonApp)].dbo.cftPM AS cftPM
INNER JOIN 
    dbo.cft_PM_HISTORY AS cft_PM_HISTORY 
	    ON RTRIM( cft_PM_HISTORY.PMID ) = RTRIM( cftPM.PMID )
OUTER APPLY [$(SolomonApp)].dbo.cff_tvf_GetMarketServiceManager( cftPM.SourceContactID, @lStartDate ) AS marketManager
WHERE
    cftPM.MovementDate BETWEEN @lStartDate AND @lEndDate
        AND cft_PM_HISTORY.SentChanges != 1
        AND marketManager.ContactID IS NOT NULL
        AND cftPM.Highlight NOT IN ( 255, -65536 )
        AND @lPMTypeString IN( '00', '02' )
        AND ISNULL( NULLIF( @lPMTypeString, '00' ), cftPM.PMTypeID ) = cftPM.PMTypeID

UNION

SELECT
    ContactID   =   CONVERT( int, marketManager.ContactID )
  , UserName    =   CONVERT( varchar(20), marketManager.UserID )
  , ServiceName =   CONVERT( varchar(20), marketManager.ContactName )
  , ReportType  =   CAST( cftPM.PMTypeID AS INT )
FROM
    [$(SolomonApp)].dbo.cftPM AS cftPM
INNER JOIN 
    dbo.cft_PM_HISTORY AS cft_PM_HISTORY 
	    ON RTRIM( cft_PM_HISTORY.PMID ) = RTRIM( cftPM.PMID )
OUTER APPLY [$(SolomonApp)].dbo.cff_tvf_GetMarketServiceManager( cftPM.SourceContactID, @lStartDate ) AS marketManager
WHERE
    cftPM.MovementDate BETWEEN @lStartDate AND @lEndDate
        AND cft_PM_HISTORY.SentChanges != 1
        AND marketManager.ContactID IS NOT NULL
        AND cftPM.Highlight NOT IN ( 255, -65536 )
        AND @lPMTypeString = cftPM.PMTypeID
        AND cftPM.PMSystemID IN( SELECT PMSystemID FROM @lSystemStrings )
        AND cftPM.PMTypeID = '01'

SELECT
    ContactID
,   UserName
,   ServiceName
,   SUM(ReportType) ReportType
FROM    #ListGroup
GROUP BY
    ContactID
,   UserName
,   ServiceName
ORDER BY
    ServiceName
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SERVICE_MANAGERS_FROM_TRANSPORTATION_SCHEDULE_SELECT_CHANGES] TO [db_sp_exec]
    AS [dbo];

