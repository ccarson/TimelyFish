 Create Proc ED850SubLineItem_AllDMG @CpnyId varchar(10), @EDIPOID varchar(10)
As
	Select * From ED850SubLineItem
	Where 	CpnyId = @CpnyId And
		EDIPOID = @EDIPOID
	Order By CpnyId, EDIPOID, LineId


