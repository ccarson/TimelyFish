 /****** Object:  Stored Procedure dbo.Close_ARBal_StmtCycle    Script Date: 4/7/98 12:30:33 PM ******/
Create proc Close_ARBal_StmtCycle @parm1 smalldatetime, @parm2 varchar ( 15), @parm3 smalldatetime As
        UPDATE AR_Balances SET LastStmtDate = @parm1,
        LastStmtBegBal = LastStmtBal00,
        LastStmtBal00 = CurrBal,
        LastStmtBal01 = AgeBal01,
        LastStmtBal02 = AgeBal02,
        LastStmtBal03 = AgeBal03,
        LastStmtBal04 = AgeBal04
        WHERE CustID = @parm2
        AND LastStmtDate < @parm3


