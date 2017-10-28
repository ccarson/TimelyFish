 CREATE Proc ED810Header_Nav @CpnyId varchar(10), @EDIInvID varchar(10) As
Select * From ED810Header Where CpnyId Like @CpnyId And EDIInvId Like @EDIInvId Order By CpnyId, EDIInvId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED810Header_Nav] TO [MSDSL]
    AS [dbo];

