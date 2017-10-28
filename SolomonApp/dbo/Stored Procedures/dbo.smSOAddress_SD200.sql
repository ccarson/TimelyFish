 CREATE PROCEDURE
	smSOAddress_SD200
		@parm1 	varchar(15),
		@parm2 	varchar(10)
AS
	SELECT
		DefaultTechnician
	FROM
		smSOAddress (NOLOCK)
	WHERE
		CustID = @parm1 	AND
		ShiptoID = @parm2


