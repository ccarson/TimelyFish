 CREATE PROCEDURE Warehouse_Location
	@parm1 varchar(30),
	@parm2 varchar(10),
        @parm3 varchar(10)
AS
	Select *
	FROM	Location
	WHERE	Invtid = @parm1
	  AND	Siteid = @parm2
          AND   Whseloc Like @Parm3
        Order By Invtid,Siteid,WhseLoc


