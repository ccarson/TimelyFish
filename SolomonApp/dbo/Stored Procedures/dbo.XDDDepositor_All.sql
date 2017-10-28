
CREATE PROCEDURE XDDDepositor_All
	@VendCust	varchar(1),
	@ID 		varchar(15),
	@Acct   	varchar(10)
AS
	SELECT *
	FROM XDDDepositor
	WHERE VendCust = @VendCust
	and VendID like @ID
	and VendAcct LIKE @Acct
  	ORDER BY VendID, VendAcct

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDDepositor_All] TO [MSDSL]
    AS [dbo];

