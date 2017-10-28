
CREATE PROCEDURE XDDBatchAREFT_Pending_EFT_Pmts
	@CustID		varchar( 15 ),
	@DocType	varchar( 2 ),
	@RefNbr		varchar( 10 ),
  	@BatNbr		varchar( 10 ),
	@BatSeq		smallint,
	@BatEFTGrp	smallint

AS
	declare	@BaseCuryPrec	float
	declare @CMCount	smallint
	declare @CMBal		float
	declare @EFTAmt		float
	declare @EFTDiscAmt	float
		
	-- Get the base currency precision
	SELECT	@BaseCuryPrec = c.DecPl
	FROM	GLSetup s (nolock),
		Currncy c (nolock)
	WHERE	s.BaseCuryID = c.CuryID

	-- Pad @BatNbr, so comparison works
	SET	@BatNbr = left(@BatNbr + Space(10), 10)

	-- Pending EFT Payments
	SELECT	@EFTAmt = sum(round(EFTAmount, @BaseCuryPrec)), 
		@EFTDiscAmt = sum(round(EFTDiscAmount, @BaseCuryPrec))
	FROM	XDDBatchAREFT E (nolock) LEFT OUTER JOIN Batch B (nolock)
		ON E.PmtApplicBatNbr = B.BatNbr and 'AR' = B.Module
	WHERE	E.CustID = @CustID
		and E.DocType = @DocType
		and E.RefNbr = @RefNbr
		and E.BatNbr + convert(varchar(2), E.BatEFTGrp) <> @BatNbr + convert(varchar(2), @BatEFTGrp)
		and (E.PmtApplicBatNbr = '' or (E.PmtApplicBatNbr <> '' and B.Status = 'H'))

	-- CMs with balances
	SELECT	@CMCount = count(*),
		@CMBal = sum(round(CuryDocBal, @BaseCuryPrec))
	FROM	ARDoc (nolock)
	WHERE	CustID = @CustID
		and DocType = 'CM'
		and round(CuryDocBal, @BaseCuryPrec) <> 0
		and (Rlsed = 1)		-- only when released can it be applied

	SELECT 	@EFTAmt, @EFTDiscAmt, @CMCount, @CMBal

