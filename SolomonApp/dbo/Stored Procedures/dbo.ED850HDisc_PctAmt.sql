 CREATE Proc ED850HDisc_PctAmt @CpnyId varchar(10), @EDIPOID varchar(10) As
Select * From ED850HDisc Where CpnyId = @CpnyId And EDIPOID = @EDIPOID And Indicator = 'A'
And (Pct <> 0 Or HDiscRate <> 0 Or TotAmt <> 0)
Order By Case When Pct <> 0 Or HDiscRate <> 0 Then 0 Else 1 End


