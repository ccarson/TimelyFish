 CREATE PROCEDURE EDContainerDet_ShipperId
 @parm1 varchar( 15 )
AS
 SELECT *
 FROM EDContainerDet
 WHERE ShipperId LIKE @parm1
 ORDER BY ShipperId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDContainerDet_ShipperId] TO [MSDSL]
    AS [dbo];

