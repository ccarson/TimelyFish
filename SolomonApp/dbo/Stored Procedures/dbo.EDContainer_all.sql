 CREATE PROCEDURE EDContainer_all
 @parm3 varchar( 10 )

AS
 SELECT *
 FROM EDContainer
 WHERE  ContainerID LIKE @parm3
 ORDER BY CpnyId,
    ShipperId,
    ContainerID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDContainer_all] TO [MSDSL]
    AS [dbo];

