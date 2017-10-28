
CREATE PROCEDURE XDDBatchARLBApplic_Get_Applications_CM
	@CustID			varchar(15),
	@CMNbr			varchar(10),		-- CM Number
	@SumApplyAmtPmtCury	float OUTPUT		-- Payment Currency
AS	
	SET		@SumApplyAmtPmtCury = 0
	
	-- Sum the amounts for this CM that have been applied, but not yet posted to the CM CuryDocBal field
	-- A.ApplyAmount is ALWAYS in the Pmt Currency
	SELECT		@SumApplyAmtPmtCury = Coalesce(Sum(A.ApplyAmount), 0)
	FROM		XDDBatchARLBApplic A (nolock) LEFT OUTER JOIN XDDBatchARLB L (nolock)
			ON A.LBBatNbr = L.LBBatNbr and A.CustID = L.CustID and A.PmtRecordID = L.RecordID LEFT OUTER JOIN Batch B (nolock)
			ON L.PmtApplicBatNbr = B.BatNbr and B.Module = 'AR'
	WHERE		(B.Status In ('B', 'H') or B.Status IS NULL) -- Only Balanced and Hold batches or if batch does not yet exist
			and L.CustID = @CustID
			and L.DocType = 'CM'
			and L.RefNbr = @CMNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDBatchARLBApplic_Get_Applications_CM] TO [MSDSL]
    AS [dbo];

