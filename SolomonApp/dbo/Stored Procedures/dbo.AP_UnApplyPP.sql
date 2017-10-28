
CREATE PROCEDURE AP_UnApplyPP  
	@BatNbr  VARCHAR(10),  
	@VORefNbr VARCHAR(10),  
	@BaseCuryID VARCHAR(10),  
	@UserID  VARCHAR(10),
	@PPREfNbr VarCHAR(10)    
AS  
  
DECLARE @Cnt  Int  
DECLARE @BaseDecPl Int  
DECLARE @ErrMess SmallInt  
DECLARE @PrevLineNbr smallint  
DECLARE @ProgID  VARCHAR(8)  
DECLARE @PerPost VARCHAR(6)	--B20887

SELECT @PerPost = (SELECT perpost FROM batch with (NOLOCK) WHERE module = 'AP' and batnbr = @BatNbr) --B20887
-- 3 other changes later for bug 20887.  Search @PerPost to find them
  
SELECT @ErrMess = 0, @ProgID = '03070'  
  
IF NOT EXISTS (SELECT * FROM AP_PPApplicDet WHERE BatNbr = @BatNbr AND VORefNbr = @VORefNbr AND OperType = 'R' AND Rlsed = 0)  
   GOTO FINISH  
  
SELECT @BaseDecPl = (SELECT DecPl FROM Currncy (NOLOCK) WHERE CuryID = @BaseCuryID)  
  
SELECT @ErrMess = 16210 /* Error occurred in Batch %s while executing the following procedure: %s */  
  
/***** Add New AP_Hist Record if Vendor Does Not Exist *****/  
INSERT APHist (BegBal, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User,  
                    CuryID, FiscYr, LUpd_DateTime, LUpd_Prog, LUpd_User,  
                    NoteID, PerNbr, PtdCrAdjs00, PtdBkupWthld00, PtdBkupWthld01,
        PtdBkupWthld02, PtdBkupWthld03, PtdBkupWthld04, PtdBkupWthld05, PtdBkupWthld06, PtdBkupWthld07,
        PtdBkupWthld08, PtdBkupWthld09, PtdBkupWthld10, PtdBkupWthld11, PtdBkupWthld12, PtdCrAdjs01, PtdCrAdjs02,  
                    PtdCrAdjs03, PtdCrAdjs04, PtdCrAdjs05, PtdCrAdjs06, PtdCrAdjs07,  
                    PtdCrAdjs08, PtdCrAdjs09, PtdCrAdjs10, PtdCrAdjs11, PtdCrAdjs12,  
                    PtdDiscTkn00, PtdDiscTkn01, PtdDiscTkn02, PtdDiscTkn03, PtdDiscTkn04,  
                    PtdDiscTkn05, PtdDiscTkn06, PtdDiscTkn07, PtdDiscTkn08, PtdDiscTkn09,  
                    PtdDiscTkn10, PtdDiscTkn11, PtdDiscTkn12, PtdDrAdjs00, PtdDrAdjs01,  
                    PtdDrAdjs02, PtdDrAdjs03, PtdDrAdjs04, PtdDrAdjs05, PtdDrAdjs06,  
                    PtdDrAdjs07, PtdDrAdjs08, PtdDrAdjs09, PtdDrAdjs10, PtdDrAdjs11,  
                    PtdDrAdjs12, PtdPaymt00, PtdPaymt01, PtdPaymt02, PtdPaymt03,  
                    PtdPaymt04, PtdPaymt05, PtdPaymt06, PtdPaymt07, PtdPaymt08,  
                    PtdPaymt09, PtdPaymt10, PtdPaymt11, PtdPaymt12, PtdPurch00,  
                    PtdPurch01, PtdPurch02, PtdPurch03, PtdPurch04, PtdPurch05,  
                    PtdPurch06, PtdPurch07, PtdPurch08, PtdPurch09, PtdPurch10,  
                    PtdPurch11, PtdPurch12, S4Future01, S4Future02, S4Future03,  
                    S4Future04, S4Future05, S4Future06, S4Future07, S4Future08,  
                    S4Future09, S4Future10, S4Future11, S4Future12, User1,  
                    User2, User3, User4, User5, User6,  
                    User7, User8, VendId, YtdBkupWthld,YtdCrAdjs, YtdDiscTkn,  
                    YtdDrAdjs, YtdPaymt, YtdPurch)  
  
SELECT 0, dCpnyId, GETDATE(), @ProgID, @UserID, v.CuryID, dFiscYr, GETDATE(), @ProgID, @UserID,  
       0, CASE WHEN dFiscYr < SUBSTRING(APSetup.CurrPerNbr ,1,4)  
               THEN dFiscYr + CONVERT(CHAR(2),GLSetup.NbrPer)  
               ELSE dPerPost END,  
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  
       '', '', 0, 0, 0, 0, '', '', 0, 0, '', '',  
       '', '', 0, 0, '', '', '', '', v.VendId, 0, 0, 0, 0, 0, 0  
FROM APSetup CROSS JOIN GLSetup CROSS JOIN  
     (SELECT dVendID = d.VendID,  dCpnyID = d.CpnyID, dFiscYr = SUBSTRING(d.PerPost,1,4), dPerPost = MAX(d.PerPost)  
      FROM AP_PPApplicDet pd  
           INNER JOIN APDoc d  
               ON d.RefNbr = pd.VORefNbr AND d.DocType=pd.AppliedDocType
           Inner Join AP_PPApplic p 
           On p.AdjdRefNbr = pd.VORefNbr      
           INNER JOIN APAdjust jj  
               ON jj.AdjdRefNbr = p.PrePay_RefNbr AND jj.AdjdDocType = 'PP'  
           INNER JOIN APAdjust j  
               ON d.RefNbr = j.AdjdRefNbr AND j.AdjdDocType = d.DocType  
                  AND j.AdjgRefNbr = jj.AdjgRefNbr AND j.AdjgDocType = jj.AdjgDocType  
      WHERE pd.BatNbr = @BatNbr  
      AND   pd.VORefNbr = @VORefNbr  
      and jj.AdjdRefNbr = @PPREfNbr
      AND   pd.Rlsed = 0  
      GROUP BY d.VendID, d.CpnyID, SUBSTRING(d.PerPost,1,4)) s  
      INNER JOIN Vendor v  
          ON dVendID = v.VendID  
      LEFT JOIN APHist h  
          ON h.VendID = dVendID AND h.CpnyID = dCpnyID AND h.FiscYr = dFiscYr  
WHERE h.CpnyID IS NULL  
  
IF @@ERROR <> 0 GOTO ABORT  
  
/***** Update AP History *****/  
UPDATE APHist SET  
 LUpd_DateTime = GETDATE(),  
 LUpd_Prog = @ProgID,  
 LUpd_User = @UserID,  
 PtdPaymt00 = ROUND(PtdPaymt00 + deltaPtd00, @BaseDecPl),  
 PtdPaymt01 = ROUND(PtdPaymt01 + deltaPtd01, @BaseDecPl),  
 PtdPaymt02 = ROUND(PtdPaymt02 + deltaPtd02, @BaseDecPl),  
 PtdPaymt03 = ROUND(PtdPaymt03 + deltaPtd03, @BaseDecPl),  
 PtdPaymt04 = ROUND(PtdPaymt04 + deltaPtd04, @BaseDecPl),  
 PtdPaymt05 = ROUND(PtdPaymt05 + deltaPtd05, @BaseDecPl),  
 PtdPaymt06 = ROUND(PtdPaymt06 + deltaPtd06, @BaseDecPl),  
 PtdPaymt07 = ROUND(PtdPaymt07 + deltaPtd07, @BaseDecPl),  
 PtdPaymt08 = ROUND(PtdPaymt08 + deltaPtd08, @BaseDecPl),  
 PtdPaymt09 = ROUND(PtdPaymt09 + deltaPtd09, @BaseDecPl),  
 PtdPaymt10 = ROUND(PtdPaymt10 + deltaPtd10, @BaseDecPl),  
 PtdPaymt11 = ROUND(PtdPaymt11 + deltaPtd11, @BaseDecPl),  
    PtdPaymt12 = ROUND(PtdPaymt12 + deltaPtd12, @BaseDecPl),  
    YtdPaymt = ROUND(YtdPaymt + deltaYtd, @BaseDecPl)  
FROM (SELECT dVendID=d.VendID, dCpnyID=d.CpnyID, dFiscYr=SUBSTRING(d.PerPost,1,4),  
             deltaPtd00=SUM(CASE WHEN SUBSTRING(d.PerPost,5,2)='01' THEN j.CuryRGOLAmt ELSE 0 END),  
             deltaPtd01=SUM(CASE WHEN SUBSTRING(d.PerPost,5,2)='02' THEN j.CuryRGOLAmt ELSE 0 END),  
             deltaPtd02=SUM(CASE WHEN SUBSTRING(d.PerPost,5,2)='03' THEN j.CuryRGOLAmt ELSE 0 END),  
             deltaPtd03=SUM(CASE WHEN SUBSTRING(d.PerPost,5,2)='04' THEN j.CuryRGOLAmt ELSE 0 END),  
             deltaPtd04=SUM(CASE WHEN SUBSTRING(d.PerPost,5,2)='05' THEN j.CuryRGOLAmt ELSE 0 END),  
             deltaPtd05=SUM(CASE WHEN SUBSTRING(d.PerPost,5,2)='06' THEN j.CuryRGOLAmt ELSE 0 END),  
             deltaPtd06=SUM(CASE WHEN SUBSTRING(d.PerPost,5,2)='07' THEN j.CuryRGOLAmt ELSE 0 END),  
             deltaPtd07=SUM(CASE WHEN SUBSTRING(d.PerPost,5,2)='08' THEN j.CuryRGOLAmt ELSE 0 END),  
             deltaPtd08=SUM(CASE WHEN SUBSTRING(d.PerPost,5,2)='09' THEN j.CuryRGOLAmt ELSE 0 END),  
             deltaPtd09=SUM(CASE WHEN SUBSTRING(d.PerPost,5,2)='10' THEN j.CuryRGOLAmt ELSE 0 END),  
             deltaPtd10=SUM(CASE WHEN SUBSTRING(d.PerPost,5,2)='11' THEN j.CuryRGOLAmt ELSE 0 END),  
             deltaPtd11=SUM(CASE WHEN SUBSTRING(d.PerPost,5,2)='12' THEN j.CuryRGOLAmt ELSE 0 END),  
             deltaPtd12=SUM(CASE WHEN SUBSTRING(d.PerPost,5,2)='13' THEN j.CuryRGOLAmt ELSE 0 END),  
             deltaYtd=SUM(j.CuryRGOLAmt)  
      FROM AP_PPApplicDet pd  
           INNER JOIN APDoc d  
               ON d.RefNbr = pd.VORefNbr AND d.DocType = pd.AppliedDocType  
                          Inner Join AP_PPApplic p 
           On p.AdjdRefNbr = pd.VORefNbr  
           INNER JOIN APAdjust jj  
               ON jj.AdjdRefNbr = p.PrePay_RefNbr AND jj.AdjdDocType = 'PP'  
           INNER JOIN APAdjust j  
               ON d.RefNbr = j.AdjdRefNbr AND j.AdjdDocType = d.DocType  
                  AND j.AdjgRefNbr = jj.AdjgRefNbr AND j.AdjgDocType = jj.AdjgDocType  
      WHERE pd.BatNbr = @BatNbr  
      AND   pd.VORefNbr = @VORefNbr  
      and jj.AdjdRefNbr = @PPREfNbr
      AND   pd.Rlsed = 0  
      GROUP BY d.VendID, d.CpnyID, SUBSTRING(d.PerPost,1,4)) s  
WHERE VendID = dVendID  
AND CpnyID = dCpnyID  
AND FiscYr = dFiscYr  
  
IF @@ERROR < > 0 GOTO ABORT  
  
/***** Create Vendor AP_Balances Record If Does Not Exist  *****/  
INSERT AP_Balances (CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User, CurrBal,  
                    CuryID, CYBox00, CYBox01, CYBox02, CYBox03,  
                    CYBox04, CYBox05, CYBox06, CYBox07, CYBox08,  
                    CYBox09, CYBox10, CYBox11, CYBox12, CYBox13, 
					CYBox14, CYBox15, CYFor01, CYInterest, FutureBal, LastChkDate,  
                    LastVODate, LUpd_DateTime, LUpd_Prog, LUpd_User, NoteID,  
                    NYBox00, NYBox01, NYBox02, NYBox03, NYBox04,  
                    NYBox05, NYBox06, NYBox07, NYBox08, NYBox09,  
                    NYBox10, NYBox11, NYBox12, NYBox13, NYBox14, 
					NYBox15, NYFor01, NYInterest, PerNbr, S4Future01, S4Future02,  
                    S4Future03, S4Future04, S4Future05, S4Future06, S4Future07,  
                    S4Future08, S4Future09, S4Future10, S4Future11, S4Future12,  
                    User1, User2, User3, User4, User5,  
              User6, User7, User8, VendID)  
  
SELECT DISTINCT d.CpnyId, GETDATE(), @ProgID, @UserID, 0,   
        v.CuryID, 0, 0, 0, 0,  
        0, 0, 0, 0, 0,  
        0, 0, 0, 0, 0, 
		0, 0, '', 0, 0, '',  
        '', GETDATE(), @ProgID, @UserID, '',   
		0, 0, 0, 0, 0,  
        0, 0, 0, 0, 0,  
        0, 0, 0, 0, 0, 
		0, '', 0, '', '', '',  
		0, 0, 0, 0, '',  
        '', 0, 0, '', '',  
		'', '', 0, 0, '',  
        '', '', '', v.VendID  
FROM AP_PPApplicDet pd  
     INNER JOIN APDoc d  
         ON d.RefNbr = pd.VORefNbr AND d.DocType = pd.AppliedDocType  
     INNER JOIN Vendor v  
         ON d.VendID = v.VendID  
                    Inner Join AP_PPApplic p 
           On p.AdjdRefNbr = pd.VORefNbr  
     INNER JOIN APAdjust jj  
         ON jj.AdjdRefNbr = p.PrePay_RefNbr AND jj.AdjdDocType = 'PP'  
     INNER JOIN APAdjust j  
         ON d.RefNbr = j.AdjdRefNbr AND j.AdjdDocType = d.DocType  
            AND j.AdjgRefNbr = jj.AdjgRefNbr AND j.AdjgDocType = jj.AdjgDocType  
     LEFT OUTER JOIN AP_Balances b  
        ON d.cpnyid = b.cpnyid and d.vendid = b.vendid  
WHERE b.cpnyid IS NULL  
AND pd.BatNbr = @BatNbr  
AND pd.VORefNbr = @VORefNbr  
and jj.AdjdRefNbr = @PPREfNbr
AND pd.Rlsed = 0  
  
IF @@ERROR < > 0 GOTO ABORT  
  
/*** update vendor balances with prepayment RGOL ***/  
UPDATE AP_Balances  
SET CurrBal = ROUND(CurrBal - deltaCurr, @BaseDecPl),  
 FutureBal = ROUND(FutureBal - deltaFuture, @BaseDecPl),  
 LUpd_DateTime = GETDATE(),  
 LUpd_Prog = @ProgID,  
 LUpd_User = @UserID  
FROM (SELECT dVendID = d.VendID, dCpnyID = d.CpnyID,  
             deltaCurr = SUM(CASE WHEN d.PerPost <= s.CurrPerNbr THEN j.CuryRGOLAmt ELSE 0 END),  
             deltaFuture = SUM(CASE WHEN d.PerPost > s.CurrPerNbr THEN j.CuryRGOLAmt ELSE 0 END)  
      FROM AP_PPApplicDet pd  
           INNER JOIN APDoc d  
               ON d.RefNbr = pd.VORefNbr AND d.DocType = pd.AppliedDocType
                          Inner Join AP_PPApplic p 
           On p.AdjdRefNbr = pd.VORefNbr    
           INNER JOIN APAdjust jj  
               ON jj.AdjdRefNbr = p.PrePay_RefNbr AND jj.AdjdDocType = 'PP'  
           INNER JOIN APAdjust j  
               ON d.RefNbr = j.AdjdRefNbr AND j.AdjdDocType = d.DocType  
                  AND j.AdjgRefNbr = jj.AdjgRefNbr AND j.AdjgDocType = jj.AdjgDocType  
           CROSS JOIN APSetup s  
      WHERE pd.BatNbr = @BatNbr  
      AND   pd.VORefNbr = @VORefNbr  
      and jj.AdjdRefNbr = @PPREfNbr
      AND   pd.Rlsed = 0  
      GROUP BY d.VendID, d.CpnyID) s  
WHERE VendID = dVendID  
AND CpnyID = dCpnyID  
  
IF @@ERROR <> 0 GOTO ABORT  
  
-- Rollback AP Transactions for PP Application [PP Application screen]  
INSERT APTran (Acct, AcctDist, Applied_PPrefNbr, BatNbr, BoxNbr, Component, CostType, CostTypeWO, CpnyId,  
       Crtd_DateTime, Crtd_Prog, Crtd_User,  
       CuryId, CuryMultDiv, CuryRate, CuryTaxAmt00, CuryTaxAmt01, CuryTaxAmt02, CuryTaxAmt03,  
       CuryTranAmt,  
       CuryTxblAmt00, CuryTxblAmt01, CuryTxblAmt02, CuryTxblAmt03, CuryUnitPrice,  
       DrCr, Employee, EmployeeID, Excpt, ExtRefNbr, FiscYr, InstallNbr, InvcTypeId,  
       JobRate, JrnlType, Labor_Class_Cd, LineId, LineNbr,  
       LineRef, LineType,  
       LUpd_dateTime, LUpd_Prog, LUpd_User,  
       MasterDocNbr, NoteID, PC_Flag, PC_ID, PC_Status, PerEnt, PerPost, PmtMethod, POLineRef, ProjectID, Qty, Rcptnbr,  
       RefNbr, Rlsed,  
       S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,  
       S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12,  
       ServiceDate, Sub, TaskID,  
       TaxAmt00, TaxAmt01, TaxAmt02, TaxAmt03, TaxCalced,  
       TaxCat, TaxId00, TaxId01, TaxId02, TaxId03, TaxIdDflt,  
       TranAmt,  
       TranClass, TranDate, TranDesc, TranType,  
       TxblAmt00, TxblAmt01, TxblAmt02, TxblAmt03,  
       UnitDesc, UnitPrice,  
       User1, User2, User3, User4, User5, User6, User7, User8,  
       VendId,  
       AlternateID, BOMLineRef, CuryPOExtPrice, CuryPOUnitPrice, CuryPPV, InvtID, POExtPrice, PONbr, POQty,  
       POUnitPrice, PPV, QtyVar, RcptLineRef, RcptQty, SiteId, SoLineRef, SOOrdNbr, SOTypeID, WONbr, WOStepNbr)  
SELECT Distinct t.Acct, t.AcctDist, '', @BatNbr, t.BoxNbr, t.Component, t.CostType, t.CostTypeWO, t.CpnyId,  
       getdate(), @ProgID, @UserID,  
       t.CuryId, t.CuryMultDiv, t.CuryRate, t.CuryTaxAmt00, t.CuryTaxAmt01, t.CuryTaxAmt02, t.CuryTaxAmt03,  
    t.CuryTranAmt,  
       t.CuryTxblAmt00, t.CuryTxblAmt01, t.CuryTxblAmt02, t.CuryTxblAmt03, t.CuryUnitPrice,  
       CASE t.DrCr WHEN 'D' THEN 'C' ELSE 'D' END, t.Employee, t.EmployeeID, t.Excpt, t.ExtRefNbr, t.FiscYr, t.InstallNbr, t.InvcTypeId,  
       t.JobRate, t.JrnlType, t.Labor_Class_Cd, t.LineId, t.LineNbr,  
       t.LineRef, t.LineType,  
       getdate(), @ProgID, @UserID,  
       t.MasterDocNbr, '', t.PC_Flag, t.PC_ID, t.PC_Status, t.PerEnt, @PerPost, t.PmtMethod, t.POLineRef, t.ProjectID, t.Qty, t.Rcptnbr,
       t.RefNbr, 1,  
       t.S4Future01, t.S4Future02, t.S4Future03, t.S4Future04, t.S4Future05, t.S4Future06,  
       t.S4Future07, t.S4Future08, t.S4Future09, t.S4Future10, t.S4Future11, t.S4Future12,  
       t.ServiceDate, t.Sub, t.TaskID,  
       t.TaxAmt00, t.TaxAmt01, t.TaxAmt02, t.TaxAmt03, t.TaxCalced,  
       t.TaxCat, t.TaxId00, t.TaxId01, t.TaxId02, t.TaxId03, t.TaxIdDflt,  
       t.TranAmt,  
       t.TranClass, t.TranDate, t.TranDesc, t.TranType,  
       t.TxblAmt00, t.TxblAmt01, t.TxblAmt02, t.TxblAmt03,  
       t.UnitDesc, t.UnitPrice,  
       t.User1, t.User2, t.User3, t.User4, t.User5, t.User6, t.User7, t.User8,  
       t.VendId,  
       t.AlternateID, t.BOMLineRef, t.CuryPOExtPrice, t.CuryPOUnitPrice, t.CuryPPV, t.InvtID, t.POExtPrice, t.PONbr, t.POQty,  
       t.POUnitPrice, t.PPV, t.QtyVar, t.RcptLineRef, t.RcptQty,  
       t.SiteId, t.SoLineRef, t.SOOrdNbr, t.SOTypeID, t.WONbr, t.WOStepNbr  
FROM AP_PPApplicDet pd  
     INNER JOIN APDoc d                              -- VO  
         ON d.RefNbr = pd.VORefNbr AND d.DocType = pd.AppliedDocType 
                    Inner Join AP_PPApplic p 
           On p.AdjdRefNbr = pd.VORefNbr   
     INNER JOIN APAdjust jj                          -- CK to PP  
         ON jj.AdjdRefNbr = p.PrePay_RefNbr AND jj.AdjdDocType = 'PP'  
     INNER JOIN APAdjust j                           -- CK to VO  
         ON d.RefNbr = j.AdjdRefNbr AND j.AdjdDocType = d.DocType  
            AND j.AdjgRefNbr = jj.AdjgRefNbr AND j.AdjgDocType = jj.AdjgDocType  
     INNER JOIN APTran t                             -- PP applying APTrans  
         ON t.RefNbr = d.RefNbr AND t.TranType in ('PP','RL','RG')  
WHERE pd.BatNbr = @BatNbr  
AND pd.VORefNbr = @VORefNbr
and jj.AdjdRefNbr = @PPREfNbr  
AND pd.Rlsed = 0  
AND LTRIM(j.S4Future12) <> ''  
AND t.BatNbr = j.S4Future12
AND t.Applied_PPrefNbr = @PPREfNbr  
  
IF @@ERROR <> 0 GOTO ABORT  

-- Rollback AP Transactions for PP Application [Normal VO release process]  
-- Reversing PP transactions now  
INSERT APTran (Acct, AcctDist, Applied_PPrefNbr, BatNbr, BoxNbr, Component, CostType, CostTypeWO, CpnyId,  
       Crtd_DateTime, Crtd_Prog, Crtd_User,  
       CuryId, CuryMultDiv, CuryRate, CuryTaxAmt00, CuryTaxAmt01, CuryTaxAmt02, CuryTaxAmt03,  
       CuryTranAmt,  
       CuryTxblAmt00, CuryTxblAmt01, CuryTxblAmt02, CuryTxblAmt03, CuryUnitPrice,  
       DrCr, Employee, EmployeeID, Excpt, ExtRefNbr, FiscYr, InstallNbr, InvcTypeId,  
       JobRate, JrnlType, Labor_Class_Cd, LineId, LineNbr,  
       LineRef, LineType,  
       LUpd_dateTime, LUpd_Prog, LUpd_User,  
       MasterDocNbr, NoteID, PC_Flag, PC_ID, PC_Status, PerEnt, PerPost, PmtMethod, POLineRef, ProjectID, Qty, Rcptnbr,  
       RefNbr, Rlsed,  
       S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,  
       S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12,  
       ServiceDate, Sub, TaskID,  
       TaxAmt00, TaxAmt01, TaxAmt02, TaxAmt03, TaxCalced,  
       TaxCat, TaxId00, TaxId01, TaxId02, TaxId03, TaxIdDflt,  
       TranAmt,  
       TranClass, TranDate, TranDesc, TranType,  
       TxblAmt00, TxblAmt01, TxblAmt02, TxblAmt03,  
       UnitDesc, UnitPrice,  
       User1, User2, User3, User4, User5, User6, User7, User8,  
       VendId,  
       AlternateID, BOMLineRef, CuryPOExtPrice, CuryPOUnitPrice, CuryPPV, InvtID, POExtPrice, PONbr, POQty,  
       POUnitPrice, PPV, QtyVar, RcptLineRef, RcptQty, SiteId, SoLineRef, SOOrdNbr, SOTypeID, WONbr, WOStepNbr)  
SELECT Distinct t.Acct, t.AcctDist, '',@BatNbr, t.BoxNbr, t.Component, t.CostType, t.CostTypeWO, t.CpnyId,  
       getdate(), @ProgID, @UserID,  
       t.CuryId, t.CuryMultDiv, t.CuryRate, t.CuryTaxAmt00, t.CuryTaxAmt01, t.CuryTaxAmt02, t.CuryTaxAmt03,  
       t.CuryTranAmt,  
       t.CuryTxblAmt00, t.CuryTxblAmt01, t.CuryTxblAmt02, t.CuryTxblAmt03, t.CuryUnitPrice,  
       CASE t.DrCr WHEN 'D' THEN 'C' ELSE 'D' END, t.Employee, t.EmployeeID, t.Excpt, t.ExtRefNbr, t.FiscYr, t.InstallNbr, t.InvcTypeId,  
       t.JobRate, t.JrnlType, t.Labor_Class_Cd, t.LineId, t.LineNbr,  
       t.LineRef, t.LineType,  
       getdate(), @ProgID, @UserID,  
       t.MasterDocNbr, '', t.PC_Flag, t.PC_ID, t.PC_Status, t.PerEnt, @PerPost, t.PmtMethod, t.POLineRef, t.ProjectID, t.Qty, t.Rcptnbr,
       t.RefNbr, 1,  
       t.S4Future01, t.S4Future02, t.S4Future03, t.S4Future04, t.S4Future05, t.S4Future06,  
       t.S4Future07, t.S4Future08, t.S4Future09, t.S4Future10, t.S4Future11, t.S4Future12,  
       t.ServiceDate, t.Sub, t.TaskID,  
       t.TaxAmt00, t.TaxAmt01, t.TaxAmt02, t.TaxAmt03, t.TaxCalced,  
       t.TaxCat, t.TaxId00, t.TaxId01, t.TaxId02, t.TaxId03, t.TaxIdDflt,  
       t.TranAmt,  
       t.TranClass, t.TranDate, t.TranDesc, t.TranType,  
       t.TxblAmt00, t.TxblAmt01, t.TxblAmt02, t.TxblAmt03,  
       t.UnitDesc, t.UnitPrice,  
       t.User1, t.User2, t.User3, t.User4, t.User5, t.User6, t.User7, t.User8,  
       t.VendId,  
       t.AlternateID, t.BOMLineRef, t.CuryPOExtPrice, t.CuryPOUnitPrice, t.CuryPPV, t.InvtID, t.POExtPrice, t.PONbr, t.POQty,  
       t.POUnitPrice, t.PPV, t.QtyVar, t.RcptLineRef, t.RcptQty,  
       t.SiteId, t.SoLineRef, t.SOOrdNbr, t.SOTypeID, t.WONbr, t.WOStepNbr  
FROM AP_PPApplicDet pd  
     INNER JOIN APDoc d                              -- VO  
         ON d.RefNbr = pd.VORefNbr AND d.DocType = pd.AppliedDocType  
                    Inner Join AP_PPApplic p 
           On p.AdjdRefNbr = pd.VORefNbr  
     INNER JOIN APAdjust jj                          -- CK to PP  
         ON jj.AdjdRefNbr = p.PrePay_RefNbr AND jj.AdjdDocType = 'PP'  
     INNER JOIN APAdjust j                           -- CK to VO  
         ON d.RefNbr = j.AdjdRefNbr AND j.AdjdDocType = d.DocType  
            AND j.AdjgRefNbr = jj.AdjgRefNbr AND j.AdjgDocType = jj.AdjgDocType  
     INNER JOIN APTran t                             -- PP applying APTrans  
         ON t.RefNbr = d.RefNbr AND t.TranType in ('PP','RL','RG')  
WHERE pd.BatNbr = @BatNbr  
AND pd.VORefNbr = @VORefNbr  
and jj.AdjdRefNbr = @PPREfNbr
AND pd.Rlsed = 0  
AND t.BatNbr = d.BatNbr  
AND LTRIM(j.S4Future12) = ''
AND t.Applied_PPrefNbr = @PPREfNbr    

IF @@ERROR <> 0 GOTO ABORT  

  
-- Inserting summary credit transaction  
INSERT APTran (Acct, AcctDist, Applied_PPrefNbr, BatNbr, BoxNbr, Component, CostType, CostTypeWO, CpnyId,  
       Crtd_DateTime, Crtd_Prog, Crtd_User,  
       CuryId, CuryMultDiv, CuryRate, CuryTaxAmt00, CuryTaxAmt01, CuryTaxAmt02, CuryTaxAmt03,  
       CuryTranAmt,  
       CuryTxblAmt00, CuryTxblAmt01, CuryTxblAmt02, CuryTxblAmt03, CuryUnitPrice,  
       DrCr, Employee, EmployeeID, Excpt, ExtRefNbr, FiscYr, InstallNbr, InvcTypeId,  
       JobRate, JrnlType, Labor_Class_Cd, LineId, LineNbr,  
       LineRef, LineType,  
       LUpd_dateTime, LUpd_Prog, LUpd_User,  
       MasterDocNbr, NoteID, PC_Flag, PC_ID, PC_Status, PerEnt, PerPost, PmtMethod, POLineRef, ProjectID, Qty, Rcptnbr,  
       RefNbr, Rlsed,  
       S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,  
       S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12,  
       ServiceDate, Sub, TaskID,  
       TaxAmt00, TaxAmt01, TaxAmt02, TaxAmt03, TaxCalced,  
       TaxCat, TaxId00, TaxId01, TaxId02, TaxId03, TaxIdDflt,  
       TranAmt,  
       TranClass, TranDate, TranDesc, TranType,  
       TxblAmt00, TxblAmt01, TxblAmt02, TxblAmt03,  
       UnitDesc, UnitPrice,  
       User1, User2, User3, User4, User5, User6, User7, User8,  
       VendId,  
       AlternateID, BOMLineRef, CuryPOExtPrice, CuryPOUnitPrice, CuryPPV, InvtID, POExtPrice, PONbr, POQty,  
       POUnitPrice, PPV, QtyVar, RcptLineRef, RcptQty, SiteId, SoLineRef, SOOrdNbr, SOTypeID, WONbr, WOStepNbr)  
SELECT Distinct t.Acct, t.AcctDist, '', @BatNbr, t.BoxNbr, t.Component, t.CostType, t.CostTypeWO, t.CpnyId,  
       getdate(), @ProgID, @UserID,  
       t.CuryId, t.CuryMultDiv, t.CuryRate, t.CuryTaxAmt00, t.CuryTaxAmt01, t.CuryTaxAmt02, t.CuryTaxAmt03,  
       ttt.CuryTranAmt,  
       t.CuryTxblAmt00, t.CuryTxblAmt01, t.CuryTxblAmt02, t.CuryTxblAmt03, t.CuryUnitPrice,  
       'C', t.Employee, t.EmployeeID, t.Excpt, t.ExtRefNbr, t.FiscYr, t.InstallNbr, t.InvcTypeId,  
       t.JobRate, t.JrnlType, t.Labor_Class_Cd, t.LineId, t.LineNbr,  
       t.LineRef, t.LineType,  
       getdate(), @ProgID, @UserID,  
       t.MasterDocNbr, '', t.PC_Flag, t.PC_ID, t.PC_Status, t.PerEnt, @PerPost, t.PmtMethod, t.POLineRef, t.ProjectID, t.Qty, t.Rcptnbr,
       t.RefNbr, 1,  
       t.S4Future01, t.S4Future02, t.S4Future03, t.S4Future04, t.S4Future05, t.S4Future06,  
       t.S4Future07, t.S4Future08, t.S4Future09, t.S4Future10, t.S4Future11, t.S4Future12,  
       t.ServiceDate, t.Sub, t.TaskID,  
       t.TaxAmt00, t.TaxAmt01, t.TaxAmt02, t.TaxAmt03, t.TaxCalced,  
       t.TaxCat, t.TaxId00, t.TaxId01, t.TaxId02, t.TaxId03, t.TaxIdDflt,  
       j.AdjAmt,  
       t.TranClass, t.TranDate, t.TranDesc, 'PP',  
       t.TxblAmt00, t.TxblAmt01, t.TxblAmt02, t.TxblAmt03,  
       t.UnitDesc, t.UnitPrice,  
       t.User1, t.User2, t.User3, t.User4, t.User5, t.User6, t.User7, t.User8,  
       t.VendId,  
       t.AlternateID, t.BOMLineRef, t.CuryPOExtPrice, t.CuryPOUnitPrice, t.CuryPPV, t.InvtID, t.POExtPrice, t.PONbr, t.POQty,  
       t.POUnitPrice, t.PPV, t.QtyVar, t.RcptLineRef, t.RcptQty,  
       t.SiteId, t.SoLineRef, t.SOOrdNbr, t.SOTypeID, t.WONbr, t.WOStepNbr  
FROM AP_PPApplicDet pd  
     INNER JOIN APDoc d                              -- VO  
         ON d.RefNbr = pd.VORefNbr AND d.DocType = pd.AppliedDocType  
                    Inner Join AP_PPApplic p 
           On p.AdjdRefNbr = pd.VORefNbr  
     INNER JOIN APAdjust jj                          -- CK to PP  
         ON jj.AdjdRefNbr = p.PrePay_RefNbr AND jj.AdjdDocType = 'PP'  
     INNER JOIN APAdjust j                           -- CK to VO  
         ON d.RefNbr = j.AdjdRefNbr AND j.AdjdDocType = d.DocType  
            AND j.AdjgRefNbr = jj.AdjgRefNbr AND j.AdjgDocType = jj.AdjgDocType  
     INNER JOIN APTran t                             -- PP applying APTran missing  
         ON t.RefNbr = d.RefNbr AND t.TranType=pd.AppliedDocType AND t.DrCr = 'C' AND t.BatNbr = d.BatNbr  
     INNER JOIN (SELECT RefNbr, sum(TranAmt) AS TranAmt, sum(CuryTranAmt) AS CuryTranAmt  
                 FROM APTran tt  
                 WHERE tt.BatNbr=@BatNbr AND tt.DrCr='D'  
                 GROUP BY tt.RefNbr) ttt  
         ON ttt.RefNbr = d.RefNbr  
WHERE pd.BatNbr = @BatNbr  
AND pd.VORefNbr = @VORefNbr  
and jj.AdjdRefNbr = @PPREfNbr
AND pd.Rlsed = 0  
AND LTRIM(j.S4Future12) = '' 
AND t.Applied_PPrefNbr = @PPREfNbr   
  
IF @@ERROR <> 0 GOTO ABORT  

/*** update original prepayment APAdjust record ***/  
UPDATE j  
SET adjamt =    round(convert(dec(28,3), j.AdjAmt) + convert(dec(28,3),j2.AdjAmt)+convert(dec(28,3),j2.CuryRGOLAmt),@BaseDecPl),  
 curyadjdamt = round(convert(dec(28,3),j.CuryAdjdAmt) + convert(dec(28,3), j2.CuryAdjdAmt),Currncy.DecPl),  
 curyadjgamt=round(convert(dec(28,3), j.CuryAdjgAmt) + convert(dec(28,3),j2.CuryAdjgAmt),Currncy.DecPl),  
 LUpd_DateTime = GETDATE(),  
 LUpd_Prog = @ProgID,  
 LUpd_User = @UserID  
FROM AP_PPApplicDet pd  
     INNER JOIN APDoc d                     -- VO  
         ON d.RefNbr = pd.VORefNbr  
            AND d.DocType = pd.AppliedDocType  
     INNER JOIN APAdjust j                  -- CK to PP  
         ON j.AdjdRefNbr = pd.PPRefNbr  
            AND j.AdjdDocType = 'PP'  
            AND j.s4future11 <> 'V'         -- new  
     INNER JOIN APAdjust j2                 -- CK to VO  
         ON j2.AdjdRefNbr = pd.VORefNbr  
            AND j2.AdjdDocType = pd.AppliedDocType  
            AND j2.AdjgRefNbr = j.AdjgRefNbr  
            AND j2.AdjgDocType = j.AdjgDocType  
     INNER JOIN Currncy (NOLOCK)  
 ON j.CuryAdjdCuryID = Currncy.CuryID  -- PP Currency  
WHERE pd.BatNbr = @BatNbr  
AND pd.VORefNbr = @VORefNbr  
and pd.PPRefNbr = @PPREfNbr
AND pd.Rlsed = 0  
  
IF @@ERROR < > 0 GOTO ABORT  

/*** update VO apdoc to adjust for pre-payment unapplied ***/  
UPDATE d  
SET CuryDocBal = ROUND(CuryDocBal + j.CuryAdjdAmt,Currncy.DecPl),  
 DocBal = ROUND(DocBal + j.AdjAmt,@BaseDecPl),  
 PerClosed = CASE WHEN ROUND(d.CuryDocBal + j.CuryAdjdAmt, Currncy.DecPl) > 0 THEN '' Else PerClosed END,  
 OpenDoc = CASE WHEN ROUND(d.CuryDocBal + j.CuryAdjdAmt, Currncy.DecPl) > 0 THEN 1 Else 0 END,  
 LUpd_DateTime = GETDATE(),  
 LUpd_Prog = @ProgID,  
 LUpd_User = @UserID  
FROM AP_PPApplicDet pd  
     INNER JOIN APDoc d  
         ON d.RefNbr = pd.VORefNbr AND d.DocType = pd.AppliedDocType 
                    Inner Join AP_PPApplic p 
           On p.AdjdRefNbr = pd.VORefNbr   
     INNER JOIN APAdjust jj  
         ON jj.AdjdRefNbr = p.PrePay_RefNbr AND jj.AdjdDocType = 'PP'  
     INNER JOIN APAdjust j  
         ON d.RefNbr = j.AdjdRefNbr AND j.AdjdDocType = d.DocType AND j.AdjgRefNbr=jj.AdjgRefNbr AND j.AdjgDocType=jj.AdjgDocType  
     INNER JOIN Currncy (NOLOCK)  
         ON d.CuryID = Currncy.CuryID  
WHERE pd.BatNbr = @BatNbr  
AND pd.VORefNbr = @VORefNbr  
and jj.AdjdRefNbr = @PPREfNbr
AND pd.Rlsed = 0  
  
IF @@ERROR < > 0 GOTO ABORT  
  
/***** Updating AP_PP details *****/  
UPDATE pd  
SET CuryApplyAmt = j.CuryAdjdAmt  
FROM AP_PPApplicDet pd  
     INNER JOIN APDoc d  
         ON d.RefNbr = pd.VORefNbr AND d.DocType = pd.AppliedDocType 
                    Inner Join AP_PPApplic p 
           On p.AdjdRefNbr = pd.VORefNbr   
     INNER JOIN APAdjust jj  
         ON jj.AdjdRefNbr = p.PrePay_RefNbr AND jj.AdjdDocType = 'PP'  
     INNER JOIN APAdjust j  
         ON j.AdjdRefNbr = pd.VORefNbr AND j.AdjdDocType = pd.AppliedDocType AND j.AdjgRefNbr=jj.AdjgRefNbr AND j.AdjgDocType=jj.AdjgDocType  
WHERE pd.BatNbr = @BatNbr  
AND pd.VORefNbr = @VORefNbr  
and jj.AdjdRefNbr = @PPREfNbr
AND pd.Rlsed = 0  
  
IF @@ERROR < > 0 GOTO ABORT  
  
/***** Deleting APAdjust - Prepayment Application *****/  
DELETE j  
FROM AP_PPApplicDet pd  
     INNER JOIN APDoc d  
         ON d.RefNbr=pd.VORefNbr AND d.DocType=pd.AppliedDocType 
                    Inner Join AP_PPApplic p 
           On p.AdjdRefNbr = pd.VORefNbr   
     INNER JOIN APAdjust jj  
         ON jj.AdjdRefNbr=p.PrePay_RefNbr AND jj.AdjdDocType='PP'  
     INNER JOIN APAdjust j  
         ON d.RefNbr = j.AdjdRefNbr AND j.AdjdDocType = d.DocType  
            AND j.AdjgRefNbr=jj.AdjgRefNbr AND j.AdjgDocType=jj.AdjgDocType  
WHERE pd.BatNbr = @BatNbr  
AND pd.VORefNbr = @VORefNbr  
and jj.AdjdRefNbr = @PPREfNbr
AND pd.Rlsed = 0 

IF @@ERROR < > 0 GOTO ABORT  

--Remove Records From AP_PPApplic table
Delete AP_PPApplic 
where 
AdjdRefNbr = @VORefNbr AND
PrePay_RefNbr = @PPRefNbr
 
IF @@ERROR < > 0 GOTO ABORT   
  
--Removing the last reference to the PP unapplied from the VO APDoc  
UPDATE d  
SET LUpd_DateTime = GETDATE(),  
 LUpd_Prog = @ProgID,  
 LUpd_User = @UserID
FROM AP_PPApplicDet pd INNER JOIN APDoc d ON d.RefNbr=pd.VORefNbr AND d.DocType=pd.AppliedDocType  
WHERE pd.BatNbr=@BatNbr  
AND pd.VORefNbr = @VORefNbr  
and pd.PPRefNbr = @PPREfNbr
AND pd.Rlsed = 0  
  
IF @@ERROR < > 0 GOTO ABORT  
  
UPDATE AP_PPApplicDet  
SET LUpd_Prog = @ProgID,  
 LUpd_User = @UserID,  
 LUpd_DateTime = getdate(),  
 Rlsed = 1  
WHERE BatNbr = @BatNbr  
AND VORefNbr = @VORefNbr 
AND PPRefNbr = @pprefnbr 
AND Rlsed = 0  
  
IF @@ERROR < > 0 GOTO ABORT  

 
SELECT @ErrMess=1  
  
GOTO FINISH  
  
ABORT:  
  
FINISH:  
 --SELECT @ErrMess  
 RETURN @ErrMess  
  

GO
GRANT CONTROL
    ON OBJECT::[dbo].[AP_UnApplyPP] TO [MSDSL]
    AS [dbo];

