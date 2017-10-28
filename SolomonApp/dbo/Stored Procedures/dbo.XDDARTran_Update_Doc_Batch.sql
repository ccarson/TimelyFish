
CREATE PROCEDURE XDDARTran_Update_Doc_Batch
	@Module		varchar( 2 ),
   	@BatNbr		varchar( 10 ),
	@CustID		varchar( 15 ),
	@DocType	varchar( 2 ),
   	@RefNbr		varchar( 10 ),
   	@BatSeq		int,
	@DeleteFlag	smallint,
	@NoteID		int

AS

	Declare		
	@ApplAmt		float,
	@BaseCuryPrec		smallInt,
	@BatchCuryPrec		smallInt,
	@BankAcct		varchar(10),
	@BankSub		varchar(24),
	@CuryApplAmt		float,
	@CuryEffDate		smalldatetime,
	@CuryDiscApplAmt	float,
	@CuryMultDiv		varchar(1),
	@CuryOrigDocAmt		float,
	@CuryRate		float,
	@CuryRateType		varchar(6),
	@CuryTranAmt		float,
	@DiscBal		float,
	@LineCntr		int,
	@OrigDocAmt		float


	-- Get the base currency precision
	SELECT	@BaseCuryPrec = c.DecPl
	FROM	GLSetup s (NOLOCK),
		Currncy c (NOLOCK)
	WHERE	s.BaseCuryID = c.CuryID

	-- Get the batch currency precision
	SELECT	@BatchCuryPrec = c.DecPl
	FROM	Batch B (nolock) left outer join Currncy c (nolock)
		ON B.CuryID = C.CuryID
	WHERE	B.Module = 'AR'
		and B.BatNbr = @BatNBr

	
	-- Delete the Batch
	if @DeleteFlag = 1 
		DELETE 	From Batch
		WHERE	Module = @Module
			and BatNbr = @BatNbr
	else


	if @RefNbr <> ''

		BEGIN

		-- Update the ARDoc totals from its ARTran
			-- ARTRAN - Unique Key - CustId, TranType, RefNbr, LineNbr, RecordID

			-- Sum ARTran values
			-- Unique Key - CustID, TranType, RefNbr, LineNbr, RecordID
			SELECT 	@ApplAmt 		= Coalesce( Sum( Round(TranAmt, @BatchCuryPrec) ), 0),
			 	@CuryApplAmt 		= Coalesce( Sum( Round(CuryTranAmt, @BatchCuryPrec) ), 0),
				@CuryDiscApplAmt 	= Coalesce( Sum( Round(CuryUnitPrice, @BatchCuryPrec) ), 0),
				@DiscBal 		= Coalesce( Sum( Round(CnvFact, @BatchCuryPrec) ), 0),
				@LineCntr = Count(*)
			FROM 	ARTran
			WHERE	BatNbr = @BatNbr
				and CustID = @CustID
				and TranType = @DocType
				and RefNbr = @RefNbr
	
			-- ARDOC - Unique Key - CustId, DocType, RefNbr, BatNbr, BatSeq
-- ApplAmt		Remaining Unapplied Balance, Base Cury
-- CuryApplAmt		Remaining Unapplied Balance, Pmt Cury
-- CuryDiscApplAmt	Discount Applied, Pmt Cury
-- CuryDiscBal		Balance - Discount Applied, Pmt Cury
-- DiscBal		Balance - Discount Applied, Base Cury

			UPDATE 	ARDoc
			SET 	ApplAmt = Round ( DocBal - @ApplAmt, @BaseCuryPrec ), 
				CuryApplAmt = Round ( CuryDocBal - @CuryApplAmt, @BatchCuryPrec ),
				CuryDiscApplAmt = Round ( @CuryDiscApplAmt, @BatchCuryPrec ), 
				CuryDiscBal = Round ( @CuryDiscApplAmt, @BatchCuryPrec ), 
				DiscBal = Round ( @DiscBal, @BaseCuryPrec ),
				LineCntr = @LineCntr,
				NoteID = @NoteID
			WHERE	CustID = @CustID
				and DocType = @DocType
				and RefNbr = @RefNbr
				and BatNbr = @BatNbr
				and BatSeq = @BatSeq

		END
	else
	
		BEGIN
		-- RefNbr is blank - therefore Update the Batch from the ARDocs

			SET		@OrigDocAmt = convert(float, 0)
			SET		@CuryOrigDocAmt = convert(float, 0)
			SET		@BankAcct = ''
			SET		@BankSub = ''
			SET		@CuryEffDate = convert(smalldatetime, '01/01/1900')
			SET		@CuryMultDiv = 'M'
			SET		@CuryRate = convert(float, 1)
			SET		@CuryRateType = ''

			-- Get totals from all ARDocs
			SELECT 		@OrigDocAmt = 		Coalesce( Sum( Round(OrigDocAmt, @BatchCuryPrec) ), 0),
					@CuryOrigDocAmt = 	Coalesce( Sum( Round(CuryOrigDocAmt, @BatchCuryPrec) ), 0)
			FROM 		ARDoc
			WHERE		BatNbr = @BatNbr
			
			-- Get values from last ARDoc entered
			SELECT TOP 1	@BankAcct = BankAcct,
					@BankSub = BankSub,
					@CuryEffDate = CuryEffDate,
					@CuryMultDiv = CuryMultDiv,
					@CuryRate = CuryRate,
					@CuryRateType = CuryRateType
			FROM		ARDoc	
			WHERE		BatNbr = @BatNbr
			ORDER BY	RefNbr DESC
				
			-- Update the Batch
			UPDATE		Batch
			SET		BankAcct = @BankAcct,
					BankSub = @BankSub,
					CrTot = @OrigDocAmt,
					CtrlTot = @OrigDocAmt,
					CuryCrTot = @CuryOrigDocAmt,
					CuryCtrlTot = @CuryOrigDocAmt,
					CuryDepositAmt = @CuryOrigDocAmt,
					CuryDrTot = 0,			-- @CuryOrigDocAmt,
					CuryEffDate = @CuryEffDate,
					CuryMultDiv = @CuryMultDiv,
					CuryRate = @CuryRate,
					CuryRateType = @CuryRateType,
					DepositAmt = @OrigDocAmt
			WHERE		Module = 'AR'
					and BatNbr = @BatNbr
			
		END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDARTran_Update_Doc_Batch] TO [MSDSL]
    AS [dbo];

