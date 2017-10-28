 Create Proc ED810LineItem_ValidatePOLineRef @CpnyId varchar(10), @EDIInvId varchar(10) As
Select A.LineId From ED810LineItem A Inner Join ED810Header B On A.CpnyId = B.CpnyId And
A.EDIInvId = B.EDIInvId Where A.CpnyId = @CpnyId And A.EDIInvId = @EDIInvId And
A.POLineRef Not In (Select LineRef From PurOrdDet C Where C.PONbr = B.PONbr) And
A.POLineRef <> ''



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED810LineItem_ValidatePOLineRef] TO [MSDSL]
    AS [dbo];

