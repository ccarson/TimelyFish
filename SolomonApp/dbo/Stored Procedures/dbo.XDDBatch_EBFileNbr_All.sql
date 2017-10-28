
CREATE PROCEDURE XDDBatch_EBFileNbr_All
  	@FileType	varchar( 1 ),
  	@EBFileNbr	varchar( 6 ),
  	@BatNbr		varchar( 10 )
AS

	SELECT		*
	FROM		XDDBatch 
	WHERE		FileType = @FileType
			and EBFileNbr = @EBFileNbr
			and BatNbr LIKE @BatNbr
	ORDER BY	BatNbr DESC

