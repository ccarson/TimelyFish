 create Proc CA_Find_PRDoc @CpnyID varchar ( 10), @acct varchar ( 10), @sub varchar ( 24), @ChkNbr
varchar ( 10) as
Select * from PRdoc
Where CpnyID = @CpnyID
and acct = @acct
and sub = @sub
and ChkNbr = @ChkNbr
and rlsed = 1
and status = 'O'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[CA_Find_PRDoc] TO [MSDSL]
    AS [dbo];

