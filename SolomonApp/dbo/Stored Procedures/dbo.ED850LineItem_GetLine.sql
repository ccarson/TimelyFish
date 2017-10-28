 Create Proc ED850LineItem_GetLine @CpnyId varchar(10), @EDIPOID varchar(10), @LineId int As
Select * From ED850LineItem Where CpnyId = @CpnyId And EDIPOID = @EDIPOID And LineId = @LineId


