 Create Proc ED850SDQ_Count @CpnyId varchar(10), @EDIPOID varchar(10) As
Select Count(*) From ED850SDQ Where CpnyId = @CpnyId And EDIPOID = @EDIPOID


