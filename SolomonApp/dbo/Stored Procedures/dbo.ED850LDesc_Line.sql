 Create Proc ED850LDesc_Line @CpnyId varchar(10), @EDIPOID varchar(10), @LineId int As
Select * From ED850LDesc Where CpnyId = @CpnyId And EDIPOID = @EDIPOID And LineId = @LineId


