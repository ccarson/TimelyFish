 Create Proc ED810Split_MaxLineNbr @CpnyId varchar(10), @EDIInvId varchar(10), @LineId int As
Select Max(LineNbr) From ED810Split Where CpnyId = @CpnyId And EDIInvId = @EDIInvId And LineId = @LineId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED810Split_MaxLineNbr] TO [MSDSL]
    AS [dbo];

