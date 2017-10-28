 Create Proc ED850LDesc_MaxLine @CpnyId varchar(10), @EDIPOID varchar(10) As
Select Max(LineId), Max(LineNbr) From ED850LDesc Where CpnyId = @CpnyId And EDIPOID = @EDIPOID


