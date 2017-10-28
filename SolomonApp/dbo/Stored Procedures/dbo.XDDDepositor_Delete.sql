
CREATE PROCEDURE XDDDepositor_Delete
   @VendCust		varchar(1),
   @VendID		varchar(15),
   @VendAcct		varchar(10)

AS
   DELETE
   FROM		XDDDepositor
   WHERE	VendCust = @VendCust
   		and VendID = @VendID
		and VendAcct = @VendAcct

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDDepositor_Delete] TO [MSDSL]
    AS [dbo];

