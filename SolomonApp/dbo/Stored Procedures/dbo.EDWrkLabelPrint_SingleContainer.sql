 CREATE PROCEDURE EDWrkLabelPrint_SingleContainer
 @ContainerId varchar( 10 )
AS
 SELECT *
 FROM EDWrkLabelPrint
 WHERE  ContainerID LIKE  @ContainerId
 ORDER BY
    ContainerID


