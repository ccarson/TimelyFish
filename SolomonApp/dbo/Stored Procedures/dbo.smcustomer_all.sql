 CREATE PROCEDURE smcustomer_all
	@parm1 varchar(15)
AS
SELECT *
FROM customer
	left outer join smCustomer
		on customer.CustId = smCustomer.CustId
WHERE customer.custid LIKE @parm1
ORDER BY customer.custid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smcustomer_all] TO [MSDSL]
    AS [dbo];

