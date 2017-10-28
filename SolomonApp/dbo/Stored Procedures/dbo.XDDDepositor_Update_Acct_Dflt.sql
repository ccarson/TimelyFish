
CREATE PROCEDURE XDDDepositor_Update_Acct_Dflt
	@VendCust	varchar(1),
	@VendID 	varchar(15),
	@VendAcct	varchar(10)
AS

	Update XDDDepositor
	Set VendAcctDflt = case VendAcct
				When @VendAcct Then 1
				else 0
			end
	Where VendCust= @VendCust
	and VendID = @VendID

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDDepositor_Update_Acct_Dflt] TO [MSDSL]
    AS [dbo];

