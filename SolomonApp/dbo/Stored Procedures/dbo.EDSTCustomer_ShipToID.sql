 CREATE PROCEDURE EDSTCustomer_ShipToID
 @parm1 varchar( 10 )
AS
 SELECT *
 FROM EDSTCustomer
 WHERE ShipToID LIKE @parm1
 ORDER BY ShipToID


