
CREATE PROCEDURE XDDDepositor_Delete_Check
	@VendCust		varchar(1),
	@VendID			varchar(15),
	@VendAcct		varchar(10)

As

	Declare	@EFTTerms	varchar( 3 )

	if @VendCust = 'V'
	BEGIN
		-- APDocs - OpenDocs, eStatus <> '' and VendID/VendAcct
		Select count(*)	FROM APDoc (nolock)
			WHERE VendID = @VendID
				and eConfirm = @VendAcct
				and eStatus <> ''
				and ((OpenDoc = 1 and DocClass = 'N')
	    			    or (DocClass = 'R'))
	END

	else

	BEGIN

		-- ARDocs - OpenDoc, Terms LIKE EFT Terms code
		Select	@EFTTerms = ARTermsID
		FROM	XDDSetup (nolock)

		SET	@EFTTerms = Replace(@EFTTerms, '*', '%')
		SET	@EFTTerms = Replace(@EFTTerms, '?', '_')


		Select count(*)	FROM ARDoc (nolock)
			WHERE CustID = @VendID
				and Terms LIKE @EFTTerms
				and ((OpenDoc = 1 and DocClass = 'N')
	    			    or (DocClass = 'R'))

	END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDDepositor_Delete_Check] TO [MSDSL]
    AS [dbo];

