CREATE PROCEDURE pXU010Inventory_InvtID
	-- CREATED BY: TJones
	-- CREATED ON: 6/06/05
	@parm1 varchar(30)
	AS
	SELECT *
	FROM Inventory
	WHERE InvtID LIKE @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXU010Inventory_InvtID] TO [MSDSL]
    AS [dbo];

