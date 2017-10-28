 CREATE PROCEDURE
	smSOPricing_Count_smSiteGroupDet_SD043
		@StartDate			smalldatetime,
		@CustSiteGroupID	varchar(10),
		@CustID				varchar(15),
		@CustSiteID			varchar(10),
		@InvtID				varchar(30)
		
AS
	--Used in SD04300 to count the number of smSOPrice records matching selection criteria
	--when selection category = Customer Site Group ID

	SELECT Count(*)

	FROM
		smSOPricing
		JOIN smSiteGroupDet ON smSiteGroupDet.CustID = smSOPricing.CustId AND smSiteGroupDet.CustSiteID = smSOPricing.ShipToId

	WHERE
		smSOPricing.StartDate <= @StartDate AND
		smSiteGroupDet.CustSiteGroupID like @CustSiteGroupID AND
		smSOPricing.CustID like @CustID AND
		smSOPricing.ShipToID like @CustSiteID AND
		smSOPricing.Invtid like @InvtID AND
		(smSOPricing.RevAmount <> 0.0 OR smSOPricing.RevStartDate <> '01/01/1900' OR smSOPricing.RevEndDate <> '01/01/1900')

		

GO
GRANT CONTROL
    ON OBJECT::[dbo].[smSOPricing_Count_smSiteGroupDet_SD043] TO [MSDSL]
    AS [dbo];

