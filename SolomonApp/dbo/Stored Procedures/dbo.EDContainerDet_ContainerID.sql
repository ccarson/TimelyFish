 CREATE PROCEDURE EDContainerDet_ContainerID
 @parm1 varchar( 10 )
AS
 SELECT *
 FROM EDContainerDet
 WHERE ContainerID LIKE @parm1
 ORDER BY ContainerID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDContainerDet_ContainerID] TO [MSDSL]
    AS [dbo];

