 CREATE PROCEDURE smSOAddr_smSiteGr_smSOPricing
	@parm1	varchar(10),
	@parm2	varchar(15),
	@parm3	varchar(10)
AS
	--Retrieve Cust Sites belonging to Cust Site Groups matching CustSiteGroup ID wildcard and matching a specific Customer ID
	--and having special pricing

	SELECT
		DISTINCT SOAddress.*
	FROM
		SOAddress
		JOIN smSOAddress ON SOAddress.CustId = smSOAddress.CustID AND SOAddress.ShipToId = smSOAddress.ShiptoID
		JOIN smSiteGroupDet ON smSiteGroupDet.CustID = smSOAddress.CustID AND smSiteGroupDet.CustSiteID = smSOAddress.ShiptoID
		JOIN smSOPricing ON smSOPricing.CustID = smSOAddress.CustID AND smSOPricing.ShipToID = smSOAddress.ShiptoID
	WHERE
		smSiteGroupDet.CustSiteGroupID LIKE @parm1 AND
		smSOAddress.CustId = @parm2 AND
		smSOAddress.ShiptoID LIKE @parm3
	ORDER BY
		SOAddress.ShiptoID
		

