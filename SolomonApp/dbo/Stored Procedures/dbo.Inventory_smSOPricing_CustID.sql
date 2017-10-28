 CREATE PROCEDURE Inventory_smSOPricing_CustID
	@parm1	varchar(15),
	@parm2	varchar(30)
AS
	--Retrieve Inventory items with special pricing matching a Customer wildcard

	SELECT
		DISTINCT Inventory.*
	FROM
		Inventory
		JOIN smSOPricing on Inventory.InvtID = smSOPricing.Invtid
	WHERE
		smSOPricing.CustID LIKE @parm1 AND
		Inventory.InvtID LIKE @parm2
	ORDER BY
		Inventory.InvtID

