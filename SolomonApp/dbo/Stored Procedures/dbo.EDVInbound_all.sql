 CREATE PROCEDURE EDVInbound_all
 @parm1 varchar( 15 ),
 @parm2 varchar( 3 )
AS
 SELECT *
 FROM EDVInbound
 WHERE VendId LIKE @parm1
    AND Trans LIKE @parm2
 ORDER BY VendId,
    Trans


