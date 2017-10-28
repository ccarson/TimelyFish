 CREATE PROCEDURE EDSOHeader_OrdNbr
 @parm1 varchar( 15 )
AS
 SELECT *
 FROM EDSOHeader
 WHERE OrdNbr LIKE @parm1
 ORDER BY OrdNbr


