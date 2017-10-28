 Create Proc ED850Sched_UpdateQty @NewQty float, @CpnyId varchar(10), @EDIPOID varchar(10), @LineNbr smallint As
Update ED850Sched Set Qty = @NewQty Where CpnyId = @CpnyId And EDIPOID = @EDIPOID And LineNbr = @LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850Sched_UpdateQty] TO [MSDSL]
    AS [dbo];

