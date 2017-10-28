-- =======================================================================
-- Author:		Brian Cesafsky
-- Create date: 12/10/2008
-- Description:	summarize GLTransactions for 
--              a specificed account, sub-account, PerPost
-- =======================================================================
CREATE PROCEDURE [dbo].[pAcctGLSumByAccountAndSub]
(	
		@Acct				char(10)
		,@Sub				char(24) 
		,@PerPost			varchar(6)
		,@CpnyID			varchar(10)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT Acct, Round(Sum(CrAmt),2), Round(Sum(DrAmt),2)
		FROM GLTran
		WHERE PerPost >= @PerPost 
		AND Acct = @Acct 
		AND Sub = @Sub
		AND CpnyID = @CpnyID
		AND Posted = 'U'
		GROUP BY Acct
END
