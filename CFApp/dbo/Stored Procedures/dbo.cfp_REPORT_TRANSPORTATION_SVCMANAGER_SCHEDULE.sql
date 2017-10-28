
/*
:SETVAR SolomonApp  SolomonApp
:SETVAR CentralData CentralData

USE [CFApp]
GO

DECLARE
    @StartDate              DATETIME        =
  , @EndDate                DATETIME        =
  , @ContactID              INT             =
  , @UserName               VARCHAR(20)     =
  , @PMTypeString           VARCHAR(2)      =
  , @PMSystemString         VARCHAR(50)     =
  , @SendingReportChanges   CHAR(1)         =   ;

EXECUTE
    dbo.cfp_REPORT_TRANSPORTATION_SVCMANAGER_SCHEDULE_new
        @StartDate
      , @EndDate
      , @ContactID
      , @UserName
      , @PMTypeString
      , @PMSystemString
      , @SendingReportChanges ;

*/
CREATE PROCEDURE
    dbo.cfp_REPORT_TRANSPORTATION_SVCMANAGER_SCHEDULE(
        @StartDate              datetime
      , @EndDate                datetime
      , @ContactID              int
      , @UserName               char(20)
      , @PMTypeString           varchar(02)
      , @PMSystemString         varchar(50)
      , @SendingReportChanges   char(01) )

/*
***********************************************************************************************************************************

    Procedure:      dbo.cfp_REPORT_TRANSPORTATION_SVCMANAGER_SCHEDULE
    Author:	        Matt Dawson


    Revisions:
    Date            Revisor         Comments
    mdawson         1/4/2008        original proc
    sripley         2012/01/12      removed actqty, actwgt;   added disinfectflg
    ddahle          9/10/2015  	    Added company check on driver name.
    nhonetschlager  10/10/2015 	    Added actuals for qty and wgt
    nhonetschlager  11/17/2015      Added Packer Desc
    ddahle          03/28/2016      Increased Trucker field to varchar(50) from (30)
    nhonetschlager  04/04/2016      Changed OrderBy to MovementDate, Source, LoadingTime
    ccarson         2017-02-17      Refactored
                                        removed dynamic SQL
                                        replaced scalar get contact data functions with table-valued functions
                                        added call to split PMSystemString
***********************************************************************************************************************************
*/
AS
SET NOCOUNT, XACT_ABORT ON ;

/*  SELECT parameters into local variables -- this helps prevent parameter sniffing issues   */
DECLARE
    @lStartDate             datetime    = @StartDate
  , @lEndDate               datetime    = @EndDate
  , @lContactID             int         = @ContactID
  , @lUserName              char(20)    = @UserName
  , @lPMTypeString          varchar(02) = @PMTypeString
  , @lPMSystemString        varchar(50) = REPLACE( RTRIM( @PMSystemString ), '''', '' )
  , @lSendingReportChanges  char(01)    = @SendingReportChanges ;


DECLARE
    @UserName_wc            varchar(20) = RTRIM( @lUserName ) + '%'
  , @ScheduleStatus         varchar(50)
  , @SundayDate             datetime ;

/*  Get Sunday Date for current week    */
SELECT
    @SundayDate = WeekOfDate
FROM
    [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo
WHERE
    DayDate = @lStartDate ;


/*  Get schedule status */
SELECT
    TOP 1
    @ScheduleStatus =   pmStatus.Description
FROM
    [$(SolomonApp)].dbo.cftPMWeekStatus AS pmWeekStatus
INNER JOIN
    [$(SolomonApp)].dbo.cftPMStatus AS pmStatus
        ON pmStatus.PMStatusID = pmWeekStatus.PMStatusID
            AND pmStatus.PMTypeID = pmWeekStatus.PMTypeID
WHERE
    pmWeekStatus.WeekOfDate = @SundayDate
        AND pmStatus.PMTypeID = @lPMTypeString
ORDER BY
    pmWeekStatus.Lupd_DateTime DESC ;


CREATE TABLE
    #Schedule(
        MovementDate        smalldatetime
      , ID                  int
      , Source              char(30)
      , SourceBarnNbr       char(10)
      , SourceRoomNbr       char(10)
      , LoadTime            varchar(20)--float
      , ArriveTime          varchar(20)--float
      , EstimatedQty        smallint
      , ActualQty           smallint
      , EstimatedWgt        char(7)
      , ActualWgt           smallint
      , MarketType          char(30)
      , TrailerWashFlag     char(1)
      , Destination         char(30)
      , DestBarnNbr         char(10)
      , DestRoomNbr         char(10)
      , Trucker             char(50)
      , Trailer             char(30)
      , PICWeek             smallint
      , ScheduleStatus      char(30)
      , WeekOfDate          smalldatetime
      , Comment             char(100)
      , DisinfectFlg        char(1)
      , CpnyID              char(10)
      , LoadingTime         smalldatetime
      , ArrivalTime         smalldatetime
      , Highlight           int
      , PFEU                smallint
      , SelectedContact     char(30)
      , PigType             char(30)
      , TattooFlag          char(1)
      , GiltAge             char(10)
      , PMID                char(10)
      , PMLoadID            char(10)
      , PackerDesc          char(30)
      , SourceMktManager    char(20)
      , SourceSvcManager    char(20)
      , DestMktManager      char(20)
      , DestSvcManager      char(20)
      , CreatedUser         char(10) ) ;



INSERT INTO
    #Schedule
SELECT DISTINCT
    MovementDate        =   cftPM.MovementDate
  , ID                  =   cftPM.ID
  , Source              =   SourceContact.ShortName
  , SourceBarnNbr       =   cftPM.SourceBarnNbr
  , SourceRoomNbr       =   cftPM.SourceRoomNbr
  , LoadTime            =   SUBSTRING( CONVERT( CHAR(19), cftPM.LoadingTime, 100 ), 13, 19 )
  , ArriveTime          =   SUBSTRING( CONVERT( CHAR(19), cftPM.ArrivalTime, 100 ), 13, 19 )
  , EstimatedQty        =       EstimatedQty
  , ActualQty           =   cftPM.ActualQty
  , EstimatedWgt        =   cftPM.EstimatedWgt
  , ActualWgt           =   cftPM.ActualWgt
  , MarketType          =   cftMarketSaleType.Description
  , TrailerWashFlag     =   CASE
                                WHEN cftPM.TrailerWashFlag = 0 THEN ''
                                ELSE 'Y'
                            END
  , Destination         =   DestContact.ShortName
  , DestBarnNbr         =   cftPM.DestBarnNbr
  , DestRoomNbr         =   cftPM.DestRoomNbr
  , Trucker             =   ISNULL( dcpy.TruckingCompanyName, TruckerContact.ShortName )
  , Trailer             =   cftPigTrailer.Description
  , PICWeek             =   cftWeekDefinition.PICWeek
  , ScheduleStatus      =   RTRIM( @ScheduleStatus )
  , WeekOfDate          =   cftWeekDefinition.WeekOfDate
  , Comment             =   NULLIF( cftPM.Comment, '' )
  , DisinfectFlg        =   CASE cftPM.DisinfectFlg
                                WHEN 0 THEN ''
                                ELSE 'Y'
                            END
  , CpnyID              =   cftPM.CpnyID
  , LoadingTime         =   cftPM.LoadingTime
  , ArrivalTime         =   cftPM.ArrivalTime
  , Highlight           =   cftPM.Highlight
  , PFEU                =   cftPM.PFEUEligible
  , SelectedContact     =   SelectedContact.ShortName
  , PigType             =   CASE
                                WHEN cftPM.PigTypeID <> '04' THEN cftPigType.PigTypeDesc
                                ELSE cftMarketSaleType.Description
                            END
  , tattooflag          =   CASE cftPM.TattooFlag
                                WHEN 0 then ''
                                ELSE 'Y'
                            END
  , GiltAge             =   cftPM.GiltAge
  , PMID                =   cftPM.PMID
  , PMLoadID            =   cftPM.PMLoadID
  , PackerDesc          =   ord.Descr
  , SourceMktManager    =   ISNULL( sourceMM.UserID, '' )
  , SourceSvcManager    =   ISNULL( sourceSM.UserID, '' )
  , DestMktManager      =   ISNULL( destMM.UserID, '' )
  , DestSvcManager      =   ISNULL( destSM.UserID, '' )
  , CreatedUser         =   cftPM.Crtd_User

FROM
    [$(SolomonApp)].dbo.cftPM AS cftPM
LEFT JOIN
    [$(SolomonApp)].dbo.cftContact AS SourceContact
        ON cftPM.SourceContactID = SourceContact.ContactID
LEFT JOIN
    [$(SolomonApp)].dbo.cftContact AS DestContact
        ON cftPM.DestContactID = DestContact.ContactID
LEFT JOIN
    [$(CentralData)].dbo.cfv_DriverCompany AS dcpy
        ON CONVERT( int, cftPM.TruckerContactID ) = dcpy.DriverContactID
LEFT JOIN
    [$(SolomonApp)].dbo.cftPigType AS cftPigType
        ON cftPM.PigTypeID = cftPigType.PigTypeID
LEFT JOIN
    [$(SolomonApp)].dbo.cftMarketSaleType AS cftMarketSaleType
        ON cftPM.MarketSaleTypeID = cftMarketSaleType.MarketSaleTypeID
LEFT JOIN
    [$(SolomonApp)].dbo.cftContact AS TruckerContact
        ON cftPM.TruckerContactID = TruckerContact.ContactID
LEFT JOIN
    [$(SolomonApp)].dbo.cftContact AS SelectedContact
        ON SelectedContact.ContactID = @lContactID
LEFT JOIN
    [$(SolomonApp)].dbo.cftPigTrailer AS cftPigTrailer
        ON CONVERT( int, cftPM.PigTrailerID ) = CONVERT( int, cftPigTrailer.PigTrailerID )
LEFT JOIN
    [$(SolomonApp)].dbo.cftWeekDefinition AS cftWeekDefinition
        ON cftPM.MovementDate BETWEEN cftWeekDefinition.WeekOfDate AND cftWeekDefinition.WeekEndDate
LEFT JOIN
    [$(SolomonApp)].dbo.cftPSOrdHdr AS ord
        ON cftPM.OrdNbr = ord.OrdNbr
OUTER APPLY
    [$(SolomonApp)].dbo.cff_tvf_GetSiteServiceManagerData( cftPM.SourceContactID, @lEndDate ) AS sourceSM
OUTER APPLY
    [$(SolomonApp)].dbo.cff_tvf_GetSiteMarketManagerData( cftPM.SourceContactID, @lEndDate ) AS sourceMM
OUTER APPLY
    [$(SolomonApp)].dbo.cff_tvf_GetSiteServiceManagerData( cftPM.DestContactID, @lEndDate ) AS destSM
OUTER APPLY
    [$(SolomonApp)].dbo.cff_tvf_GetSiteMarketManagerData( cftPM.DestContactID, @lEndDate ) AS destMM
WHERE
    cftPM.MovementDate between @lStartDate AND @lEndDate
        AND cftPM.Highlight <> 255
        AND cftPM.Highlight <> -65536
        AND cftPM.PMTypeID = @lPMTypeString
        AND
            (   ( @lPMTypeString = '02' )
                    OR
                ( @lPMTypeString != '02'
                    AND cftPM.PMSystemID IN ( SELECT Item FROM [$(SolomonApp)].dbo.cff_tvf_StringSplitter_varchar( @lPMSystemString, ',' ) )
                )
            ) ;

SELECT
    MovementDate, ID, Source, SourceBarnNbr, SourceRoomNbr, LoadTime, ArriveTime
        , EstimatedQty, EstimatedWgt, MarketType, TrailerWashFlag, Destination
        , DestBarnNbr, DestRoomNbr, Trucker, Trailer, PICWeek, ScheduleStatus
        , WeekOfDate, Comment, DisinfectFlg, CpnyID, LoadingTime, ArrivalTime
        , Highlight, ActualQty, ActualWgt, PFEU, SelectedContact, PigType, TattooFlag
        , GiltAge, PMID, PMLoadID, PackerDesc
FROM
    #Schedule
WHERE
    SourceMktManager            LIKE @UserName_wc
        OR SourceSvcManager     LIKE @UserName_wc
        OR DestMktManager       LIKE @UserName_wc
        OR DestSvcManager       LIKE @UserName_wc
        OR CreatedUser          LIKE @lUserName
ORDER BY
    MovementDate
  , Source
  , LoadingTime  ; --MovementDate, LoadingTime



IF ( @lSendingReportChanges = 'Y' )
    UPDATE
        cft_PM_History
	SET
        SentChanges = 1
	FROM
        dbo.cft_PM_HISTORY AS cft_PM_History
	INNER JOIN
        #Schedule
            ON #Schedule.PMID = cft_PM_History.PMID
                AND #Schedule.PMLoadID = cft_PM_History.PMLoadID ;


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_TRANSPORTATION_SVCMANAGER_SCHEDULE] TO [db_sp_exec]
    AS [dbo];

