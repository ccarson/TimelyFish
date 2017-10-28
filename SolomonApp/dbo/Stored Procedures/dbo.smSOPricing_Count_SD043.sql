 CREATE PROCEDURE
	smSOPricing_Count_SD043
		@StartDate			smalldatetime,
		@CustID				varchar(15),
		@CustSiteID			varchar(10),
		@InvtID				varchar(30)
		
AS
	--Used in SD04300 to count the number of smSOPrice records matching selection criteria
	--when selection category = All, Customer ID, Customer Site ID, or Inventory ID

	SELECT Count(*)

	FROM
		smSOPricing
	WHERE
		smSOPricing.StartDate <= @StartDate AND
		smSOPricing.CustID like @CustID AND
		smSOPricing.ShipToID like @CustSiteID AND
		smSOPricing.Invtid like @InvtID AND
		(smSOPricing.RevAmount <> 0.0 OR smSOPricing.RevStartDate <> '01/01/1900' OR smSOPricing.RevEndDate <> '01/01/1900')

		

GO
GRANT CONTROL
    ON OBJECT::[dbo].[smSOPricing_Count_SD043] TO [MSDSL]
    AS [dbo];

