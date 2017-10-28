 CREATE PROCEDURE smSOAddr_smSOPri_CustID_Wild
	@parm1	varchar(15),
	@parm2	varchar(10)
AS
	--Retrieve Customer Site IDs with special pricing and matching Cust ID wildcard.
	--Note:  The same Site ID can represent different actual locations for different Customers.
	SELECT
		DISTINCT smSOAddress.ShiptoID
	FROM
		smSOAddress
		JOIN SOAddress ON SOAddress.CustId = smSOAddress.CustID AND SOAddress.ShipToId = smSOAddress.ShiptoID
		JOIN smSOPricing ON smSOPricing.CustID = smSOAddress.CustID AND smSOPricing.ShipToID = smSOAddress.ShiptoID
	WHERE
		smSOAddress.CustId LIKE @parm1 AND
		smSOAddress.ShiptoID LIKE @parm2
	ORDER BY
		smSOAddress.ShiptoID
		

