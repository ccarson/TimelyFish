 CREATE PROCEDURE
	smServCall_CpnyID_EXE
		@parm1	varchar(1)
		,@parm2 varchar(10)
		,@parm3 varchar(10)
AS
	SELECT
		*
	FROM
		smServCall
	WHERE
		ServiceCallCompleted LIKE @parm1
			AND
		CpnyID = @parm2
			AND
		ServiceCallId LIKE @parm3
	ORDER BY
		ServiceCallId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smServCall_CpnyID_EXE] TO [MSDSL]
    AS [dbo];

