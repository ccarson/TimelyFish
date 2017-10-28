 CREATE Proc ED850SDQ_FreeFormQtyCheck @CpnyId varchar(10), @EDIPOID varchar(10)
As
	Select LineId From ED850SDQ
	Where Exists (Select * From ED850SubLineItem
			Where 	ED850SubLineItem.CpnyId = @CpnyId And
				ED850SubLineItem.EDIPOID = @EDIPOID And
				ED850SubLineItem.LineId = ED850SDQ.LineId) And
		CpnyId = @CpnyId And
		EDIPOID = @EDIPOID
	Group By LineId Having Sum(Qty) <> (Select Qty From ED850LineItem
						Where 	ED850LineItem.CpnyId = @CpnyId And
							ED850LineItem.EDIPOID = @EDIPOID And
							ED850LineItem.LineId = ED850SDQ.LineId)


