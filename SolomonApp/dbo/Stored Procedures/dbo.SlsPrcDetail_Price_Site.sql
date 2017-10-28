 /****** Object:  Stored Procedure dbo.SlsPrcDetail_Price_Site    Script Date: 1/12/08 12:30:33 PM ******/
CREATE PROCEDURE SlsPrcDetail_Price_Site
	@PriceCat VarChar(2), @CuryId Varchar(4), @DiscMthd VarChar(1), @Custid VarChar(15), 
    @InvtId VarChar(30), @CustClassID VarChar(6), @InvtPriceClassID VarChar(6),
    @SlsUnits VarChar(6), @QtyBreak float, @CurrentPrice Float, @SiteID VarChar (10), 
    @FetchAllQtyBreaks VarChar(3), @FetchAllPrices VarChar(3), @DiscPrcTyp VarChar(1)
AS

Select c.CuryID, c.CustClassID, c.CustID, c.DiscPrcMthd, c.DiscPrcTyp, c.InvtID, c.PriceCat, c.PriceClassID, c.SiteID,
       d.DetRef, d.DiscPrice, d.RvsdDiscPrice, d.DiscPct, d.RvsdDiscPct, d.QtyBreak, d.SlsUnit, d.S4Future01, d.S4Future02

  from SlsPrc c JOIN SlsPrcDet d
                     ON c.SlsPrcID = d.SlsPrcID
 WHERE c.PriceCat = @PriceCat
   AND c.DiscPrcMthd = @DiscMthd 
   AND c.CuryID = @CuryId
   AND c.SiteID LIKE @SiteID   
   AND c.CustID LIKE @CustID
   AND c.InvtID LIKE @InvtID
   AND c.PriceClassID LIKE @InvtPriceClassID
   AND c.CustClassID LIKE @CustClassID
   AND d.SlsUnit LIKE @SlsUnits
   AND ((d.QtyBreak = @QtyBreak AND @FetchAllQtyBreaks = 'NO')  or @FetchAllQtyBreaks = 'YES')
   AND ((d.DiscPrice = @CurrentPrice AND @FetchAllPrices = 'NO') or @FetchAllPrices = 'YES') 
   AND c.DiscPrcTyp LIKE @DiscPrcTyp

 Order by c.SlsPrcID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SlsPrcDetail_Price_Site] TO [MSDSL]
    AS [dbo];

