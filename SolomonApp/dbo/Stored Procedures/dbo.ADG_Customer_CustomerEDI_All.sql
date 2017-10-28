 CREATE PROCEDURE ADG_Customer_CustomerEDI_All
	@CustID varchar(15)
AS
	SELECT *
	FROM Customer
	WHERE Customer.CustId = @CustID
	AND Customer.Status IN ('A', 'O', 'R')


