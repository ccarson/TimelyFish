 CREATE PROCEDURE ADG_Carrier_Descr @parm1 VARCHAR(10)
AS
	SELECT Descr
	FROM 	Carrier
	WHERE CarrierID = @parm1


