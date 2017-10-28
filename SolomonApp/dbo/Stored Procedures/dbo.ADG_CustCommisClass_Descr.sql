 CREATE PROCEDURE ADG_CustCommisClass_Descr
	@parm1 varchar (10)
AS
	select	Descr
	from	CustCommisClass
	where	ClassID = @parm1

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


