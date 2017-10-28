 CREATE Proc ED850Sched_ByQty @CpnyId varchar(10), @EDIPOID varchar(10), @LineId int As
Select * From ED850Sched Where CpnyId = @CpnyId And EDIPOID = @EDIPOID And LineId = @LineId
Order By CpnyId, EDIPOID, Qty



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850Sched_ByQty] TO [MSDSL]
    AS [dbo];

