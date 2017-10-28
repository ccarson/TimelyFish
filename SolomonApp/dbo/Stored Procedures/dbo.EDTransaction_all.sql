 CREATE PROCEDURE EDTransaction_all
 @parm1 varchar( 3 ),
 @parm2 varchar( 1 )
AS
 SELECT *
 FROM EDTransaction
 WHERE Trans LIKE @parm1
    AND Direction LIKE @parm2
 ORDER BY Trans,
    Direction


