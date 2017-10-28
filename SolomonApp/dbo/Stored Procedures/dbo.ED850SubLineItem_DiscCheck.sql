 Create Proc ED850SubLineItem_DiscCheck @CpnyId varchar(10), @EDIPOID varchar(10)
As
	Select LineId
	From ED850SubLineItem
	Where 	CpnyId = @CpnyId And
		EDIPOID = @EDIPOID And
		Exists (Select * From ED850LDisc
			Where 	ED850LDisc.CpnyId = ED850SubLineItem.CpnyId And
				ED850LDisc.EDIPOID = ED850SubLineItem.EDIPOID And
				ED850LDisc.LineId = ED850SubLineItem.LineId)


