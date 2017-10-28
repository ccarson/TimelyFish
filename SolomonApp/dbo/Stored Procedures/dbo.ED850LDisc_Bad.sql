 CREATE Proc ED850LDisc_Bad @CpnyId varchar(10), @EDIPOID varchar(10), @CustId varchar(15) As
Select Distinct LineId From ED850LDisc Where CpnyId = @CpnyId And EDIPOID = @EDIPOID And SpecChgCode Not In (Select SpecChgCode From EDDiscCode Where Direction = 'I' And
CustId In ('*', @CustId))


