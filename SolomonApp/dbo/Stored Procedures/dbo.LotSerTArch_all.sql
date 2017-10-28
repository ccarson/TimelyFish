 CREATE PROCEDURE LotSerTArch_all
	@parm1 varchar( 25 ),
	@parm2min int, @parm2max int
AS
	SELECT *
	FROM LotSerTArch
	WHERE LotSerNbr LIKE @parm1
	   AND RecordID BETWEEN @parm2min AND @parm2max
	ORDER BY LotSerNbr,
	   RecordID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[LotSerTArch_all] TO [MSDSL]
    AS [dbo];

