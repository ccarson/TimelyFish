 CREATE PROCEDURE pp_08220InsertWrkARDoc @CustId VARCHAR(15), @DocType VARCHAR(2), @RefNbr VARCHAR(10), @UserAddress VARCHAR(21)
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
INSERT Wrk08220ARDoc (
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
		User6,User7,User8,UserAddress,WSID
)
SELECT
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
		User6,User7,User8,@UserAddress,WSID
FROM 
		ARDoc
WHERE 
		ARDoc.CustId = @CustId AND ARDoc.DocType = @DocType AND ARDoc.RefNbr = @RefNbr


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_08220InsertWrkARDoc] TO [MSDSL]
    AS [dbo];

