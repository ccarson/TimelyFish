 CREATE PROCEDURE
	smSOPric_smSiteGrp_Cust_Site_Invt_Dist
		@PricingOption		varchar(1),
		@CustSiteGroupID	varchar(10),
		@CustID				varchar(15),
		@CustSiteID			varchar(10),
		@InvtID				varchar(30),
		@CurrentPrice		float,
		@CurrentDisc		float,
		@StartDate			smalldatetime,
		@EndDate			smalldatetime,
		@NotZero			smallint
		
AS
	--Used in SD04200 to retrieve distinct Cust ID, Site ID, and Invt ID combinations matching selection criteria.
	--(Used to check whether applying revised Start Date will result in duplicate CustID/ShiptoID/InvtID/StartDate combos.) 

	SELECT distinct smSOPricing.CustID, smSOPricing.ShipToID, smSOPricing.Invtid
	
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

		

GO
GRANT CONTROL
    ON OBJECT::[dbo].[smSOPric_smSiteGrp_Cust_Site_Invt_Dist] TO [MSDSL]
    AS [dbo];

