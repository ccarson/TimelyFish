
CREATE PROCEDURE XDDDepositor_Set_Acct_Dflt
	@VendCust	varchar(1),
	@VendID 	varchar(15),
	@VendAcct	varchar(10)
AS

	Update XDDDepositor
	Set VendAcctDflt = 1
	Where VendCust= @VendCust
	and VendID = @VendID
	and VendAcct = @VendAcct

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDDepositor_Set_Acct_Dflt] TO [MSDSL]
    AS [dbo];

