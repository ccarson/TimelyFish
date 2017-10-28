 CREATE PROCEDURE smSiteGroup_smSOPricing
	@parm1	varchar(10)
AS
	--Retrieve Cust Site Groups with special pricing

	SELECT
		DISTINCT smSiteGroup.*
	FROM
		smSiteGroup
		JOIN smSiteGroupDet on smSiteGroup.CustSiteGroupID = smSiteGroupDet.CustSiteGroupID
		JOIN smSOPricing on smSiteGroupDet.CustId = smSOPricing.CustID AND smSiteGroupDet.CustSiteID = smSOPricing.ShipToID
	WHERE
		smSiteGroup.CustSiteGroupID LIKE @parm1
	ORDER BY
		smSiteGroup.CustSiteGroupID

