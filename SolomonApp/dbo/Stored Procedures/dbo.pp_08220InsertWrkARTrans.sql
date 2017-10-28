 CREATE PROCEDURE pp_08220InsertWrkARTrans @CustId VARCHAR(15), @TranType VARCHAR(2), @RefNbr VARCHAR(10), @UserAddress VARCHAR(21)
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as

INSERT Wrk08220ARTran (
		Acct,AcctDist,BatNbr,CmmnPct,CnvFact,ContractID,CostType,CpnyID,Crtd_DateTime,Crtd_Prog,
		Crtd_User,CuryExtCost,CuryId,CuryMultDiv,CuryRate,CuryTaxAmt00,CuryTaxAmt01,
		CuryTaxAmt02,CuryTaxAmt03,CuryTranAmt,CuryTxblAmt00,CuryTxblAmt01,CuryTxblAmt02,
		CuryTxblAmt03,CuryUnitPrice,CustId,DrCr,Excpt,ExtCost,ExtRefNbr,FiscYr,FlatRateLineNbr,InstallNbr,
		InvtId,JobRate,JrnlType,LineId,LineNbr,LineRef,LUpd_DateTime,LUpd_Prog,LUpd_User,
		MasterDocNbr,NoteId,OrdNbr,PC_Flag,PC_ID,PC_Status,PerEnt,PerPost,ProjectID,Qty,
		RefNbr,Rlsed,S4Future01,S4Future02,S4Future03,S4Future04,S4Future05,S4Future06,
		S4Future07,S4Future08,S4Future09,S4Future10,S4Future11,S4Future12,ServiceCallID,ServiceCallLineNbr,ServiceDate,
		ShipperCpnyID, ShipperID, ShipperLineRef, SiteId,SlsperId,SpecificcostID,Sub,TaskID,TaxAmt00,TaxAmt01,TaxAmt02,TaxAmt03,
		TaxCalced,TaxCat,TaxId00,TaxId01,TaxId02,TaxId03,TaxIdDflt,TranAmt,TranClass,
		TranDate,TranDesc,TranType,TxblAmt00,TxblAmt01,TxblAmt02,TxblAmt03,UnitDesc,
		UnitPrice,User1,User2,User3,User4,User5,User6,User7,User8,UserAddress,WhseLoc
		)
SELECT  
		Acct,AcctDist,BatNbr,CmmnPct,CnvFact,ContractID,CostType,CpnyID,Crtd_DateTime,Crtd_Prog,
		Crtd_User,CuryExtCost,CuryId,CuryMultDiv,CuryRate,CuryTaxAmt00,CuryTaxAmt01,
		CuryTaxAmt02,CuryTaxAmt03,CuryTranAmt,CuryTxblAmt00,CuryTxblAmt01,CuryTxblAmt02,
		CuryTxblAmt03,CuryUnitPrice,CustId,DrCr,Excpt,ExtCost,ExtRefNbr,FiscYr,FlatRateLineNbr,InstallNbr,
		InvtId,JobRate,JrnlType,LineId,LineNbr,LineRef,LUpd_DateTime,LUpd_Prog,LUpd_User,
		MasterDocNbr,NoteId,OrdNbr,PC_Flag,PC_ID,PC_Status,PerEnt,PerPost,ProjectID,Qty,
		RefNbr,Rlsed,S4Future01,S4Future02,S4Future03,S4Future04,S4Future05,S4Future06,
		S4Future07,S4Future08,S4Future09,S4Future10,S4Future11,S4Future12,ServiceCallID,ServiceCallLineNbr,ServiceDate,
		ShipperCpnyID, ShipperID, ShipperLineRef, SiteId,SlsperId,SpecificcostID,Sub,TaskID,TaxAmt00,TaxAmt01,TaxAmt02,TaxAmt03,
		TaxCalced,TaxCat,TaxId00,TaxId01,TaxId02,TaxId03,TaxIdDflt,TranAmt,TranClass,
		TranDate,TranDesc,TranType,TxblAmt00,TxblAmt01,TxblAmt02,TxblAmt03,UnitDesc,
		UnitPrice,User1,User2,User3,User4,User5,User6,User7,User8,@UserAddress,WhseLoc
FROM
		ARTran
		
WHERE
		ARTran.CustId = @CustId AND ARTran.TranType = @TranType AND ARTran.RefNbr = @RefNbr


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_08220InsertWrkARTrans] TO [MSDSL]
    AS [dbo];

