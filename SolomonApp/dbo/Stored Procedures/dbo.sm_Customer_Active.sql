 CREATE PROCEDURE
	sm_Customer_Active
		@parm1	varchar(15)
AS
	SELECT
		*
	FROM
		Customer
	WHERE
		CustId LIKE @parm1
	And
		Status In ('A', 'O')
	ORDER BY
		custid

