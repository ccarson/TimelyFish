--Uncomment these lines for testing SQL inside proc

--:SETVAR     SolomonApp  SolomonApp
--DECLARE
--    @pNumDetailWeeks            int         = 13
--  , @pMarketManagerID           char(06)    = '005491' ;

CREATE PROCEDURE
    [dbo].[cfp_REPORT_MarketManagerPerformance](
        @pNumDetailWeeks    int
      , @pMarketManagerID   char(06) )
AS
/*
************************************************************************************************************************************

  Procedure:    dbo.cfp_REPORT_MarketManagerPerformance
     Author:    Chris Carson
    Created:    2016-10-04
    Purpose:    Extract Market sales statistics for reporting


    Revision History:
    revisor         date                description
    ---------       -----------         ----------------------------
    bdiehl          2016-03-16          created
    ccarson         2016-10-04          revised, updated, refactored for performance

    Notes:
        Reference for color names: http://ascii-code.com/html-color-names.php

************************************************************************************************************************************
*/

SET NOCOUNT, XACT_ABORT ON ;

DECLARE
    /*  local variables to receive proc parameters */
    @lNumDetailWeeks        int         = @pNumDetailWeeks
  , @lMarketManagerID       char(06)    = @pMarketManagerID

    /*  date parameters that establish date ranges for extract */
  , @TodaysDate             datetime    = CONVERT( date, GETDATE() )
  , @PriorWeekSunday        datetime
  , @StartingSundayDate     datetime
  , @EndingSaturdayDate     datetime ;


/*
    DATE DEFINITIONS:
        TodaysDate          -- midnight of current day
        PriorWeekSunday     -- one week prior to first day of current week
        StartingSundayDate  -- variable number of weeks prior to first day of current week
        EndingSaturdayDate  -- one day before first day of current week
*/
SELECT
    @PriorWeekSunday        = DATEADD( ww, -1, WeekOfDate )
  , @StartingSundayDate     = DATEADD( ww, - @lNumDetailWeeks, WeekOfDate )
  , @EndingSaturdayDate     = DATEADD( d, -1, WeekOfDate )
FROM
    [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo
WHERE
    DayDate = @TodaysDate ;


IF OBJECT_ID( 'tempdb..#reportSummary' ) IS NOT NULL
    DROP TABLE #reportSummary ;

CREATE TABLE
    #reportSummary(
            ID                  INT             NOT NULL    IDENTITY    PRIMARY KEY CLUSTERED
          , Site                CHAR(50)        NOT NULL
          , PigGroupID          CHAR(10)        NOT NULL
          , KillDate            SMALLDATETIME   NOT NULL
          , Packer              CHAR(50)        NOT NULL
          , BarnNbr             CHAR(10)        NOT NULL
          , BarnLoadID          CHAR(10)        NOT NULL
          , PMLoadID            CHAR(10)        NOT NULL
          , TotalHead           INT             NOT NULL
          , HotWgt              FLOAT           NOT NULL
          , LiveWgtAvg          FLOAT           NOT NULL
          , LiveWgtStdDev       FLOAT           NOT NULL
          , WghtdStdDev         FLOAT           NOT NULL
          , WghtdAvgWgt         FLOAT           NOT NULL
          , MarketSaleTypeID    INT             NOT NULL
          , MarketManagerID     CHAR(06)        NOT NULL
          , ResultSetID         INT             NOT NULL
          , ReportingSeptile    INT             NOT NULL
          , PicYrWk             CHAR(06)        NOT NULL ) ;


--  #reportSummary
--      INSERT requested market data into temp storage
--          ResultSetID assigns row numbers to all non-current market loads
INSERT INTO
    #reportSummary(
        Site, PigGroupID, KillDate, Packer, BarnNbr, BarnLoadID, PMLoadID, TotalHead, HotWgt, LiveWgtAvg
            , LiveWgtStdDev, WghtdStdDev, WghtdAvgWgt, MarketSaleTypeID, MarketManagerID, PicYrWk
            , ReportingSeptile, ResultSetID )

SELECT
    Site                =   summary.Site
  , PigGroupID          =   summary.PigGroupID
  , KillDate            =   summary.KillDate
  , Packer              =   summary.Packer
  , BarnNbr             =   summary.BarnNbr
  , BarnLoadID          =   summary.BarnLoadID
  , PMLoadID            =   summary.PMLoadID
  , TotalHead           =   summary.TotalHead
  , HotWgt              =   summary.HotWgt
  , LiveWgtAvg          =   summary.LiveWgtAvg
  , LiveWgtStdDev       =   summary.LiveWgtStdDev
  , WghtdStdDev         =   summary.WghtdStdDev
  , WghtdAvgWgt         =   summary.WghtdAvgWgt
  , MarketSaleTypeID    =   summary.MarketSaleTypeID
  , MarketManagerID     =   summary.MarketManagerID
  , PicYrWk             =   summary.PicYrWk
  , ReportingSeptile    =   0
  , ResultSetID         =   CASE ISNULL( NULLIF( DATEDIFF( ww, @PriorWeekSunday, ddw.WeekOfDate ), 1 ), 0 )
                                WHEN 0 THEN 0
                                ELSE ROW_NUMBER() OVER( PARTITION BY    summary.MarketManagerID, summary.MarketSaleTypeID
                                                        ORDER BY        summary.KillDate )
                            END
    FROM
        dbo.cft_REPORT_MARKET_MANAGER_LOAD_SUMMARY AS summary
    INNER JOIN
        [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo AS ddw
            ON ddw.DayDate = summary.KillDate
    WHERE
        summary.KillDate BETWEEN @StartingSundayDate AND @EndingSaturdayDate
            AND MarketManagerID = @lMarketManagerID ;


--  #reportSummary
--      UPDATE ReportingSeptile to divide non-current loads into seven equal parts for reporting purposes
WITH
    septiles AS(
        SELECT  *, N = NTILE( 7 ) OVER ( PARTITION BY MarketManagerID, MarketSaleTypeID ORDER BY ResultSetID DESC )
        FROM    #reportSummary
        WHERE   ResultSetID != 0 )

UPDATE
    septiles
SET
    ReportingSeptile = N ;


--  #reportSummary
--      assign color scheme based on ReportingSeptile
--      calculate weekly avg std dev and avg live weight for trend purposes
SELECT
    Site
  , PigGroupID
  , KillDate
  , Packer
  , BarnNbr
  , BarnLoadID
  , PMLoadID
  , TotalHead
  , HotWgt
  , LiveWgtAvg
  , LiveWgtStdDev
  , MarketSaleTypeID
  , MarketManagerID
  , PicYrWk
  , ReportingColor          =   CASE ReportingSeptile
                                    WHEN 0 THEN 'green'
                                    WHEN 1 THEN 'brown'
                                    WHEN 2 THEN 'sienna'
                                    WHEN 3 THEN 'peru'
                                    WHEN 4 THEN 'goldenrod'
                                    WHEN 5 THEN 'tan'
                                    WHEN 6 THEN 'wheat'
                                    WHEN 7 THEN 'cornsilk'
                                    ELSE 'silver'
                                END
  , PrWkAvgWeightedStdDev   =   CASE ResultSetID
                                    WHEN 0 THEN CONVERT( decimal( 5, 2 ), AVG( WghtdStdDev ) OVER( PARTITION BY MarketManagerID, MarketSaleTypeID, ResultSetID  ) / AVG( TotalHead ) OVER( PARTITION BY MarketManagerID, MarketSaleTypeID, ResultSetID  ) )
                                    ELSE 0
                                END
  , PrWkAvgWeightedWgtAvg   =   CASE ResultSetID
                                    WHEN 0 THEN CONVERT( decimal( 4, 1 ), AVG( WghtdAvgWgt ) OVER( PARTITION BY MarketManagerID, MarketSaleTypeID, ResultSetID ) / AVG( TotalHead ) OVER( PARTITION BY MarketManagerID, MarketSaleTypeID, ResultSetID  ) )
                                    ELSE 0
                                END
  , WkAvgWeightedStdDev     =   AVG( WghtdStdDev ) OVER( PARTITION BY MarketManagerID, MarketSaleTypeID, PicYrWk ) / AVG( TotalHead ) OVER( PARTITION BY MarketManagerID, MarketSaleTypeID, PicYrWk )
  , WkAvgWeightedWgtAvg     =   AVG( WghtdAvgWgt ) OVER( PARTITION BY MarketManagerID, MarketSaleTypeID, PicYrWk ) / AVG( TotalHead ) OVER( PARTITION BY MarketManagerID, MarketSaleTypeID, PicYrWk )

FROM
    #reportSummary ;


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_MarketManagerPerformance] TO [CorpReports]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_MarketManagerPerformance] TO [db_sp_exec]
    AS [dbo];

