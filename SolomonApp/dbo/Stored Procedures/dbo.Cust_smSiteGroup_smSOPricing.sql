 CREATE PROCEDURE Cust_smSiteGroup_smSOPricing
	@parm1	varchar(10),
	@parm2	varchar(15)
AS
	--Retrieve Customers in specified Cust Site Groups and having special pricing

	SELECT
		DISTINCT Customer.*
	FROM
		Customer
		JOIN smSiteGroupDet on Customer.CustID = smSiteGroupDet.CustID
		JOIN smSOPricing on smSiteGroupDet.CustId = smSOPricing.CustID AND smSiteGroupDet.CustSiteID = smSOPricing.ShipToID
	WHERE
		smSiteGroupDet.CustSiteGroupID LIKE @parm1 AND
		smSiteGroupDet.CustID LIKE @parm2		
	ORDER BY
		Customer.CustID

