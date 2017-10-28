CREATE PROCEDURE WSPDoc_ById @parm1 smallint
AS
	SELECT * FROM WSPDoc WHERE DocumentID = @parm1 ORDER BY DocumentID
