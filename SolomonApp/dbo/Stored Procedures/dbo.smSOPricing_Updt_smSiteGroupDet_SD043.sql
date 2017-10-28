 CREATE PROCEDURE
	smSOPricing_Updt_smSiteGroupDet_SD043
		@StartDate			smalldatetime,
		@CustSiteGroupID	varchar(10),
		@CustID				varchar(15),
		@CustSiteID			varchar(10),
		@InvtID				varchar(30)
		
AS
	--Used in SD04300 to set Amount to Revised Amount in smSOPrice records matching selection criteria
	--when selection category = Customer Site Group ID

	UPDATE smSOPricing SET Amount = RevAmount, RevAmount = 0.0,
		StartDate = CASE WHEN RevStartDate <> '01/01/1900' THEN RevStartDate ELSE smSOPricing.StartDate END, RevStartDate = '01/01/1900',
		EndDate = CASE WHEN RevEndDate <> '01/01/1900' THEN RevEndDate ELSE	smSOPricing.EndDate END, RevEndDate = '01/01/1900'

	FROM
		smSOPricing
		JOIN smSiteGroupDet ON smSiteGroupDet.CustID = smSOPricing.CustId AND smSiteGroupDet.CustSiteID = smSOPricing.ShipToId
		JOIN Customer ON Customer.CustId = smSOPricing.CustID
		JOIN SOAddress ON SOAddress.CustId = smSOPricing.CustID AND SOAddress.ShipToId = smSOPricing.ShipToID
		JOIN Inventory ON Inventory.InvtID = smSOPricing.Invtid
		

	WHERE
		smSOPricing.StartDate <= @StartDate AND
		smSiteGroupDet.CustSiteGroupID like @CustSiteGroupID AND
		smSOPricing.CustID like @CustID AND
		smSOPricing.ShipToID like @CustSiteID AND
		smSOPricing.Invtid like @InvtID AND
		(smSOPricing.RevAmount <> 0.0 OR smSOPricing.RevStartDate <> '01/01/1900' OR smSOPricing.RevEndDate <> '01/01/1900')

		
