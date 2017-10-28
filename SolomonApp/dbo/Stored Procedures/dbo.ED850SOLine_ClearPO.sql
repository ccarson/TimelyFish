 Create Proc ED850SOLine_ClearPO @CpnyId varchar(10), @EDIPOID varchar(10)
As
	Delete From ED850SOLine
	Where CpnyId = @CpnyId And EDIPOID = @EDIPOID


