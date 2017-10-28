 /****** Object:  Stored Procedure dbo.BUAcctHist_YrAcctSub    Script Date: 10/23/98 12:38:58 PM ******/
CREATE PROCEDURE BUAcctHist_YrAcctSub @Parm1 varchar ( 10), @Parm2 varchar ( 4), @Parm3 varchar ( 10), @Parm4 varchar ( 10), @parm5 varchar ( 24) AS
SELECT * FROM AcctHist Where CpnyId = @parm1 AND FiscYr = @Parm2 and ledgerid = @parm3 And Acct = @Parm4 And Sub like @Parm5 Order By FiscYr, ledgerid, Acct, Sub, CuryId


