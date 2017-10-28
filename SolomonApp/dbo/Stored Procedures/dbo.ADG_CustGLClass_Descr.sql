 CREATE PROCEDURE ADG_CustGLClass_Descr
	@parm1 varchar (10)
AS
	select	Descr
	from	CustGLClass
	where	GLClassID = @parm1

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


