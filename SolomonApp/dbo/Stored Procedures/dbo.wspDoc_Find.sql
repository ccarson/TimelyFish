CREATE PROCEDURE wspDoc_Find @parm1 smallint, @parm2 smallint
AS
	SELECT *
	FROM wspdoc
	WHERE instance = @parm1
		AND documentid = @parm2

GO
GRANT CONTROL
    ON OBJECT::[dbo].[wspDoc_Find] TO [MSDSL]
    AS [dbo];

