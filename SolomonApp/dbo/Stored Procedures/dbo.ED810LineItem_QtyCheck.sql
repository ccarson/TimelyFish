 Create Proc ED810LineItem_QtyCheck @CpnyId varchar(10), @EDIInvId varchar(10) As
Select A.LineId From ED810LineItem A Inner Join ED810Header B On A.CpnyId = B.CpnyId And
A.EDIInvId = B.EDIInvId Inner Join PurOrdDet C On B.PONbr = C.PONbr And A.POLineRef = C.LineRef
Where A.CpnyId = @CpnyId And A.EDIInvId = @EDIInvId And A.QtyInvoicedUOM = C.PurchUnit And A.QtyInvoiced +
C.QtyRcvd Not Between C.QtyOrd * (C.RcptPctMin / 100) And C.QtyOrd * (C.RcptPctMax / 100) And
C.RcptPctAct = 'E' Order By A.CpnyId, A.EDIInvId, A.LineId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED810LineItem_QtyCheck] TO [MSDSL]
    AS [dbo];

