CREATE PROC pAcctGLSum
	@CpnyID varchar(10), @Acct varchar(10), @PerPost varchar(6)
	AS
	-- This procedure is used to summarize GLTransactions for 
	-- a specificed account and PerPost
	-- CREATED BY: TJONES 10/23/04
	SELECT Acct, Round(Sum(CrAmt),2), Round(Sum(DrAmt),2)
		FROM GLTran
		WHERE PerPost >= @PerPost 
		AND Acct = @Acct 
		AND CpnyID = @CpnyID
		AND Posted = 'U'
		GROUP BY Acct
