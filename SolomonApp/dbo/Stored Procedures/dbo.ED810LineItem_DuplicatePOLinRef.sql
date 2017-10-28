 Create Proc ED810LineItem_DuplicatePOLinRef @CpnyId varchar(10), @EDIInvId varchar(10) As
Select POLineRef From ED810LineItem Where CpnyId = @CpnyId And EDIInvId = @EDIInvId And
POLineRef <> '' Group By CpnyId, EDIInvId, POLineRef Having Count(*) > 1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED810LineItem_DuplicatePOLinRef] TO [MSDSL]
    AS [dbo];

