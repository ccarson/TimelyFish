 CREATE PROCEDURE smSOAddr_smSOPricing_CustID
	@parm1	varchar(15),
	@parm2	varchar(10)
AS
	--Retrieve Customer Sites with special pricing

	SELECT
		DISTINCT smSOAddress.*
	FROM
		smSOAddress
		JOIN SOAddress ON SOAddress.CustId = smSOAddress.CustID AND SOAddress.ShipToId = smSOAddress.ShiptoID
		JOIN smSOPricing ON smSOPricing.CustID = smSOAddress.CustID AND smSOPricing.ShipToID = smSOAddress.ShiptoID
	WHERE
		smSOAddress.CustId = @parm1 AND
		smSOAddress.ShiptoID LIKE @parm2
	ORDER BY
		smSOAddress.ShiptoID
		

