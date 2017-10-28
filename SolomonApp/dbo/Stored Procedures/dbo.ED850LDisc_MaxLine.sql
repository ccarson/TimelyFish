 Create Proc ED850LDisc_MaxLine @CpnyId varchar(10), @EDIPOID varchar(10) As
Select Max(LineId), Max(LineNbr) From ED850LDisc Where CpnyId = @CpnyId And EDIPOID = @EDIPOID


