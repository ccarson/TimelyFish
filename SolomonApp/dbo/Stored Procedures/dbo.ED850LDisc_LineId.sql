 Create Proc ED850LDisc_LineId @CpnyId varchar(10), @EDIPOID varchar(10), @LineId int As
Select * From ED850LDisc Where CpnyId = @CpnyId And EDIPOID = @EDIPOID And LineId = @LineId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850LDisc_LineId] TO [MSDSL]
    AS [dbo];

