 CREATE PROCEDURE
	smServCall_CpnyID
		@parm1	varchar(1)
		,@parm2 varchar(10)
		,@parm3 varchar(10)
AS
	SELECT *
	FROM
		smServCall
	WHERE
		ServiceCallCompleted = CONVERT(int,@parm1)
			AND
		CpnyID = @parm2
			AND
		ServiceCallId LIKE @parm3
	ORDER BY
		ServiceCallId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smServCall_CpnyID] TO [MSDSL]
    AS [dbo];

