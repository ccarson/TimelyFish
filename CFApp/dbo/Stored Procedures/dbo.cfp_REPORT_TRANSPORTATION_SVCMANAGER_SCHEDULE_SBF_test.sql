

-- =============================================
-- Author:  Doran Dahle
-- Create date: 2/1/2016
-- Description: Senior Service\Service\Market Manager Transportation Schedule for the SBF sale
-- Parameters:
--      @ContactID,
--      @PMTypeID, (specifies all(00), internal(01), or market(02)
--      @PMSystemID (specifies all(00), multiplication(01), or commericialHH(02);
--              commercialHH has consolidated data values for IA and SE 02&03
--      NOTE: @PMSystemID is always = '%'
-- Change:  Increased Trucker field to varchar(50) from (30) (ddahle) 03/28/2016
-- =============================================
CREATE PROCEDURE
    [dbo].[cfp_REPORT_TRANSPORTATION_SVCMANAGER_SCHEDULE_SBF_test] (
        @ContactID      int
      , @PMTypeString   varchar(2)
      , @Days           int )
AS

SET NOCOUNT, XACT_ABORT ON ;

DECLARE
    @lContactID     CHAR(06)    =   RIGHT( '000000' + CONVERT( varchar(12), @ContactID ), 6 )
  , @lPMTypeString  varchar(02) =   @PMTypeString
  , @lDays          int         =   @Days ;

DECLARE
    @StartDate      datetime        =   CONVERT( date, GETDATE() )
  , @SundayDate     datetime
  , @EndDate        datetime
  , @SQLString      nvarchar(4000) ;


SELECT
    @SundayDate = WeekOfDate
FROM
    [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo
WHERE
    DayDate = @StartDate ;

SELECT
    @EndDate = WeekEndDate
FROM
    [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo
WHERE
    DayDate = DATEADD( day, @lDays, @SundayDate ) ;

IF OBJECT_ID( 'tempdb..#Schedule' ) IS NOT NULL
    DROP TABLE #Schedule ;

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
      , tattooflag          char(1)
      , GiltAge             char(10)
      , PMID                char(10)
      , PMLoadID            char(10)
      , PackerDesc          char(30)
      , SourceMktSvcManager char(06)
      , SourceSvcManager    char(06)
      , SourceSrSvcManager  char(06)
      , DestMktSvcManager   char(06)
      , DestSvcManager      char(06)
      , DestSrSvcManager    char(06) ) ;

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
  , ScheduleStatus      =   'Projected Draft'
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
  , tattooflag          =   CASE cftPM.tattooflag
                                WHEN 0 then ''
                                ELSE 'Y'
                            END
  , GiltAge             =   cftPM.GiltAge
  , PMID                =   cftPM.PMID
  , PMLoadID            =   cftPM.PMLoadID
  , PackerDesc          =   ord.Descr
  , SourceMktSvcManager =   ISNULL( source.MarketManagerID, '' )
  , SourceSvcManager    =   ISNULL( source.ServiceManagerID, '' )
  , SourceSrSvcManager  =   ISNULL( source.SeniorServiceManagerID, '' )
  , DestMktSvcManager   =   ISNULL( dest.MarketManagerID, '' )
  , DestSvcManager      =   ISNULL( dest.ServiceManagerID, '' )
  , DestSrSvcManager    =   ISNULL( dest.SeniorServiceManagerID, '' )

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
    [$(SolomonApp)].dbo.cff_tvf_GetServiceManagerData_SBF( cftPM.SourceContactID, @EndDate ) AS source
OUTER APPLY
    [$(SolomonApp)].dbo.cff_tvf_GetServiceManagerData_SBF( cftPM.DestContactID, @EndDate ) AS dest
WHERE
    cftPM.MovementDate BETWEEN @StartDate AND @EndDate
        AND ISNULL( NULLIF( @PMTypeString, '00' ), '%' ) = cftPM.PMTypeID
        AND cftPM.Highlight <> 255
        AND cftPM.Highlight <> -65536 ;

SELECT
    MovementDate, ID, Source, SourceBarnNbr, SourceRoomNbr
        , LoadTime, ArriveTime, EstimatedQty, EstimatedWgt, MarketType
        , TrailerWashFlag, Destination, DestBarnNbr, DestRoomNbr, Trucker
        , Trailer, PICWeek, ScheduleStatus, WeekOfDate, Comment
        , DisinfectFlg, CpnyID, LoadingTime, ArrivalTime, Highlight
        , ActualQty, ActualWgt, PFEU, SelectedContact, PigType
        , tattooflag, GiltAge, PMID, PMLoadID, PackerDesc
FROM
    #Schedule
WHERE
    SourceMktSvcManager = @lContactID
        OR SourceSvcManager    = @lContactID
        OR SourceSrSvcManager  = @lContactID
        OR DestMktSvcManager   = @lContactID
        OR DestSvcManager      = @lContactID
        OR DestSrSvcManager    = @lContactID
ORDER BY
    MovementDate
  , LoadingTime ;
