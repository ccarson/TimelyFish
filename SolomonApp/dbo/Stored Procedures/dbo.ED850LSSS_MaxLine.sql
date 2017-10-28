 Create Proc ED850LSSS_MaxLine @CpnyId varchar(10), @EDIPOID varchar(10) As
Select Max(LineId), Max(LineNbr) From ED850LSSS Where CpnyId = @CpnyId And EDIPOID = @EDIPOID


