
CREATE PROCEDURE XDDBatch_Update
	@Module		varchar( 2 ),
	@BatNbr		varchar( 10 ),
	@FileType 	varchar( 1 ),
	@BatSeq		smallint,
	@BatEFTGrp	smallint,
  	@UpdField	varchar( 10 ),	-- EBFILENBR
  	@UpdValue	varchar( 30 ),
  	@UpdUser	varchar( 10 ),
  	@UpdProg	varchar( 5 )

AS

	Declare		@CurrDate	smalldatetime
	Declare		@CurrTime	smalldatetime
		
	SELECT @CurrDate = GetDate()
--	SELECT @CurrTime = cast(convert(varchar(10), getdate(), 108) as smalldatetime)

	if not exists(Select * from XDDBatch (nolock) 
		WHERE	Module = @Module
			and BatNbr = @BatNbr
			and FileType = @FileType
			and BatSeq = @BatSeq
			and BatEFTGrp = @BatEFTGrp)
	BEGIN	
		INSERT INTO XDDBatch
		(Module, BatNbr, FileType, BatSeq, BatEFTGrp,
		 Crtd_DateTime, Crtd_Prog, Crtd_User)
		VALUES
		(@Module, @BatNbr, @FileType, @BatSeq, @BatEFTGrp,
		 @CurrDate, @UpdProg, @UpdUser)
	END

	UPDATE		XDDBatch
	SET		EBFileNbr = case when @UpdField = 'EBFILENBR'
				then @UpdValue
				else EBFileNbr
				end,
			LUpd_DateTime = @CurrDate,
			LUpd_Prog = @UpdProg,
			LUpd_User = @UpdUser
	WHERE		Module = @Module
			and BatNbr = @BatNbr
			and FileType = @FileType
			and BatSeq = @BatSeq
			and BatEFTGrp = @BatEFTGrp

