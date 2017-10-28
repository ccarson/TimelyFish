 Create Proc ED810LineItem_Count @CpnyId varchar(10), @EDIInvId varchar(10) As
Select Count(*) From ED810LineItem Where CpnyId = @CpnyId And EDIInvId = @EDIInvId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED810LineItem_Count] TO [MSDSL]
    AS [dbo];

