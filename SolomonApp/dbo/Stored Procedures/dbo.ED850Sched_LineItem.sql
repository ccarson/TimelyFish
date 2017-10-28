 Create Proc ED850Sched_LineItem @CpnyId varchar(10), @EDIPOID varchar(10), @Lineid int As
Select * From ED850Sched Where CpnyId = @CpnyId And EDIPOID = @EDIPOID And LineId = @LineId
Order By CpnyId, EDIPOID, LineId, LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850Sched_LineItem] TO [MSDSL]
    AS [dbo];

