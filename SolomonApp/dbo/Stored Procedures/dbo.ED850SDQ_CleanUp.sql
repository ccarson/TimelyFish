 Create Proc ED850SDQ_CleanUp @CpnyId varchar(10), @EDIPOID varchar(10) As
Delete From ED850SDQ Where CpnyId = @CpnyId And EDIPOID = @EDIPOID And Qty = 0


