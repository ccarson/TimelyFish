 CREATE PROCEDURE EDSTCustomer_all
 @parm1 varchar( 15 ),
 @parm2 varchar( 10 )
AS
 SELECT *
 FROM EDSTCustomer
 WHERE CustID LIKE @parm1
    AND ShipToID LIKE @parm2
 ORDER BY CustID,
    ShipToID


