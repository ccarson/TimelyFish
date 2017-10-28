 CREATE PROCEDURE EDContainer_ContainerID
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM EDContainer
	WHERE ContainerID LIKE @parm1
	ORDER BY ContainerID


