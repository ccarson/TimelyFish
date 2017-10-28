 CREATE Proc ED850LDisc_MoveLine @NewLineId int, @CpnyId varchar(10), @EDIPOID varchar(10), @LineNbr smallint, @Qty float As
Update ED850LDisc Set LineId = @NewLineId, Qty = @Qty, AllChgQuantity = @Qty Where CpnyId = @CpnyId And EDIPOID = @EDIPOID And
LineNbr = @LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850LDisc_MoveLine] TO [MSDSL]
    AS [dbo];

