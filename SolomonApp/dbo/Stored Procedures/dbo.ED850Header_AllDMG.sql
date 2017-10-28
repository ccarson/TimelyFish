 Create Proc ED850Header_AllDMG @CpnyId varchar(10), @EDIPOID varchar(10) As
Select * From ED850Header Where CpnyId = @CpnyId And EDIPOID = @EDIPOID


