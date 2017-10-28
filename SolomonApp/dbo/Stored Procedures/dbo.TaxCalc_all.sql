 CREATE PROCEDURE TaxCalc_all
	@parm1min int, @parm1max int
AS
	SELECT *
	FROM TaxCalc
	WHERE DetLineID BETWEEN @parm1min AND @parm1max
	ORDER BY DetLineID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[TaxCalc_all] TO [MSDSL]
    AS [dbo];

