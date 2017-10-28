 CREATE PROCEDURE Customer_smSOPricing
	@parm1	varchar(15)
AS
	--Retrieve Customers with special pricing

	SELECT
		DISTINCT Customer.*
	FROM
		Customer
		JOIN smSOPricing on Customer.CustId = smSOPricing.CustID
	WHERE
		Customer.CustId LIKE @parm1
	ORDER BY
		Customer.CustId

