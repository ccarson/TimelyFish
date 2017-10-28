 CREATE Proc ED810Split_AllDMG @CpnyId varchar(10), @EDIInvId varchar(10) As
Select * From ED810Split Where CpnyId = @CpnyId And EDIInvId = @EDIInvId
Order By CpnyId, EDIInvId, LineId, LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED810Split_AllDMG] TO [MSDSL]
    AS [dbo];

