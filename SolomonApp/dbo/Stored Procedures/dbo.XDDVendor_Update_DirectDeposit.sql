CREATE PROCEDURE XDDVendor_Update_DirectDeposit
	@VendID 	varchar(15),
	@PNStatus	varchar( 1 )
AS
	UPDATE	Vendor
	SET	DirectDeposit = @PNStatus
	WHERE	VendID = @VendID

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDVendor_Update_DirectDeposit] TO [MSDSL]
    AS [dbo];

