create Proc RCCue_CUSTDUE90 @parm1 varchar(10) as
       SELECT COUNT(*) 
  FROM Customer c Join ArStmt s 
                    on c.StmtCycleID = s.StmtCycleID
                  Join Ar_Balances b 
                    on c.CustID = b.CustID
Where b.AgeBal03 + b.AgeBal04 > 0 
and b.CpnyID = @parm1 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[RCCue_CUSTDUE90] TO [MSDSL]
    AS [dbo];

