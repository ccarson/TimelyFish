 CREATE PROCEDURE pp_08400SalesTax @UserAddress VARCHAR(21),
                                        @Sol_User CHAR (10),
                                        @BaseDecPl INT,
                                        @CRResult INT OUTPUT
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
/********************************************************************************
*             Copyright Solomon Software, Inc. 1994-2001 All Rights Reserved
**    Proc Name: pp_08400SalesTax
**++* Narrative: Runs all tax processing for batches with editscrnbr = 08010.
*++*            - Adjusts price inclusive tranamts to not include tax
*++*            - Inserts ArTrans for the tax amounts
*++*            - Updates Appropriate history tables.
*++*
**    Inputs   : UserAddress  VARCHAR(21)   Workstation id of caller
*               Sol_User     VARCHAR(10)   Calling User
**   Called by: pp_08400
*
*/

SET NOCOUNT ON
SET DEADLOCK_PRIORITY LOW

DECLARE @PROGID CHAR(8)
DECLARE @Debug INT
DECLARE @CpnyID CHAR(10), @RefNbr CHAR(10), @DocType CHAR(2), @TaxID CHAR(10),
	@Acct CHAR(10), @YrMon CHAR(6), @CuryTaxTot FLOAT(32),
	@CuryTxblTot FLOAT(32), @TaxTot FLOAT(32), @TxblTot FLOAT(32), @Sub char(24)

SELECT @PROGID = '08400'
SELECT @Debug = CASE WHEN @UserAddress = 'ARDebug' THEN 1
                     ELSE 0
                END
--- Beginning of Sales Tax Logic
IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
    SELECT 'vp_08400SalesTaxTran'
    SELECT *
      FROM vp_08400SalesTaxTran
     WHERE useraddress = @useraddress

    SELECT 'vp_08400SalesTaxTranRls'
    SELECT *
      FROM vp_08400SalesTaxTranRls
     WHERE useraddress = @useraddress

    SELECT 'vp_08400SalesTaxDoc'
    SELECT *
      FROM vp_08400SalesTaxDoc
     WHERE useraddress = @useraddress

    SELECT 'vp_08400SalesTaxDocRls'
    SELECT *
      FROM vp_08400SalesTaxDocRls
     WHERE useraddress = @useraddress

    SELECT 'SalesTax Table'
    SELECT t.taxid,t.taxtype,t.taxrate,t.taxcalctype,t.*
      FROM salestax t, ardoc d, wrkrelease w
     WHERE w.batnbr = d.batnbr
       AND w.module = 'AR'
       AND w.useraddress = @useraddress
       AND (t.taxid = d.taxid00 or t.taxid = d.taxid01 or t.taxid = d.taxid02
                       or t.taxid = d.taxid03)

    SELECT 'SlsTaxGrp table'
    SELECT t.groupid, t.taxid, t.*
      FROM Wrkrelease w INNER JOIN ArDoc d
                           ON w.batnbr = d.batnbr
                        INNER JOIN SlsTaxGrp t
                           ON t.groupid = d.taxid00 OR t.groupid = d.taxid01
                           OR t.groupid = d.taxid02
                           OR t.groupid = d.taxid03
     WHERE w.module = 'AR'
       AND w.useraddress = @useraddress

    SELECT 'vp_SalesTax'
    SELECT v.*
      FROM Wrkrelease w INNER JOIN ArDoc d
                         ON w.batnbr = d.batnbr
                        INNER JOIN vp_SalesTax v
                         ON v.recordid = d.taxid00 OR v.recordid = d.taxid01
                            OR v.recordid = d.taxid02 OR v.recordid = d.taxid03
     WHERE w.module = 'AR'
       AND w.useraddress = @useraddress

    PRINT 'Debug...Step 600:  Update ARTran records that have price inclusive tax.'
    SELECT 'price inclusive tax'
    SELECT *
      FROM vp_SalesTaxARPrcTaxIncl
     WHERE useraddress = @useraddress
  END

UPDATE ARTran
   SET TranAmt = v.NewTranAmt, CuryTranAmt = v.NewCuryTranAmt
  FROM ARTran t INNER JOIN vp_SalesTaxARPrcTaxIncl v
                   ON t.RecordID = v.tRecordID
 WHERE v.UserAddress = @UserAddress

IF @@ERROR <> 0 GOTO ABORT

/***** Create tax entries for document based taxes. *****/
INSERT Wrk_SalesTax
SELECT v.CpnyID, 1, v.RefNbr, v.DocType, v.TaxId,
       v.TaxRate,'D',v.TaxAcct, v.TaxSub, v.TaxDate,
       CuryTaxTot = ROUND(SUM(v.curytaxamt),v.DecPl),
       CuryTxblTot = ROUND(SUM(v.CuryTxblAmt),v.DecPl),
       TaxTot = ROUND(SUM(v.taxamt),@BaseDecPl),
       TxblTot = ROUND(SUM(v.TxblAmt),@BaseDecPl),
       GrpTaxID = v.GrpTaxID,
       GrpRate = 0,
       GrpTaxTot = ROUND(SUM(v.taxamt),@BaseDecPl),
       GrpCuryTaxTot = ROUND(SUM(v.curytaxamt),v.DecPl),
       v.CustID,
       v.DecPl,
       @UserAddress,'',''
  FROM vp_08400SalesTaxDocRls v
 WHERE v.UserAddress = @UserAddress
 GROUP BY v.CpnyID, v.CustID, v.DocType, v.RefNbr, v.TaxID, v.TaxRate,
          v.TaxAcct, v.TaxSub, v.TaxDate, v.GrpTaxID, v.DecPl

IF @@ERROR <> 0 GOTO ABORT

/** Create tax entries for item based taxes.                *****/

INSERT Wrk_SalesTax
SELECT v.CpnyID, v.tRecordid, v.RefNbr, v.DocType, v.TaxId,
       v.TaxRate, 'I', v.TaxAcct, v.TaxSub, v.TaxDate,
       CuryTaxTot = v.CuryTaxAmt,
       CuryTxblTot = v.CuryTxblAmt,
       TaxTot = v.TaxAmt,
       TxblTot = v.TxblAmt,
       GrpTaxID = v.GrpTaxID,
       GrpRate  = 0,
       GrpTaxTot = v.TaxAmt,
       GrpCuryTaxTot = v.CuryTaxAmt,
       v.CustID,
       v.DecPl,
       @UserAddress,
       '',''
  FROM vp_08400SalesTaxTranRls v
 WHERE v.UserAddress = @UserAddress
 IF @@ERROR <> 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    SELECT 'Wrk_SalesTax Before Group ProRating'
    SELECT *
      FROM  Wrk_SalesTax
     WHERE useraddress = @useraddress

  END

--********** Group Rate Prorating across individual taxes*********************

-- First Set the Group Rate
-- Since Exceptions can exclude some taxes from some lines, need to get the group rate
-- by each usage.
UPDATE WS
   SET GrpRate = ( SELECT SUM(TaxRate)
                     FROM Wrk_SalesTax ws2
                    WHERE ws.UserAddress = ws2.UserAddress
                      AND ws.RecordID = ws2.RecordID
                      AND ws.CustVend = ws2.CustVend
                      AND ws.DocType = ws2.DocType
                      AND ws.Refnbr = ws2.Refnbr
                      AND ws.GrpTaxID = ws2.GrpTaxID )
  FROM Wrk_SalesTax ws
 WHERE ws.UserAddress = @UserAddress
   AND ws.GrpTaxID <> ' '

IF @@ERROR <> 0 GOTO ABORT

-- Next Set the individual tax amounts pro-rated across groups

UPDATE WRK_SalesTax
   SET TaxTot = ROUND(TaxTot * (TaxRate/GrpRate),@BaseDecPl),
       CuryTaxTot = ROUND(CuryTaxTot * (TaxRate/GrpRate),CuryDecPl)
  FROM WRK_SalesTax ws
 WHERE ws.UserAddress = @UserAddress
   AND ws.GrpTaxID <> ' '
   AND ws.GrpRate <> 0

IF @@ERROR <> 0 GOTO ABORT

-- MJA - correct for tax groups that net to 0% - bug 20664
UPDATE WRK_SalesTax
   SET TaxTot = ROUND(txbltot * TaxRate * 0.01,@BaseDecPl),
       CuryTaxTot = ROUND(CurytxblTot * TaxRate * 0.01,CuryDecPl)
  FROM WRK_SalesTax ws  
 WHERE ws.UserAddress = @UserAddress
   AND ws.GrpTaxID <> ' '
   AND ws.GrpRate = 0

IF @@ERROR <> 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    SELECT 'Wrk_SalesTax Before ProRating rounding adjustment'
    SELECT *
      FROM  Wrk_SalesTax
     WHERE useraddress = @useraddress

  END

-- Apply rounding difference if any to first tax
UPDATE ws
   SET TaxTot = ws.TaxTot - Diff,
       CuryTaxTot = ws.CuryTaxTot - CuryDiff
  FROM Wrk_SalesTax ws JOIN (SELECT RecordID,CustVend,
                                    DocType,RefNbr,GrpTaxID,
                                    TaxID = MIN(TaxID),
                                    Diff = Sum(TaxTot) - MIN(GrpTaxTot),
                                    CuryDiff = Sum(CuryTaxTot) - MIN(GrpCuryTaxTot)
                               FROM Wrk_SalesTax
                              WHERE UserAddress = @UserAddress AND GrpTaxID <> ' '
                              GROUP BY RecordID,CustVend,
                                       DocType,RefNbr,GrpTaxID
                             HAVING SUM(TaxTot) - MIN(GrpTaxTot) <> 0
                                 OR SUM(CuryTaxtot) - MIN(GrpCuryTaxTot) <> 0) ws2
                         ON ws.RecordID = ws2.RecordID
                        AND ws.CustVend = ws2.CustVend
                        AND ws.DocType = ws2.DocType
                        AND ws.Refnbr = ws2.Refnbr
                        AND ws.GrpTaxID = ws2.GrpTaxID
                        AND ws.TaxID    = ws2.TaxID
 WHERE ws.UserAddress = @UserAddress
   AND ws.GrpTaxID <> ' '

IF @@ERROR <> 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    SELECT 'Wrk_SalesTax Final'
    SELECT *
      FROM  Wrk_SalesTax
     WHERE useraddress = @useraddress

  END
/***** Insert ARTran records for Sales Tax activity. *****/

DECLARE TranCursor INSENSITIVE CURSOR FOR
	SELECT CpnyID, RefNbr, DocType, TaxID, Acct, Sub, YrMon,
		CuryTaxTot, CuryTxblTot, TaxTot, TxblTot
	  FROM Wrk_SalesTax
         WHERE UserAddress = @UserAddress

OPEN TranCursor

FETCH NEXT FROM TranCursor INTO @CpnyID, @RefNbr, @DocType, @TaxID, @Acct, @Sub, @YrMon,
				@CuryTaxTot, @CuryTxblTot, @TaxTot, @TxblTot

WHILE (@@FETCH_STATUS <> -1)
   BEGIN
     IF @@FETCH_STATUS <> -2
          INSERT ARTran (Acct, AcctDist, BatNbr, CmmnPct, CnvFact, ContractID, CostType, CpnyID, Crtd_DateTime,
                 Crtd_Prog, Crtd_User, CuryExtCost, CuryId, CuryMultDiv, CuryRate, CuryTaxAmt00,
                 CuryTaxAmt01,
                 CuryTaxAmt02, CuryTaxAmt03, CuryTranAmt, CuryTxblAmt00, CuryTxblAmt01, CuryTxblAmt02,
                 CuryTxblAmt03, CuryUnitPrice, CustId, DrCr, Excpt, ExtCost, ExtRefNbr, FiscYr, FlatRateLineNbr, InstallNbr,
                 InvtId, JobRate, JrnlType, LineId, LineNbr, LineRef, LUpd_DateTime, LUpd_Prog, LUpd_User,
                 MasterDocNbr, NoteId, OrdNbr, PC_Flag, PC_ID, PC_Status, PerEnt, PerPost, ProjectID, Qty,
                 RefNbr, Rlsed, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
                 S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ServiceCallID, ServiceCallLineNbr, ServiceDate,
                 ShipperCpnyID, ShipperID, ShipperLineRef, SiteId, SlsperId,
                 SpecificcostID, Sub, TaskID, TaxAmt00, TaxAmt01, TaxAmt02, TaxAmt03, TaxCalced,
                 TaxCat, TaxId00,
                 TaxId01, TaxId02, TaxId03, TaxIdDflt, TranAmt, TranClass, TranDate, TranDesc, TranType,
                 TxblAmt00, TxblAmt01, TxblAmt02, TxblAmt03, UnitDesc, UnitPrice, User1, User2, User3, User4,
                 User5, User6, User7, User8, WhseLoc)
          SELECT @Acct, 1, d.BatNbr, 0, 0, ' ', '', d.CpnyID, GetDate(), @ProgID, d.Crtd_User,
                 0, d.CuryId, d.CuryMultDiv, d.CuryRate,0, 0, 0, 0,
                 ROUND(@CuryTaxTot, c.DecPl), 0, 0, 0, 0, 0, d.CustID,
                   CASE @DOCTYPE
                     WHEN 'CM' THEN 'D'
                     WHEN 'PA' THEN 'D'
                     WHEN 'DA' THEN 'D'
                   ELSE 'C'
                   END,
                 0, 0, '', SUBSTRING(d.PerPost, 1, 4), 0,
                 0, '', 0, 'AR', 0,
                   (SELECT MAX(LineNbr)
                      FROM ARTran
                     WHERE LineNbr < 32765
                       AND RefNbr = @RefNbr
                       AND TranType = @DocType) + 1,
                 '', GetDate(), @ProgID, d.Lupd_user, '', 0, '', '', '', '',
                 d.PerEnt, d.PerPost, '', 0, d.RefNbr, 0, '', '',
                 0, 0, 0, 0, '', '', 0, 0, '', '', ' ', 0, '', '', '', '', '', '', '', @Sub, '',
                 0, 0, 0, 0, '', '', '', '', '', '', '', ROUND(@TaxTot, @BaseDecPl), 'T',
                 d.DocDate, s.Descr, d.DocType, 0, 0, 0, 0, '', 0, '', '', 0, 0, '', '', '', '','TX'
            FROM SalesTax s,ARDoc d,  Currncy c
           WHERE d.DocType = @DocType
             AND d.RefNbr = @RefNbr
             AND s.TaxId = @TaxId
             AND d.CuryId = c.CuryId
     FETCH NEXT FROM TranCursor
                INTO @CpnyID, @RefNbr, @DocType, @TaxID, @Acct, @Sub, @YrMon,
                     @CuryTaxTot, @CuryTxblTot, @TaxTot, @TxblTot
   END
CLOSE TranCursor
DEALLOCATE TranCursor
IF @@ERROR <> 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    SELECT 'TX', t.batnbr, t.custid, t.trantype, t.refnbr, t.curytranamt,
           t.tranamt, t.drcr, t.tranclass, t.WhseLoc, t.*
      FROM artran t, wrkrelease w
     WHERE w.batnbr = t.batnbr
       AND w.module = 'AR'
       AND w.useraddress = @useraddress
       AND t.WhseLoc = 'TX'
  END

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
    PRINT 'Debug...Step 700:  Create history records from activity.'
  END

INSERT HistDocSlsTax (BOCntr, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User,
       CuryDocTot, CuryID, CuryMultDiv, CuryRate,
       CuryTaxTot, CuryTxblTot, CustVendId, DocTot, DocType, JrnlType, LUpd_DateTime,
       LUpd_Prog, LUpd_User, RefNbr,
       Reported, RptBegDate, RptEndDate, S4Future01, S4Future02, S4Future03, S4Future04,
       S4Future05, S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11,
       S4Future12, TaxId, TaxTot, TxblTot, User1, User2,
       User3, User4, User5, User6, User7, User8, YrMon)
SELECT 0, d.CpnyID, GETDATE(), @ProgID, @Sol_User, d.CuryOrigDocAmt, d.CuryId, d.CuryMultDiv,
       d.CuryRate, ROUND(Sum(t.CuryTaxTot),c.DecPl), ROUND(Sum(t.CuryTxblTot),C.Decpl),
       d.CustID, d.OrigDocAmt, t.DocType,
       'AR', Getdate(), @ProgID, @Sol_User, t.RefNbr, 0, '', '', '', '', 0, 0, 0, 0, '',
       '', 0, 0, '', '', t.TaxID,
       ROUND(Sum(t.TaxTot),@BaseDecPL), ROUND(Sum(t.TxblTot),@BaseDecPl),'', '', 0, 0, '', '', '', '', t.YrMon
  FROM Wrk_SalesTax t INNER JOIN ARDoc d
                              ON t.RefNbr = d.RefNbr
                             AND t.DocType = d.DocType
                           INNER JOIN Currncy c
                              ON d.curyid = c.curyid
 WHERE t.UserAddress = @UserAddress
 GROUP BY t.TaxID, t.RefNbr, t.DocType, t.YrMon, d.CuryOrigDocAmt, d.CuryId,
	d.CuryMultDiv, d.CuryRate, d.CustID, d.OrigDocAmt,  c.decpl,d.CpnyID
IF @@ERROR <> 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
    PRINT 'Debug...Step 800:  Create history records from activity. This is for invoices created in OM.'
  END

INSERT HistDocSlsTax (BOCntr, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User,
       CuryDocTot, CuryID, CuryMultDiv, CuryRate,
       CuryTaxTot, CuryTxblTot, CustVendId, DocTot, DocType, JrnlType,
       LUpd_DateTime, LUpd_Prog, LUpd_User, RefNbr,
       Reported, RptBegDate, RptEndDate, S4Future01, S4Future02,
       S4Future03, S4Future04, S4Future05, S4Future06,
       S4Future07, S4Future08, S4Future09, S4Future10, S4Future11,
       S4Future12, TaxId, TaxTot, TxblTot, User1, User2,
       User3, User4, User5, User6, User7, User8, YrMon)
SELECT 0, MIN(d.CpnyID), GETDATE(), @ProgID, @Sol_User, MIN(d.CuryOrigDocAmt),
       MIN(d.CuryId), MIN(d.CuryMultDiv), MIN(d.CuryRate),
       ROUND(SUM(t.CuryTranAmt), MIN(c.DecPl)),
       ROUND(SUM(t.CuryTxblAmt00), MIN(c.DecPl)),
       MIN(d.CustID), MIN(d.OrigDocAmt), d.DocType,
       jrnltype = 'OM', GETDATE(),  @ProgID, @Sol_User,
       d.RefNbr, 0, '', '', '', '',
       0, 0, 0, 0, '', '', 0, 0, '', '', t.s4future11,
       ROUND(SUM(t.TranAmt), @basedecpl), ROUND(SUM(t.TxblAmt00), @basedecpl),
       '', '', 0, 0, '', '', '', '',
       MIN(LTRIM(RTRIM(STR(DATEPART(YEAR, d.DocDate))))+
           RIGHT('0' + LTRIM(RTRIM(STR(DATEPART(MONTH, d.DocDate)))),2))
  FROM wrkrelease w INNER JOIN ARDoc d
                       ON w.batnbr =d.batnbr
                    INNER JOIN ARTran  t
                       ON d.batnbr = t.batnbr
                      AND d.custid = t.custid
                      AND d.doctype = t.trantype
   AND d.refnbr = t.refnbr
                    INNER JOIN Currncy c
                       ON d.CuryId = c.CuryId
 WHERE w.useraddress = @UserAddress
   AND w.module = 'AR' AND t.jrnltype = 'OM' AND t.tranclass = 'T'
 GROUP BY d.custid, d.DocType, d.RefNbr, t.s4future11
IF @@ERROR <> 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
    PRINT 'Debug...Step 900:  Create history records that are missing.'

  END

INSERT SlsTaxHist (CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User,
       LUpd_DateTime, LUpd_Prog, LUpd_User, NoteId,
       S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06, S4Future07, S4Future08,
       S4Future09, S4Future10, S4Future11, S4Future12, TaxId, TotTaxColl,
       TotTaxPaid, TxblPurchTot, TxblSlsTot,
       User1, User2, User3, User4, User5, User6, User7, User8, YrMon)
SELECT t.CpnyID, GETDATE(), @ProgID, @Sol_User, GETDATE(), @ProgID,
       @Sol_User, 0, '', '', 0, 0, 0, 0, '', '',
       0, 0, '', '', t.TaxId, 0, 0, 0, 0, '', '', 0, 0, '', '', '', '', t.YrMon
  FROM Wrk_SalesTax t LEFT JOIN SlsTaxHist h
                             ON t.TaxId = h.TaxId
                            AND t.YrMon = h.YrMon
                            AND t.cpnyid= h.cpnyid
 WHERE h.TaxId IS NULL AND UserAddress = @UserAddress
 GROUP BY t.TaxId, t.YrMon, t.CpnyID
IF @@ERROR <> 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
    PRINT 'Debug...Step 1000:  Update the history records with activity.'

  END

UPDATE SlsTaxHist SET
	TotTaxColl = CONVERT(DEC(28,3),TotTaxColl) + t.TaxTot ,
        TxblSlsTot = CONVERT(DEC(28,3),TxblSlsTot) + t.TxblTot
  FROM  vp_08400SumARSalesTaxEntry  t INNER JOIN SlsTaxHist h
                                         ON h.TaxId = t.TaxId
                                        AND h.YrMon = t.YrMon
                                        AND h.CpnyId = t.CpnyId
 WHERE UserAddress = @UserAddress
IF @@ERROR <> 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
    PRINT 'Debug...Step 1100:  Create history records that are missing.  For OM.'

  END

INSERT SlsTaxHist (CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User, LUpd_DateTime,
       LUpd_Prog, LUpd_User, NoteId,
       S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06, S4Future07, S4Future08,
       S4Future09, S4Future10, S4Future11, S4Future12, TaxId, TotTaxColl,
       TotTaxPaid, TxblPurchTot, TxblSlsTot,
       User1, User2, User3, User4, User5, User6, User7, User8, YrMon)
SELECT t.CpnyID, GETDATE(), @ProgID, @Sol_User,
       GETDATE(),  @ProgID, @Sol_User, 0, '', '', 0, 0, 0, 0, '', '',
       0, 0, '', '', t.taxid, 0, 0, 0, 0, '', '', 0, 0, '', '', '', '', t.YrMon
   FROM vp_08400SumOMTaxTrans t LEFT JOIN SlsTaxHist h
                     ON h.TaxId = t.taxid AND h.YrMon = t.YrMon
                     AND t.CpnyId = h.CpnyId
   WHERE t.UserAddress = @UserAddress
     AND h.TaxId IS NULL

IF @@ERROR <> 0 GOTO ABORT

UPDATE SlsTaxHist SET
	TotTaxColl = ROUND(h.TotTaxColl + t.TotTaxcoll, @BaseDecPl),
	TxblSlsTot = ROUND(h.TxblSlsTot + t.TxblSlsTot, @BaseDecPl)
  FROM vp_08400SumOMTaxTrans t INNER JOIN SlsTaxHist h
                                  ON h.TaxId = t.taxid AND h.YrMon = t.YrMon
                                  AND t.CpnyId = h.CpnyId
 WHERE t.UserAddress = @UserAddress
IF @@ERROR <> 0 GOTO ABORT

SELECT @CRResult = 1
GOTO FINISH

ABORT:
SELECT @CRResult = 0

FINISH:


