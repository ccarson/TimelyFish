 CREATE Proc ED850LineItem_ByLineId @CpnyId varchar(10), @EDIPOID varchar(10) As
Select * From ED850LineItem Where CpnyId = @CpnyId And EDIPOID = @EDIPOID Order By LineId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850LineItem_ByLineId] TO [MSDSL]
    AS [dbo];

