
CREATE PROCEDURE XDD_LockBox_Customer_PV
	@CustID		varchar(15)
AS
	SELECT * FROM XDD_vp_LB_Customer
	WHERE CustID LIKE @CustID
  	ORDER BY CustID

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDD_LockBox_Customer_PV] TO [MSDSL]
    AS [dbo];

