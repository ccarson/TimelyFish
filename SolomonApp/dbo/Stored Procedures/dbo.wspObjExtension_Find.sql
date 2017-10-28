CREATE PROCEDURE wspObjExtension_Find @parm1 smallint, @parm2 varchar(60)
AS 
	SELECT * 
	FROM wspObjExtension
	WHERE sltypeid = @parm1
		AND slobjid = @parm2

GO
GRANT CONTROL
    ON OBJECT::[dbo].[wspObjExtension_Find] TO [MSDSL]
    AS [dbo];

