 Create Proc ED850Sched_CountLineIdEntityId @CpnyId varchar(10), @EDIPOID varchar(10), @LineId int, @EntityId varchar(80)
As
	Select Count(*)
	From ED850Sched
	Where 	CpnyId = @CpnyId And
		EDIPOID = @EDIPOID And
		LineId = @LineId And
		EntityId Like @EntityId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850Sched_CountLineIdEntityId] TO [MSDSL]
    AS [dbo];

