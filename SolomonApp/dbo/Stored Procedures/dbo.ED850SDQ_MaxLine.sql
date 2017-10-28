 Create Proc ED850SDQ_MaxLine @CpnyId varchar(10), @EDIPOID varchar(10) As
Select Max(LineId), Max(LineNbr) From ED850SDQ Where CpnyId = @CpnyId And EDIPOID = @EDIPOID


