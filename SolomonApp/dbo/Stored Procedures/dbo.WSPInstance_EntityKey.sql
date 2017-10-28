CREATE PROCEDURE WSPInstance_EntityKey @parm1 smallint
AS
	SELECT [EntityKey] FROM [WSPInstance] WHERE [SLTypeID] = @parm1 ORDER BY EntityKey
