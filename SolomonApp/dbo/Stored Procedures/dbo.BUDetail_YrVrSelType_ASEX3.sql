 /****** Object:  Stored Procedure dbo.BUDetail_YrVrSelType_ASEX3    Script Date: 11/13/99 12:38:58 PM ******/
CREATE PROCEDURE BUDetail_YrVrSelType_ASEX3
@Parm1 varchar ( 10), @Parm2 varchar ( 4), @Parm3 varchar ( 10),
@Parm4 varchar ( 24), @Parm5 varchar(10) AS
SELECT * FROM Accthist, account WHERE account.acct = accthist.acct and AcctHist.CpnyID = @Parm1 AND
AcctHist.fiscyr = @Parm2 AND AcctHist.ledgerid = @Parm3 AND AcctHist.Sub Like @Parm4 And
AcctHist.Acct Like @Parm5 AND Account.AcctType IN ('1A', '2A', '3A', '4A', '1E', '2E', '3E', '4E')
ORDER BY AcctHist.CpnyID, AcctHist.Acct, AcctHist.Sub, AcctHist.Ledgerid, AcctHist.FiscYr DESC



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BUDetail_YrVrSelType_ASEX3] TO [MSDSL]
    AS [dbo];

