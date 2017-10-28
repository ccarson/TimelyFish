 /****** Object:  Stored Procedure dbo.AcctHist_RoleUpByAcct    Script Date: 4/7/98 12:38:58 PM ******/
CREATE PROCEDURE AcctHist_RoleUpByAcct
 @cpnyid varchar (10), @ledgerid varchar (10), @Acct varchar ( 10) , @FiscYr varchar ( 4)  AS
SELECT max(cpnyid), max(Acct) ,
MAX(BdgtRvsnDate) , SUM(BegBal) ,  MAX(FiscYr) ,  MAX(LedgerID) ,
 SUM(PtdBal00) , SUM(PtdBal01) , SUM(PtdBal02) , SUM(PtdBal03) ,
 SUM(PtdBal04) , SUM(PtdBal05) , SUM(PtdBal06) , SUM(PtdBal07) ,
 SUM(PtdBal08) , SUM(PtdBal09) , SUM(PtdBal10) , SUM(PtdBal11) ,
 SUM(PtdBal12) ,  MAX(Sub) ,
 SUM(YtdBal00) , SUM(YtdBal01) , SUM(YtdBal02) , SUM(YtdBal03) ,
 SUM(YtdBal04) , SUM(YtdBal05) , SUM(YtdBal06) , SUM(YtdBal07) ,
 SUM(YtdBal08) , SUM(YtdBal09) , SUM(YtdBal10) , SUM(YtdBal11) ,
 SUM(YtdBal12)
 FROM AcctHist  WHERE cpnyid = @cpnyid and ledgerid = @ledgerid AND FiscYr = @FiscYr and Acct = @Acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[AcctHist_RoleUpByAcct] TO [MSDSL]
    AS [dbo];

