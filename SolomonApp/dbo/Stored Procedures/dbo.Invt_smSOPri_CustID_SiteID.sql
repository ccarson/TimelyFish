 CREATE PROCEDURE Invt_smSOPri_CustID_SiteID
	@parm1	varchar(15),
	@parm2	varchar(10),
	@parm3	varchar(30)
AS
	--Retrieve Inventory items with special pricing matching Cust ID and Site ID wildcards

	SELECT
		DISTINCT Inventory.*
	FROM
		Inventory
		JOIN smSOPricing on Inventory.InvtID = smSOPricing.Invtid
	WHERE
		smSOPricing.CustID LIKE @parm1 AND
		smSOPricing.ShipToID LIKE @parm2 AND
		Inventory.InvtID LIKE @parm3
	ORDER BY
		Inventory.InvtID

