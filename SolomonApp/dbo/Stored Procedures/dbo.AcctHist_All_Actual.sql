 Create Proc AcctHist_All_Actual @parm1 varchar ( 10), @parm2 varchar ( 24), @parm3 varchar ( 10), @parm4 varchar ( 4), @parm5 varchar ( 10) as
Select * from AcctHist
  where BalanceType = 'A' and
  Acct like @parm1 and
  Sub like @parm2 and
  LedgerID like @parm3 and
  FiscYr like @parm4 and
  CpnyID = @parm5
  order by CpnyID, Acct, Sub, Ledgerid, FiscYr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[AcctHist_All_Actual] TO [MSDSL]
    AS [dbo];

