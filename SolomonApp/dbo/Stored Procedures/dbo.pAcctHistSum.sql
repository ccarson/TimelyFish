CREATE PROC pAcctHistSum
	@Acct varchar(10), @FiscYr varchar(6), @CpnyID varchar(10)
	AS
	-- This procedure is used to summarize YTD account balances for 
	-- a specificed account, fiscal year
	-- CREATED BY: TJONES 10/23/04
	SELECT Acct, Sum(YTDBal00),Sum(YTDBal01),Sum(YTDBal02),Sum(YTDBal03),
		Sum(YTDBal04),Sum(YTDBal05),Sum(YTDBal06),Sum(YTDBal07),
		Sum(YTDBal08),Sum(YTDBal09),Sum(YTDBal10),Sum(YTDBal11)
		FROM AcctHist
		WHERE Acct = @Acct 
		AND FiscYr = @FiscYr
		AND CpnyID = @CpnyID
		GROUP BY Acct
