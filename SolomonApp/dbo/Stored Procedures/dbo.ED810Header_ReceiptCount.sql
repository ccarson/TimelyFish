 Create Proc ED810Header_ReceiptCount @CpnyId varchar(10), @EDIInvId varchar(10) As
Select Count(*) From POReceipt Where CpnyId = @CpnyId And S4Future11 = @EDIInvId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED810Header_ReceiptCount] TO [MSDSL]
    AS [dbo];

