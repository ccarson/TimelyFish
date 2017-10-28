 CREATE PROCEDURE
	smEmpSchedule_ALL
		@parm1	varchar(10)
		,@parm2beg	smallint
		,@parm2end	smallint
AS
	SELECT
		*
	FROM
		smEmpSchedule
	WHERE
		EmpID = @parm1
			AND
		LineNbr BETWEEN @parm2beg AND @parm2end
	ORDER BY
		EmpID,
		StartDate



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smEmpSchedule_ALL] TO [MSDSL]
    AS [dbo];

