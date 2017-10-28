 CREATE PROCEDURE Inventory_smSOPricing
	@parm1	varchar(30)
AS
	--Retrieve Inventory items with special pricing

	SELECT
		DISTINCT Inventory.*
	FROM
		Inventory
		JOIN smSOPricing on Inventory.InvtID = smSOPricing.Invtid
	WHERE
		Inventory.InvtID LIKE @parm1
	ORDER BY
		Inventory.InvtID

