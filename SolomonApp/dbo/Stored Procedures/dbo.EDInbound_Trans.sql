 CREATE PROCEDURE EDInbound_Trans
 @parm1 varchar( 3 )
AS
 SELECT *
 FROM EDInbound
 WHERE Trans LIKE @parm1
 ORDER BY Trans


