 Create Proc ED850LineItem_Count @CpnyId varchar(10), @EDIPOID varchar(10) As
Select Count(*) From ED850LineItem Where CpnyId = @CpnyId And EDIPOID = @EDIPOID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850LineItem_Count] TO [MSDSL]
    AS [dbo];

