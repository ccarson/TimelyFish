CREATE PROCEDURE XDDBatch_BatNbr
	@Module		varchar( 2 ),
	@FileType	varchar( 1 ),
	@BatNbr		varchar( 10 )
AS
  	Select 		*
  	FROM 		XDDBatch
  	WHERE 		Module = @Module
  			and FileType = @FileType
  			and BatNbr LIKE @BatNbr
  	ORDER BY	BatNbr DESC		
