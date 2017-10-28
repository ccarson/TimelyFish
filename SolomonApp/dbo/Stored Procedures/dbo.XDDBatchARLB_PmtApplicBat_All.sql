
CREATE PROCEDURE XDDBatchARLB_PmtApplicBat_All
	@LBBatNbr	varchar(10),
	@CustID		varchar(15),
	@LineNbrBeg	smallint,
	@LineNbrEnd	smallint
	
AS
	SELECT		*
	FROM		XDDBatchARLB L LEFT OUTER JOIN Batch B
			ON L.PmtApplicBatNbr = B.BatNbr and 'AR' = B.Module
	WHERE		L.LBBatNbr = @LBBatNbr
			and L.CustID LIKE @CustID
			and L.LineNbr BETWEEN @LineNbrBeg and @LineNbrEnd
	ORDER BY	L.LBBatNbr, L.CustID, L.RefNbr, L.LineNbr		

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDBatchARLB_PmtApplicBat_All] TO [MSDSL]
    AS [dbo];

