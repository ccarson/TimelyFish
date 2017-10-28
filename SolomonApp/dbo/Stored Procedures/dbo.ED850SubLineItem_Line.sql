 CREATE Proc ED850SubLineItem_Line @CpnyId varchar(10), @EDIPOID varchar(10), @LineId int
As
	Select * From ED850SubLineItem
	Where 	CpnyId = @CpnyId And
		EDIPOID = @EDIPOID And
		LineId = @LineId
	Order By CpnyId, EDIPOID, LineId, LineNbr


