CREATE PROCEDURE WSPDoc_InstanceById @parm1 smallint
AS
	SELECT Instance FROM WSPDoc WHERE DocumentID = @parm1 ORDER BY DocumentID
