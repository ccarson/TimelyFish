 Create Proc ED850HSSS_Grid @CpnyId varchar(10), @EDIPOID varchar(15) As
Select * From ED850HSSS Where CpnyId = @CpnyId And EDIPOID = @EDIPOID
Order By CpnyId, EDIPOID, LineNbr


