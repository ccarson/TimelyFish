 CREATE PROCEDURE smSOAddr_smSiteGr_smSOPri_Wild
	@parm1	varchar(10),
	@parm2	varchar(15),
	@parm3	varchar(10)
AS
	--Retrieve Cust Site IDs belonging to Cust Site Groups matching CustSiteGroup ID wildcard
	--and matching a Customer ID wildcard and having special pricing.
	--Note:  Different Customers can have the same Site ID representing a different actual location.

	SELECT
		DISTINCT smSOAddress.ShiptoID
	FROM
		smSOAddress
		JOIN SOAddress ON SOAddress.CustId = smSOAddress.CustID AND SOAddress.ShipToId = smSOAddress.ShiptoID
		JOIN smSiteGroupDet ON smSiteGroupDet.CustID = smSOAddress.CustID AND smSiteGroupDet.CustSiteID = smSOAddress.ShiptoID
		JOIN smSOPricing ON smSOPricing.CustID = smSOAddress.CustID AND smSOPricing.ShipToID = smSOAddress.ShiptoID
	WHERE
		smSiteGroupDet.CustSiteGroupID LIKE @parm1 AND
		smSOAddress.CustId LIKE @parm2 AND
		smSOAddress.ShiptoID LIKE @parm3
	ORDER BY
		smSOAddress.ShiptoID
		

