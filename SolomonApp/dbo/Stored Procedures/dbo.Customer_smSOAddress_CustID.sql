CREATE PROCEDURE
	Customer_smSOAddress_CustID
		@parm1 	varchar(15)
AS
	SELECT
		*
	FROM
		Customer
	WHERE
		CustID LIKE @parm1 AND 
		CustID IN (Select Distinct CustID FROM smSOAddress)
	ORDER BY
		CustID


