 Create Proc ED850SubLineItem_CountLine @CpnyId varchar(10), @EDIPOID varchar(10), @LineId int
As
	Select Count(*)
	From ED850SubLineItem (NOLOCK)
	Where 	CpnyId = @CpnyId And
		EDIPOID = @EDIPOID And
		LineId = @LineId


