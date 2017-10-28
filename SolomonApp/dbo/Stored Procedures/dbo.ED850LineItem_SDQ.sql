 Create Proc ED850LineItem_SDQ @CpnyId varchar(10), @EDIPOID varchar(10) As
Select A.LineId,
	A.RequestDate,
	A.CancelDate,
	B.QTY,
	B.SolShipToId
From ED850LineItem A
	left outer join ED850SDQ B
		on A.CpnyId = B.CpnyId
		And A.EDIPOID = B.EDIPOID
		And A.LineId = B.LineId
Where A.CpnyId = @CpnyId
	And A.EDIPOID = @EDIPOID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850LineItem_SDQ] TO [MSDSL]
    AS [dbo];

