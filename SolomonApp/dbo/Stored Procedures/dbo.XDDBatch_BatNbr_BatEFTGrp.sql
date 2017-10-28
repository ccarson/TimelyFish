CREATE PROCEDURE XDDBatch_BatNbr_BatEFTGrp
	@Module		varchar( 2 ),
	@FileType	varchar( 1 ),
	@BatNbr		varchar( 10 ),
	@BatSeq		smallint,
	@BatEFTGrp	smallint
AS
  	Select 		*
  	FROM 		XDDBatch
  	WHERE 		Module = @Module
  			and FileType = @FileType
  			and BatNbr = @BatNbr
  			and BatSeq = @BatSeq
  			and BatEFTGrp LIKE @BatEFTGrp
  	ORDER BY	BatNbr DESC, BatSeq DESC, BatEFTGrp DESC
