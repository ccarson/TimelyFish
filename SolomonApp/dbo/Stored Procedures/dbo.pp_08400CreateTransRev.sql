 CREATE PROCEDURE pp_08400CreateTransRev @UserAddress VARCHAR(21),
                                        @Sol_User CHAR (10),
                                        @CRResult INT OUTPUT
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
/********************************************************************************
*             Copyright Solomon Software, Inc. 1994-2001 All Rights Reserved
**    Proc Name: pp_08400CreateTransRev
**++* Narrative: Runs release processing for Reversal(08240) NSF and Reclass batches only.
*++*            Reverse Application is handled separately in pp_08400ReverseApp
*++*            For NSF voids (doctype NS) and Reclassifications (doctype RP)
*++*               - Finds and reverses all AR adjustments for original check
*++*               - Creates a new adjustment between the RP/NS and the original PA/PP/SB
*++*               - Finds and reverses all artrans that the original check or any applications
*++*                 created and reverses that accounting
*++*               - Updates the Original Payment with S4Future11 = Voiding Batnbr
*++*                     and S4Future12 = Voiding DocType
*++*
**    Inputs   : UserAddress  VARCHAR(21)   Workstation id of caller
*               Sol_User     VARCHAR(10)   Calling User
**   Called by: pp_08400
*
*/

SET NOCOUNT ON
SET DEADLOCK_PRIORITY LOW

DECLARE @PerNbr CHAR(6), @PerToSub INT, @OutPerNbr VarChar(6),  @TranDescDflt CHAR(1)
--Declare variables for numdays csr
Declare @CpnyID CHAR (10), @Custid CHAR(15), @DocType CHAR(2), @RefNbr CHAR(10),
        @DocDate SMALLDATETIME
/***** Set variables *****/
SELECT @PerNbr = PerNbr,
       @PerToSub = RetAvgDay,
       @TranDescDflt = TranDescDflt
  FROM ARSetup (NOLOCK)

IF @@ERROR <> 0 GOTO ABORT
/* Void or Reclassified Checks. Find all adjustments attached to the orignal check and back out */
/* applications if there are any.  Exclude any adjustments already reversed (S4Future12 = 'RA'  */

INSERT INTO ARADJUST
       (AdjAmt, AdjBatNbr, AdjdDocType, AdjDiscAmt, AdjdRefNbr,
       AdjgDocDate, AdjgDocType, AdjgPerPost, AdjgRefNbr, Crtd_DateTime,
       Crtd_Prog, Crtd_User, CuryAdjdAmt, CuryAdjdCuryId, CuryAdjdDiscAmt,
       CuryAdjdMultDiv, CuryAdjdRate, CuryAdjgAmt, CuryAdjgDiscAmt, CuryRGOLAmt,
       CustId, DateAppl, LUpd_DateTime, LUpd_Prog, LUpd_User,
       PC_Status, PerAppl, ProjectID, S4Future01, S4Future02,
       S4Future03, S4Future04, S4Future05, S4Future06, S4Future07,
       S4Future08, S4Future09, S4Future10, S4Future11, S4Future12,
       TaskID, User1, User2, User3, User4,
       User5, User6, User7, User8)
 SELECT j.AdjAmt * -1, d.BatNbr, j.AdjdDocType, j.AdjDiscAmt * -1, j.AdjdRefNbr,
        j.AdjgDocDate, j.AdjgDocType,j.AdjgPerpost, j.AdjgRefNbr, GETDATE(),
        '08240', @Sol_User, j.CuryAdjdAmt * -1, j.CuryAdjdCuryId, j.CuryAdjdDiscAmt * -1,
        j.CuryAdjdMultDiv, j.CuryAdjdRate, CuryAdjgAmt * -1, CuryAdjgDiscAmt * -1, CuryRGOLAmt * -1,
        j.CustId, b.DateEnt, GETDATE(), '08400', @Sol_User,
        j.PC_Status, d.perpost, j.ProjectID, j.S4Future01, j.S4Future02,
        j.S4Future03, j.S4Future04, j.S4Future05, j.S4Future06, j.S4Future07,
        j.S4Future08, j.S4Future09, j.S4Future10, j.adjbatnbr, d.doctype,
        j.TaskID, j.User1, j.User2, j.User3, j.User4,
        j.User5, j.User6, j.User7, j.User8
   FROM WrkRelease w JOIN Batch b
                       ON w.Batnbr = b.Batnbr and w.Module = b.Module
                     JOIN ARDoc d
                       ON b.batnbr = d.batnbr
                     JOIN ArAdjust j
                       ON d.custid = j.custid
                      AND d.S4Future12 = j.adjgdoctype
                      AND d.s4Future02 = j.adjgrefnbr
  WHERE w.UserAddress = @UserAddress
    AND w.Module = 'AR'
    AND j.s4Future12 <> 'RA'

IF @@ERROR <> 0
GOTO ABORT

-- Get Average Days to Pay Retention CutOff
EXEC pp_PeriodMinusPerNbr @PerNbr,  @PerToSub , @OutPerNbr Output
-- Backout effect that payment had on Avg Day to Pay if Payment Reversed
--Find all debit documents that will be reopened by this batch
DECLARE NumDays_Csr INSENSITIVE CURSOR FOR
SELECT distinct d.cpnyid, d.CustID, d.DocType, d.RefNbr, d.DocDate
  FROM WrkRelease w INNER JOIN ARAdjust adj ON w.Module = 'AR' AND w.BatNbr = adj.AdjBatNbr
  	 	INNER LOOP JOIN ARDoc d
                                ON adj.CustID = d.CustID
                               AND adj.AdjdRefNbr = d.RefNbr AND adj.AdjdDocType = d.DocType
  	 	INNER JOIN ARDoc d1
                                ON adj.CustID = d1.CustID
                               AND adj.AdjgRefNbr = d1.RefNbr AND adj.AdjgDocType = d1.DocType
 WHERE d.CuryDocbal = 0 AND d.CuryOrigdocamt <> 0
   AND d.DocType IN ('IN','DM','NC','FI')
   AND (d.PerPost > @OutPerNbr OR d1.PerPost > @OutPerNbr)
   AND w.UserAddress = @UserAddress

OPEN NumDays_Csr
FETCH NumDays_Csr INTO @CpnyID, @Custid,  @DocType, @RefNbr,@DocDate
IF @@ERROR <> 0
BEGIN
    CLOSE NUMDAYS_CSR
    DEALLOCATE NUMDAYS_CSR
    GOTO ABORT
END
-- For each debit doc reopened in this batch, find the max credit doc date applied (that wasn't reversed)
-- and use that date - debit doc date to calculate paid invoice days.
WHILE @@FETCH_STATUS = 0
BEGIN
  UPDATE b
     SET b.NbrInvcPaid = b.NbrInvcPaid - CASE WHEN v.AdjgDocDate = '' THEN 0 ELSE 1 END,
         b.PaidInvcDays = b.PaidInvcDays - DATEDIFF(DAY,@DocDate , ISNULL(NULLIF(v.AdjgDocDate, ''), @DocDate)),
         b.AvgDayToPay = CASE WHEN v.AdjgDocDate = '' THEN b.AvgDayToPay ELSE
                              CASE WHEN b.NbrInvcPaid - 1 = 0
                                 THEN 0
                              ELSE ROUND((b.PaidInvcDays - DATEDIFF(DAY,@DocDate , v.AdjgDocDate))/ (b.NbrInvcPaid - 1),2)
                         END END
    FROM vp_08400_alladjd v INNER JOIN ar_balances b
                                    ON b.cpnyid = @cpnyid
                                   AND b.custid = v.custid
   WHERE v.CustID = @CustID
     AND v.AdjdDocType = @Doctype
     AND v.AdjdRefNbr = @RefNbr

  IF @@ERROR <> 0
  BEGIN
    CLOSE NUMDAYS_CSR
    DEALLOCATE NUMDAYS_CSR
    GOTO ABORT
  END

  -- get next record, if any, and loop.
  FETCH NumDays_Csr INTO @CpnyID, @Custid,  @DocType, @RefNbr,@DocDate
  IF @@ERROR <> 0
  BEGIN
    CLOSE NUMDAYS_CSR
    DEALLOCATE NUMDAYS_CSR
    GOTO ABORT
  END

END
CLOSE NUMDAYS_CSR
DEALLOCATE NUMDAYS_CSR

IF @@ERROR <> 0
GOTO ABORT
/* Insert aradjust from NS/RP to the PA/CM/PP   */
/* applications if there are any.  Exclude any adjustments already reversed (S4Future12 = 'RA'*/

INSERT INTO ARADJUST
       (AdjAmt, AdjBatNbr, AdjdDocType, AdjDiscAmt, AdjdRefNbr,
       AdjgDocDate, AdjgDocType, AdjgPerPost, AdjgRefNbr, Crtd_DateTime,
       Crtd_Prog, Crtd_User, CuryAdjdAmt, CuryAdjdCuryId, CuryAdjdDiscAmt,
       CuryAdjdMultDiv, CuryAdjdRate, CuryAdjgAmt, CuryAdjgDiscAmt, CuryRGOLAmt,
       CustId, DateAppl, LUpd_DateTime, LUpd_Prog, LUpd_User,
       PC_Status, PerAppl, ProjectID, S4Future01, S4Future02,
       S4Future03, S4Future04, S4Future05, S4Future06, S4Future07,
       S4Future08, S4Future09, S4Future10, S4Future11, S4Future12,
       TaskID, User1, User2, User3, User4,
       User5, User6, User7, User8)
 SELECT d.origdocamt, d.BatNbr, CASE d.DocType WHEN 'SB' THEN d.S4Future12 ELSE d.DocType END, 0, d.RefNbr ,
        d.DocDate, CASE d.DocType WHEN 'SB' THEN 'SB' ELSE S4Future12 END, d.PerPost, d.S4Future02, GETDATE(),
        '08240', @Sol_User, d.CuryOrigDocAmt ,d.CuryId, 0,
        d.CuryMultDiv, d.CuryRate, d.curyorigdocamt, 0, 0,
        d.CustId, d.docdate, GETDATE(), '08400', @Sol_User,
        ' ', d.perpost, ' ', ' ', ' ',
        0, 0, 0, 0,  ' ',
        ' ', 0, 0, d.S4Future11, d.S4Future12,
        ' ', ' ', ' ', 0, 0,
        ' ', ' ', ' ', ' '
   FROM WrkRelease w JOIN ARDoc d
                       ON w.batnbr = d.batnbr
     WHERE w.UserAddress = @UserAddress
    AND w.Module = 'AR'

IF @@ERROR <> 0
GOTO ABORT

-- "Point" all original adjustments to the reversal doc
UPDATE ARAdjust
   SET LUpd_DateTime = GETDATE(),
       LUpd_Prog     = '08400',
       LUpd_User    = @Sol_User,
       S4Future11    = d.batnbr,
       S4Future12    = d.doctype
  FROM WrkRelease w JOIN ARDoc d
                       ON w.batnbr = d.batnbr
                    JOIN ArAdjust j
                      ON d.custid = j.custid
                     AND d.batnbr <> j.adjbatnbr
                     AND d.S4Future12 = j.adjgdoctype
                     AND d.s4Future02 = j.adjgrefnbr

  WHERE w.UserAddress = @UserAddress
    AND w.Module = 'AR'
    AND j.s4Future12 <> 'RA'

IF @@ERROR <> 0
GOTO ABORT

/* For NSF or reclassification, find all trans originally made by the check and the */
/* applications, and flip the DRCR sign.                                            */
INSERT ARTRAN
       (Acct, AcctDist, BatNbr, CmmnPct, CnvFact,
       ContractID, CostType, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User,
       CuryExtCost, CuryId, CuryMultDiv, CuryRate, CuryTaxAmt00,
       CuryTaxAmt01, CuryTaxAmt02, CuryTaxAmt03, CuryTranAmt, CuryTxblAmt00,
       CuryTxblAmt01, CuryTxblAmt02, CuryTxblAmt03, CuryUnitPrice, CustId,
       DrCr, Excpt, ExtCost, ExtRefNbr, FiscYr, FlatRateLineNbr,
       InstallNbr, InvtId, JobRate, JrnlType, LineId,
       LineNbr, LineRef, LUpd_DateTime, LUpd_Prog, LUpd_User,
       MasterDocNbr, NoteId, OrdNbr, PC_Flag, PC_ID,
       PC_Status, PerEnt, PerPost, ProjectID, Qty,
       RefNbr, Rlsed, S4Future01, S4Future02, S4Future03,
       S4Future04, S4Future05, S4Future06, S4Future07, S4Future08,
       S4Future09, S4Future10, S4Future11, S4Future12, ServiceCallID, ServiceCallLineNbr, ServiceDate,
       ShipperCpnyID, ShipperID, ShipperLineRef, SiteId, SlsperId, SpecificCostID, Sub, TaskID,
       TaxAmt00, TaxAmt01, TaxAmt02, TaxAmt03, TaxCalced,
       TaxCat, TaxId00, TaxId01, TaxId02, TaxId03,
       TaxIdDflt, TranAmt, TranClass, TranDate, TranDesc,
       TranType, TxblAmt00, TxblAmt01, TxblAmt02, TxblAmt03,
       UnitDesc, UnitPrice, User1, User2, User3,
       User4, User5, User6, User7, User8,
       WhseLoc)

SELECT t.Acct, t.AcctDist, d.BatNbr, t.CmmnPct, t.CnvFact,
       ' ', t.CostType, t.CpnyID, GetDate(), '08240', d.Crtd_User,
       t.CuryExtCost, t.CuryId, t.CuryMultDiv, t.CuryRate, t.CuryTaxAmt00,
       t.CuryTaxAmt01, t.CuryTaxAmt02, t.CuryTaxAmt03, t.CuryTranAmt, t.CuryTxblAmt00,
       t.CuryTxblAmt01, t.CuryTxblAmt02, t.CuryTxblAmt03, t.CuryUnitPrice, t.CustId,
       CASE t.DrCr WHEN 'C' THEN 'D'
                 WHEN 'D' THEN 'C'
                 ELSE 'U'
       END, t.Excpt, t.ExtCost, t.ExtRefNbr, substring(d.perpost,1,4), 0,
       t.InstallNbr, t.InvtId, t.JobRate, 'AR', t.LineId,
       t.LineNbr, t.LineRef, GetDate(), '08400', @Sol_User,
       t.MasterDocNbr, t.NoteId, t.OrdNbr, t.PC_Flag, t.PC_ID,
       t.PC_Status, d.PerEnt, d.PerPost, t.ProjectID, t.Qty,
       d.RefNbr, 1, t.S4Future01, t.S4Future02, t.S4Future03,
       t.S4Future04, t.S4Future05, t.S4Future06, t.S4Future07, t.S4Future08,
       t.S4Future09, t.S4Future10, t.S4Future11, d.doctype, ' ', 0, t.ServiceDate,
       t.ShipperCpnyID, t.ShipperID, t.ShipperLineRef, ' ', t.SlsperId, t.SpecificCostID, t.Sub, t.TaskID,
       t.TaxAmt00, t.TaxAmt01, t.TaxAmt02, t.TaxAmt03, t.TaxCalced,
       t.TaxCat, t.TaxId00, t.TaxId01, t.TaxId02, t.TaxId03,
       t.TaxIdDflt, t.TranAmt, t.TranClass, d.DocDate, t.TranDesc,
       d.doctype, t.TxblAmt00, t.TxblAmt01, t.TxblAmt02, t.TxblAmt03,
       t.UnitDesc, t.UnitPrice, t.User1, t.User2, t.User3,
       t.User4, t.User5, t.User6, t.User7, t.User8,
       'RP1'
  FROM WrkRelease w JOIN ArDoc d
                      ON w.batnbr = d.batnbr
                    JOIN ArTran t
                      ON d.custid = t.custid
                     AND d.S4Future12 = t.trantype
                     AND d.S4Future02 = t.refnbr
 WHERE w.UserAddress = @UserAddress
   AND w.Module = 'AR'

IF @@ERROR <> 0
GOTO ABORT

-- For Payments that originated in Cash Module, the normal A/R void
-- puts the money back in the Cash to A/R holding account.
-- Since the Cash Module does not "finish" the void by taking the money back
-- out of the holding account and into the original cash account affected,
-- that accounting is done here.  The voids affected by this are identified by
-- the presence of data in the OrigBankAcct, OrigBankSub, OrigCpynId fields.
-- First Debit money back out of the holding account
INSERT ARTran (Acct, AcctDist, BatNbr, CmmnPct, CnvFact, ContractID, CostType, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User,
	CuryExtCost, CuryId, CuryMultDiv, CuryRate, CuryTaxAmt00, CuryTaxAmt01, CuryTaxAmt02, CuryTaxAmt03,
	CuryTranAmt, CuryTxblAmt00, CuryTxblAmt01, CuryTxblAmt02, CuryTxblAmt03, CuryUnitPrice, CustId, DrCr,
	Excpt, ExtCost, ExtRefNbr, FiscYr, FlatRateLineNbr, InstallNbr, InvtId, JobRate, JrnlType, LineId, LineNbr, LineRef,
	LUpd_DateTime, LUpd_Prog, LUpd_User, MasterDocNbr, NoteId, OrdNbr, PC_Flag, PC_ID, PC_Status, PerEnt,
	PerPost, ProjectID, Qty, RefNbr, Rlsed, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05,
	S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ServiceCallID, ServiceCallLineNbr, ServiceDate,
	ShipperCpnyID, ShipperID, ShipperLineRef, SiteId, SlsperId,
	SpecificcostID, Sub, TaskID, TaxAmt00, TaxAmt01, TaxAmt02, TaxAmt03, TaxCalced, TaxCat, TaxId00, TaxId01,
	TaxId02, TaxId03, TaxIdDflt, TranAmt, TranClass, TranDate, TranDesc,
        TranType, TxblAmt00, TxblAmt01, TxblAmt02,
	TxblAmt03, UnitDesc, UnitPrice, User1, User2, User3, User4, User5, User6, User7, User8, WhseLoc)
SELECT d.BankAcct, 1, b.BatNbr, 0, 0, ' ', ' ', d.CpnyID, GETDATE(), '08400', @Sol_User,
       0, d.CuryId, d.CuryMultDiv, d.CuryRate, 0, 0, 0, 0,
       d.CuryOrigDocAmt, 0, 0, 0, 0, 0, d.CustID, 'D',
       0, 0, d.CustOrdNbr, SUBSTRING(b.PerPost,1,4), 0, 0, ' ', 0, 'AR', 0, 32600, ' ',
       GETDATE(), '08400', @Sol_User, ' ', 0, ' ', ' ', ' ', ' ', b.PerEnt,
       b.PerPost, ' ', 0, d.RefNbr, 1, ' ', ' ', 0, 0, 0,
       0, ' ', ' ', 0, 0, ' ', ' ', ' ', 0, ' ', ' ', ' ', ' ', ' ', ' ',
       ' ', d.BankSub, ' ', 0, 0, 0, 0, ' ', ' ', ' ', ' ', ' ', ' ', ' ', d.OrigDocAmt, ' ', d.DocDate,
	substring((CASE @TranDescDflt
	WHEN 'C' THEN RTRIM(d.CustID) + ' ' +
		CASE
		WHEN CHARINDEX('~', c.Name) > 0
		THEN LTRIM(RTRIM(RIGHT(c.Name, DATALENGTH(RTRIM(c.Name)) - CHARINDEX('~', c.Name)))) + ' ' + SUBSTRING(c.Name, 1, (CHARINDEX('~', c.Name) - 1))
		ELSE c.Name
		END
	WHEN 'I' THEN RTRIM(d.CustID)
	ELSE	CASE
		WHEN CHARINDEX('~', c.Name) > 0
		THEN LTRIM(RTRIM(RIGHT(c.Name, DATALENGTH(RTRIM(c.Name)) - CHARINDEX('~', c.Name)))) + ' ' + SUBSTRING(c.Name, 1, (CHARINDEX('~', c.Name) - 1))
		ELSE c.Name
		END
	END), 1, 30),
        d.DocType, 0, 0, 0,
        0, ' ', 0, ' ', ' ', 0, 0, ' ', ' ', ' ', ' ', 'R23'
  FROM WrkRelease w JOIN Batch b
                      ON w.Batnbr = b.Batnbr and w.Module = b.Module
                    JOIN ARDoc d
                      ON b.BatNbr = d.BatNbr
                    JOIN Customer c (nolock)
                      ON d.custid = c.custid
 WHERE  w.module = 'AR' AND w.UserAddress = @UserAddress
   AND  d.DocType = 'NS'
   AND  d.OrigBankAcct <> ' '

IF @@ERROR <> 0
GOTO ABORT

-- Now Credit the original account used in Cash Manager
INSERT ARTran (Acct, AcctDist, BatNbr, CmmnPct, CnvFact, ContractID, CostType, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User,
	CuryExtCost, CuryId, CuryMultDiv, CuryRate, CuryTaxAmt00, CuryTaxAmt01, CuryTaxAmt02, CuryTaxAmt03,
	CuryTranAmt, CuryTxblAmt00, CuryTxblAmt01, CuryTxblAmt02, CuryTxblAmt03, CuryUnitPrice, CustId, DrCr,
	Excpt, ExtCost, ExtRefNbr, FiscYr, FlatRateLineNbr, InstallNbr, InvtId, JobRate, JrnlType, LineId, LineNbr, LineRef,
	LUpd_DateTime, LUpd_Prog, LUpd_User, MasterDocNbr, NoteId, OrdNbr, PC_Flag, PC_ID, PC_Status, PerEnt,
	PerPost, ProjectID, Qty, RefNbr, Rlsed, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05,
	S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ServiceCallID, ServiceCallLineNbr, ServiceDate,
	ShipperCpnyID, ShipperID, ShipperLineRef, SiteId, SlsperId,
	SpecificcostID, Sub, TaskID, TaxAmt00, TaxAmt01, TaxAmt02, TaxAmt03, TaxCalced, TaxCat, TaxId00, TaxId01,
	TaxId02, TaxId03, TaxIdDflt, TranAmt, TranClass, TranDate, TranDesc,
        TranType, TxblAmt00, TxblAmt01, TxblAmt02,
	TxblAmt03, UnitDesc, UnitPrice, User1, User2, User3, User4, User5, User6, User7, User8, WhseLoc)
SELECT d.OrigBankAcct, 1, b.BatNbr, 0, 0, ' ', ' ', d.OrigCpnyID, GETDATE(), '08400', @Sol_User,
       0, d.CuryId, d.CuryMultDiv, d.CuryRate, 0, 0, 0, 0,
       d.CuryOrigDocAmt, 0, 0, 0, 0, 0, d.CustID, 'C',
       0, 0, d.CustOrdNbr, SUBSTRING(b.PerPost,1,4), 0, 0, ' ', 0, 'AR', 0, 32601, ' ',
       GETDATE(), '08400', @Sol_User, ' ', 0, ' ', ' ', ' ', ' ', b.PerEnt,
       b.PerPost, ' ', 0, d.RefNbr, 1, ' ', ' ', 0, 0, 0,
       0, ' ', ' ', 0, 0, ' ', ' ', ' ', 0, ' ', ' ', ' ', ' ', ' ', ' ',
       ' ', d.OrigBankSub, ' ', 0, 0, 0, 0, ' ', ' ', ' ', ' ', ' ', ' ', ' ', d.OrigDocAmt, ' ', d.DocDate,
	substring((CASE @TranDescDflt
	WHEN 'C' THEN RTRIM(d.CustID) + ' ' +
		CASE
		WHEN CHARINDEX('~', c.Name) > 0
		THEN LTRIM(RTRIM(RIGHT(c.Name, DATALENGTH(RTRIM(c.Name)) - CHARINDEX('~', c.Name)))) + ' ' + SUBSTRING(c.Name, 1, (CHARINDEX('~', c.Name) - 1))
		ELSE c.Name
		END
	WHEN 'I' THEN RTRIM(d.CustID)
	ELSE	CASE
		WHEN CHARINDEX('~', c.Name) > 0
		THEN LTRIM(RTRIM(RIGHT(c.Name, DATALENGTH(RTRIM(c.Name)) - CHARINDEX('~', c.Name)))) + ' ' + SUBSTRING(c.Name, 1, (CHARINDEX('~', c.Name) - 1))
		ELSE c.Name
		END
	END), 1, 30),
        d.DocType, 0, 0, 0,
        0, ' ', 0, ' ', ' ', 0, 0, ' ', ' ', ' ', ' ', 'R24'
  FROM WrkRelease w JOIN Batch b
                      ON w.Batnbr = b.Batnbr and w.Module = b.Module
                    JOIN ARDoc d
                      ON b.BatNbr = d.BatNbr
                    JOIN Customer c (nolock)
                      ON d.custid = c.custid
 WHERE  w.module = 'AR' AND w.UserAddress = @UserAddress
   AND  d.DocType = 'NS'
   AND  d.OrigBankAcct <> ' '

IF @@ERROR <> 0
GOTO ABORT

-- UPDATE original Payment with Voiding DocType and BatNbr
UPDATE p
   SET S4Future02 = v.RefNbr,
       S4Future11 = v.batnbr,
       S4Future12 = v.DocType,
       Lupd_DateTime = GetDate(),
       Lupd_Prog     = '08400',
       Lupd_User     = @Sol_User
  FROM WrkRelease w JOIN ARDOC v     -- Voiding Doc
                      ON w.BatNbr = v.BatNbr
                    JOIN ARDOC p     -- Original Payment
                      ON v.custid = p.custid
                     AND v.S4Future12 = p.DocType
                     AND v.S4Future02 = p.RefNbr
  WHERE w.UserAddress = @UserAddress
   AND w.Module = 'AR'

IF @@ERROR <> 0
GOTO ABORT

SELECT @CRResult = 1
GOTO FINISH

ABORT:
SELECT @CRResult = 0

FINISH:



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_08400CreateTransRev] TO [MSDSL]
    AS [dbo];

