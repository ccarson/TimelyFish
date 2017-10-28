 CREATE Proc ED810Split_QtyChk @CpnyId varchar(10), @EDIInvId varchar(10) As
Select A.LineId From ED810LineItem A Inner Join ED810Split B On A.CpnyId = B.CpnyId And A.EDIInvId =
B.EDIInvId And A.LineId = B.LineId Where A.CpnyId = @CpnyId And A.EDIInvId = @EDIInvId
Group By A.LineId Having Avg(A.QtyInvoiced) <> Sum(B.QtyInvoiced)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED810Split_QtyChk] TO [MSDSL]
    AS [dbo];

