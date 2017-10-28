 CREATE Proc ED850HDisc_DiscPct @CpnyId varchar(10), @EDIPOID varchar(10) As
Select * From ED850HDisc Where CpnyId = @CpnyId And EDIPOID = @EDIPOID And Indicator = 'A' And (Pct <> 0 or HDiscRate <> 0)


