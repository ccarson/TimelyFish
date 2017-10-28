 Create Proc ED850HDisc_AllDMG @CpnyId varchar(10), @EDIPOID varchar(10) As
Select * From ED850HDisc Where CpnyId = @CpnyId And EDIPOID = @EDIPOID
Order By CpnyId, EDIPOID, LineNbr


