
CREATE PROCEDURE XDDBatchARLB_CustID_RefNbr_Dupes
   @LBBatNbr		varchar(10)

AS

	Declare		@CustID			varchar(15)
	Declare		@RefNbr			varchar(10)
	Declare		@CustIDRefNbrKey	varchar(25)
	Declare		@RetValue		int
	
	SET		@RetValue = 0

	-- Check for duplicate CustID/RefNbrs in a Payment batch
	-- Blank RefNbrs - we will auto-assign numbers	
	DECLARE         Pmt_Cursor CURSOR LOCAL FAST_FORWARD
	FOR
	SELECT 		CustID,	
			RefNbr 
	FROM            XDDBatchARLB (nolock)
	WHERE		LBBatNbr = @LBBatNbr
	   		and PmtApplicBatNbr = ''
			and PmtApplicRefNbr = ''
	ORDER BY	CustID, RefNbr

	if (@@error <> 0) GOTO ABORT

	-- Cycle through payments, check for dupes
	OPEN Pmt_Cursor

	Fetch Next From Pmt_Cursor into
	@CustID,
	@RefNbr
	
	SET	@CustIDRefNbrKey = ''
	
	-- Add ALL Open documents to the table
	While (@@Fetch_Status = 0)
	BEGIN

		-- Blank RefNbrs we will provide unique values, no problem
		if rtrim(@RefNbr) <> ''
			if @CustID + @RefNbr = @CustIDRefNbrKey
			BEGIN
				SET @RetValue = 1
				GOTO GETOUT
			END

		SET @CustIDRefNbrKey = @CustID + @RefNbr

		Fetch Next From Pmt_Cursor into
		@CustID,
		@RefNbr
	END
	
GETOUT:	
	Close Pmt_Cursor
	Deallocate Pmt_Cursor

	SELECT @RetValue
	
ABORT:


GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDBatchARLB_CustID_RefNbr_Dupes] TO [MSDSL]
    AS [dbo];

