CREATE PROCEDURE WSPDoc_WSPInstance @parm1 smallint, @parm2 char(50)
AS
	SELECT DocumentType FROM WSPDoc WHERE Instance = @parm1 AND DocumentType LIKE @parm2 ORDER BY DocumentType
