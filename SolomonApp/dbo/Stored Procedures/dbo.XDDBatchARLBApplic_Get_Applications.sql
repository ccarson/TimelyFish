
CREATE PROCEDURE XDDBatchARLBApplic_Get_Applications
	@LBBatNbr		varchar(10),
	@CustID			varchar(15),
	@DocType		varchar(2),		-- DocType applying against
	@RefNbr			varchar(10),		-- Invoice/Reference number
	@PmtRecordID		int,			-- RecordID from XDDBatchARLB (Good grid)
	@ReturnSelect		smallint,
	@SumApplyAmt		float OUTPUT,
	@SumDiscApplyAmt	float OUTPUT
AS	
	SET		@SumApplyAmt = 0
	SET		@SumDiscApplyAmt = 0
	
	-- This assumes that all Applic records for one Customer are in the same Pmt Currency
	-- 	A.ApplyAmount, A.DiscApplyAmount are in Pmt Currency	
	SELECT		@SumApplyAmt = Coalesce(Sum(A.ApplyAmount), 0),
			@SumDiscApplyAmt = Coalesce(Sum(A.DiscApplyAmount), 0)
	FROM		XDDBatchARLBApplic A (nolock) LEFT OUTER JOIN XDDBatchARLB L (nolock)
			ON A.LBBatNbr = L.LBBatNbr and A.CustID = L.CustID and A.PmtRecordID = L.RecordID LEFT OUTER JOIN Batch B (nolock)
			ON L.PmtApplicBatNbr = B.BatNbr and B.Module = 'AR'
	WHERE		(B.Status In ('B', 'H') or B.Status IS NULL) -- Only Balanced and Hold batches or if batch does not yet exist
			and A.CustID = @CustID
			and A.DocType = @DocType
			and A.DocType <> 'CM'
			and A.RefNbr = @RefNbr
			and A.PmtRecordID <> @PmtRecordID
			
	-- This switch is needed because this proc is called both from T-SQL (Output parms)
	-- and from SWIM SqlFetch().  When call from T-SQL - do not want Select 		
	if @ReturnSelect = 1		
		SELECT	@SumApplyAmt, @SumDiscApplyAmt		

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDBatchARLBApplic_Get_Applications] TO [MSDSL]
    AS [dbo];

