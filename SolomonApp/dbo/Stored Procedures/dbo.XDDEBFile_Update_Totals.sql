
CREATE PROCEDURE XDDEBFile_Update_Totals
  	@FileType	varchar( 1 ),
  	@EBFileNbr	varchar( 6 )

AS
	declare @BaseCuryPrec	smallint

	-- Get the base currency precision
	SET	@BaseCuryPrec = 2
	
	SELECT	@BaseCuryPrec = c.DecPl
	FROM	GLSetup s (NOLOCK),
		Currncy c (NOLOCK)
	WHERE	s.BaseCuryID = c.CuryID

	UPDATE	XDDEBFile
	SET	BatchCount = coalesce((Select count(*) FROM XDDBatch B (nolock) Where B.FileType = @FileType and B.EBFileNbr = @EBFileNbr), 0),
    		BatchTotal = coalesce((Select sum(round(B.CuryCtrlTot, @BaseCuryPrec)) FROM Batch B (nolock) LEFT OUTER JOIN XDDBatch X (nolock)
  						ON B.Module = X.Module and B.BatNbr = X.BatNbr
  						WHERE 	X.FileType = @FileType
  							and X.EBFileNbr = @EBFileNbr), 0)
	WHERE 	FileType = @FileType
		and EBFileNbr = @EBFileNbr
