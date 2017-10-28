 Create Proc ED810LineItem_AllDMG @CpnyId varchar(10), @EDIInvId varchar(10) As
Select * From ED810LineItem Where CpnyId = @CpnyId And EDIInvId = @EDIInvId Order By
CpnyId, EDIInvId, LineId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED810LineItem_AllDMG] TO [MSDSL]
    AS [dbo];

