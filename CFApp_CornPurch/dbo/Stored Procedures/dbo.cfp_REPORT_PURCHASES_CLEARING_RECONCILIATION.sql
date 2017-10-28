
CREATE PROCEDURE 
    dbo.cfp_REPORT_PURCHASES_CLEARING_RECONCILIATION( 
        @FeedMillID         AS char(10)
      , @DeliveryDateStart  AS datetime
      , @DeliveryDateEnd    AS datetime )
/*
***********************************************************************************************************************************
    Procedure:      cfp_REPORT_PURCHASES_CLEARING_RECONCILIATION
    Author:         Sergey Neskin
    Date:           2008-09-10
    
    Description:    Select data for Purchases Clearing Reconciliation Report
    
    Revision
    2008-09-10      Sergey Neskin
                        Original source code
    2016-12-29      Chris Carson
                        refactored code for efficiency and legibility
                        removed scalar functions that called dbo.cffn_CORN_PURCHASING_GET_CORN_PRICE_FOR_TICKET
                        
    Procedure Logic:
        1)  INSERT daily corn prices from feed mills into temp storage  
        2)  INSERT deferred dry bushels data into temp storage 
        3)  INSERT on hold bushels data into temp storage 
        4)  INSERT unpriced bushels data into temp storage 
        5)  SELECT report data from temp storage
                        
***********************************************************************************************************************************
*/
AS

SET NOCOUNT, XACT_ABORT ON ;

/*
    Local variables that receive proc parameters -- prevents parameter sniffing issues
*/
DECLARE 
    @lFeedMillID         AS char(10)    =   @FeedMillID              
  , @lDeliveryDateStart  AS datetime    =   @DeliveryDateStart
  , @lDeliveryDateEnd    AS datetime    =   @DeliveryDateEnd ; 

  
/*  
    1)  INSERT daily corn prices from feed mills into temp storage  
*/
IF OBJECT_ID( 'tempdb..#dailyCornPrice' ) IS NOT NULL 
    DROP TABLE #dailyCornPrice ;

CREATE TABLE 
    #dailyCornPrice( 
        FeedMillID  char(10)
      , PriceDate   datetime
      , CornPrice   decimal(23, 4) ) ; 

WITH 
    ctePrices AS( 
        SELECT 
            FeedMillID  =   dailyPrice.FeedMillID
          , PriceDate   =   dailyPrice.[Date]
          , CornPrice   =   pDetail.Price
          , N           =   ROW_NUMBER() OVER( PARTITION BY pDetail.DailyPriceID ORDER BY DailyPriceDetailID )
        FROM 
            dbo.cft_DAILY_PRICE AS dailyPrice
        INNER JOIN
            dbo.cft_DAILY_PRICE_DETAIL AS pDetail
                ON pDetail.DailyPriceID = dailyPrice.DailyPriceID
        WHERE 
            dailyPrice.approved = 1 
                AND dailyPrice.[Date] BETWEEN @lDeliveryDateStart AND @lDeliveryDateEnd ) 
INSERT INTO 
    #dailyCornPrice( FeedMillID, PriceDate , CornPrice )
SELECT  
    FeedMillID, PriceDate , CornPrice 
FROM    
    ctePrices 
WHERE 
    N = 1 ; 


/*  
    2)  INSERT deferred dry bushels data into temp storage 
*/
IF OBJECT_ID( 'tempdb..#workTable' ) IS NOT NULL 
    DROP TABLE #workTable ;

CREATE TABLE 
    #workTable( 
        ClassificationID    tinyint 
      , Classification		varchar(30)
      , PartialTicketID     int 
      , DeliveryDate        datetime
      , PaymentTypeID       int
      , ContractID          int
      , Futures             money
      , PricedBasis         money
      , QuoteID             int
      , QuotePrice          money
      ,	FeedMillName		varchar(50) 
      , CornProducerName	char(30) 
      , VendorID			char(15) 
      , DryBushels			decimal(18,4) 
      , cornPrice           decimal(23,4) 
      , ValuePrice          decimal(10,4) ) ; 

INSERT INTO 
    #workTable( 
        ClassificationID    
      , Classification		
      , PartialTicketID     
      , DeliveryDate        
      , PaymentTypeID       
      , ContractID          
      , Futures             
      , PricedBasis         
      , QuoteID             
      , QuotePrice          
      ,	FeedMillName		
      , CornProducerName	
      , VendorID			
      , DryBushels			
      , cornPrice           
      , ValuePrice ) 
SELECT 
	ClassificationID	=	CONVERT( tinyint, 1 )
  , Classification		=	'Deferred Dry Bushels' 
  , PartialTicketID     =   pTicket.PartialTicketID
  , DeliveryDate        =   pTicket.DeliveryDate        
  , PaymentTypeID       =   pTicket.PaymentTypeID
  , ContractID          =   contract.ContractID
  , Futures             =   contract.Futures
  , PricedBasis         =   contract.PricedBasis
  , QuoteID             =   quote.QuoteID
  , QuotePrice          =   quote.Price
  ,	FeedMillName		=	feedMill.Name
  , CornProducerName	=	vendor.RemitName
  , VendorID			=	vendor.VendId
  , DryBushels			=	pTicket.DryBushels
  , cornPrice           =   CASE 
                                WHEN pTicket.PaymentTypeID = 2 AND contract.Futures IS NOT NULL AND contract.PricedBasis IS NOT NULL THEN contract.Futures + contract.PricedBasis
                                WHEN pTicket.QuoteID IS NOT NULL THEN quote.Price
                                ELSE cornPrice.CornPrice
                            END
  , ValuePrice          =	iBatch.ValuePrice
FROM 
	dbo.cft_PARTIAL_TICKET AS pTicket
INNER JOIN 
	dbo.cft_CORN_TICKET AS fullTicket
		ON fullTicket.TicketID = pTicket.FullTicketID
INNER JOIN 
	dbo.cft_FEED_MILL AS feedMill 
		ON feedMill.FeedMillID = fullTicket.FeedMillID
INNER JOIN
    [$(SolomonApp)].dbo.Vendor AS vendor 
        ON vendor.VendId = pTicket.CornProducerID
INNER JOIN 
	dbo.cft_CONTRACT AS contract 
		ON contract.ContractID = pTicket.ContractID
INNER JOIN 
	dbo.cft_CONTRACT_TYPE AS cType 
		ON cType.ContractTypeID = contract.ContractTypeID
LEFT JOIN
    dbo.cft_QUOTE AS quote 
        ON quote.QuoteID = pTicket.QuoteID 
LEFT JOIN 
	dbo.cft_INVENTORY_BATCH AS iBatch
		ON iBatch.PartialTicketID = pTicket.PartialTicketID
CROSS APPLY( 
    SELECT  TOP 1 CornPrice
    FROM    #dailyCornPrice
    WHERE   FeedMillID = fullTicket.FeedMillID AND CONVERT( date, pTicket.DeliveryDate ) !< PriceDate
    ORDER BY PriceDate DESC ) AS cornPrice
WHERE 
	pTicket.SentToAccountsPayable != 1 
		AND cType.DeferredPayment = 1
		AND ISNULL( NULLIF( @FeedMillID, '%' ), feedMill.FeedMillID ) = feedMill.FeedMillID
		AND CONVERT( date, pTicket.DeliveryDate ) BETWEEN @DeliveryDateStart AND @DeliveryDateEnd ;    


/*  
    3)  INSERT on hold bushels data into temp storage 
*/
INSERT INTO 
    #workTable( 
        ClassificationID    
      , Classification		
      , PartialTicketID     
      , DeliveryDate        
      , PaymentTypeID       
      , ContractID          
      , Futures             
      , PricedBasis         
      , QuoteID             
      , QuotePrice          
      ,	FeedMillName		
      , CornProducerName	
      , VendorID			
      , DryBushels			
      , cornPrice           
      , ValuePrice ) 
SELECT 
	ClassificationID	=	CONVERT( tinyint, 2 )
  , Classification		=	'On Hold Bushels' 
  , PartialTicketID     =   pTicket.PartialTicketID
  , DeliveryDate        =   pTicket.DeliveryDate        
  , PaymentTypeID       =   pTicket.PaymentTypeID
  , ContractID          =   contract.ContractID
  , Futures             =   contract.Futures
  , PricedBasis         =   contract.PricedBasis
  , QuoteID             =   quote.QuoteID
  , QuotePrice          =   quote.Price
  ,	FeedMillName		=	feedMill.Name
  , CornProducerName	=	vendor.RemitName
  , VendorID			=	vendor.VendId
  , DryBushels			=	pTicket.DryBushels
  , cornPrice           =   CASE 
                                WHEN pTicket.PaymentTypeID = 2 AND contract.Futures IS NOT NULL AND contract.PricedBasis IS NOT NULL THEN contract.Futures + contract.PricedBasis
                                WHEN pTicket.QuoteID IS NOT NULL THEN quote.Price
                                ELSE cornPrice.CornPrice
                            END
  , ValuePrice          =	iBatch.ValuePrice
FROM 
	dbo.cft_PARTIAL_TICKET AS pTicket
INNER JOIN 
	dbo.cft_CORN_TICKET AS fullTicket
		ON fullTicket.TicketID = pTicket.FullTicketID
INNER JOIN 
	dbo.cft_FEED_MILL AS feedMill 
		ON feedMill.FeedMillID = fullTicket.FeedMillID
INNER JOIN 
    [$(SolomonApp)].dbo.Vendor AS vendor 
        ON vendor.VendId = pTicket.CornProducerID
LEFT JOIN 
	dbo.cft_CONTRACT AS contract 
		ON contract.ContractID = pTicket.ContractID
LEFT JOIN 
	dbo.cft_CONTRACT_TYPE AS cType 
		ON cType.ContractTypeID = contract.ContractTypeID
LEFT JOIN
    dbo.cft_QUOTE AS quote 
        ON quote.QuoteID = pTicket.QuoteID 
LEFT JOIN 
	dbo.cft_INVENTORY_BATCH AS iBatch
		ON iBatch.PartialTicketID = pTicket.PartialTicketID
CROSS APPLY( 
    SELECT  TOP 1 CornPrice
    FROM    #dailyCornPrice
    WHERE   FeedMillID = fullTicket.FeedMillID AND CONVERT( DATE, pTicket.DeliveryDate ) !< PriceDate
    ORDER BY PriceDate DESC ) AS cornPrice        
WHERE 
    pTicket.SentToAccountsPayable != 1 
        AND ISNULL( cType.DeferredPayment, 0 ) != 1 
        AND( pTicket.PaymentTypeID = 1 OR( pTicket.PaymentTypeID = 2 AND pTicket.ContractID IS NOT NULL AND ISNULL( cType.PriceLater, 0 ) != 1 ) ) 
		AND ISNULL( NULLIF( @FeedMillID, '%' ), feedMill.FeedMillID ) = feedMill.FeedMillID
		AND CONVERT( DATE, pTicket.DeliveryDate ) BETWEEN @DeliveryDateStart AND @DeliveryDateEnd ;


/*  
    4)  INSERT unpriced bushels data into temp storage 
*/
INSERT INTO 
    #workTable( 
        ClassificationID    
      , Classification		
      , PartialTicketID     
      , DeliveryDate        
      , PaymentTypeID       
      , ContractID          
      , Futures             
      , PricedBasis         
      , QuoteID             
      , QuotePrice          
      ,	FeedMillName		
      , CornProducerName	
      , VendorID			
      , DryBushels			
      , cornPrice           
      , ValuePrice ) 
SELECT 
	ClassificationID	=	CONVERT( tinyint, 4 )
  , Classification		=	'UnPriced Bushels' 
  , PartialTicketID     =   pTicket.PartialTicketID
  , DeliveryDate        =   pTicket.DeliveryDate        
  , PaymentTypeID       =   pTicket.PaymentTypeID
  , ContractID          =   contract.ContractID
  , Futures             =   contract.Futures
  , PricedBasis         =   contract.PricedBasis
  , QuoteID             =   quote.QuoteID
  , QuotePrice          =   quote.Price
  ,	FeedMillName		=	feedMill.Name
  , CornProducerName	=	vendor.RemitName
  , VendorID			=	vendor.VendId
  , DryBushels			=	pTicket.DryBushels
  , cornPrice           =   CASE 
                                WHEN pTicket.PaymentTypeID = 2 AND contract.Futures IS NOT NULL AND contract.PricedBasis IS NOT NULL THEN contract.Futures + contract.PricedBasis
                                WHEN pTicket.QuoteID IS NOT NULL THEN quote.Price
                                ELSE cornPrice.CornPrice
                            END
  , ValuePrice          =	iBatch.ValuePrice
FROM 
	dbo.cft_PARTIAL_TICKET AS pTicket
INNER JOIN 
	dbo.cft_CORN_TICKET AS fullTicket
		ON fullTicket.TicketID = pTicket.FullTicketID
INNER JOIN 
	dbo.cft_FEED_MILL AS feedMill 
		ON feedMill.FeedMillID = fullTicket.FeedMillID
INNER JOIN 
	dbo.cft_VENDOR AS vendor 
		ON vendor.VendId = pTicket.CornProducerID
LEFT JOIN 
	dbo.cft_CONTRACT AS contract 
		ON contract.ContractID = pTicket.ContractID
LEFT JOIN 
	dbo.cft_CONTRACT_TYPE AS cType 
		ON cType.ContractTypeID = contract.ContractTypeID
LEFT JOIN
    dbo.cft_QUOTE AS quote 
        ON quote.QuoteID = pTicket.QuoteID 
LEFT JOIN 
	dbo.cft_INVENTORY_BATCH AS iBatch
		ON iBatch.PartialTicketID = pTicket.PartialTicketID
CROSS APPLY( 
    SELECT  TOP 1 CornPrice
    FROM    #dailyCornPrice
    WHERE   FeedMillID = fullTicket.FeedMillID AND CONVERT( DATE, pTicket.DeliveryDate ) !< PriceDate
    ORDER BY PriceDate DESC ) AS cornPrice
WHERE 
	pTicket.SentToAccountsPayable != 1 
        AND ISNULL( cType.DeferredPayment, 0 ) != 1     
        AND NOT( pTicket.PaymentTypeID = 1 OR ( pTicket.PaymentTypeID = 2 AND pTicket.ContractID IS NOT NULL AND ISNULL( cType.PriceLater, 0 ) != 1 ) )         
		AND ISNULL( NULLIF( @FeedMillID, '%' ), feedMill.FeedMillID ) = feedMill.FeedMillID
		AND CONVERT( DATE, pTicket.DeliveryDate ) BETWEEN @DeliveryDateStart AND @DeliveryDateEnd ;  
        

/*  
    5)  SELECT report data from temp storage
*/
SELECT 
	ClassificationID
  , Classification	
  ,	FeedMillName		
  , CornProducerName	
  , VendorID			
  , Bushels				=	SUM( DryBushels )
  , [Value]				=	SUM( DryBushels * CornPrice )
  , ValueAtInventory	=	SUM( DryBushels * ValuePrice ) 
  , [Difference]		=	SUM( DryBushels * CornPrice ) - SUM( DryBushels * ValuePrice )
FROM 
    #WorkTable 
GROUP BY 	
    ClassificationID
  , Classification		
  ,	FeedMillName		
  , CornProducerName	
  , VendorID			;

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_PURCHASES_CLEARING_RECONCILIATION] TO [db_sp_exec]
    AS [dbo];

