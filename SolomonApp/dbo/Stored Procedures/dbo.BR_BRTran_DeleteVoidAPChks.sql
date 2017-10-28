
CREATE Procedure BR_BRTran_DeleteVoidAPChks
@CpnyId char(10),
@AcctID char(10),
@BegPer char(6),
@EndPer char(6)

AS 
DELETE BRTran from BRTran
inner join (SELECT BRTran.Mainkey,apdoc.perclosed from BRTran
JOIN APDoc ON APDoc.BatNbr = BRTran.OrigBatNbr AND APDoc.RefNbr = BRTran.OrigRefNbr AND APDoc.Status = 'V'
AND APDoc.Rlsed =1)
x on BRTran.MainKey = x.MainKey
Where BRTran.CpnyId = @CpnyId and BRTran.AcctID = @AcctID and BRTran.CurrPerNbr BETWEEN @BegPer AND @EndPer
and CurrPerNbr>=x.perclosed


GO
GRANT CONTROL
    ON OBJECT::[dbo].[BR_BRTran_DeleteVoidAPChks] TO [MSDSL]
    AS [dbo];

