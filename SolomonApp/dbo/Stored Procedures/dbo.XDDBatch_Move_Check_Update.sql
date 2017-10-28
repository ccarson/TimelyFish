
CREATE PROCEDURE XDDBatch_Move_Check_Update
	@Mode		varchar( 1 ),		-- "C"heck, "M"ove
	@BatNbr		varchar( 10 ),
	@CpnyID		varchar( 10 ),
	@Acct		varchar( 10 ),
	@SubAcct	varchar( 24 ),
	@OldFileType	varchar( 1 ),
	@NewFileType	varchar( 1 ),
	@Crtd_Prog	varchar( 8 ),
	@Crtd_User	varchar( 10 )
AS

	Declare @CheckCnt	int
	Declare	@CurrDate	smalldatetime
	Declare	@CurrTime	smalldatetime
	Declare @EBFileNbr	varchar( 6 )
	Declare @FormatID	varchar( 15 )
	Declare @PmtTotal	float
	Declare @VoucherCnt	int

	SELECT @CurrDate = GetDate()
	SELECT @CurrTime = cast(convert(varchar(10), getdate(), 108) as smalldatetime)
	
	SET	@FormatID = ''
	SELECT	@FormatID = PPFormatID
	FROM	XDDBank (nolock)
  	WHERE	CpnyID = @CpnyID
  		and Acct = @Acct
  		and Sub = @SubAcct
	
	if @Mode = 'C'

	BEGIN
	-- Check:
	--	1) Pos Pay format exists for this Cpny/Acct/Sub
	--	2) Number of checks/vouchers that will have eStatus blanked
		
		SET	@VoucherCnt = 0	
		SELECT 	@VoucherCnt = count(*)
		FROM	APAdjust A (nolock) LEFT OUTER JOIN APDoc V (nolock)
			ON A.VendID = V.VendID and A.AdjdRefNbr = V.RefNbr and A.AdjdDocType = V.DocType
		WHERE	A.AdjBatNbr = @BatNbr
			and V.eStatus <> ''
		
		SET 	@CheckCnt = 0
		SELECT 	@CheckCnt = count(Distinct AdjgRefNbr)
		FROM	APAdjust A (nolock) 
		WHERE	A.AdjBatNbr = @BatNbr
		
		-- Return PPFormatID (blank if not found)
		SELECT	@FormatID, @VoucherCnt, @CheckCnt
	END

	else

	BEGIN
	-- Move 

		-- Set eStatus to SL Check for all vouchers in this batch
		UPDATE	APDoc
		SET	eStatus = ''
		FROM	APDoc INNER JOIN APAdjust (nolock)
			ON APAdjust.AdjBatNbr = @BatNbr
			and APDoc.VendID = APAdjust.VendID
			and APDoc.DocType = APAdjust.AdjdDocType
			and APDoc.RefNbr = APAdjust.AdjdRefNbr
		
		-- Update XDDEBFile - Get XDDBatch values
		SET	@EBFileNbr = ''
		SET	@PmtTotal = 0
		SELECT	@EBFileNbr = EBFileNbr,
			@PmtTotal = PmtTotal
		FROM	XDDBatch (nolock)
		WHERE	BatNbr = @BatNbr
		  	and FileType = @OldFileType
		  	
		-- Update XDDEBFile - Reduce BatchCount and BatchTotal
		UPDATE	XDDEBFile
		SET	BatchCount = BatchCount - 1,
			BatchTotal = BatchTotal - @PmtTotal
		WHERE	EBFileNbr = @EBFileNbr
			and FileType = @OldFileType
							
		-- If Move from XDDBatch does not yet exist
		if not exists(SELECT * from XDDBatch (nolock)
			WHERE	BatNbr = @BatNbr
		   		and FileType = @OldFileType)

		   	INSERT	INTO XDDBatch
		   	(	BatNbr, 
		   		CpnyID, 
		   		Acct, 
		   		Sub, 
		   		FileType, 
		   		FormatID, 
		   		Module,
		   		Crtd_DateTime, Crtd_Prog, Crtd_User,
		   		LUpd_DateTime, LUpd_Prog, LUpd_User
		   	)
		   	VALUES
		   	(
		  		@BatNbr, 
		  		@CpnyID, 
		  		@Acct, 
		  		@SubAcct, 
		  		@NewFileType,
		  		@FormatID,
		  		'AP',
		  		@CurrDate, @Crtd_Prog, @Crtd_User,
		  		@CurrDate, @Crtd_Prog, @Crtd_User
		  	)
		else 
		   	UPDATE	XDDBatch
		   	SET	BatNbr = @BatNbr, 
		   		CpnyID = @CpnyID, 
		   		Acct = @Acct, 
		   		Sub = @SubAcct, 
		   		EBFileNbr = '',
		   		DepDate = '01/01/1900',
		   		FileType = @NewFileType, 
		   		FormatID = @FormatID, 
				KeepDelete = '',
		   		Module = 'AP',
		   		LUpd_DateTime = @CurrDate, 
		   		LUpd_Prog = @Crtd_Prog, 
		   		LUpd_User = @Crtd_User
		   	WHERE	BatNbr = @BatNbr
		   		and FileType = @OldFileType
	END

