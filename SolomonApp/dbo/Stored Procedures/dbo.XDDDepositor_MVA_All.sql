
CREATE PROCEDURE XDDDepositor_MVA_All
	@VendCust	varchar(1),
	@ID 		varchar(15),
	@VendAcct	varchar(10)
AS
	SELECT *
	FROM XDDDepositor
	WHERE VendCust LIKE @VendCust
	and VendID LIKE @ID
	and VendAcct LIKE @VendAcct
  	ORDER BY VendCust, VendID, VendAcct 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDDepositor_MVA_All] TO [MSDSL]
    AS [dbo];

