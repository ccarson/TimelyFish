 Create Proc ED850Sched_CountLineId @CpnyId varchar(10), @EDIPOID varchar(10), @LineId int As
Select Count(*) From ED850Sched Where CpnyId = @CpnyId And EDIPOID = @EDIPOID And LineId = @LineId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850Sched_CountLineId] TO [MSDSL]
    AS [dbo];

