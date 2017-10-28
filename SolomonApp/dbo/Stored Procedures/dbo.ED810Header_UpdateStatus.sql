 Create Proc ED810Header_UpdateStatus @UpdateStatus varchar(2) As
Select CpnyId, EDIInvId From ED810Header Where UpdateStatus = @UpdateStatus



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED810Header_UpdateStatus] TO [MSDSL]
    AS [dbo];

