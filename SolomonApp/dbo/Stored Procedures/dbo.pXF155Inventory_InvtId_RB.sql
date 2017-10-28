CREATE PROCEDURE pXF155Inventory_InvtId_RB 
	@parm1 varchar (6), 
	@parm2 varchar (6), 
	@parm3 varchar (30) 
	AS 
    	SELECT * FROM Inventory 
	WHERE (ClassId = @parm1 or ClassId = @parm2) 
	AND InvtId LIKE @parm3
	ORDER BY InvtId
