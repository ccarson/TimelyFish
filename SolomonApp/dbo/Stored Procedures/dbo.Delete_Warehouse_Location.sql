 CREATE PROCEDURE Delete_Warehouse_Location
	@parm1 varchar(10),
	@parm2 varchar(10)
AS
	Delete
	FROM	LocTable
	WHERE	Siteid = @parm1
	  AND	WhseLoc = @parm2


