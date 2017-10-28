 Create Proc ED850SDQ_LineItem @CpnyId varchar(10), @EDIPOID varchar(10), @LineId int, @LineNbrBeg smallint, @LineNbrEnd smallint As
Select * From ED850SDQ Where CpnyId = @CpnyId And EDIPOID = @EDIPOID And LineId = @LineId And LineNbr Between @LineNbrBeg And @LineNbrEnd
Order By CpnyId, EDIPOID, LineId, LineNbr


