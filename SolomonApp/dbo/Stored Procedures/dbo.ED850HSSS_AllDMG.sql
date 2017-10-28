 Create Proc ED850HSSS_AllDMG @CpnyId varchar(10), @EDIPOID varchar(15), @LineNbrMin smallint, @LineNbrMax smallint As
Select * From ED850HSSS Where CpnyId = @CpnyId And EDIPOID = @EDIPOID And LineNbr Between @LineNbrMin And @LineNbrMax


