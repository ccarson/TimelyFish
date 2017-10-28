
CREATE PROCEDURE XDDDepositor_XDDFileFormat
	@CustID		varchar( 15 )
AS
	SELECT		*
	FROM 		XDDDepositor D (nolock) LEFT OUTER JOIN XDDFileFormat F (nolock)
                	ON D.FormatID = F.FormatID
	WHERE		D.VendID = @CustID
			and D.VendCust = 'C'
