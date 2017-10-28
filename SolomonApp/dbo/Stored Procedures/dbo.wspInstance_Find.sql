CREATE PROCEDURE wspInstance_Find @parm1 smallint
AS
	SELECT * 
	FROM wspinstance
	WHERE sltypeid = @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[wspInstance_Find] TO [MSDSL]
    AS [dbo];

