 CREATE PROCEDURE Invt_smSOPri_SiteGr_Cust_Site
	@parm1	varchar(10),
	@parm2	varchar(15),
	@parm3	varchar(10),
	@parm4	varchar(30)
AS
	--Retrieve Inventory items with special pricing matching Cust Site ID, Cust ID, and Site ID wildcards

	SELECT
		DISTINCT Inventory.*
	FROM
		Inventory
		JOIN smSOPricing ON Inventory.InvtID = smSOPricing.Invtid
		JOIN smSiteGroupDet ON smSiteGroupDet.CustID = smSOPricing.CustID AND smSiteGroupDet.CustSiteID = smSOPricing.ShipToID
	WHERE
		smSiteGroupDet.CustSiteGroupID LIKE @parm1 AND
		smSOPricing.CustID LIKE @parm2 AND
		smSOPricing.ShipToID LIKE @parm3 AND
		Inventory.InvtID LIKE @parm4
	ORDER BY
		Inventory.InvtID

