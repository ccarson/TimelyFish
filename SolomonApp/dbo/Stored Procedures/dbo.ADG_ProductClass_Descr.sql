 CREATE PROCEDURE ADG_ProductClass_Descr
	@parm1 varchar(6)
AS
	SELECT Descr
	FROM ProductClass
	WHERE ClassID = @parm1

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


