 CREATE PROCEDURE sm_inventory_masked
	@parm1	varchar(30),
	@parm2	varchar(30)
AS
	--Used in SD03700 to allow PV on InvtID in detail grid to display only the inventory items matching
	--the InvtID wildcard mask entered in the selection criteria header.

	SELECT
		*
	FROM
		inventory
	WHERE
		invtid LIKE @parm1 AND
		InvtID LIKE @parm2
	ORDER BY
		invtid



