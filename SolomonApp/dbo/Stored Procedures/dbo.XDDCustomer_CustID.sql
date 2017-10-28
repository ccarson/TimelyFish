CREATE PROCEDURE XDDCustomer_CustID
  @CustID	varchar(15)
AS
  Select      	*
  FROM        	Customer
  WHERE       	CustID LIKE @CustID
  ORDER BY    	CustID

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDCustomer_CustID] TO [MSDSL]
    AS [dbo];

