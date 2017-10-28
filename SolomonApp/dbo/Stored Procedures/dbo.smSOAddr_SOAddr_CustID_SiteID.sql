 CREATE PROCEDURE
	smSOAddr_SOAddr_CustID_SiteID
		@parm1 	varchar(15),
		@parm2  varchar(10)
AS
	SELECT
		*
	FROM
		smSOAddress
		JOIN SOAddress ON smSOAddress.CustID = SOAddress.CustId AND smSOAddress.ShiptoID = SOAddress.ShipToId
	WHERE
		smSOAddress.CustID = @parm1 AND
		smSOAddress.ShiptoID like @parm2
		
	ORDER BY
		smSOAddress.ShiptoID

