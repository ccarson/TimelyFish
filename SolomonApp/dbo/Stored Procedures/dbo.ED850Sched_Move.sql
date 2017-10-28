 CREATE Proc ED850Sched_Move @CpnyId varchar(10), @EDIPOID varchar(10), @NewLineId int, @OldLineId int, @LineNbr smallint As
Update ED850Sched Set LineId = @NewLineId Where CpnyId = @CpnyId And EDIPOID = @EDIPOID And
LineId = @OldLineId And LineNbr = @LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850Sched_Move] TO [MSDSL]
    AS [dbo];

