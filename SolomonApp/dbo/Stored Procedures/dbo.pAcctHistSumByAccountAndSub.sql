-- =======================================================================
-- Author:		Brian Cesafsky
-- Create date: 12/10/2008
-- Description:	summarize YTD account balances for 
--              a specificed account, sub-account, fiscal year
-- =======================================================================
CREATE PROCEDURE [dbo].[pAcctHistSumByAccountAndSub]
(	
		@Acct				char(10)
		,@Sub				char(24) 
		,@FiscYr			varchar(6)
		,@CpnyID			varchar(10)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT Acct, Sum(YTDBal00),Sum(YTDBal01),Sum(YTDBal02),Sum(YTDBal03),
		Sum(YTDBal04),Sum(YTDBal05),Sum(YTDBal06),Sum(YTDBal07),
		Sum(YTDBal08),Sum(YTDBal09),Sum(YTDBal10),Sum(YTDBal11)
		FROM AcctHist
		WHERE Acct = @Acct 
		AND Sub = @Sub
		AND FiscYr = @FiscYr
		AND CpnyID = @CpnyID
		GROUP BY Acct
END
