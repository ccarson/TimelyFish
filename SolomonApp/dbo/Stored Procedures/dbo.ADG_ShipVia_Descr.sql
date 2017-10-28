 CREATE PROCEDURE ADG_ShipVia_Descr
	@parm1 varchar(10),
	@parm2 varchar(15)
AS
	Select	Descr
	from	ShipVia
	where	CpnyID = @parm1
	  and 	ShipViaID = @parm2

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


