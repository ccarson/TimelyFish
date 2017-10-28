 CREATE Proc ED850SDQ_LineIdStoreNbr @CpnyId varchar(10), @EDIPOID varchar(10), @LineId int, @StoreNbr varchar(17) As
Select * From ED850SDQ Where CpnyId = @CpnyId And EDIPOID = @EDIPOID And LineId = @LineId And StoreNbr = @StoreNbr


