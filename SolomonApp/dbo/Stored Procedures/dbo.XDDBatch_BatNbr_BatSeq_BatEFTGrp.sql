CREATE PROCEDURE XDDBatch_BatNbr_BatSeq_BatEFTGrp
	@Module		varchar( 2 ),
	@BatNbr		varchar( 10 ),
	@FileType	varchar( 1 ),
	@BatSeq		smallint,
	@BatEFTGrp	smallint
AS
  	Select 		*
  	FROM 		XDDBatch
  	WHERE 		Module = @Module
  			and BatNbr = @BatNbr
  			and FileType = @FileType
  			and BatSeq = @BatSeq
  			and BatEFTGrp = @BatEFTGrp
