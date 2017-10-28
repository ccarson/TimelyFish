 Create Proc ED850SubLineItem_KitChk @CpnyId varchar(10), @EDIPOID varchar(10), @LineId int
As
	Select InvtId, Qty, UOM
	From ED850SubLineItem
	Where 	CpnyId = @CpnyId And
		EDIPOID = @EDIPOID And
		LineId = @LineId


