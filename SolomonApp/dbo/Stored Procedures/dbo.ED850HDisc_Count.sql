 Create Proc ED850HDisc_Count @CpnyId varchar(10), @EDIPOID varchar(10) As
Select Count(*) From ED850HDisc Where CpnyId = @CpnyId And EDIPOID = @EDIPOID


