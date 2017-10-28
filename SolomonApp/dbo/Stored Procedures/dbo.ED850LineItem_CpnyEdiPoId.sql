 CREATE Proc ED850LineItem_CpnyEdiPoId @CpnyId varchar(10), @EDIPOID varchar(10) As
Select * From ED850LineItem Where CpnyId = @CpnyId And EDIPOID = @EDIPOID
Order by LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850LineItem_CpnyEdiPoId] TO [MSDSL]
    AS [dbo];

