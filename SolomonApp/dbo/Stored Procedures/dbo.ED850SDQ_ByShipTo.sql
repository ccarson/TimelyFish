 Create Proc ED850SDQ_ByShipTo @CpnyId varchar(10), @EDIPOID varchar(10)
As
	Select * From ED850SDQ
	Where 	CpnyId = @CpnyId And
		EDIPOID = @EDIPOID
	Order By CpnyId, EDIPOID, SolShipToId, LineId


