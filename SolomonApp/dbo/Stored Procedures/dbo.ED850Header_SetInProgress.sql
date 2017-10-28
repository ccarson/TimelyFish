 Create Proc ED850Header_SetInProgress @CpnyId varchar(10), @EDIPOID varchar(10) As
Update ED850Header Set UpdateStatus = 'IN' Where CpnyId = @CpnyId And EDIPOID = @EDIPOID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850Header_SetInProgress] TO [MSDSL]
    AS [dbo];

