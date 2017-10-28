 CREATE PROCEDURE EDPurchOrd_all
 @parm1 varchar( 10 )
AS
 SELECT *
 FROM EDPurchOrd
 WHERE PONbr LIKE @parm1
 ORDER BY PONbr


