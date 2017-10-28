 CREATE PROCEDURE EDITranSet_all
 @parm1 varchar( 6 )
AS
 SELECT *
 FROM EDITranSet
 WHERE TranSetID LIKE @parm1
 ORDER BY TranSetID


