 Create Proc ED810Header_Ok @CpnyId varchar(10), @EDIInvID varchar(10) As
Select * From ED810Header Where CpnyId = @CpnyId And EDIInvId = @EDIInvId And UpdateStatus = 'OK'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED810Header_Ok] TO [MSDSL]
    AS [dbo];

