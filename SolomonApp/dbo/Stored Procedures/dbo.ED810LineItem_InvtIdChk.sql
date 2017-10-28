 Create Proc ED810LineItem_InvtIdChk @CpnyId varchar(10), @EDIInvId varchar(10), @PONbr varchar(10) As
Select InvtId From ED810LineItem Where CpnyId = @CpnyId And EDIInvId = @EDIInvId And InvtId Not In
(Select InvtId From PurOrdDet Where PONbr = @PONbr)


