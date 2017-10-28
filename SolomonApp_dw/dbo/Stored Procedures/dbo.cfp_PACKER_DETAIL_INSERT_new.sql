CREATE PROCEDURE 
	[dbo].[cfp_PACKER_DETAIL_INSERT_new]
AS
/*
***********************************************************************************************************************************
Procedure:	dbo.CFP_PACKER_DETAIL_INSERT

Purpose:	ETL proc that brings SolomonApp packer detail data into SolomonApp_dw


Change Log:
Date        Who				Change
----------- -----------		-------------------------------------------------------
2011-08-02	Mike Zimanski	initial release
2011-08-04  Dan Bryskin		Put it in the template, performance optimizations
2013-04-03  sripley			added salebasis to diff live and carcass weight, affecting yldpct
2016-09-25	ccarson			Removed old template, cleaned up SQL, expanded summarized Tyson records
***********************************************************************************************************************************
*/

SET NOCOUNT, XACT_ABORT ON ;

DECLARE	@KillDateExtract smalldatetime ; 

--	@KillDateExtract 
--		Ensure at least 18 months of data, going back to either first day of last year or first day two years ago
IF	MONTH( GETDATE() ) > 6 
	SELECT @KillDateExtract = CONVERT( smalldatetime, '1/1/' + CONVERT( VARCHAR(04), YEAR( GETDATE() ) - 1 ) ) ;
ELSE
	SELECT @KillDateExtract = CONVERT( smalldatetime, '1/1/' + CONVERT( VARCHAR(04), YEAR( GETDATE() ) - 2 ) ) ;


--	#YieldPercentage
--		SELECT Yield percetnages by load from SolomonApp 
IF OBJECT_ID( 'tempdb..#YieldPercentage' ) IS NOT NULL
	DROP TABLE #YieldPercentage ;

SELECT 
	PMLoadId
  , SaleBasis
  , YldPct	  =	CASE 
					WHEN SUM( DelvLiveWgt ) = 0 OR SUM( DelvCarcWgt ) = 0 THEN 0.77 
					ELSE SUM( DelvCarcWgt ) / SUM( DelvLiveWgt ) 
				END 
INTO
	#YieldPercentage
FROM 
	[$(SolomonApp)].dbo.cfvPIGSALEREV
WHERE 
	SaleTypeId = 'MS'
GROUP BY
	PMLoadId, SaleBasis ; 
	

/*
	2)	SELECT Market Sales from SolomonApp into temp storage
*/
IF OBJECT_ID( 'tempdb..#MarketSales' ) IS NOT NULL
	DROP TABLE #MarketSales ;

SELECT DISTINCT
	PMLoadId
    , SiteContactID
    , BarnNbr
    , PigGroupID
    , PkrContactId
    , KillDate
    , TattooNbr
    , SaleBasis				
INTO
	#MarketSales
FROM 
	[$(SolomonApp)].dbo.cfvPIGSALEREV
WHERE 
	SaleTypeID = 'MS' ;  


/*
    3)  Find eligible input detail files
*/
SELECT 
    DetailFile      =   inputfilename
  , FileChecksum    =   sum( cast( tstamp AS BIGINT ) )
INTO
    #InputFiles
FROM
    [$(SolomonApp)].dbo.cftPSDetTriumph           
WHERE 
    KillDate > = @KillDateExtract
GROUP BY inputfilename ;


INSERT INTO
    #InputFiles
SELECT 
    DetailFile      =   inputfilename
  , FileChecksum    =   sum( cast( tstamp AS BIGINT ) )
FROM
    [$(SolomonApp)].dbo.cftPSDetSwift        
WHERE 
    KillDate > = @KillDateExtract
GROUP BY inputfilename ;


INSERT INTO
    #InputFiles
SELECT 
    DetailFile      =   inputfilename
  , FileChecksum    =   sum( cast( tstamp AS BIGINT ) )
FROM
    [$(SolomonApp)].dbo.cftPSDetSwift        
WHERE 
    KillDate > = @KillDateExtract
GROUP BY inputfilename ;


/*
    4) 
*/






TRUNCATE TABLE 
	dbo.cft_PACKER_DETAIL ;

ALTER INDEX ALL ON dbo.cft_PACKER_DETAIL DISABLE ; 

/*
	3)	INSERT Triumph packer detail
*/
WITH
    cteTriumph AS( 
        SELECT 
        	  CarcassID	  =	RecordID 		
        	, PlantID  	  =	CONVERT( CHAR(06), '002936' ) 
        	, KillDate 	  =	KillDate 		
        	, TattooNbr	  =	TattooNbr 	
        	, HotWgt   	  =	HotWgt 		
        	, LeanPct	  =	LeanPct
        FROM 
        	[$(SolomonApp)].dbo.cftPSDetTriumph
        WHERE 
        	KillDate >= @KillDateExtract )
--INSERT INTO 
--	dbo.cft_PACKER_DETAIL(	
--		CarcassID
--	   , KillDate
--	   , PMLoadID
--	   , SiteContactID
--	   , BarnNbr
--	   , PigGroupID
--	   , PkrContactID
--	   , TotalHead
--	   , HotWgt
--	   , LeanPct
--	   , YldPct )
SELECT 
	dtl.CarcassID
  , ms.KillDate
  , ms.PMLoadId
  , ms.SiteContactID
  , ms.BarnNbr
  , ms.PigGroupID
  , ms.PkrContactId
  , 1  
  , dtl.HotWgt
  , dtl.LeanPct
  , yp.YldPct 
FROM 
	cteTriumph AS dtl
LEFT JOIN
	#MarketSales AS ms
		ON ms.PkrContactId = dtl.PlantID
			AND ms.KillDate = dtl.KillDate
			AND ms.TattooNbr = dtl.TattooNbr
LEFT JOIN
	#YieldPercentage AS yp 
		ON yp.PMLoadId = ms.PMLoadId 
			AND yp.SaleBasis = ms.SaleBasis ; 


/*
	4)	INSERT Swift packer detail into temp storage
*/
INSERT INTO	
	#PackerDetail
SELECT 
	CarcassID	  =	RecordID 
  , PlantID  	  =	CONVERT( CHAR(06), CASE WHEN PlantNbr = 48 THEN '000554' ELSE '000555' END ) 
  , KillDate 	  =	KillDate
  , TattooNbr	  =	TattooNbr
  , HotWgt   	  =	HotWeight 
  , LeanPct	 	  =	LeanPct
FROM 
	[$(SolomonApp)].dbo.cftPSDetSwift
WHERE 
	KillDate >= @KillDateExtract 
		AND ExceptionCode NOT IN ('N','C','X','D') ; 


/*
	5)	INSERT Tyson packer detail into temp storage
		
	Notes:  
		Records here are expanded, such that proc inserts multiple records for each summary record from Tyson 
		Numbers table is used to expand the records from the Tyson detail table on SolomonApp
*/
WITH cteNumbers AS( 
	SELECT TOP 500 NumRecords = ROW_NUMBER() OVER( ORDER BY ( SELECT NULL ) ) - 1
	FROM sys.objects a, sys.objects b, sys.objects c ) 

INSERT INTO
	#PackerDetail
SELECT
	CarcassID	  =	t.RecordID 
  , PlantID  	  =	CONVERT( CHAR(06), '000823' )
  , KillDate 	  =	t.KillDate 
  , TattooNbr	  =	t.Tattoo 
  , HotWgt   	  =	CASE t.TotalHead 
						WHEN 0 THEN 0 
						ELSE t.HotCarcassWeight / t.TotalHead 
					END 
  , LeanPct	 	  =	t.AvgLeanPercent
FROM 
	[$(SolomonApp)].dbo.cftPSDetTyson AS t
INNER JOIN 
	cteNumbers AS n
		ON n.NumRecords < t.TotalHead 
WHERE 
	t.KillDate >= @KillDateExtract ; 

CREATE UNIQUE CLUSTERED INDEX IX_DetailTemp ON #PackerDetail( 
    PlantID, KillDate, TattooNbr, ID, CarcassID, HotWgt, LeanPct ) ; 


/*
	6)	INSERT packer detail data from temp storage
*/
TRUNCATE TABLE 
	dbo.cft_PACKER_DETAIL ;

ALTER INDEX ALL ON dbo.cft_PACKER_DETAIL DISABLE ; 

INSERT INTO 
	dbo.cft_PACKER_DETAIL(	
		CarcassID
	   , KillDate
	   , PMLoadID
	   , SiteContactID
	   , BarnNbr
	   , PigGroupID
	   , PkrContactID
	   , TotalHead
	   , HotWgt
	   , LeanPct
	   , YldPct )

SELECT 
	dtl.CarcassID
  , ms.KillDate
  , ms.PMLoadId
  , ms.SiteContactID
  , ms.BarnNbr
  , ms.PigGroupID
  , ms.PkrContactId
  , 1  
  , dtl.HotWgt
  , dtl.LeanPct
  , yp.YldPct 
FROM 
	#PackerDetail AS dtl
LEFT JOIN
	#MarketSales AS ms
		ON ms.PkrContactId = dtl.PlantID
			AND ms.KillDate = dtl.KillDate
			AND ms.TattooNbr = dtl.TattooNbr
LEFT JOIN
	#YieldPercentage AS yp 
		ON yp.PMLoadId = ms.PMLoadId 
			AND yp.SaleBasis = ms.SaleBasis ; 

ALTER INDEX ALL ON dbo.cft_PACKER_DETAIL REBUILD ; 
