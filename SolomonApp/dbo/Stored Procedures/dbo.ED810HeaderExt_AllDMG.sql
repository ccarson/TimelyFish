 CREATE Proc ED810HeaderExt_AllDMG @CpnyId varchar(10), @EDIInvId varchar(10) As
Select * From ED810HeaderExt Where CpnyId = @CpnyId And EDIInvId = @EDIInvId Order By CpnyId, EDIInvId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED810HeaderExt_AllDMG] TO [MSDSL]
    AS [dbo];

