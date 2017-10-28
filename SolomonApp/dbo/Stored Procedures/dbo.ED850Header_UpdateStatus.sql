 CREATE Proc ED850Header_UpdateStatus @CpnyId varchar(10), @EDIPOID varchar(10), @OrdNbr varchar(15) As
Update ED850Header Set UpdateStatus = 'OC', OrdNbr = @OrdNbr Where CpnyId = @CpnyId And EDIPOID = @EDIPOID
Update ED850HeaderExt Set ConvertedDate = GetDate() Where CpnyId = @CpnyId And EDIPOID = @EDIPOID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850Header_UpdateStatus] TO [MSDSL]
    AS [dbo];

