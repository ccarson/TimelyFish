 Create Proc ED850LineItem_DeductQty @DeductQty float, @CpnyId varchar(10), @EDIPOID varchar(10), @LineNbr smallint As
Update ED850LineItem Set Qty = Qty - @DeductQty Where CpnyId = @CpnyId And EDIPOID = @EDIPOID And
LineNbr = @LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850LineItem_DeductQty] TO [MSDSL]
    AS [dbo];

