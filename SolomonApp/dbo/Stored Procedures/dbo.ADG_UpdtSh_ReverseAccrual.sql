 CREATE PROCEDURE ADG_UpdtSh_ReverseAccrual @CpnyID VARCHAR(10), @ShipperID VARCHAR(15),
                                           @BatNbr VARCHAR(10), @BatSeq INTEGER, @PerPost VARCHAR(6), @UserID VARCHAR(10)

AS

DECLARE @DocType VARCHAR(2)
DECLARE @RefNbr  VARCHAR(10)

SELECT @DocType = MAX(DocType), @RefNbr = MAX(RefNbr) FROM ARDoc WHERE CpnyID = @CpnyID AND RefNbr = @ShipperID AND DocClass = 'A'

IF @DocType <> 'AD' RETURN

INSERT ARTran (
Acct,AcctDist,BatNbr,CmmnPct,CnvFact,ContractID,CostType,CpnyID,Crtd_DateTime,Crtd_Prog,Crtd_User,
CuryExtCost,CuryId,CuryMultDiv,CuryRate,CuryTaxAmt00,CuryTaxAmt01,CuryTaxAmt02,CuryTaxAmt03,CuryTranAmt,
CuryTxblAmt00,CuryTxblAmt01,CuryTxblAmt02,CuryTxblAmt03,CuryUnitPrice,CustId,DrCr,Excpt,ExtCost,ExtRefNbr,
FiscYr,FlatRateLineNbr,InstallNbr,InvtId,JobRate,JrnlType,LineId,LineNbr,LineRef,LUpd_DateTime,LUpd_Prog,LUpd_User,
MasterDocNbr,NoteId,OrdNbr,PC_Flag,PC_ID,PC_Status,PerEnt,PerPost,ProjectID,Qty,RefNbr,Rlsed,
S4Future01,S4Future02,S4Future03,S4Future04,S4Future05,S4Future06,S4Future07,S4Future08,S4Future09,S4Future10,
S4Future11,S4Future12,ServiceCallID,ServiceCallLineNbr,ServiceDate,ShipperCpnyID,ShipperID,ShipperLineRef,SiteId,
SlsperId,SpecificCostID,Sub,TaskID,TaxAmt00,TaxAmt01,TaxAmt02,TaxAmt03,TaxCalced,TaxCat,TaxId00,TaxId01,TaxId02,
TaxId03,TaxIdDflt,TranAmt,TranClass,TranDate,TranDesc,TranType,TxblAmt00,TxblAmt01,TxblAmt02,TxblAmt03,UnitDesc,
UnitPrice,User1,User2,User3,User4,User5,User6,User7,User8,WhseLoc
)SELECT
Acct,AcctDist,@BatNbr,CmmnPct,CnvFact,ContractID,CostType,CpnyID,GETDATE(),'40690',@UserID,
-CuryExtCost,CuryId,CuryMultDiv,CuryRate,CuryTaxAmt00,CuryTaxAmt01,CuryTaxAmt02,CuryTaxAmt03,CuryTranAmt,
CuryTxblAmt00,CuryTxblAmt01,CuryTxblAmt02,CuryTxblAmt03,CuryUnitPrice,CustId,CASE DrCr WHEN 'D' THEN 'C' ELSE 'D' END,
Excpt,-ExtCost,ExtRefNbr,
LEFT(@PerPost,4),FlatRateLineNbr,InstallNbr,InvtId,JobRate,JrnlType,LineId,LineNbr,LineRef,GETDATE(),'40690',@UserID,
MasterDocNbr,NoteId,OrdNbr,PC_Flag,PC_ID,CASE PC_Status WHEN ' ' THEN ' 'WHEN '0' THEN '0' WHEN '1' THEN '1' WHEN '2' THEN '1' WHEN '9' THEN '9' END,@PerPost,@PerPost,ProjectID,-Qty,RefNbr,0,
S4Future01,S4Future02,S4Future03,S4Future04,S4Future05,S4Future06,S4Future07,S4Future08,S4Future09,S4Future10,
S4Future11,S4Future12,ServiceCallID,ServiceCallLineNbr,ServiceDate,ShipperCpnyID,ShipperID,ShipperLineRef,SiteId,
SlsperId,SpecificCostID,Sub,TaskID,TaxAmt00,TaxAmt01,TaxAmt02,TaxAmt03,TaxCalced,TaxCat,TaxId00,TaxId01,TaxId02,
TaxId03,TaxIdDflt,TranAmt,TranClass,TranDate,TranDesc,'RA',TxblAmt00,TxblAmt01,TxblAmt02,TxblAmt03,UnitDesc,
UnitPrice,User1,User2,User3,User4,User5,User6,User7,User8,WhseLoc
FROM ARTran
WHERE TranType = @DocType AND RefNbr = @RefNbr AND Crtd_Prog = '40690'
IF @@ERROR<>0 RETURN

INSERT ARDoc (
AcctNbr,AgentID,ApplAmt,ApplBatNbr,ApplBatSeq,ASID,BankAcct,BankID,BankSub,BatNbr,BatSeq,Cleardate,CmmnAmt,CmmnPct,
ContractID,CpnyID,Crtd_DateTime,Crtd_Prog,Crtd_User,CurrentNbr,CuryApplAmt,CuryClearAmt,CuryCmmnAmt,
CuryDiscApplAmt,CuryDiscBal,CuryDocBal,CuryEffDate,CuryId,CuryMultDiv,CuryOrigDocAmt,CuryRate,CuryRateType,
CuryStmtBal,CuryTaxTot00,CuryTaxTot01,CuryTaxTot02,CuryTaxTot03,CuryTxblTot00,CuryTxblTot01,CuryTxblTot02,
CuryTxblTot03,CustId,CustOrdNbr,Cycle,DiscApplAmt,DiscBal,DiscDate,DocBal,DocClass,DocDate,DocDesc,DocType,
DraftIssued,DueDate,InstallNbr,JobCntr,LineCntr,LUpd_DateTime,LUpd_Prog,LUpd_User,MasterDocNbr,NbrCycle,NoPrtStmt,
NoteId,OpenDoc,OrdNbr,OrigBankAcct,OrigBankSub,OrigCpnyID,OrigDocAmt,OrigDocNbr,PC_Status,PerClosed,PerEnt,PerPost,
PmtMethod,ProjectID,RefNbr,RGOLAmt,Rlsed,S4Future01,S4Future02,S4Future03,S4Future04,S4Future05,S4Future06,
S4Future07,S4Future08,S4Future09,S4Future10,S4Future11,S4Future12,ServiceCallID,ShipmentNbr,SlsperId,Status,
StmtBal,StmtDate,TaskID,TaxCntr00,TaxCntr01,TaxCntr02,TaxCntr03,TaxId00,TaxId01,TaxId02,TaxId03,TaxTot00,
TaxTot01,TaxTot02,TaxTot03,Terms,TxblTot00,TxblTot01,TxblTot02,TxblTot03,User1,User2,User3,User4,User5,
User6,User7,User8,WSID
)SELECT
AcctNbr,AgentID,ApplAmt,ApplBatNbr,ApplBatSeq,0,BankAcct,BankID,BankSub,@BatNbr,@BatSeq,Cleardate,CmmnAmt,CmmnPct,
ContractID,CpnyID,GETDATE(),'40690',@UserID,CurrentNbr,CuryApplAmt,CuryClearAmt,CuryCmmnAmt,
CuryDiscApplAmt,CuryDiscBal,CuryDocBal,CuryEffDate,CuryId,CuryMultDiv,CuryOrigDocAmt,CuryRate,CuryRateType,
CuryStmtBal,CuryTaxTot00,CuryTaxTot01,CuryTaxTot02,CuryTaxTot03,CuryTxblTot00,CuryTxblTot01,CuryTxblTot02,
CuryTxblTot03,CustId,CustOrdNbr,Cycle,DiscApplAmt,DiscBal,DiscDate,DocBal,DocClass,DocDate,DocDesc,'RA',
DraftIssued,DueDate,InstallNbr,JobCntr,LineCntr,GETDATE(),'40690',@UserID,MasterDocNbr,NbrCycle,NoPrtStmt,
NoteId,OpenDoc,OrdNbr,OrigBankAcct,OrigBankSub,OrigCpnyID,OrigDocAmt,OrigDocNbr,PC_Status,PerClosed,@PerPost,@PerPost,
PmtMethod,ProjectID,RefNbr,RGOLAmt,0,S4Future01,S4Future02,S4Future03,S4Future04,S4Future05,S4Future06,
S4Future07,S4Future08,S4Future09,S4Future10,S4Future11,S4Future12,ServiceCallID,ShipmentNbr,SlsperId,Status,
StmtBal,StmtDate,TaskID,TaxCntr00,TaxCntr01,TaxCntr02,TaxCntr03,TaxId00,TaxId01,TaxId02,TaxId03,TaxTot00,
TaxTot01,TaxTot02,TaxTot03,Terms,TxblTot00,TxblTot01,TxblTot02,TxblTot03,User1,User2,User3,User4,User5,
User6,User7,User8,WSID
FROM ARDoc
WHERE DocType = @DocType AND RefNbr = @RefNbr
IF @@ERROR<>0 RETURN

UPDATE Batch SET
CuryCrTot = CONVERT(DEC(28,3),Batch.CuryCrTot) + CONVERT(DEC(28,3),ARDoc.CuryOrigDocAmt),
CuryCtrlTot = CONVERT(DEC(28,3),Batch.CuryCtrlTot) + CONVERT(DEC(28,3),ARDoc.CuryOrigDocAmt),
CrTot = CONVERT(DEC(28,3),Batch.CrTot) + CONVERT(DEC(28,3),ARDoc.OrigDocAmt),
CtrlTot = CONVERT(DEC(28,3),Batch.CtrlTot) + CONVERT(DEC(28,3),ARDoc.OrigDocAmt)
FROM ARDoc
WHERE ARDoc.BatNbr = @BatNbr AND ARDoc.RefNbr = @RefNbr AND ARDoc.DocType = 'RA'
AND Batch.BatNbr = @BatNbr AND Batch.Module = 'AR'
IF @@ERROR<>0 RETURN

UPDATE	tnew SET S4Future09 = told.S4Future09
FROM	ARTran tnew INNER JOIN ARTran told ON
	told.ShipperCpnyID = tnew.ShipperCpnyID AND told.ShipperID = tnew.ShipperID AND told.ShipperLineRef = tnew.ShipperLineRef
WHERE	told.TranType = @DocType AND told.RefNbr = @RefNbr AND told.Crtd_Prog = '40690'
	AND tnew.BatNbr = @BatNbr AND tnew.TranType NOT IN ('AD','RA')
IF @@ERROR<>0 RETURN


