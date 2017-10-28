
CREATE PROCEDURE XDDBatchARLBApplic_Insert
	@CustID			varchar(15),
	@DocType		varchar(2),
	@RefNbr			varchar(10),
	@ApplyAmount		float,
	@DiscApplyAmount	float,
	@PmtRecordID		int,			
	@Crtd_Prog		varchar(8),
	@Crtd_User		varchar(10)
AS

	Declare @CurrDate	smalldatetime
	Declare @LBBatNbr	varchar(10)
	Declare @LineNbr	smallint
	Declare @LineNbrInc	smallint
		
	SET	@LineNbrInc = 32

	-- SELECT	@CurrDate = cast(convert(varchar(10), getdate(), 101) as smalldatetime)
	SET		@CurrDate = GetDate()
	
	-- Get LBBatNbr from Payment file
	SELECT		@LBBatNbr = LBBatNbr
	FROM		XDDBatchARLB (nolock)
	WHERE		RecordID = @PmtRecordID

	-- Initialize in case no records are yet in XDDBatchARLBApplic
	SET @LineNbr	= -32768
	-- Get Highest LineNbr for the Applications for this Payment
	SELECT TOP 1	@LineNbr = LineNbr + @LineNbrInc
	FROM		XDDBatchARLBApplic (nolock)
	WHERE		PmtRecordID = @PmtRecordID
	ORDER BY	LineNbr DESC
	
	-- Add XDDBatchARLBApplic record
	-- The ApplyAmount and DiscApplyAmount must be in Payment Currency
	INSERT	INTO XDDBATCHARLBAPPLIC
	(ApplyAmount,
	Crtd_DateTime, Crtd_Prog, Crtd_User,
	CustID, DiscApplyAmount, DocType, 
	LBBatNbr, LineNbr,
	LUpd_DateTime, LUpd_Prog, LUpd_User,
	PmtRecordID, RefNbr
	)
	VALUES
	(@ApplyAmount,
	@CurrDate, @Crtd_Prog, @Crtd_User,
	@CustID, @DiscApplyAmount, @DocType,
	@LBBatNbr, @LineNbr,
	@CurrDate, @Crtd_Prog, @Crtd_User,
	@PmtRecordID, @RefNbr)


GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDBatchARLBApplic_Insert] TO [MSDSL]
    AS [dbo];

