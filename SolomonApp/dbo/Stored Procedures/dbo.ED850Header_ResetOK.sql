 CREATE Proc ED850Header_ResetOK @CpnyId varchar(10), @EDIPOID varchar(10) As
Update ED850Header Set UpdateStatus = 'OK' Where CpnyId = @CpnyId And EDIPOID = @EDIPOID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850Header_ResetOK] TO [MSDSL]
    AS [dbo];

