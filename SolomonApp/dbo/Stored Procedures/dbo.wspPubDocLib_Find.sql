CREATE PROCEDURE wspPubDocLib_Find @parm1 smallint, @parm2 varchar(60), @parm3 smallint
AS
	SELECT *
	FROM wsppubdoclib
	WHERE sltypeid = @parm1
		AND slobjid = @parm2
		AND DocumentID = @parm3

GO
GRANT CONTROL
    ON OBJECT::[dbo].[wspPubDocLib_Find] TO [MSDSL]
    AS [dbo];

