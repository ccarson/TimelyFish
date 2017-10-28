 Create Proc ED850Header_Nav @CpnyId varchar(10), @EDIPOID varchar(10) As
Select * From ED850Header Where CpnyId Like @CpnyId And EDIPOID Like @EDIPOID Order By EDIPOID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850Header_Nav] TO [MSDSL]
    AS [dbo];

