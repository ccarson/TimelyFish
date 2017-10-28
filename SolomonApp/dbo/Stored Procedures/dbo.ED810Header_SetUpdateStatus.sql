 Create Proc ED810Header_SetUpdateStatus @CpnyId varchar(10), @EDIInvId varchar(10), @UpdateStatus varchar(2) As
Update ED810Header Set UpdateStatus = @UpdateStatus Where CpnyId = @CpnyId And EDIInvId = @EDIInvId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED810Header_SetUpdateStatus] TO [MSDSL]
    AS [dbo];

