 Create Proc ED850MarkFor_Count @CpnyId varchar(10), @EDIPOID varchar(10) As
Select Count(*) From ED850MarkFor Where CpnyId = @CpnyId And EDIPOID = @EDIPOID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850MarkFor_Count] TO [MSDSL]
    AS [dbo];

