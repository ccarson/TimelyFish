 CREATE PROCEDURE CustContact_all
	@parm1 varchar( 15 ),
	@parm2 varchar( 10 )
AS
	SELECT *
	FROM CustContact
	WHERE CustID LIKE @parm1
	   AND ContactID LIKE @parm2
	ORDER BY CustID,
	   ContactID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[CustContact_all] TO [MSDSL]
    AS [dbo];

