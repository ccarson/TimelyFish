 Create Proc ED850SDQ_UpdateQty @NewQty float, @CpnyId varchar(10), @EDIPOID varchar(10), @LineId int, @LineNbr smallint As
Update ED850SDQ Set Qty = @NewQty Where CpnyId = @CpnyId And EDIPOID = @EDIPOID And LineId = @LineId
And LineNbr = @LineNbr


