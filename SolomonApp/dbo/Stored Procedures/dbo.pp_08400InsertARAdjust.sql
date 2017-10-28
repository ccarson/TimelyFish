 CREATE PROCEDURE pp_08400InsertARAdjust @Useraddress varchar (21),
                                        @DecPl Int, @CurrPerNbr varchar (6),
                                        @Sol_User VARCHAR(10), @AJError INT OUTPUT

WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as

DECLARE @ProgId  CHAR (5)
DECLARE @CurTime CHAR(30)
DECLARE @Debug   INT

SELECT 	@ProgID =   '08400'

SELECT @Debug =
       CASE WHEN UPPER(@UserAddress) = 'ARDEBUG'
            THEN 1
            ELSE 0
       END

IF (@Debug = 1)
  BEGIN
    SELECT @CurTime =  CONVERT(VARCHAR(30), GETDATE(), 113)
    PRINT @CurTime
    PRINT 'Debug...Step 2010:  Prep U trans for aradjust insert'
  END

UPDATE T SET /**  Step one, take tranamt back to IN cury  **/
   T.TaxAmt00 =
   CASE WHEN D.CuryID = T.CuryID
	THEN T.CuryTranAmt
	ELSE
             (CASE WHEN T.CuryMultDiv = 'M'
	          THEN ROUND( T.TranAmt / T.CuryRate, C2.DecPl)
	          ELSE ROUND( T.TranAmt * T.CuryRate, C2.DecPl)
              END)
	END,
   T.TaxAmt01 =
   CASE WHEN D.CuryID = T.CuryID
        THEN T.CuryUnitPrice
        ELSE /**  AND take discamt back to IN cury  **/
	     (CASE WHEN T.CuryMultDiv = 'M'
                   THEN ROUND( T.CnvFact / T.CuryRate, C2.DecPl)
                   ELSE ROUND( T.CnvFact * T.CuryRate, C2.DecPl)
             END)
   END

FROM WrkRelease AS W
    INNER JOIN ArTran  AS T
            ON W.BatNbr  = T.BatNbr
    INNER JOIN ArDoc   AS D
           ON D.DocType =  t.TRANTYPE
          AND D.RefNbr = T.RefNbr  AND D.CustID = T.CustID
    INNER JOIN Currncy AS C2 (NOLOCK) ON T.CuryID  = C2.CuryID
WHERE W.Module = 'AR' AND W.UserAddress = @UserAddress AND T.DrCr = 'U'


IF @@ERROR < > 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    SELECT 'Step One', T.batnbr, T.custid, T.trantype, T.refnbr, T.curytranamt, T.tranamt, T.drcr,
    T.tranclass, T.WhseLoc, T.*
    FROM artran t, wrkrelease w WHERE w.batnbr = T.batnbr AND w.module = 'AR' AND
    w.useraddress = @useraddress AND T.drcr = 'U'
  END

UPDATE T SET
    TaxAmt02 =
    CASE WHEN D.CuryID = T.CuryID AND T.CuryRate = T.UnitPrice AND T.CuryMultDiv = I.CuryMultDiv
         THEN T.TranAmt
         ELSE /**  Step two, now back to base at orig rate  **/
              (CASE WHEN I.CuryMultDiv = 'D'
                    THEN ROUND( T.TaxAmt00 / T.UnitPrice, @DecPl)
                    ELSE ROUND( T.TaxAmt00 * T.UnitPrice, @DecPl)
               END)
    END,
    TaxAmt03 =
    CASE WHEN D.CuryID = T.CuryID AND T.CuryRate = T.UnitPrice AND T.CuryMultDiv = I.CuryMultDiv
         THEN T.CNVFact
         ELSE  /** Same for discount **/
 	      (CASE WHEN I.CuryMultDiv = 'D'
                    THEN ROUND( T.TaxAmt01 / T.UnitPrice, @DecPl)
                    ELSE ROUND( T.TaxAmt01 * T.UnitPrice, @DecPl)
               END)
    END
FROM WrkRelease AS W
    INNER JOIN ARTran AS T ON W.BatNbr  = T.BatNbr
    INNER JOIN ARDoc  AS D ON D.DocType = t.TRANTYPE
                          AND D.RefNbr = T.RefNbr AND D.CustID = T.CustID
    INNER JOIN ARDoc  AS I ON I.DocType = t.COSTTYPE
                          AND I.RefNbr = T.SiteID AND I.CustID = T.CustID
WHERE W.Module = 'AR' AND W.UserAddress = @UserAddress AND T.DrCr = 'U'

IF @@ERROR < > 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    SELECT 'Step Two', T.batnbr, T.custid, T.trantype,
           T.refnbr, T.curytranamt, T.tranamt, T.drcr, T.tranclass, T.WhseLoc, T.*
    FROM   artran t, wrkrelease w
    WHERE  w.batnbr = T.batnbr AND w.module = 'AR' AND
           w.useraddress = @useraddress AND T.drcr = 'U'
  END

/******** adjust first line for rounding errors with totals ******/
-- CuryTxblAmt01 contains the remaining discount on the invoice in payment currency.
-- If this amount is 0, than no cury discbal is remaing so, the base discbal on the
-- invoice should be zeroed out. Do this by bumping the disc applied on one of the adjustments
-- up/down  by the difference between Base discbal on the invoice and the sum of the base discounts being applied.
/******** correct discounts first *******/
UPDATE T SET
    T.TaxAmt03 =
    CASE WHEN V.CuryTxblAmt01 = 0
         THEN ROUND((T.TaxAmt03 + (D.DiscBal - V.AdjDiscAmt)),@DecPl)
         ELSE T.TaxAmt03
    END,
    T.TaxAmt01 =
    CASE WHEN V.CuryTxblAmt01 = 0
         THEN ROUND((T.TaxAmt01 + (D.CuryDiscBal - V.CuryAdjdDiscAmt)), C.DecPl)
         ELSE T.TaxAmt01
    END
FROM WrkRelease AS W
    INNER JOIN ARTRAN AS T            ON W.BatNbr = T.BatNbr
    INNER JOIN ARDOC  AS D            ON T.CustID   = D.CustID   AND T.SiteID   = D.RefNbr AND
                                         T.CostType = D.Doctype
    INNER JOIN vp_08400SumUTrans AS V ON V.BatNbr   = T.BatNbr   AND V.CustID = T.CustID AND
                                         V.CostType = T.CostType AND V.SiteID = T.SiteID AND
                                         V.DiscRecordID = T.RecordID
    INNER JOIN Currncy AS C (NOLOCK) ON  T.CuryID = C.CuryID
WHERE W.Module = 'AR' AND W.UserAddress = @UserAddress

IF @@ERROR < > 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    SELECT 'Step Three', T.batnbr, T.custid, T.trantype, T.refnbr, T.curytranamt, T.tranamt, T.drcr,
    T.tranclass, T.WhseLoc, T.*
    FROM artran t, wrkrelease w WHERE w.batnbr = T.batnbr AND w.module = 'AR' AND
    w.useraddress = @useraddress AND T.drcr = 'U'
  END

/******** Then adjamounts  ********/
-- CuryTxblAmt00 contains the remaining balance on the invoice in payment currency.
-- If this amount is 0, than no cury DocBal is remaing so, the base DocBal on the
-- invoice should be zeroed out. Do this by bumping the base amount applied on one of the adjustments
-- up/down  by the difference between Base docbal on the invoice and the sum of base amounts being applied.

UPDATE T SET
    T.TaxAmt02 =
    CASE WHEN V.CuryTxblAmt00 = 0
         THEN ROUND((T.TaxAmt02 + (D.DocBal - V.AdjAmt)),@DecPl)
         ELSE T.TaxAmt02
    END,
    T.TaxAmt00 =
    CASE WHEN V.CuryTxblAmt00 = 0
         THEN ROUND((T.TaxAmt00 + (D.CuryDocBal - V.CuryAdjdAmt)), C.DecPl)
         ELSE T.TaxAmt00
    END
FROM WrkRelease AS W
    INNER JOIN ARTran AS T             ON W.BatNbr = T.BatNbr
    INNER JOIN ARDoc  AS D             ON T.CustID = D.CustID AND T.CostType = D.DocType AND
                                          T.SiteID = D.RefNbr
    INNER JOIN vp_08400SumUTrans  AS V ON V.BatNbr = T.BatNbr AND V.CustID = T.CustID AND
                                          V.CostType = T.CostType AND V.SiteID = T.SiteID AND
                                          V.RecordID = T.RecordID
    INNER JOIN Currncy  AS C (NOLOCK)  ON T.CuryID = C.CuryID
WHERE  W.Module = 'AR' AND W.UserAddress = @UserAddress

IF @@ERROR < > 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    SELECT 'Step Four', T.batnbr, T.custid, T.trantype, T.refnbr, T.curytranamt, T.tranamt, T.drcr,
    T.tranclass, T.WhseLoc, T.*
    FROM artran t, wrkrelease w WHERE w.batnbr = T.batnbr AND w.module = 'AR' AND
    w.useraddress = @useraddress AND T.drcr = 'U'
  END

/*************** Calc RGOL Amounts **********************/
-- TaxAmt02 is amount adjusted in base cury converted at invoice rate
-- tranamt is amount adjusted in base cury converted at payment rate
-- diff is rgol, temporarily stored in curytaxamt00

UPDATE T SET
    CuryTaxAmt00 = ROUND((T.TaxAmt02-T.TranAmt), @DecPl)   /**  this is rgolamt  **/
    FROM  WrkRelease AS W
        INNER JOIN ArTran AS T ON W.BatNbr = T.BatNbr
    WHERE W.Module = 'AR' AND T.DrCr = 'U'

IF @@ERROR < > 0 GOTO ABORT

--For payment documents:
-- Origdocamt  Sum(Adjamt  Rgol) = Docbal
-- CuryOrigdocamt  Sum (CuryAdjgAmt) = CuryDocBal
-- If the CuryDocBal will be brought to 0 on a payment and the base amount of the payment in is non-zero,
-- the base amount is brought to zero by adjusting RGOL as follows:
-- RGOL = RGOL + ((CuryDocBal of payment  Cury application) M/D payrate) - (Docbal - (Sum(AdjAmt-RGOL for payment) )
UPDATE ARTran SET
    CuryTaxAmt00 = ROUND((CuryTaxAmt00+s.RoundDiff), @DecPl),
    TranAmt = ROUND((TranAmt-s.RoundDiff), @DecPl)
    FROM (SELECT WrkRelease.UserAddress, ARTran.CustID, ARTran.TranType, ARTran.RefNbr,
		 RoundDiff = CASE MAX(ARDoc.CuryMultDiv) WHEN 'M' THEN
					ROUND(CONVERT(DEC(28,3),(MAX(ARDoc.CuryDocBal) - SUM(CuryTranAmt))) * MAX(CONVERT(DEC(19,9),ARDoc.CuryRate)), @DecPl)
				ELSE
					ROUND(CONVERT(DEC(28,3),(MAX(ARDoc.CuryDocBal) - SUM(CuryTranAmt))) / MAX(CONVERT(DEC(19,9),ARDoc.CuryRate)), @DecPl)
				END
				- (MAX(ARDoc.DocBal) - SUM(TaxAmt02 - CuryTaxAmt00)),
		 MinRecordID = ABS(MIN(CASE WHEN CuryTaxAmt00<>0 THEN -RecordID ELSE RecordID END))
            FROM WrkRelease INNER JOIN ARTran
                               ON ARTran.BatNbr = WrkRelease.BatNbr
                            INNER JOIN ARDoc
                               ON ARDoc.CustID = ARTran.CustID AND ARDoc.DocType = ARTran.TranType
                              AND ARDoc.RefNbr = ARTran.RefNbr
           WHERE WrkRelease.Module = 'AR' AND WrkRelease.UserAddress = @UserAddress AND ARTran.DrCr = 'U'
	   GROUP BY WrkRelease.UserAddress, ARTran.CustID, ARTran.TranType, ARTran.RefNbr) s
  WHERE s.CustID = ARtran.CustID AND s.TranType = ARTran.TranType AND s.RefNbr = ARTran.RefNbr
          AND s.MinRecordID = ARTran.RecordID

IF @@ERROR < > 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    SELECT 'Step Five', T.batnbr, T.custid, T.trantype, T.refnbr, T.curytranamt, T.tranamt, T.drcr,
    T.tranclass, T.WhseLoc, T.*
    FROM artran t, wrkrelease w WHERE w.batnbr = T.batnbr AND w.module = 'AR' AND
    w.useraddress = @useraddress AND T.drcr = 'U'
  END

IF (@Debug = 1)
  BEGIN
    SELECT @CurTime =  CONVERT(varchar(30), GETDATE(), 113)
    PRINT @CurTime
    PRINT 'Debug...Step 2100:  AR Adjust - Payment Application / Payment Entry From 08030 Screen'
  END

/***** AR Adjust - Payment/PrePayment/Credit Memo *****/
INSERT ARAdjust (AdjAmt, AdjBatNbr, AdjdDocType, AdjDiscAmt, AdjdRefNbr, AdjgDocDate, AdjgDocType, AdjgPerPost,
       AdjgRefNbr, Crtd_DateTime, Crtd_Prog, Crtd_User, CuryAdjdAmt, CuryAdjdCuryId, CuryAdjdDiscAmt, CuryAdjdMultDiv,
       CuryAdjdRate, CuryAdjgAmt, CuryAdjgDiscAmt, CuryRGOLAmt, CustId, DateAppl, LUpd_DateTime, LUpd_Prog, LUpd_User,
       PC_Status, PerAppl, ProjectID, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06, S4Future07,
       S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, TaskID, User1, User2, User3, User4, User5, User6,
       User7, User8)
SELECT T.taxamt02,      T.BatNbr,       T.CostType, T.taxamt03,    T.siteid,   D.DocDate,
       T.TranType,      D.PerPost,      T.RefNbr,   GETDATE(),     @ProgID,    T.Crtd_User,
       T.TaxAmt00,      T.CuryId,       T.Taxamt01, T.CuryMultDiv, T.CuryRate, T.CuryTranAmt,
       T.CuryUnitPrice, T.curytaxamt00, T.CustID,   B.DateEnt,     GETDATE(),  @ProgID,
       T.LUpd_User, '',B.PerPost,
       '', '', '', 0, 0, 0, 0, '', '', 0, 0, '', '', '',
       T.User1, T.User2, T.User3, T.User4, T.User5, T.User6, T.User7, T.User8
FROM Batch AS b
    INNER JOIN Artran AS T                ON B.BatNbr     = T.BatNbr
    INNER JOIN ARDoc AS d with(INDEX(ARDoc17)) ON D.ApplBatNbr = T.BatNbr AND D.CustID = T.CustID AND
                                             D.RefNbr     = T.RefNbr
    INNER JOIN WrkRelease AS W            ON D.ApplBatNbr = W.BatNbr AND T.BatNbr = W.BatNbr

WHERE  B.Module = 'AR' AND W.Module = 'AR' AND W.UserAddress = @UserAddress AND
      D.DocType = T.TranType AND T.TranType IN ('PA', 'PP', 'CM') AND T.DrCr = 'U'
 IF @@ERROR <> 0 GOTO ABORT

/***** AR Adjust - Small Balances *****/
INSERT ARAdjust (AdjAmt, AdjBatNbr, AdjdDocType, AdjDiscAmt, AdjdRefNbr, AdjgDocDate, AdjgDocType, AdjgPerPost,
       AdjgRefNbr, Crtd_DateTime, Crtd_Prog, Crtd_User, CuryAdjdAmt, CuryAdjdCuryId, CuryAdjdDiscAmt, CuryAdjdMultDiv,
       CuryAdjdRate, CuryAdjgAmt, CuryAdjgDiscAmt, CuryRGOLAmt, CustId, DateAppl, LUpd_DateTime, LUpd_Prog, LUpd_User,
       PC_Status, PerAppl, ProjectID, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06, S4Future07,
       S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, TaskID, User1, User2, User3, User4, User5, User6,
       User7, User8)
SELECT sum (T.taxamt02),      T.BatNbr,
       T.CostType,  sum (T.taxamt03),
       T.SiteID  ,   D.DocDate,
       T.TranType ,   D.PerPost,
       T.RefNbr ,  GETDATE(),     @ProgID,    Min(T.Crtd_User),
       sum (T.TaxAmt00),      T.CuryId,       sum (T.Taxamt01), T.CuryMultDiv, T.CuryRate, sum (T.CuryTranAmt),
       sum (T.CuryUnitPrice), sum (T.curytaxamt00), T.CustID,   d.DocDate,     GETDATE(),  @ProgID,
       Min(T.LUpd_User), '', b.Perpost,
       '', '', '', 0, 0, 0, 0, '', '', 0, 0, '', '', '',
       MIN(T.User1), MIN(T.User2), MIN(T.User3), MIN(T.User4), MIN(T.User5),
       MIN(T.User6), MIN(T.User7), MIN(T.User8)
  FROM Batch AS b
       INNER JOIN Artran AS T                ON B.BatNbr     = T.BatNbr
       INNER JOIN ARDoc AS d with(INDEX(ARDoc17)) ON D.ApplBatNbr = T.BatNbr AND D.CustID = T.CustID AND
                                             D.RefNbr     = T.RefNbr
       INNER JOIN WrkRelease AS W            ON D.ApplBatNbr = W.BatNbr AND T.BatNbr = W.BatNbr

 WHERE B.Module = 'AR' AND W.Module = 'AR' AND W.UserAddress = @UserAddress AND
       D.DocType = T.TranType  AND T.TranType = 'SB' AND T.DrCr = 'U'

 GROUP BY  T.BatNbr, T.CostType, T.siteid, T.TranType, T.RefNbr, T.CuryId, T.CuryMultDiv,
          T.CuryRate, T.CustID, T.unitdesc, D.perpost, B.perpost, D.docdate

IF @@ERROR <> 0 GOTO ABORT

/***** AR Adjust - Small Credit Memo *****/
INSERT ARAdjust (AdjAmt, AdjBatNbr, AdjdDocType, AdjDiscAmt, AdjdRefNbr, AdjgDocDate, AdjgDocType, AdjgPerPost,
       AdjgRefNbr, Crtd_DateTime, Crtd_Prog, Crtd_User, CuryAdjdAmt, CuryAdjdCuryId, CuryAdjdDiscAmt, CuryAdjdMultDiv,
       CuryAdjdRate, CuryAdjgAmt, CuryAdjgDiscAmt, CuryRGOLAmt, CustId, DateAppl, LUpd_DateTime, LUpd_Prog, LUpd_User,
       PC_Status, PerAppl, ProjectID, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06, S4Future07,
       S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, TaskID, User1, User2, User3, User4, User5, User6,
       User7, User8)
SELECT SUM (T.taxamt02),      T.BatNbr,
       T.TranType , SUM (T.taxamt03),
       T.RefNbr  ,   D.DocDate,
       T.CostType ,   D.PerPost,
       T.SiteID ,  GETDATE(),     @ProgID,    Min(T.Crtd_User),
       SUM (T.TaxAmt00),      T.CuryId,       SUM (T.Taxamt01), T.CuryMultDiv, T.CuryRate, SUM (T.CuryTranAmt),
       SUM (T.CuryUnitPrice), SUM (T.curytaxamt00), T.CustID,   b.DateEnt,     GETDATE(),  @ProgID,
       Min(T.LUpd_User), '', b.Perpost,
       '', '', '', 0, 0, 0, 0, '', '', 0, 0, '', '', '',
       MIN(T.User1), MIN(T.User2), MIN(T.User3), MIN(T.User4), MIN(T.User5),
       MIN(T.User6), MIN(T.User7), MIN(T.User8)
  FROM WrkRelease w JOIN Batch b
                      ON W.Module = b.Module and W.Batnbr = b.BatNbr
                    JOIN Artran T
                      ON B.BatNbr     = T.BatNbr
                    JOIN ARDoc  d
                      ON D.CustID = T.CustID
                     AND D.RefNbr = T.SiteID
                     AND D.DocType = T.CostType
 WHERE W.Module = 'AR' AND W.UserAddress = @UserAddress
   AND T.TranType = 'SC' AND T.DrCr = 'U'
 GROUP BY  T.BatNbr, T.CostType, T.siteid, T.TranType, T.RefNbr, T.CuryId, T.CuryMultDiv,
          T.CuryRate, T.CustID, T.unitdesc, D.perpost, B.perpost, b.DateEnt, d.docdate

IF @@ERROR <> 0 GOTO ABORT

/***** AR Adjust - Reversal Accrued *****/
INSERT ARAdjust (AdjAmt, AdjBatNbr, AdjdDocType, AdjDiscAmt, AdjdRefNbr, AdjgDocDate, AdjgDocType, AdjgPerPost,
       AdjgRefNbr, Crtd_DateTime, Crtd_Prog, Crtd_User, CuryAdjdAmt, CuryAdjdCuryId, CuryAdjdDiscAmt, CuryAdjdMultDiv,
       CuryAdjdRate, CuryAdjgAmt, CuryAdjgDiscAmt, CuryRGOLAmt, CustId, DateAppl, LUpd_DateTime, LUpd_Prog, LUpd_User,
       PC_Status, PerAppl, ProjectID, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06, S4Future07,
       S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, TaskID, User1, User2, User3, User4, User5, User6,
       User7, User8)
SELECT d1.OrigDocAmt, W.BatNbr, d2.DocType, 0, d2.RefNbr, d1.DocDate, d1.DocType, d1.PerPost,
       d1.RefNbr, GETDATE(), @ProgID,  d1.Crtd_User, d2.CuryOrigDocAmt, d2.CuryId, 0, d2.CuryMultDiv,
       d2.CuryRate, d1.CuryOrigDocAmt, 0, 0, d1.CustID, d1.DocDate, GETDATE(),  @ProgID, d1.LUpd_User,
       '', b.Perpost, '', '', '', 0, 0, 0, 0, '',
       '', 0, 0, '', '', '', d1.User1, d1.User2, d1.User3, d1.User4, d1.User5, d1.User6,
       d1.User7, d1.User8
  FROM WrkRelease w JOIN Batch b
                      ON W.Module = b.Module and W.Batnbr = b.BatNbr
                    JOIN ARDoc D1
                      ON B.BatNbr     = D1.BatNbr AND D1.DocType = 'RA'
                    JOIN ARDoc  D2
                      ON D2.CustID = D1.CustID
                     AND D2.RefNbr = D1.RefNbr
                     AND D2.DocType = 'AD'
 WHERE W.Module = 'AR' AND W.UserAddress = @UserAddress

IF @@ERROR <> 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    SELECT 'ARAdjust', j.*
      FROM WrkRelease w JOIN ARADJUST j
                          ON w.BatNbr = j.AdjBatNbr
     WHERE w.module = 'AR' AND
           w.UserAddress = @UserAddress
  END

SELECT @AJError = 0
GOTO Finish

Abort:
SELECT @AJError = 1

Finish:



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_08400InsertARAdjust] TO [MSDSL]
    AS [dbo];

