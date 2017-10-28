
 CREATE PROCEDURE pp_08220SalesTax @UserAddress VARCHAR(21),
                                        @Sol_User CHAR (10),
                                        @BaseDecPl INT

WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
/********************************************************************************
**    Proc Name: pp_08220SalesTax
**++* Narrative: Runs all tax processing for 0822000 Invoice Preview
*++*            - Adjusts price inclusive tranamts to not include tax
*++*            - Inserts ArTrans for the tax amounts
*++*            - Updates Appropriate history tables.
*++*			- Assumes that information from the ARDoc and ARTran
*++*			-	records for the document to be previewed has been
*++*			-	inserted in the Wrk08220ARDoc and Wrk08220ARTran
*++*			-	tables prior to executing this proc.
*++*
**    Inputs   : UserAddress  VARCHAR(21)   Workstation id of caller
*               Sol_User     VARCHAR(10)   Calling User
*
*/

SET NOCOUNT ON
SET DEADLOCK_PRIORITY LOW

DECLARE @PROGID CHAR(8)
DECLARE @Debug INT
DECLARE @CpnyID CHAR(10), @RefNbr CHAR(10), @DocType CHAR(2), @TaxID CHAR(10),
	@Acct CHAR(10), @YrMon CHAR(6), @CuryTaxTot FLOAT(32),
	@CuryTxblTot FLOAT(32), @TaxTot FLOAT(32), @TxblTot FLOAT(32), @Sub char(24)

SELECT @PROGID = '08220'
SELECT @Debug = CASE WHEN @UserAddress = 'ARDebug' THEN 1
                     ELSE 0
                END
--- Beginning of Sales Tax Logic
IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
    SELECT 'vp_08220SalesTaxTran'
    SELECT *
      FROM vp_08220SalesTaxTran
     WHERE useraddress = @useraddress

    SELECT 'vp_08220SalesTaxTranPrev'
    SELECT *
      FROM vp_08220SalesTaxTranPrev
     WHERE useraddress = @useraddress

    SELECT 'vp_08220SalesTaxDoc'
    SELECT *
      FROM vp_08220SalesTaxDoc
     WHERE useraddress = @useraddress

    SELECT 'vp_08220SalesTaxDocPrev'
    SELECT *
      FROM vp_08220SalesTaxDocPrev
     WHERE useraddress = @useraddress

    SELECT 'SalesTax Table'
    SELECT t.taxid,t.taxtype,t.taxrate,t.taxcalctype,t.*
      FROM salestax t, Wrk08220ARDoc d
     WHERE d.useraddress = @useraddress
       AND (t.taxid = d.taxid00 or t.taxid = d.taxid01 or t.taxid = d.taxid02
                       or t.taxid = d.taxid03)

    SELECT 'SlsTaxGrp table'
    SELECT t.groupid, t.taxid, t.*
      FROM Wrk08220ArDoc d
                        INNER JOIN SlsTaxGrp t
                           ON t.groupid = d.taxid00 OR t.groupid = d.taxid01
                           OR t.groupid = d.taxid02
                           OR t.groupid = d.taxid03
     WHERE d.useraddress = @useraddress

    SELECT 'vp_SalesTax'
    SELECT v.*
      FROM Wrk08220ARDoc d
                        INNER JOIN vp_SalesTax v
                         ON v.recordid = d.taxid00 OR v.recordid = d.taxid01
                            OR v.recordid = d.taxid02 OR v.recordid = d.taxid03
     WHERE d.useraddress = @useraddress

    PRINT 'Debug...Step 600:  Update Wrk08220ARTran records that have price inclusive tax.'
    SELECT 'price inclusive tax'
    SELECT *
      FROM vp_08220SalesTaxARPrcTaxIncl
     WHERE useraddress = @useraddress
  END

UPDATE Wrk08220ARTran
   SET TranAmt = v.NewTranAmt, CuryTranAmt = v.NewCuryTranAmt
  FROM Wrk08220ARTran t INNER JOIN vp_SalesTaxARPrcTaxIncl v
                   ON t.RecordID = v.tRecordID
 WHERE v.UserAddress = @UserAddress

IF @@ERROR <> 0 GOTO ABORT

/***** Create tax entries for document based taxes. *****/
INSERT Wrk08220SalesTax
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
       @UserAddress
  FROM vp_08220SalesTaxDocPrev v
 WHERE v.UserAddress = @UserAddress
 GROUP BY v.CpnyID, v.CustID, v.DocType, v.RefNbr, v.TaxID, v.TaxRate,
          v.TaxAcct, v.TaxSub, v.TaxDate, v.GrpTaxID, v.DecPl

IF @@ERROR <> 0 GOTO ABORT

/** Create tax entries for item based taxes.                *****/

INSERT Wrk08220SalesTax
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
       @UserAddress
  FROM vp_08220SalesTaxTranPrev v
 WHERE v.UserAddress = @UserAddress

IF @@ERROR <> 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    SELECT 'Wrk08220SalesTax Before Group ProRating'
    SELECT *
      FROM  Wrk08220SalesTax
     WHERE useraddress = @useraddress

  END

--********** Group Rate Prorating across individual taxes*********************

-- First Set the Group Rate
-- Since Exceptions can exclude some taxes from some lines, need to get the group rate
-- by each usage.
UPDATE ws
   SET GrpRate = ( SELECT SUM(TaxRate)
                     FROM Wrk08220SalesTax ws2
                    WHERE ws.UserAddress = ws2.UserAddress
                      AND ws.RecordID = ws2.RecordID
                      AND ws.CustVend = ws2.CustVend
                      AND ws.DocType = ws2.DocType
                      AND ws.Refnbr = ws2.Refnbr
                      AND ws.GrpTaxID = ws2.GrpTaxID )
  FROM Wrk08220SalesTax ws
 WHERE ws.UserAddress = @UserAddress
   AND ws.GrpTaxID <> ' '

IF @@ERROR <> 0 GOTO ABORT

-- Next Set the individual tax amounts pro-rated across groups

UPDATE WRK08220SalesTax
   SET TaxTot = ROUND(TaxTot * (TaxRate/GrpRate),@BaseDecPl),
       CuryTaxTot = ROUND(CuryTaxTot * (TaxRate/GrpRate),CuryDecPl)
  FROM WRK08220SalesTax ws
 WHERE ws.UserAddress = @UserAddress
   AND ws.GrpTaxID <> ' '
   AND ws.GrpRate <> 0

IF @@ERROR <> 0 GOTO ABORT

-- MJA - correct for tax groups that net to 0% - bug 20664
UPDATE WRK08220SalesTax
   SET TaxTot = ROUND(txbltot * TaxRate * 0.01,@BaseDecPl),
       CuryTaxTot = ROUND(CurytxblTot * TaxRate * 0.01,CuryDecPl)
  FROM WRK08220SalesTax ws  
 WHERE ws.UserAddress = @UserAddress
   AND ws.GrpTaxID <> ' '
   AND ws.GrpRate = 0

IF @@ERROR <> 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    SELECT 'Wrk08220SalesTax Before ProRating rounding adjustment'
    SELECT *
      FROM  Wrk08220SalesTax
     WHERE useraddress = @useraddress

  END

-- Apply rounding difference if any to first tax
UPDATE ws
   SET TaxTot = ws.TaxTot - Diff,
       CuryTaxTot = ws.CuryTaxTot - CuryDiff
  FROM Wrk08220SalesTax ws JOIN (SELECT RecordID,CustVend,
                                    DocType,RefNbr,GrpTaxID,
                                    TaxID = MIN(TaxID),
                                    Diff = Sum(TaxTot) - MIN(GrpTaxTot),
                                    CuryDiff = Sum(CuryTaxTot) - MIN(GrpCuryTaxTot)
                               FROM Wrk08220SalesTax
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
    SELECT 'Wrk08220SalesTax Final'
    SELECT *
      FROM  Wrk08220SalesTax
     WHERE useraddress = @useraddress

  END

/***** Insert Wrk08220ARTran records for Sales Tax activity. *****/

DECLARE TranCursor INSENSITIVE CURSOR FOR
	SELECT CpnyID, RefNbr, DocType, TaxID, Acct, Sub, YrMon,
		CuryTaxTot, CuryTxblTot, TaxTot, TxblTot
	  FROM Wrk08220SalesTax
         WHERE UserAddress = @UserAddress

OPEN TranCursor

FETCH NEXT FROM TranCursor INTO @CpnyID, @RefNbr, @DocType, @TaxID, @Acct, @Sub, @YrMon,
				@CuryTaxTot, @CuryTxblTot, @TaxTot, @TxblTot

WHILE (@@FETCH_STATUS <> -1)
   BEGIN
     IF @@FETCH_STATUS <> -2
          INSERT Wrk08220ARTran (Acct, AcctDist, BatNbr, CmmnPct, CnvFact, ContractID, CostType, CpnyID, Crtd_DateTime,
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
                 User5, User6, User7, User8, UserAddress, WhseLoc)
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
                      FROM Wrk08220ARTran
                     WHERE LineNbr < 32765
                       AND RefNbr = @RefNbr
                       AND TranType = @DocType) + 1,
                 '', GetDate(), @ProgID, d.Lupd_user, '', 0, '', '', '', '',
                 d.PerEnt, d.PerPost, '', 0, d.RefNbr, 0, '', '',
                 0, 0, 0, 0, '', '', 0, 0, '', '', ' ', 0, '', '', '', '', '', '', '', @Sub, '',
                 0, 0, 0, 0, '', '', '', '', '', '', '', ROUND(@TaxTot, @BaseDecPl), 'T',
                 d.DocDate, s.Descr, d.DocType, 0, 0, 0, 0, '', 0, '', '', 0, 0, '', '', '', '', @UserAddress, 'TX'
            FROM SalesTax s, Wrk08220ARDoc d, Currncy c
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
      FROM Wrk08220ARTran t
     WHERE t.useraddress = @useraddress
       AND t.WhseLoc = 'TX'
  END


GOTO FINISH

ABORT:

FINISH:


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_08220SalesTax] TO [MSDSL]
    AS [dbo];

