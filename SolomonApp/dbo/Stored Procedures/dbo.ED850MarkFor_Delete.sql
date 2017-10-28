 Create Proc ED850MarkFor_Delete @CpnyId varchar(10), @EDIPOID varchar(10) As
Delete From ED850MarkFor Where CpnyId = @CpnyId And EDIPOID = @EDIPOID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850MarkFor_Delete] TO [MSDSL]
    AS [dbo];

