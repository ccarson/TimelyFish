 Create Proc ED850LineItem_DetailDelete @CpnyId varchar(10), @EDIPOID varchar(10), @LineId int As
Delete From ED850SDQ Where CpnyId = @CpnyId And EDIPOID = @EDIPOID And LineId = @LineId
Delete From ED850Sched Where CpnyId = @CpnyId And EDIPOID = @EDIPOID And LineId = @LineId
Delete From ED850LDesc Where CpnyId = @CpnyId And EDIPOID = @EDIPOID And LineId = @LineId
Delete From ED850LDisc Where CpnyId = @CpnyId And EDIPOID = @EDIPOID And LineId = @LineId
Delete From ED850LRef Where CpnyId = @CpnyId And EDIPOID = @EDIPOID And LineId = @LineId
Delete From ED850LSSS Where CpnyId = @CpnyId And EDIPOID = @EDIPOID And LineId = @LineId


