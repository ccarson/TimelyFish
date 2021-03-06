﻿ CREATE PROCEDURE
	smSOPricing_Count_SD042
		@PricingOption		varchar(1),
		@CustID				varchar(15),
		@CustSiteID			varchar(10),
		@InvtID				varchar(30),
		@CurrentPrice		float,
		@CurrentDisc		float,
		@StartDate			smalldatetime,
		@EndDate			smalldatetime,
		@NotZero			smallint
		
AS
	--Used in SD04200 to update smSOPrice records matching selection criteria

	SELECT COUNT(*)
	
	FROM
		smSOPricing
	WHERE
		smSOPricing.BaseOption = @PricingOption AND
		smSOPricing.CustID like @CustID AND
		smSOPricing.ShipToID like @CustSiteID AND
		smSOPricing.Invtid like @InvtID AND
		(@NotZero = 1 OR (@NotZero = 0 AND smSOPricing.RevAmount = 0)) AND
		(@CurrentPrice = 0.0 OR (smSOPricing.Amount = @CurrentPrice)) AND
		(@CurrentDisc = 0.0 OR (smSOPricing.Amount = @CurrentDisc)) AND
		(@StartDate = '01/01/1900' OR (smSOPricing.StartDate = @StartDate)) AND
		(@EndDate = '01/01/1900' OR (smSOPricing.EndDate = @EndDate))

		
