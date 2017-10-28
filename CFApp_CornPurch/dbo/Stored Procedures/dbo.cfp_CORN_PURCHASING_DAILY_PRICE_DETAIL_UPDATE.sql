


-- ===================================================================
-- Author:  Andrew Derco
-- Create date: 04/07/2008
-- Description: Updates DailyPriceDetail and Competitor records
-- ===================================================================
/* 
================================================================================= 
Change Log: 
Date        Who           	   Change 
----------- ------------------ -------------------------------------------------- 
2013-10-09  Nick Honetschlager Altered to also update new columns, 
                               DeliveryDateFrom, and DeliveryDateTo.
================================================================================= 
*/
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_DAILY_PRICE_DETAIL_UPDATE]
(
    @XML        text,
    @FeedMillID char(10),
    @UpdatedBy  varchar(50)
)
AS
BEGIN

SET NOCOUNT ON;

--prepare XML
DECLARE @idoc int
EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

--check if all records in XML have the same DailyPriceID and if FeddMillID of DailyPrice corresponds to @FeedMillID parameter
DECLARE @RealFeedMillID char(10),
        @temp int
SELECT DISTINCT @temp = DailyPriceID 
FROM OPENXML (@idoc, '/DocumentElement/DailyPriceDetails',2)
     WITH 
     (
       DailyPriceID int
     )
IF @@ROWCOUNT > 1 BEGIN
  RAISERROR('DailyPriceID is not the same for all of the provided DailyPriceDetail records',17,1)
  GOTO Error
END

SELECT TOP 1 @RealFeedMillID = FeedMillID 
FROM OPENXML (@idoc, '/DocumentElement/DailyPriceDetails',2)
     WITH 
     (
       DailyPriceID int
     ) X
INNER JOIN dbo.cft_DAILY_PRICE DP ON X.DailyPriceID = DP.DailyPriceID

IF @FeedMillID <> @RealFeedMillID BEGIN
  RAISERROR('@FeedMillID parameters differs from the FeedMillID value of the provided DailyPriceDetail records',17,1)
  GOTO Error
END
--process DailyPriceDetail
BEGIN TRAN
UPDATE dbo.cft_DAILY_PRICE_DETAIL
SET DailyPriceID = DC.DailyPriceID,
    DeliveryMonth = DC.DeliveryMonth,
    DeliveryYear = DC.DeliveryYear,
    DeliveryDateFrom = DC.DeliveryDateFrom,			--added 10/10/13
    DeliveryDateTo = DC.DeliveryDateTo,				--added 10/10/13
    OptionMonth = DC.OptionMonth,
    NonClassicalTrade = case lower(DC.NonClassicalTrade) when 'true' then 1 else 0 end,
    CBOTCornClose = DC.CBOTCornClose,
    CBOTChange = DC.CBOTChange,
    CompetitorBasis = DC.CompetitorBasis,
    CompetitorFreight = DC.CompetitorFreight,
    Adj = DC.Adj,
    NoBid = case lower(DC.NoBid) when 'true' then 1 else 0 end,
    UpdatedDateTime = getdate(),
    UpdatedBy = @UpdatedBy
FROM dbo.cft_DAILY_PRICE_DETAIL DPD
INNER JOIN OPENXML (@idoc, '/DocumentElement/DailyPriceDetails',2)
     WITH 
     (
       DailyPriceDetailID int,
       DailyPriceID int,
       DeliveryMonth tinyint,
       DeliveryYear smallint,
       DeliveryDateFrom DateTime,					--added 10/10/13
       DeliveryDateTo DateTime,						--added 10/10/13
       OptionMonth tinyint,
       NonClassicalTrade varchar(5),
       CBOTCornClose decimal(20,4),
       CBOTChange decimal(20,4),
       CompetitorBasis decimal(20,4),
       CompetitorFreight decimal(20,4),
       Adj decimal(20,4),
       NoBid varchar(5)
     )  DC ON DPD.DailyPriceDetailID = DC.DailyPriceDetailID 

--process DailyPriceDetailCompetitor
DECLARE @Competitors TABLE
(
  RID int IDENTITY(1,1),
  CompetitorID int
)

DECLARE @Count int,
        @i     int,
        @SQL   varchar(8000)



INSERT @Competitors
SELECT CompetitorID 
FROM dbo.cft_COMPETITOR 
WHERE ShowOnReport = 1 AND Inactive = 0 AND FeedMillID = @FeedMillID

SET @Count = @@ROWCOUNT

SET @i = 1
SET @SQL = 'DECLARE @idoc int, @UpdatedBy varchar(50)
SELECT @idoc = ' + ltrim(str(@idoc)) + ', @UpdatedBy = ''' + @UpdatedBy + ''''


SET @SQL = @SQL + 'DECLARE @Updates TABLE
(
  DailyPriceDetailID int,
  CompetitorID int,
  Price decimal(20,4)
)'

IF @i <= @Count BEGIN
  SET @SQL = @SQL + '

INSERT @Updates'
END

DECLARE @ID int
WHILE @i <= @Count BEGIN

  SELECT @ID = CompetitorID 
  FROM @Competitors 
  WHERE RID = @i

  IF @i > 1 BEGIN
    SET @SQL = @SQL + '
UNION ALL'
 END

  SET @SQL = @SQL + '
SELECT DailyPriceDetailID,' + ltrim(str(@ID)) + ' AS CompetitorID,_' + ltrim(str(@ID)) + ' AS Price
FROM OPENXML (@idoc, ''/DocumentElement/DailyPriceDetails'',2)
WITH (DailyPriceDetailID int, _' + ltrim(str(@ID)) +  ' decimal(20,4))'


  SET @i = @i + 1

END
SET @SQL = @SQL + '
UPDATE dbo.cft_DAILY_PRICE_DETAIL_COMPETITOR
SET Price = U.Price,
    UpdatedBy = @UpdatedBy,
    UpdatedDateTime = getdate()
FROM dbo.cft_DAILY_PRICE_DETAIL_COMPETITOR DPDC
INNER JOIN @Updates U ON DPDC.DailyPriceDetailID = U.DailyPriceDetailID AND DPDC.CompetitorID = U.CompetitorID

INSERT dbo.cft_DAILY_PRICE_DETAIL_COMPETITOR (DailyPriceDetailID,CompetitorID,Price,CreatedBy)
SELECT U.DailyPRiceDetailID,U.CompetitorID,U.Price,@UpdatedBy
FROM dbo.cft_DAILY_PRICE_DETAIL_COMPETITOR DPDC
RIGHT OUTER JOIN @Updates U ON DPDC.DailyPriceDetailID = U.DailyPriceDetailID AND DPDC.CompetitorID = U.CompetitorID
WHERE DPDC.DailyPriceDetailID IS NULL OR DPDC.CompetitorID IS NULL'
--print @sql
--print len(@sql)
--exec sp_executesql @sql,N'@idoc int,@CreatedBy varchar(50)',@idoc = @idoc,@CreatedBy = @UpdatedBy
EXEC(@SQL)
COMMIT TRAN
EXEC sp_xml_removedocument @idoc

Error:

END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_DAILY_PRICE_DETAIL_UPDATE] TO [db_sp_exec]
    AS [dbo];

