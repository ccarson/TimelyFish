 CREATE PROCEDURE Company_all
	@CpnyID varchar( 10 )

WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
	SELECT *
	FROM vs_Company
	WHERE CpnyID LIKE @CpnyID
	ORDER BY CpnyID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Company_all] TO [MSDSL]
    AS [dbo];

