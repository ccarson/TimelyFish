 CREATE Proc ED810Header_AllDMG @CpnyId varchar(10), @EDIInvId varchar(10) As
Select * From ED810Header Where CpnyId = @CpnyId And EDIInvId Like @EDIInvId Order By CpnyId, EDIInvId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED810Header_AllDMG] TO [MSDSL]
    AS [dbo];

