 Create Proc ED850SubLineItem_NoInvtId @CpnyId varchar(10), @EDIPOID varchar(10)
As
	Select * From ED850SubLineItem
	Where 	CpnyId = @CpnyId And
		EDIPOID = @EDIPOID And
		InvtId = ''


