 Create Proc ED850Sched_MaxLine @CpnyId varchar(10), @EDIPOID varchar(10) As
Select Max(LineId), Max(LineNbr) From ED850Sched Where CpnyId = @CpnyId And EDIPOID = @EDIPOID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850Sched_MaxLine] TO [MSDSL]
    AS [dbo];

