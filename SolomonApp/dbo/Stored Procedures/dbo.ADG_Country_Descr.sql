 CREATE PROCEDURE ADG_Country_Descr
	@parm1 varchar(3)
AS
	Select	Descr
	from	Country
	where CountryID = @parm1

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


