﻿ CREATE PROCEDURE ADG_CustContact_by_Type
	@parm1 varchar(15),
	@parm2 varchar(2),
	@parm3 varchar(10)
AS
	SELECT *
	FROM CustContact
	WHERE CustID LIKE @parm1
	   AND Type LIKE @parm2
	   AND ContactID LIKE @parm3
	ORDER BY CustID,
	   ContactID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


