
CREATE PROCEDURE XDDBatchARLB_All
	@LBBatNbr	varchar(10),
	@CustID		varchar(15),
	@LineNbrBeg	smallint,
	@LineNbrEnd	smallint
	
AS
	SELECT		*
	FROM		XDDBatchARLB
	WHERE		LBBatNbr = @LBBatNbr
			and CustID LIKE @CustID
			and LineNbr BETWEEN @LineNbrBeg and @LineNbrEnd
	ORDER BY	LBBatNbr, CustID, LineNbr		

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDBatchARLB_All] TO [MSDSL]
    AS [dbo];

