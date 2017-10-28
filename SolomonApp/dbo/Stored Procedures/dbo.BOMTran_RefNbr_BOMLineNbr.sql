 CREATE PROCEDURE BOMTran_RefNbr_BOMLineNbr
	@parm1 varchar( 10 ),
	@parm2min smallint, @parm2max smallint
AS
	SELECT *
	FROM BOMTran
	WHERE RefNbr LIKE @parm1
	   AND BOMLineNbr BETWEEN @parm2min AND @parm2max
	ORDER BY RefNbr,
	   BOMLineNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BOMTran_RefNbr_BOMLineNbr] TO [MSDSL]
    AS [dbo];

