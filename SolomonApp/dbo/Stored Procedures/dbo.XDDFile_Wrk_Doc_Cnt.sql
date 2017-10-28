
CREATE PROCEDURE XDDFile_Wrk_Doc_Cnt
  	@EBFileNbr	varchar( 6 ),
  	@FileType	varchar( 1 ),
  	@VendCustID	varchar( 15 ),
	@VendAcct	varchar( 10 )
AS

	SELECT		Count(Distinct ChkRefNbr)
	FROM            XDDFile_Wrk (nolock)
	WHERE		EBFileNbr = @EBFileNbr
			and FileType = @FileType
			and VendID = @VendCustID
			and VendAcct = @VendAcct

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDFile_Wrk_Doc_Cnt] TO [MSDSL]
    AS [dbo];

