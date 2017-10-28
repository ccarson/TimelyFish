
CREATE PROCEDURE XDDTxnTypeDep_Delete
   @VendCust		varchar(1),
   @VendID		varchar(15),
   @VendAcct		varchar(10)

AS
   DELETE
   FROM		XDDTxnTypeDep
   WHERE	VendCust = @VendCust
   		and VendID = @VendID
		and VendAcct = @VendAcct

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDTxnTypeDep_Delete] TO [MSDSL]
    AS [dbo];

