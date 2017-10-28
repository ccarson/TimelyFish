 /****** Object:  Stored Procedure dbo.AcctHist_Specific    Script Date: 4/7/98 12:38:58 PM ******/
Create Proc AcctHist_Specific @parm1 varchar(10), @parm2 varchar ( 10), @parm3 varchar ( 24), @parm4 varchar ( 10), @parm5 varchar ( 4) as
       Select * from AcctHist
           where CpnyID = @parm1
             and Acct   = @parm2
             and Sub    = @parm3
             and LedgerID = @parm4
             and FiscYr = @parm5




GO
GRANT CONTROL
    ON OBJECT::[dbo].[AcctHist_Specific] TO [MSDSL]
    AS [dbo];

