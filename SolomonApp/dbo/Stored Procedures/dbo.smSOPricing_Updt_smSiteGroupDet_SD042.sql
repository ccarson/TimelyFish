 CREATE PROCEDURE
	smSOPricing_Updt_smSiteGroupDet_SD042
		@PricingOption		varchar(1),
		@CustSiteGroupID	varchar(10),
		@CustID				varchar(15),
		@CustSiteID			varchar(10),
		@InvtID				varchar(30),
		@CurrentPrice		float,
		@CurrentDisc		float,
		@StartDate			smalldatetime,
		@EndDate			smalldatetime,
		@NotZero			smallint,
		@NewRevPrice		float,
		@RevPriceFlat		float,
		@RevPricePct		float,
		@NewDiscPct			float,
		@RevDiscPctFlat		float,
		@RevStartDate		smalldatetime,
		@RevEndDate			smalldatetime
		
AS
	--Used in SD04200 to update smSOPrice records matching selection criteria

	UPDATE smSOPricing SET
		RevStartDate = @RevStartDate,
		RevEndDate = @RevEndDate,
		RevAmount = CASE
		WHEN @PricingOption = 'A' AND @NewRevPrice <> 0.0 THEN @NewRevPrice
		WHEN @PricingOption = 'A' AND @RevPriceFlat <> 0.0 THEN CASE WHEN ROUND(smSOPricing.Amount + @RevPriceFlat, 3) >= 0
											THEN ROUND(smSOPricing.Amount + @RevPriceFlat, 3)
											ELSE 0.0 END
		WHEN @PricingOption = 'A' AND @RevPricePct <> 0.0 THEN CASE WHEN ROUND((smSOPricing.Amount + ((@RevPricePct * .01) * smSOPricing.Amount)), 3) >= 0
											THEN ROUND((smSOPricing.Amount + ((@RevPricePct * .01) * smSOPricing.Amount)), 3)
											ELSE 0 END
		WHEN @PricingOption = 'D' AND @NewDiscPct <> 0.0 THEN @NewDiscPct
		WHEN @PricingOption = 'D' AND @RevDiscPctFlat <> 0.0 THEN CASE WHEN ROUND(smSOPricing.Amount + @RevDiscPctFlat, 3) >= 0
											THEN ROUND(smSOPricing.Amount + @RevDiscPctFlat, 3)
											ELSE 0.0 END
		ELSE smSOPricing.RevAmount END

	FROM
		smSOPricing
		JOIN smSiteGroupDet ON smSiteGroupDet.CustID = smSOPricing.CustId AND smSiteGroupDet.CustSiteID = smSOPricing.ShipToId
	WHERE
		smSOPricing.BaseOption = @PricingOption AND
		smSiteGroupDet.CustSiteGroupID like @CustSiteGroupID AND
		smSiteGroupDet.CustID like @CustID AND
		smSiteGroupDet.CustSiteID like @CustSiteID AND
		smSOPricing.Invtid like @InvtID AND
		(@NotZero = 1 OR (@NotZero = 0 AND smSOPricing.RevAmount = 0)) AND
		(@CurrentPrice = 0.0 OR (smSOPricing.Amount = @CurrentPrice)) AND
		(@CurrentDisc = 0.0 OR (smSOPricing.Amount = @CurrentDisc)) AND
		(@StartDate = '01/01/1900' OR (smSOPricing.StartDate = @StartDate)) AND
		(@EndDate = '01/01/1900' OR (smSOPricing.EndDate = @EndDate))

		
