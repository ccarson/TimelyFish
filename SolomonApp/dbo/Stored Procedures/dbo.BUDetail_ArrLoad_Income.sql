 /****** Object:  Stored Procedure dbo.BUDetail_ArrLoad_Income    Script Date: 11/26/99 12:38:58 PM ******/
CREATE PROCEDURE BUDetail_ArrLoad_Income
@Parm1 varchar ( 10), @Parm2 varchar ( 4), @Parm3 varchar ( 10), @parm4 varchar ( 24),
@Parm5 varchar ( 10), @Parm6 varchar ( 10) AS
SELECT * FROM AcctHist, Account WHERE CpnyId = @parm1 AND FiscYr = @Parm2 and ledgerid = @parm3
 AND Sub Like @Parm4 AND AcctHist.Acct <> @Parm5 And AcctHist.Acct <> @Parm6 And
((ABS(PTDBal00) + ABS(PTDBal01) + ABS(PTDBal02) +  ABS(PTDBal03) + ABS(PTDBal04) + ABS(PTDBal05) +
 ABS(PTDBal06) + ABS(PTDBal07) + ABS(PTDBal08) + ABS(PTDBal09) + ABS(PTDBal10) + ABS(PTDBal11) +
 ABS(PTDBal12)) <> 0) AND AcctHist.Acct = Account.Acct AND
 Account.AcctType IN ('1I', '2I', '3I', '4I')
 ORDER BY AcctHist.CPnyID, AcctHist.Acct, AcctHist.Sub, AcctHist.Ledgerid, AcctHist.FiscYr DESC


