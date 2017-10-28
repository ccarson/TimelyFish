 CREATE Proc ED850Sched_LineId @CpnyId varchar(10), @EDIPOID varchar(10), @LineId int As
Select * From ED850Sched Where CpnyId = @CpnyId And EDIPOID = @EDIPOID And LineId = @LineId
Order By CpnyId, EDIPOID, LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850Sched_LineId] TO [MSDSL]
    AS [dbo];

