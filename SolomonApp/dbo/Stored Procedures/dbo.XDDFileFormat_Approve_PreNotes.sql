
CREATE PROCEDURE XDDFileFormat_Approve_PreNotes
	@FormatID		varchar( 15 ),
	@Prog		varchar( 8 ),
	@User		varchar( 10 )

AS
	Declare	@CurrDate 	smalldatetime

	SELECT	@CurrDate = cast(convert(varchar(10), getdate(), 101) as smalldatetime)
	
	if exists(Select * from XDDDepositor (nolock) WHERE FormatID = @FormatID and PNStatus <> 'A')
	BEGIN

		-- First update Vendor.DirectDeposit
		UPDATE	Vendor
		SET		DirectDeposit = 'A',
				LUpd_Prog = @Prog,
				LUpd_User = @User,
				LUpd_DateTime = @CurrDate
		WHERE EXISTS (Select VendID FROM XDDDepositor D WHERE D.VendID = Vendor.VendID
					and D.VendCust = 'V'
					and D.FormatID = @FormatID
					and D.PNStatus <> 'A')
				
		-- Now Update XDDDepositor		
		UPDATE	XDDDepositor
		SET		PNStatus = 'A',
				PNDate = 0,
				LUpd_Prog = @Prog,
				LUpd_User = @User,
				LUpd_DateTime = @CurrDate
		WHERE	FormatID = @FormatID
					
	END
