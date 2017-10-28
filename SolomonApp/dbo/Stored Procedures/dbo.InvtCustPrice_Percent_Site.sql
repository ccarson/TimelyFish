 /****** Object:  Stored Procedure dbo.InvtCustPrice_Percent_SiteID    Script Date: 1/12/08 12:30:33 PM ******/
CREATE PROCEDURE InvtCustPrice_Percent_Site
	@PriceCat VarChar(2), @CpnyID VarChar(10),  @CuryId Varchar(4), @DiscMthd VarChar(1), @InvtId VarChar(30), 
    @CustClassID VarChar(6), @UpdateSlsPrc int, @SlsUnits VarChar(6), @QtyBreak float, @CurrentPercent Float,   
    @RvsdPercent Float, @RvsdPercentFlat Float, @SiteID VarChar(10), @DiscPrcTyp VarChar(1)
AS
-- Pricing Category: Inventory Item and Cust Price Class
--Percent
DECLARE @FetchAllQtyBreaks VarChar(3)
DECLARE @CurrentPercentSent VarChar(3) 

--Default the local values
SELECT @FetchAllQtyBreaks = 'NO'
SELECT @CurrentPercentSent = 'NO'

IF @QtyBreak = 0
  BEGIN
	SELECT @FetchAllQtyBreaks = 'YES'
  END

IF @CurrentPercent = 0 
  BEGIN
	SELECT @CurrentPercentSent = 'YES'
  END

UPDATE d SET RvsdDiscPct = CASE WHEN @RvsdPercent <> 0 THEN @RvsdPercent  
                                WHEN @RvsdPercentFlat <> 0 THEN ROUND(d.DiscPct + @RvsdPercentFlat,2) 
                                ELSE d.RvsdDiscPct END

  FROM SlsPrc c JOIN SlsPrcDet d
                     ON c.SlsPrcID = d.SlsPrcID
 WHERE c.PriceCat = @PriceCat
   AND c.DiscPrcMthd = @DiscMthd  
   AND c.SiteID LIKE @SiteID
   AND c.CuryID = @CuryId 
   AND c.InvtID LIKE @InvtId
   AND c.CustClassID LIKE @CustClassID
   AND d.SlsUnit LIKE @SlsUnits
   AND ((@UpdateSlsPrc = 1) OR (@UpdateSlsPrc = 0 AND d.RvsdDiscPct = 0))
   AND ((d.QtyBreak = @QtyBreak AND @FetchAllQtyBreaks = 'NO')  or @FetchAllQtyBreaks = 'YES')
   AND ((d.DiscPct = @CurrentPercent AND @CurrentPercentSent = 'NO') or @CurrentPercentSent = 'YES') 
   AND c.DiscPrcTyp LIKE @DiscPrcTyp


GO
GRANT CONTROL
    ON OBJECT::[dbo].[InvtCustPrice_Percent_Site] TO [MSDSL]
    AS [dbo];

