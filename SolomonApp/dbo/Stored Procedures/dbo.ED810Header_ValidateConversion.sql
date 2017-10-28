 Create Proc ED810Header_ValidateConversion @CpnyId varchar(10), @EDIInvId varchar(10) As
Select Count(*) From ED810LineItem
Where CpnyId = @CpnyId And EDIInvId = @EDIInvId
Group By CpnyId, EDIInvId, InvtId, QtyInvoicedUOM
Having Sum(QtyInvoiced) <> IsNull((Select Sum(RcptQty) From POTran Where POTran.RcptNbr =
(Select POReceipt.RcptNbr From POReceipt Where POReceipt.S4Future11 = ED810LineItem.EDIInvId)
And POTran.InvtId = ED810LineItem.InvtId And POTran.RcptUnitDescr =
ED810LineItem.QtyInvoicedUOM),0)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED810Header_ValidateConversion] TO [MSDSL]
    AS [dbo];

