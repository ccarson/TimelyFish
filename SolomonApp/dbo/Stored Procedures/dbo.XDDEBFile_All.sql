
CREATE PROCEDURE XDDEBFile_All
  	@FileType1	varchar( 1 ),
  	@FileType2	varchar( 1 ),
  	@FileType3	varchar( 1 ),
  	@EBFileNbr	varchar( 6 )
AS

	SELECT		*
	FROM		XDDEBFile
	WHERE		(FileType = @FileType1
			or FileType = @FileType2
			or FileType = @FileType3)
			and EBFileNbr LIKE @EBFileNbr
	ORDER BY	EBFileNbr DESC

