 Create Proc ED850LDisc_Count @CpnyId varchar(10), @EDIPOID varchar(10), @LineID smallint
As
	Select Count(*) From ED850LDisc
	Where 	CpnyId = @CpnyId AND
		EDIPOID = @EDIPOID AND
		LineID = @LineID


