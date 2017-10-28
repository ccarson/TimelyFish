 CREATE PROCEDURE ADG_InventoryADG_all
	@parm1 varchar( 30 )
AS
	SELECT *
	FROM InventoryADG
	WHERE InvtID LIKE @parm1
	ORDER BY InvtID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_InventoryADG_all] TO [MSDSL]
    AS [dbo];

