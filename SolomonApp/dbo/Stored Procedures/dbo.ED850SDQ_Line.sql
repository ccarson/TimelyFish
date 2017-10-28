 Create Proc ED850SDQ_Line @CpnyId varchar(10), @EDIPOID varchar(10), @LineId int As
Select * From ED850SDQ Where CpnyId = @CpnyId And EDIPOID = @EDIPOID And LineId = @LineId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850SDQ_Line] TO [MSDSL]
    AS [dbo];

