 CREATE PROCEDURE Carrier_all @parm1 varchar( 10 )
AS
	SELECT *
	FROM Carrier
	WHERE CarrierID LIKE @parm1
	ORDER BY CarrierID


