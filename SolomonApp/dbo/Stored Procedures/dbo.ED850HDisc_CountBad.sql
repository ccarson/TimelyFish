 CREATE Proc ED850HDisc_CountBad @CpnyId varchar(10), @EDIPOID varchar(10), @CustId varchar(15) As
Select Count(*) From ED850HDisc Where CpnyId = @CpnyId And EDIPOID = @EDIPOID And SpecChgCode Not In (Select SpecChgCode From EDDiscCode Where Direction = 'I' And CustId In ('*',@CustId))


