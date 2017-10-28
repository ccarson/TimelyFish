

CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_DAILY_PRICE_DETAIL_INSERT]
(
    @XML        XML,
    @FeedMillID char(10),
    @CreatedBy  varchar(50)
)
AS
BEGIN

SET NOCOUNT ON;

--prepare XML
DECLARE @idoc int
EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

--check if all records in XML have the same DailyPriceID and if FeedMillID of DailyPrice corresponds to @FeedMillID parameter
DECLARE @RealFeedMillID char(10),
        @temp int,
        @ParentID int
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

DECLARE 
          @DeliveryDateFrom date,
          @DeliveryDateTo date,
          @DailyPriceID int,
          @DailyPriceDetailID int,
          @NonClassicalTrade bit,
          @CompetitorBasis decimal(18, 2),
          @CompetitorFreight decimal(18, 2),
          @Adj decimal(18, 2),
          @NoBid bit,
          @PrevMonth int,
          @YearTemp varchar(4),
          @MonthTemp varchar(2),
          @DeliveryMonth int,
		  @DeliveryYear int,
		  @OptionMonth tinyint,
		  @CBOTCornClose decimal(20,4),
		  @CBOTChange decimal(20,4)

BEGIN TRAN   

declare db_cursor cursor for
SELECT	   
		   DailyPriceID,
		   DeliveryMonth,
		   DeliveryYear,
		   OptionMonth,
           NonClassicalTrade,
           CBOTCornClose,
           CBOTChange,
           CompetitorBasis,
           CompetitorFreight,
           Adj,
           NoBid,
           DeliveryDateFrom,
           DeliveryDateTo

FROM OPENXML (@idoc, '/DocumentElement/DailyPriceDetails',2)
WITH 
     (
       DailyPriceID int,
       DeliveryMonth tinyint,
       DeliveryYear smallint,
       OptionMonth tinyint,
       NonClassicalTrade varchar(5),
       CBOTCornClose decimal(20,4),
       CBOTChange decimal(20,4),
       CompetitorBasis decimal(20,4),
       CompetitorFreight decimal(20,4),
       Adj decimal(20,4),
       NoBid varchar(5),
       DeliveryDateFrom DateTime,
       DeliveryDateTo DateTime
     )
OPEN db_cursor
FETCH NEXT
FROM db_cursor
INTO
       @DailyPriceID,
       @DeliveryMonth,
       @DeliveryYear,
       @OptionMonth,
       @NonClassicalTrade,
       @CBOTCornClose,
       @CBOTChange,
       @CompetitorBasis,
       @CompetitorFreight,
       @Adj,
       @NoBid,
       @DeliveryDateFrom,
       @DeliveryDateTo
     
WHILE @@FETCH_STATUS = 0 BEGIN     
INSERT cft_DAILY_PRICE_DETAIL
(
	DailyPriceID,
    DeliveryMonth,
    DeliveryYear, 
    DeliveryDateFrom, 
    DeliveryDateTo,
    OptionMonth, 
    NonClassicalTrade,
    CBOTCornClose,
    CBOTChange, 
    CompetitorBasis, 
    CompetitorFreight, 
    Adj, 
    NoBid,
    CreatedBy
    )
    
    VALUES
    (
    @DailyPriceID,
	@DeliveryMonth,
	@DeliveryYear,
	@DeliveryDateFrom,
	@DeliveryDateTo,
	@OptionMonth,
	case lower(@NonClassicalTrade) when 'true' then 1 else 0 end,
    @CBOTCornClose,
    @CBOTChange,
	@CompetitorBasis,
	@CompetitorFreight,
	@Adj,
	case lower(@NoBid) when 'true' then 1 else 0 end, 
	@CreatedBy
    )

SET @DailyPriceDetailID = SCOPE_IDENTITY()

SET @ParentID  = (SELECT b.parentid as id																												-- added 10/22/14 NJH
							FROM OPENXML (@idoc, '/DocumentElement/DailyPriceDetails',2) b							
							LEFT JOIN(
									SELECT *
									FROM OPENXML (@idoc, '/DocumentElement/DailyPriceDetails',2) c
									WHERE c.nodetype = 3
							  		) d ON b.id = d.parentid
							WHERE b.localname = 'DeliveryDateFrom' 
							AND CAST(d.[text] as varchar(10)) = CAST(@DeliveryDateFrom as varchar(10)))

    INSERT dbo.cft_DAILY_PRICE_DETAIL_COMPETITOR
    (
       DailyPriceDetailID,
       CompetitorID,
       CreatedBy,
       Price        
    )
    SELECT																																		
		   @DailyPriceDetailID,
		   C.CompetitorID,
           @CreatedBy,
           I.Price
           
    FROM dbo.cft_COMPETITOR C
    LEFT JOIN (					
				SELECT REPLACE(a.localname, '_','') AS CompetitorID, CAST(CAST(c.[text] AS nvarchar(30)) AS decimal(20,4)) as Price, a.ParentID			-- added 10/22/14 NJH
				FROM OPENXML (@idoc, '/DocumentElement/DailyPriceDetails',2) a
				LEFT JOIN (
							SELECT b.[text],b.parentid
							FROM OPENXML (@idoc, '/DocumentElement/DailyPriceDetails',2) b
							WHERE b.nodetype = 3
						  ) c ON a.id = c.parentid
				WHERE a.nodetype = 1 AND ISNUMERIC(SUBSTRING(a.localname, 2, 2)) = 1 AND a.ParentID = @ParentID											-- added 10/22/14 NJH
			  ) I ON C.CompetitorID = I.CompetitorID
    WHERE FeedMillID = @FeedMillID
    FETCH NEXT
FROM db_cursor
INTO   @DailyPriceID,
       @DeliveryMonth,
       @DeliveryYear,
       @OptionMonth,
       @NonClassicalTrade,
       @CBOTCornClose,
       @CBOTChange,
       @CompetitorBasis,
       @CompetitorFreight,
       @Adj,
       @NoBid,
       @DeliveryDateFrom,
       @DeliveryDateTo
END

CLOSE db_cursor   
DEALLOCATE db_cursor
COMMIT TRAN
EXEC sp_xml_removedocument @idoc
Error:
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_DAILY_PRICE_DETAIL_INSERT] TO [db_sp_exec]
    AS [dbo];

