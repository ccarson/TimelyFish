 Create Proc ED850LineItem_InvtId @CpnyId varchar(10), @EDIPOID varchar(10), @InvtId varchar(30) As
Select * From ED850LineItem Where CpnyId = @CpnyId And EDIPOID = @EDIPOID And InvtId = @InvtId


