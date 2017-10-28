 Create Proc ED850LRef_LineId @CpnyId varchar(10), @EDIPOID varchar(10), @LineId int As
Select * From ED850LRef Where CpnyId = @CpnyId And EDIPOID = @EDIPOID And LineId = @LineId


