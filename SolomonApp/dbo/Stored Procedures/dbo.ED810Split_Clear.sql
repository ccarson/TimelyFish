 Create Proc ED810Split_Clear @Cpnyid varchar(10), @EDIInvId varchar(10), @LineId int As
Delete From ED810Split Where CpnyId = @CpnyId And EDIInvId = @EDIInvId And LineId = @LineId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED810Split_Clear] TO [MSDSL]
    AS [dbo];

