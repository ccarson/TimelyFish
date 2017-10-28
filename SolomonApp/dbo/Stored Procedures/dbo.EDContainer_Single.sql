 CREATE PROCEDURE EDContainer_Single
 @parm3 varchar( 10 )

AS
 SELECT *
 FROM EDContainer
 WHERE  ContainerID = @parm3
 ORDER BY CpnyId,
    ShipperId,
    ContainerID


