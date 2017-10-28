 CREATE Proc ED850HDisc_DiscAmt @CpnyId varchar(10), @EDIPOID varchar(10) As
Select Sum(CuryTotAmt) From ED850HDisc Where CpnyId = @CpnyId And EDIPOID = @EDIPOID And Indicator = 'A' And TotAmt > 0  And HDiscRate = 0 And Pct = 0


