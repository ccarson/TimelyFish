 Create Proc ED850LDisc_AllDmg @CpnyId varchar(10), @EDIPOID varchar(10) As
Select * From ED850LDisc Where CpnyId = @CpnyId And EDIPOID = @EDIPOID Order By CpnyId, EDIPOID, LineId


