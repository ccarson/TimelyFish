--Uncomment these lines for testing SQL inside proc
--:SETVAR     SolomonApp  SolomonApp

CREATE PROCEDURE
    dbo.cfp_MARKET_MANAGER_LOAD_SUMMARY_INSERT
AS
/*
***********************************************************************************************************************************
Procedure:  dbo.cfp_MARKET_MANAGER_LOAD_SUMMARY_INSERT

Purpose:    Create Market Manager Load Summaries from dbo.cft_PACKER_DETAIL
                Used for Market Manager Performance Reports


Change Log:
Date        Who             Change
----------- -----------     -------------------------------------------------------
2016-10-21  ccarson         initial release
***********************************************************************************************************************************
*/

SET NOCOUNT, XACT_ABORT ON ;

DECLARE
    /*  constants */
    @TriumphYldPct          float       = 0.7538
  , @TriumphPacker          varchar(50) = '%Triumph%'
  , @SwiftPacker            varchar(50) = '%Swift%'
  , @IBPPacker              varchar(50) = '%IBP%'
  , @HotWeightLow           float       = 75
  , @HotWeightHigh          float       = 300
  , @LeanPctLow             float       = 45
  , @LeanPctHigh            float       = 62
  , @StdDevLow              float       = 10
  , @StdDevHigh             float       = 55 ;


IF OBJECT_ID( 'tempdb..#qualifyingMarketLoads' ) IS NOT NULL
    DROP TABLE #qualifyingMarketLoads ;

CREATE TABLE
        #qualifyingMarketLoads(
            ID                  INT         NOT NULL    PRIMARY KEY CLUSTERED IDENTITY
          , PMLoadID            CHAR(10)    NOT NULL
          , PMID                CHAR(10)    NOT NULL
          , MarketManagerID     CHAR(06)    NOT NULL
          , MarketSaleTypeID    int         NOT NULL ) ;


WITH
    cteLoadCounts AS(
    --  cteLoadCounts
    --      count separate HotWgt values that occur in a given PMLoadID
    --      loads must meet weight, lean percentage, and date criteria
        SELECT
            PMLoadID
          , CountByWeight   =   CONVERT( float, COUNT(*) OVER( PARTITION BY PMLoadID, HotWgt ) )
          , MarketManagerID =   marketManager.MktMgrContactID
        FROM
            dbo.cft_PACKER_DETAIL AS pDetail
        INNER JOIN
            [$(SolomonApp)].dbo.cfvCurrentMktSvcMgr AS marketManager
                ON marketManager.SiteContactID = pDetail.SiteContactID
        WHERE
            pDetail.HotWgt BETWEEN @HotWeightLow AND @HotWeightHigh
                AND pDetail.LeanPct BETWEEN @LeanPctLow AND @LeanPctHigh )


 --  #qualifyingMarketLoads
 --     SELECT load data for each PMLoadID that passes weight distribution test
 --     weight distribution test:  any single HotWgt count in a load cannot be more than 25% of total head count for load
 --     transform MarketSaleTypeID so that 3d Tops are combined with 2nd tops for reporting
 --     transform MarketSaleTypeID so that Cull/Close loads are combined with Closeout for reporting purposes
INSERT INTO
    #qualifyingMarketLoads( PMLoadID, PMID, MarketManagerID, MarketSaleTypeID )
SELECT DISTINCT
    PMLoadID            =   loads.PMLoadID
  , PMID                =   pigMgmt.PMID
  , MarketManagerID     =   loads.MarketManagerID
  , MarketSaleTypeID    =   CASE marketSale.MarketSaleTypeID
                                WHEN 25 THEN 20
                                WHEN 50 THEN 30
                                ELSE marketSale.MarketSaleTypeID
                            END
FROM
    cteLoadCounts AS loads
INNER JOIN
    [$(SolomonApp)].dbo.cftPM AS pigMgmt
        ON pigMgmt.PMID = loads.PMLoadID
INNER JOIN
    [$(SolomonApp)].dbo.cftMarketSaleType AS marketSale
        ON marketSale.MarketSaleTypeID = pigMgmt.MarketSaleTypeID
GROUP BY
    loads.PMLoadID, pigMgmt.PMID, loads.MarketManagerID, marketSale.MarketSaleTypeID
HAVING
    MAX( loads.CountByWeight ) / COUNT(*) < .250 ;

TRUNCATE TABLE 
	dbo.cft_REPORT_MARKET_MANAGER_LOAD_SUMMARY ;


WITH
    ctePackerDetail AS(
    --  ctePackerDetail
    --      SELECT detail data for qualifying PMLoadIDs
    --      use only detail records that meet weight, lean percentage and date parameters
    --      transform packer name for certain swift contracts and packers
    --      transform MarketSaleTypeID to separate closeouts by packer
    --      Triumph packers assigned constant yield pct instead of calculated yield pct
        SELECT
            Site                =   siteContact.ContactName
          , PigGroupID          =   pDetail.PigGroupID
          , KillDate            =   pDetail.KillDate
          , Packer              =   CASE
                                        WHEN packerContact.ContactName LIKE @SwiftPacker THEN
                                            CASE swiftContract.ContractNumber
                                                WHEN '000010' THEN 'Swift Light'
                                                WHEN '000023' THEN 'Swift Heavy'
                                                ELSE packerContact.ContactName
                                            END
                                        ELSE packerContact.ContactName
                                    END
          , BarnNbr             =   pDetail.BarnNbr
          , BarnLoadID          =   pDetail.PMLoadID
          , PMLoadID            =   marketLoads.PMID
          , TotalHead           =   pDetail.TotalHead
          , HotWgt
          , YldPct              =   CASE WHEN packerContact.ContactName LIKE @TriumphPacker THEN @TriumphYldPct ELSE pDetail.YldPct END
          , LiveWeight          =   HotWgt / CASE WHEN packerContact.ContactName LIKE @TriumphPacker THEN @TriumphYldPct ELSE pDetail.YldPct END
          , CarcassID           =   pDetail.CarcassID
          , MarketSaleTypeID    =   CASE marketLoads.MarketSaleTypeID
                                        WHEN 30 THEN    CASE
                                                            WHEN packerContact.ContactName LIKE @IBPPacker     THEN 301
                                                            WHEN packerContact.ContactName LIKE @SwiftPacker   THEN 302
                                                            WHEN packerContact.ContactName LIKE @TriumphPacker THEN 303
                                                        END
                                        ELSE marketLoads.MarketSaleTypeID
                                    END
          , MarketManagerID     =   marketLoads.MarketManagerID
        FROM
            dbo.cft_PACKER_DETAIL AS pDetail
        INNER JOIN
            #qualifyingMarketLoads AS marketLoads
                ON marketLoads.PMLoadID = pDetail.PMLoadID
        INNER JOIN
            [$(SolomonApp)].dbo.cftContact AS packerContact
                ON packerContact.ContactID = pDetail.PkrContactID
        INNER JOIN
            [$(SolomonApp)].dbo.cftContact AS siteContact
                ON siteContact.ContactID = pDetail.SiteContactID
        OUTER APPLY(
            SELECT DISTINCT
                ContractNumber = pigSales.ContrNbr
            FROM
                [$(SolomonApp)].dbo.cfvPIGSALEREV AS pigSales
            INNER JOIN
                [$(SolomonApp)].dbo.cftPSDetSwift AS swiftDetail
                    ON swiftDetail.KillDate = pigSales.KillDate
                        AND swiftDetail.TattooNbr   = pigSales.TattooNbr
                        AND CASE swiftDetail.PlantNbr WHEN '00048' THEN '000554' ELSE '000555' END = pigSales.PkrContactId
            WHERE
                pigSales.PkrContactId IN ( '000554', '000555' )
                    AND pigSales.ContrNbr IN ( '000023', '000010' )
                    AND swiftDetail.RecordID = pDetail.CarcassID ) AS swiftContract

        WHERE
            pDetail.HotWgt BETWEEN @HotWeightLow AND @HotWeightHigh
                AND pDetail.LeanPct BETWEEN @LeanPctLow AND @LeanPctHigh )


INSERT INTO
    dbo.cft_REPORT_MARKET_MANAGER_LOAD_SUMMARY(
        MarketManagerID, MarketSaleTypeID, PMLoadID, Site, PigGroupID, KillDate, Packer, BarnNbr
            , BarnLoadID, TotalHead, HotWgt, LiveWgtAvg, LiveWgtStdDev, WghtdStdDev, WghtdAvgWgt, PicYrWk )
SELECT
    MarketManagerID         =   MarketManagerID
  , MarketSaleTypeID        =   MarketSaleTypeID
  , PMLoadID                =   PMLoadID
  , Site                    =   Site
  , PigGroupID              =   PigGroupID
  , KillDate                =   KillDate
  , Packer                  =   Packer
  , BarnNbr                 =   BarnNbr
  , BarnLoadID              =   BarnLoadID
  , TotalHead               =   SUM( TotalHead )
  , HotWgt                  =   AVG( HotWgt )
  , LiveWgtAvg              =   AVG( LiveWeight )
  , LiveWgtStdDev           =   STDEV( LiveWeight )
  , WghtdStdDev             =   STDEV( HotWgt / YldPct ) * SUM( TotalHead )
  , WghtdAvgWgt             =   AVG( HotWgt / YldPct ) * SUM( TotalHead )
  , PicYrWk                 =   CONVERT( char(06), ddw.PICYear_Week )
FROM
    ctePackerDetail
INNER JOIN
    [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo AS ddw
        ON ddw.DayDate = ctePackerDetail.KillDate
GROUP BY
    Site, PigGroupID, KillDate, Packer, BarnNbr, BarnLoadID, PMLoadID, MarketManagerID, MarketSaleTypeID, ddw.PICYear_Week
HAVING
    STDEV( LiveWeight ) BETWEEN @StdDevLow AND @StdDevHigh ;