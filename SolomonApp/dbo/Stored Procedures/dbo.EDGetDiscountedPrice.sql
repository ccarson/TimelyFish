 CREATE Procedure EDGetDiscountedPrice
	@PriceCat         VARCHAR(2),
	@CustID     	  VARCHAR(15),
	@CustPriceClassID VARCHAR(6),
	@SiteID     	  VARCHAR(10),
	@InvtID     	  VARCHAR(30),
	@InvtPriceClassID VARCHAR(6),
	@CuryID           VARCHAR(4),
	@Quantity         FLOAT,
	@BasePrice            FLOAT,
	@BaseCost         FLOAT,
	@SlsUnit          VARCHAR(6),
	@DiscPct          FLOAT,
             @Tradedisc        FLOAT,
	@TaxCat	 VARCHAR(10),
	@DSCPrice	FLOAT,
	@DecPlPrcCst    INT,
	@DecPlQty         INT
As

 DECLARE @SelectFld1  CHAR(30)
 DECLARE @SelectFld2  CHAR(30)
 DECLARE @DiscPrice   FLOAT
 DECLARE @DiscPrcMthd CHAR(1)
 DECLARE @SlsPrcID    CHAR(15)
 DECLARE @Price       FLOAT
 DECLARE @TotOrd    FLOAT
 DECLARE @DiscPrcTyp CHAR(1)
 DECLARE @StartDate   SMALLDATETIME
 DECLARE @EndDate    SMALLDATETIME
 DECLARE @TestDate   SMALLDATETIME
 DECLARE @PromoPass    INT

 DECLARE @FoundRow    smallint

-- Initialize DSCPrice to the same as Base Price in case we do not find a discount
Set @DSCPrice = @BasePrice
 IF @PriceCat = 'CU' BEGIN  -- CUSTOMER
	SELECT  @SelectFld1 = @CustID,
		@SelectFld2 = ''
	END

ELSE IF @PriceCat = 'CC' BEGIN  -- CUSTOMER PRICE CLASS
	SELECT  @SelectFld1 = @CustPriceClassID,
		@SelectFld2 = ''
	END

ELSE IF @PriceCat = 'IT' BEGIN  -- INVENTORY ITEM
	SELECT  @SelectFld1 = @InvtID,
		@SelectFld2 = ''
	END

ELSE IF @PriceCat = 'IL' BEGIN  -- INVENTORY ITEM AND CUST PRICE CLASS
	SELECT  @SelectFld1 = @InvtID,
		@SelectFld2 = @CustPriceClassID
	END

ELSE IF @PriceCat = 'IC' BEGIN  -- INVENTORY ITEM AND CUSTOMER
	SELECT  @SelectFld1 = @InvtID,
		@SelectFld2 = @CustID
	END

ELSE IF @PriceCat = 'PC' BEGIN  -- INvENTORY PRICE CLASS
	SELECT  @SelectFld1 = @InvtPriceClassID,
		@SelectFld2 = ''
	END

ELSE IF @PriceCat = 'PL' BEGIN  -- PRICE CLASS AND CUST PRICE CLASS
	SELECT  @SelectFld1 = @InvtPriceClassID,
		@SelectFld2 = @CustPriceClassID
	END

ELSE IF @PriceCat = 'LC' BEGIN  -- INVENTORY PRICE CLASS AND CUSTOMER
	SELECT  @SelectFld1 = @InvtPriceClassID,
		@SelectFld2 = @CustID
	END

ELSE
	SELECT  @SelectFld1 = '',
		@SelectFld2 = ''

 -- Now query SlsPrc and SlsPrcDet given the passed parameters (Using SiteId).
SELECT TOP 1
	@DiscPrcMthd = h.DiscPrcMthd,
	@DiscPrcTyp = h.DiscPrcTyp,
	@SlsPrcID    = h.SlsPrcID,
	@DiscPrice   = d.DiscPrice,
	@DiscPct     = d.DiscPct,
	@StartDate     = d.StartDate,
	@EndDate     = d.EndDate

FROM    SlsPrc h,
	SlsPrcDet d

WHERE   h.SlsPrcID   = d.SlsPrcID
	AND      h.PriceCat   = @PriceCat
	AND      h.SelectFld1 = @SelectFld1
	AND      h.SelectFld2 = @SelectFld2
	AND      h.CuryID     = @CuryID
	AND      h.SiteID     = @SiteID
	AND      d.SlsUnit    = @SlsUnit
	AND      d.QtyBreak   <= @Quantity

ORDER BY h.DiscPrcTyp,
	d.QtyBreak DESC
 Set @FoundRow = @@RowCount

 -- If the previous query did return any rows for siteID then requery with SiteID GLOBAL
IF @FoundRow <= 0 BEGIN

	SELECT TOP 1
	@DiscPrcMthd = h.DiscPrcMthd,
	@DiscPrcTyp = h.DiscPrcTyp,
	@SlsPrcID    = h.SlsPrcID,
	@DiscPrice   = d.DiscPrice,
	@DiscPct     = d.DiscPct,
	@StartDate     = d.StartDate,
	@EndDate     = d.EndDate
	FROM    SlsPrc h,
		SlsPrcDet d

	WHERE	h.SlsPrcID   = d.SlsPrcID
	AND     h.PriceCat   = @PriceCat
	AND     h.SelectFld1 = @SelectFld1
	AND     h.SelectFld2 = @SelectFld2
	AND     h.CuryID     = @CuryID
	AND     h.SiteID     = 'GLOBAL'
	AND     d.SlsUnit    = @SlsUnit
	AND     d.QtyBreak   <= @Quantity

 	ORDER BY h.DiscPrcTyp,
        	d.QtyBreak DESC

        Set @FoundRow = @@RowCount
END

 -- If the previous query returned a row then calculate the price.
IF @FoundRow > 0 BEGIN

	SELECT @PromoPass = 1,
 		@TestDate = ''

	IF @DiscPrcTyp = 'P' BEGIN
			IF GETDATE() < @StartDate   OR GETDATE() > @EndDate    BEGIN
				SELECT @PromoPass = 0
			END
	END

	 -- A match was found so price according to @DiscPrcMthd
	IF @DiscPrcMthd = 'F' AND @PromoPass > 0 BEGIN -- Flat Price
		SELECT @Price   = @DiscPrice
   		END

	ELSE IF @DiscPrcMthd = 'R'  AND @PromoPass > 0 BEGIN -- Price Discount
		SELECT @DSCPrice = @BasePrice * ( 1.0 - @DiscPct / 100.0 )
      		SELECT @Price = @DSCPrice * (1.0 - @Tradedisc / 100.0 )
		END

	ELSE IF @DiscPrcMthd = 'P'  AND @PromoPass > 0 BEGIN -- Percent Discount should not apply TradeDisc!
 		SELECT @Price = @BasePrice * (1.0 - @DiscPct / 100.0 )
		END

	ELSE IF @DiscPrcMthd = 'M'  AND @PromoPass > 0 BEGIN -- Percent Markup
		 -- Markup from cost
		SELECT @DSCPrice = @BaseCost * ( 1.0 + @DiscPct / 100.0 )
        	SELECT @Price = @DSCPrice * (1.0 - @Tradedisc / 100.0 )
		END

	ELSE IF @DiscPrcMthd = 'K'  AND @PromoPass > 0 BEGIN -- Price Markup
	 	-- Cost plus DiscPrice
		SELECT @DSCPrice = @BaseCost + @DiscPrice
        		SELECT @Price = @DSCPrice * (1.0 - @Tradedisc / 100.0 )
		END

	ELSE   BEGIN -- No other discounts apply use trade only
	 	-- Price less trade discount
		SELECT @DSCPrice = @BasePrice
		SELECT @Price = @DSCPrice * ( 1.0 + @Tradedisc / 100.0 )
		END

 	Set @Price = ROUND(CONVERT(DECIMAL(25,9),@Price),@DecPlPrcCst)

	-- Return the following
	SELECT  Price = @Price
		RETURN 1
		END

ELSE BEGIN

	--No match so exit.
	RETURN 0
END

-- Check to see if any rows were returned.




GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDGetDiscountedPrice] TO [MSDSL]
    AS [dbo];

