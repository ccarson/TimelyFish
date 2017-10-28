CREATE PROCEDURE CF341p_Inventory_InvtId_RB @parm1 varchar (6), @parm2 varchar (6), @parm3 varchar (30) as 
	SELECT * FROM Inventory 
	WHERE (ClassId = @parm1 or ClassId = @parm2) 
	AND InvtId Like @parm3
	ORDER BY InvtId
