





-- ===================================================================
-- Author:  Andrew Derco
-- Create date: 04/07/2008
-- Description: Selects DailyPriceDetail and Competitor data for provided date
-- ===================================================================
/* 
================================================================================= 
Change Log: 
Date        Who           	   Change 
----------- ------------------ -------------------------------------------------- 
2013-10-09  Nick Honetschlager Altered to use cursor & grab new columns, 
                               DeliveryDateFrom, and DeliveryDateTo.
================================================================================= 
*/
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_DAILY_PRICE_DETAIL_SELECT]
(
    @DailyPriceID int,
    @CreatedBy    varchar(50)
)
AS
BEGIN

SET NOCOUNT ON;

DECLARE @MonthsForward int,
        @FeedMillID char(10)
SET @MonthsForward = 36

SELECT @FeedMillID = FeedMillID
FROM dbo.cft_DAILY_PRICE WHERE DailyPriceID = @DailyPriceID

--begin new day
IF NOT EXISTS(SELECT TOP 1 1 
              FROM dbo.cft_DAILY_PRICE_DETAIL 
              WHERE DailyPriceID = @DailyPriceID)
BEGIN
  DECLARE @j int,
          @Month int,
          @Year int,
          @DeliveryDateFrom date,	--added 10/10/13 NJH
          @DeliveryDateTo date,		--added 10/10/13 NJH
          @Date datetime,
          @OldDailyPriceID int,
          @OldDailyPriceDetailID int,
          @NonClassicalTrade bit,
          @CompetitorBasis decimal(18, 2),
          @CompetitorFreight decimal(18, 2),
          @Adj decimal(18, 2),
          @NoBid bit,
          @DailyPriceDetailID int

  SELECT @Month = month(Date),
         @Year = year(Date),
         @Date  = Date
  FROM dbo.cft_DAILY_PRICE WHERE DailyPriceID = @DailyPriceID

  IF @Month IS NULL BEGIN
    RAISERROR('DailyPrice record with DailyPriceID = %d does not exists.', 17, 1, @DailyPriceID)
    GOTO Error
  END

  --find the previous daily price
  SELECT TOP 1 @OldDailyPriceID = DailyPriceID
  FROM dbo.cft_DAILY_PRICE
  WHERE FeedMillID = @FeedMillID AND Date < @Date
  ORDER BY Date DESC    

  SET @j = 1
  BEGIN TRAN

  WHILE @j <= @MonthsForward BEGIN
  
SELECT	   @OldDailyPriceDetailID = NULL,
           @NonClassicalTrade = NULL,
           @CompetitorBasis  = NULL,
           @CompetitorFreight = NULL,
           @Adj = NULL,
           @NoBid  = NULL,
           @DeliveryDateFrom = NULL,	--added 10/10/13 NJH
           @DeliveryDateTo  = NULL		--added 10/10/13 NJH

-- 10/10/13 added use of cursors
declare db_cursor cursor for
SELECT 
		   DailyPriceDetailID,
           NonClassicalTrade,
           CompetitorBasis,
           CompetitorFreight,
           Adj,
           NoBid,
           DeliveryDateFrom,			
           DeliveryDateTo				

    FROM dbo.cft_DAILY_PRICE_DETAIL
    WHERE DailyPriceID = @OldDailyPriceID AND DeliveryMonth = @Month AND DeliveryYear = @Year

--added 10/10/13    
OPEN db_cursor
FETCH NEXT
FROM db_cursor
INTO	@OldDailyPriceDetailID,
        @NonClassicalTrade,
        @CompetitorBasis,
        @CompetitorFreight,
        @Adj,
        @NoBid,
        @DeliveryDateFrom,				
        @DeliveryDateTo
        
DECLARE @NewMonth as bit = 0

IF @@FETCH_STATUS <> 0
	IF @DeliveryDateFrom IS NULL
		SET @NewMonth = 1

-- 10/10/13 Set up start and end of month dates for blank lines        
IF @DeliveryDateFrom Is NULL
	SET @DeliveryDateFrom = CAST(CAST(@Year AS varchar) + '-' + CAST(@Month AS varchar) + '-' + '01' AS DATETIME)

IF (@DeliveryDateTo IS NULL) 
	IF (@Month = 04 OR @Month = 06 OR @Month = 09 OR @Month = 11)
		SET @DeliveryDateTo = CAST(CAST(@Year AS varchar) + '-' + CAST(@Month AS varchar) + '-' + '30' AS DATETIME)
	ELSE IF (@Month = 02)
		IF ((@Year % 4 = 0 AND @YEAR % 100 <> 0) OR @YEAR % 400 = 0)
			SET @DeliveryDateTo = CAST(CAST(@Year AS varchar) + '-' + CAST(@Month AS varchar) + '-' + '29' AS DATETIME)
		ELSE
			SET @DeliveryDateTo = CAST(CAST(@Year AS varchar) + '-' + CAST(@Month AS varchar) + '-' + '28' AS DATETIME)				
	ELSE 
		SET @DeliveryDateTo = CAST(CAST(@Year AS varchar) + '-' + CAST(@Month AS varchar) + '-' + '31' AS DATETIME)
        
WHILE @@FETCH_STATUS = 0 BEGIN
	INSERT dbo.cft_DAILY_PRICE_DETAIL
    (
       DailyPriceID,
       DeliveryMonth,
       DeliveryYear,
       DeliveryDateFrom,		--added 10/10/13 NJH
       DeliveryDateTo,			--added 10/10/13 NJH
       OptionMonth,
       NonClassicalTrade,
       CompetitorBasis,
       CompetitorFreight,
       Adj,
       NoBid,
       CreatedBy 
    )
    VALUES
    (
       @DailyPriceID,
       @Month,
       @Year,
       @DeliveryDateFrom,		--added 10/10/13 NJH
       @DeliveryDateTo,			--added 10/10/13 NJH
       dbo.cffn_GET_FINANCIAL_MONTH_ID(@Month),
       ISNULL(@NonClassicalTrade,0),
       @CompetitorBasis,
       @CompetitorFreight,
       @Adj,
       ISNULL(@NoBid,0),
       @CreatedBy
    )
    
    SET @DailyPriceDetailID = SCOPE_IDENTITY()

    INSERT dbo.cft_DAILY_PRICE_DETAIL_COMPETITOR
    (
       DailyPriceDetailID,
       CompetitorID,
       Price,
       CreatedBy        
    )
    SELECT @DailyPriceDetailID,
           CompetitorID,
           Price,
           @CreatedBy
    FROM dbo.cft_DAILY_PRICE_DETAIL_COMPETITOR
    WHERE DailyPriceDetailID = @OldDailyPriceDetailID

--added 10/10/13
FETCH NEXT
FROM db_cursor
INTO	@OldDailyPriceDetailID,
        @NonClassicalTrade,
        @CompetitorBasis,
        @CompetitorFreight,
        @Adj,
        @NoBid,
        @DeliveryDateFrom,			--added 10/10/13 NJH
        @DeliveryDateTo				--added 10/10/13 NJH
END

CLOSE db_cursor   
DEALLOCATE db_cursor

-- Begin Test Code Block
IF @@FETCH_STATUS <> 0
	IF @NewMonth = 1 BEGIN
	INSERT dbo.cft_DAILY_PRICE_DETAIL
    (
       DailyPriceID,
       DeliveryMonth,
       DeliveryYear,
       DeliveryDateFrom,		--added 10/10/13 NJH
       DeliveryDateTo,			--added 10/10/13 NJH
       OptionMonth,
       NonClassicalTrade,
       CompetitorBasis,
       CompetitorFreight,
       Adj,
       NoBid,
       CreatedBy 
    )
    VALUES
    (
       @DailyPriceID,
       @Month,
       @Year,
       @DeliveryDateFrom,		--added 10/10/13 NJH
       @DeliveryDateTo,			--added 10/10/13 NJH
       dbo.cffn_GET_FINANCIAL_MONTH_ID(@Month),
       ISNULL(@NonClassicalTrade,0),
       @CompetitorBasis,
       @CompetitorFreight,
       @Adj,
       ISNULL(@NoBid,0),
       @CreatedBy
    )
    
    SET @DailyPriceDetailID = SCOPE_IDENTITY()

    INSERT dbo.cft_DAILY_PRICE_DETAIL_COMPETITOR
    (
       DailyPriceDetailID,
       CompetitorID,
       Price,
       CreatedBy        
    )
    SELECT @DailyPriceDetailID,
           CompetitorID,
           Price,
           @CreatedBy
    FROM dbo.cft_DAILY_PRICE_DETAIL_COMPETITOR
    WHERE DailyPriceDetailID = @OldDailyPriceDetailID
END
--End Test Code Block

IF @Month = 12 BEGIN
      SELECT @Month = 1, 
             @Year = @Year + 1
    END ELSE BEGIN
      SELECT @Month = @Month + 1
    END
    
    SET @j = @j + 1
  END    
  COMMIT TRAN
END --begin new day

DECLARE @Competitors TABLE
(
  RID int IDENTITY(1,1),
  CompetitorID int
)

DECLARE @Count int,
        @i     int,
        @SQL   varchar(8000),
        @From  varchar(8000)

--added 10/10/13 DeliveryDateFrom, DeliveryDateTo
SET @SQL = 'SELECT DPD.DailyPriceDetailID,
       DPD.DailyPriceID,
       DPD.DeliveryMonth,
       DPD.DeliveryYear,
       DPD.DeliveryDate,
       DPD.DeliveryDateFrom,
       DPD.DeliveryDateTo,
       DPD.OptionMonth,
       right(FM.Name,1) AS OptionMonthName, 
       DPD.NonClassicalTrade,
       DPD.CBOTCornClose,
       DPD.CBOTChange,
       DPD.CompetitorBasis,
       DPD.CompetitorFreight,
       DPD.Adj,
       DPD.NoBid'

SET @From = ' FROM dbo.cft_DAILY_PRICE_DETAIL DPD
INNER JOIN dbo.cft_FINANCIAL_MONTH FM ON FM.FinancialMonthID = DPD.OptionMonth'

INSERT @Competitors
SELECT CompetitorID 
FROM dbo.cft_COMPETITOR 
WHERE ShowOnReport = 1 AND Inactive = 0 AND FeedMillID = @FeedMillID

SET @Count = @@ROWCOUNT

SET @i = 1


DECLARE @ID int
WHILE @i <= @Count BEGIN

  SELECT @ID = CompetitorID 
  FROM @Competitors 
  WHERE RID = @i

  SET @SQL = @SQL + ',
       DPDC' + ltrim(str(@i)) + '.Price AS _' + ltrim(str(@ID))
  SET @From = @From + '
LEFT OUTER JOIN dbo.cft_DAILY_PRICE_DETAIL_COMPETITOR DPDC' + ltrim(str(@i))
    + ' ON DPD.DailyPriceDetailID = DPDC' + ltrim(str(@i)) + '.DailyPriceDetailID AND DPDC'
    + ltrim(str(@i)) + '.CompetitorID = ' + ltrim(str(@ID))
  SET @i = @i + 1

END

SET @SQL = @SQL + @From + '
WHERE DPD.DailyPriceID = ' + ltrim(str(@DailyPriceID)) + '
ORDER BY DPD.DeliveryYear, DPD.DeliveryMonth'

EXEC(@SQL)
Error:
END









GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_DAILY_PRICE_DETAIL_SELECT] TO [db_sp_exec]
    AS [dbo];

