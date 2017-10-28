 Create Proc ED850SDQ_CountLineId @CpnyId varchar(10), @EDIPOID varchar(10), @LineId int As
Select Count(*) From ED850SDQ Where CpnyId = @CpnyId And EDIPOID = @EDIPOID And LineId = @LineId


