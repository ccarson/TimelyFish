 /****** Object:  Stored Procedure dbo.Close_ARBal_StmtCycle2    Script Date: 4/7/98 12:30:33 PM ******/
Create proc Close_ARBal_StmtCycle2 @parm1 varchar ( 10), @parm2 smalldatetime As
        UPDATE AR_Balances set LastStmtBal00 = CurrBal,
        LastStmtBal01 = AgeBal01,
        LastStmtBal02 = AgeBal02,
        LastStmtBal03 = AgeBal03,
        LastStmtBal04 = AgeBal04
        WHERE CustId = @parm1
        AND LastStmtDate = @parm2


