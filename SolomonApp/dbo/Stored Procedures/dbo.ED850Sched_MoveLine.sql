 Create Proc ED850Sched_MoveLine @NewLineId int, @CpnyId varchar(10), @EDIPOID varchar(10), @LineNbr smallint As
Update ED850Sched Set LineId = @NewLineId Where CpnyId = @CpnyId And EDIPOID = @EDIPOID And LineNbr = @LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850Sched_MoveLine] TO [MSDSL]
    AS [dbo];

