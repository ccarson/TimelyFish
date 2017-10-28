 /****** Object:  Stored Procedure dbo.EDContainerDet_all    Script Date: 5/28/99 1:17:40 PM ******/
CREATE PROCEDURE EDContainerDet_allDMG
 @parm1 varchar( 10 ),
 @parm2 varchar( 15 ),
 @parm3 varchar( 5 ),
 @parm4 varchar( 10 )
AS
 SELECT *
 FROM EDContainerDet
 WHERE CpnyId LIKE @parm1
    AND ShipperId LIKE @parm2
    AND LineRef LIKE @parm3
    AND ContainerID LIKE @parm4
 ORDER BY CpnyId,
    ShipperId,
    LineRef,
    ContainerID


