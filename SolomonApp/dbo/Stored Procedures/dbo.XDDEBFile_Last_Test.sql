
CREATE PROCEDURE XDDEBFile_Last_Test
  	@FileType	varchar( 1 ),
  	@EBFileNbr	varchar( 6 )

AS

	SELECT		*
	FROM		XDDEBFile (nolock)
	WHERE		FileType = @FileType
			and Batch_PreNote = 'T'
			and KeepDelete <> 'C'
			and EBFileNbr LIKE @EBFileNbr
	ORDER BY	EBFileNbr DESC		
