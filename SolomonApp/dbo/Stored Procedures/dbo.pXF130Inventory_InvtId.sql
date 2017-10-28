CREATE PROCEDURE pXF130Inventory_InvtId 
	@parm1 varchar (30) 
	AS 
    	SELECT * 
	FROM Inventory 
	WHERE InvtId = @parm1 
	AND TranStatusCode = 'AC'

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF130Inventory_InvtId] TO [MSDSL]
    AS [dbo];

