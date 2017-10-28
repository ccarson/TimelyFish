
CREATE PROCEDURE XDDDepositor_Check_AcctDefault
	@VendCust	varchar(1),
	@VendID 	varchar(15)

AS
  Select      	*
  FROM        	XDDDepositor
  WHERE       	VendCust = 'V'
		and VendID = @VendID
		and VendAcctDflt= 1
		and Status = 'Y'

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDDepositor_Check_AcctDefault] TO [MSDSL]
    AS [dbo];

