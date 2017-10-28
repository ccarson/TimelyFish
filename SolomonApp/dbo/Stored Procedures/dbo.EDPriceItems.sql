 CREATE Procedure EDPriceItems
 	@CustID     CHAR(15),
 	@InvtID     CHAR(30),
 	@SiteID     CHAR(10),
 	@Quantity   FLOAT,
 	@SlsUnit    CHAR(6),
 	@CuryID     CHAR(4),
	@Cost       Float,
	@TaxCat     CHAR(10)
As
  DECLARE @AllowDiscPrice     SMALLINT
 DECLARE @DiscBySite           SMALLINT
 DECLARE @DiscPrcSeq00     CHAR(2)
 DECLARE @DiscPrcSeq01     CHAR(2)
 DECLARE @DiscPrcSeq02     CHAR(2)
 DECLARE @DiscPrcSeq03     CHAR(2)
 DECLARE @DiscPrcSeq04     CHAR(2)
 DECLARE @DiscPrcSeq05     CHAR(2)
 DECLARE @DiscPrcSeq06     CHAR(2)
 DECLARE @DiscPrcSeq07     CHAR(2)
 DECLARE @DiscPrcSeq08     CHAR(2)
 DECLARE @CustPriceClassID VARCHAR(6)
 DECLARE @InvtPriceClassID  VARCHAR(6)
 DECLARE @Priced                 TINYINT
 DECLARE @DiscPct	          FLOAT
 DECLARE @TradeDisc           FLOAT
 DECLARE @DSCPrice            FLOAT
 DECLARE @BasePrice           FLOAT
 DECLARE @DecPlPrcCst       INT
 DECLARE @DecPlQty            INT
 DECLARE @TotOrd                FLOAT
 DECLARE @Price			float

 SELECT @TradeDisc = c.TradeDisc + 0, @CustPriceClassID = ClassID
	From Customer c
	Where c.CustID = @CustID

 -- Values to be used for Solomon Rounding Precision
 SELECT @DecPlPrcCst = DecPlPrcCst,
	  @DecPlQty = DecPlQty
	   FROM INSetup

-- Initialize the Discount Price and Base Price fields to 0
 SELECT @DSCPrice = 0,
	  @BasePrice = 0
  SELECT @Price               = i.StkBasePrc,
   	  @InvtPriceClassID  = i.PriceClassID,
   	  @Cost              = CASE i.ValMthd WHEN 'T' THEN i.StdCost ELSE i.LastCost END,
	  @TaxCat            = i.TaxCat

	 FROM Inventory i
	 	WHERE   i.InvtID = @InvtID
 -- Iterate thru the pricing sequence defined in SOSetup.
 SELECT @AllowDiscPrice   = AllowDiscPrice,
	@DiscBySite     = DiscBySite,
	@DiscPrcSeq00   = DiscPrcSeq00,
	@DiscPrcSeq01   = DiscPrcSeq01,
	@DiscPrcSeq02   = DiscPrcSeq02,
	@DiscPrcSeq03   = DiscPrcSeq03,
	@DiscPrcSeq04   = DiscPrcSeq04,
	@DiscPrcSeq05   = DiscPrcSeq05,
	@DiscPrcSeq06   = DiscPrcSeq06,
	@DiscPrcSeq07   = DiscPrcSeq07,
	@DiscPrcSeq08   = DiscPrcSeq08

	FROM SOSetup

 -- Use base currency for now
 SELECT @CuryID = 'BAS'
	 -- First check to see if we are doing discount pricing at all.
 IF @AllowDiscPrice <> 0
		BEGIN
		-- Discount pricing is enabled so try each

	 EXEC @Priced = EDGetDiscountedPrice @DiscPrcSeq00, @CustID, @CustPriceClassID, @SiteID, @InvtID, @InvtPriceClassID, @CuryID, @Quantity, @Price, @Cost, @SlsUnit, @DiscPct, @Tradedisc, @TaxCat, @DSCPrice, @DecPlPrcCst, @DecPlQty

	 IF @Priced = 0
	 EXEC @Priced = EDGetDiscountedPrice @DiscPrcSeq01, @CustID, @CustPriceClassID, @SiteID, @InvtID, @InvtPriceClassID, @CuryID, @Quantity, @Price, @Cost, @SlsUnit, @DiscPct, @Tradedisc, @TaxCat, @DSCPrice, @DecPlPrcCst, @DecPlQty

	 IF @Priced = 0
     	 EXEC @Priced = EDGetDiscountedPrice @DiscPrcSeq02, @CustID, @CustPriceClassID, @SiteID, @InvtID, @InvtPriceClassID, @CuryID, @Quantity, @Price, @Cost, @SlsUnit, @DiscPct, @Tradedisc, @TaxCat, @DSCPrice, @DecPlPrcCst, @DecPlQty

	 IF @Priced = 0
	 EXEC @Priced = EDGetDiscountedPrice @DiscPrcSeq03, @CustID, @CustPriceClassID, @SiteID, @InvtID, @InvtPriceClassID, @CuryID, @Quantity, @Price, @Cost, @SlsUnit, @DiscPct, @Tradedisc, @TaxCat, @DSCPrice, @DecPlPrcCst, @DecPlQty

	 IF @Priced = 0
	 EXEC @Priced = EDGetDiscountedPrice @DiscPrcSeq04, @CustID, @CustPriceClassID, @SiteID, @InvtID, @InvtPriceClassID, @CuryID, @Quantity, @Price, @Cost, @SlsUnit, @DiscPct, @Tradedisc, @TaxCat, @DSCPrice, @DecPlPrcCst, @DecPlQty

	 IF @Priced = 0
	 EXEC @Priced = EDGetDiscountedPrice @DiscPrcSeq05, @CustID, @CustPriceClassID, @SiteID, @InvtID, @InvtPriceClassID, @CuryID, @Quantity, @Price, @Cost, @SlsUnit, @DiscPct, @Tradedisc, @TaxCat, @DSCPrice, @DecPlPrcCst, @DecPlQty

	 IF @Priced = 0
	 EXEC @Priced = EDGetDiscountedPrice @DiscPrcSeq06, @CustID, @CustPriceClassID, @SiteID, @InvtID, @InvtPriceClassID, @CuryID, @Quantity, @Price, @Cost, @SlsUnit, @DiscPct, @Tradedisc, @TaxCat, @DSCPrice, @DecPlPrcCst, @DecPlQty

	 IF @Priced = 0
	 EXEC @Priced = EDGetDiscountedPrice @DiscPrcSeq07, @CustID, @CustPriceClassID, @SiteID, @InvtID, @InvtPriceClassID, @CuryID, @Quantity, @Price, @Cost, @SlsUnit, @DiscPct, @Tradedisc, @TaxCat, @DSCPrice, @DecPlPrcCst, @DecPlQty

	 IF @Priced = 0
	 EXEC @Priced = EDGetDiscountedPrice @DiscPrcSeq08, @CustID, @CustPriceClassID, @SiteID, @InvtID, @InvtPriceClassID, @CuryID, @Quantity, @Price, @Cost, @SlsUnit, @DiscPct, @Tradedisc, @TaxCat, @DSCPrice, @DecPlPrcCst, @DecPlQty
	END

	IF @Priced = 0
          	SELECT @DiscPct = @Tradedisc
	SELECT @BasePrice = CASE @BasePrice WHEN 0  THEN @Price ELSE @BasePrice END,
	 @DSCPrice = CASE @DSCPrice WHEN 0  THEN @Price ELSE @DSCPrice END

SELECT @BasePrice = ROUND(CONVERT(DECIMAL(25,9), @BasePrice),@DecPlPrcCst),
              @DSCPrice = ROUND(CONVERT(DECIMAL(25,9), @DSCPrice),@DecPlPrcCst),
              @Price = ROUND(CONVERT(DECIMAL(25,9),@Price),@DecPlPrcCst)

SELECT SlsPrcID = CAST('' AS CHAR(15)),
       InvtID   = @InvtID,
       SiteID   = @SiteID,
       Price    = @Price,
       DiscPct  = @DiscPct,
       CuryID   = @CuryID,
       Unit     = @SlsUnit,
       TaxCat   = @TaxCat,
       BasePrice = @BasePrice,
       DSCPrice = @DSCPrice
RETURN

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


