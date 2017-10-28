 /****** Object:  Stored Procedure dbo.BUAcctHist_YrSubType    Script Date: 4/7/98 12:38:58 PM ******/
CREATE PROCEDURE BUAcctHist_YrSubType @Parm1 varchar ( 4), @Parm2 varchar ( 24), @Parm3 varchar ( 2) AS
SELECT * FROM AcctHist, Account WHERE FiscYr = @Parm1 AND Sub like @Parm2 AND ((AnnBdgt +  YtdBal00 + YtdBal01 + YtdBal02 + YtdBal03 + YtdBal04 + YtdBal05 + YtdBal06 + YtdBal07 + YtdBal08 + YtdBal09 + YtdBal10 + YtdBal11) <> 0) AND AcctHist.Acct = Account.Acct  AND accttype IN (@parm3) ORDER BY FiscYr DESC, accthist.Acct DESC, Sub DESC, accthist.CuryId DESC


