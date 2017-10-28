 /****** Object:  Stored Procedure dbo.InvtCustPrice_Price_Site    Script Date: 1/12/08 12:30:33 PM ******/
CREATE PROCEDURE InvtCustPrice_Price_Site
	@PriceCat VarChar(2), @CpnyID VarChar(10),  @CuryId Varchar(4), @DiscMthd VarChar(1), @InvtId VarChar(30), 
    @CustClassID VarChar(6), @UpdateSlsPrc int, @SlsUnits VarChar(6), @QtyBreak float, @CurrentPrice Float,  
    @RvsdPrice Float, @RvsdPricePercent Float, @RvsdPriceFlat float, @SiteID VarChar(10), @DecPlPrice int,
    @DiscPrcTyp VarChar(1)
AS
-- Pricing Category: Inventory Item and Cust Price Class
--Price
DECLARE @FetchAllQtyBreaks VarChar(3)
DECLARE @CurrentPriceSent VarChar(3) 

--Default the local values
SELECT @FetchAllQtyBreaks = 'NO'
SELECT @CurrentPriceSent = 'NO'

IF @QtyBreak = 0
  BEGIN
	SELECT @FetchAllQtyBreaks = 'YES'
  END

IF @CurrentPrice = 0 
  BEGIN
	SELECT @CurrentPriceSent = 'YES'
  END



UPDATE d SET RvsdDiscPrice = CASE WHEN @RvsdPrice <> 0 THEN @RvsdPrice  -- Will always be greater or equal to 0 
                                  WHEN @RvsdPricePercent <> 0 THEN CASE WHEN ROUND((d.DiscPrice + ((@RvsdPricePercent * .01) * d.DiscPrice)), @DecPlPrice) >= 0
                                                                        THEN ROUND((d.DiscPrice + ((@RvsdPricePercent * .01) * d.DiscPrice)), @DecPlPrice)
                                                                        ELSE 0 END
                                  WHEN @RvsdPriceFlat <> 0 THEN CASE WHEN ROUND(d.DiscPrice + @RvsdPriceFlat, @DecPlPrice) >= 0 
                                                                     THEN ROUND(d.DiscPrice + @RvsdPriceFlat, @DecPlPrice)
                                                                     ELSE 0 END
                                  ELSE d.RvsdDiscPrice END 

  FROM SlsPrc c JOIN SlsPrcDet d
                     ON c.SlsPrcID = d.SlsPrcID
 WHERE c.PriceCat = @PriceCat
   AND c.DiscPrcMthd = @DiscMthd  
   AND c.SiteID LIKE @SiteID
   AND c.CuryID = @CuryId 
   AND c.InvtID LIKE @InvtId
   AND c.CustClassID LIKE @CustClassID
   AND d.SlsUnit LIKE @SlsUnits
   AND ((@UpdateSlsPrc = 1) OR (@UpdateSlsPrc = 0 AND d.RvsdDiscPrice = 0))
   AND ((d.QtyBreak = @QtyBreak AND @FetchAllQtyBreaks = 'NO')  or @FetchAllQtyBreaks = 'YES')
   AND ((d.DiscPrice = @CurrentPrice AND @CurrentPriceSent = 'NO') or @CurrentPriceSent = 'YES')
   AND c.DiscPrcTyp LIKE @DiscPrcTyp



GO
GRANT CONTROL
    ON OBJECT::[dbo].[InvtCustPrice_Price_Site] TO [MSDSL]
    AS [dbo];

