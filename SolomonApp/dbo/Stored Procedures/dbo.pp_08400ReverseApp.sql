 CREATE PROCEDURE pp_08400ReverseApp @UserAddress VARCHAR(21),
                                    @Sol_User CHAR (10),
                                    @CRResult INT OUTPUT
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
/********************************************************************************
*             Copyright Solomon Software, Inc. 1994-2001 All Rights Reserved
**    Proc Name: pp_08400ReverseApp
**++* Narrative: Runs release processing for 08240 Reverse Application batches only.
*++*            NSF voids and Reclass are handled by pp_08400CreateTransRev proc
*++*
*++*            For  Applications Reversals
*++*            - Takes the given U-Tran for the specific adjustments being reversed
*++*              and makes the reversing adjustments
*++*            - For U-trans identifying applications with the following conditions, this process
*++*              creates necessary reversing accounting.
*++*              - Original application took a discount.
*++*              - Original application create realized gain or loss (RGOL).
*++*              - Original application created situation where the A/R account had to be
*++*                 reclassified because the account, sub or cpnyid differed between the
*++*                 original payment entry and the invoice to which it was applied
**    Inputs   : UserAddress  VARCHAR(21)   Workstation id of caller
*               Sol_User     VARCHAR(10)   Calling User
**   Called by: pp_08400
*
*/

SET NOCOUNT ON
SET DEADLOCK_PRIORITY LOW

DECLARE @PerNbr CHAR(6), @PerToSub INT, @OutPerNbr VarChar(6)
--Declare variables for numdays csr
Declare @CpnyID CHAR (10), @Custid CHAR(15), @DocType CHAR(2), @RefNbr CHAR(10),
        @DocDate SMALLDATETIME
/***** Set variables *****/
SELECT @PerNbr = PerNbr,
       @PerToSub = RetAvgDay
  FROM ARSetup (NOLOCK)

IF @@ERROR <> 0 GOTO ABORT

/* Application Reversals */
/* U-Trans passed have recordid in S4Future10 or Aradjust records to reverse.      */
/* Reverse those records than mark the original records with S4Future12 = 'RA' */
/* Exclude any adjustments already reversed (S4Future12 = 'RA') */

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
 SELECT j.AdjAmt * -1, b.BatNbr, j.AdjdDocType, j.AdjDiscAmt * -1, j.AdjdRefNbr,
        j.AdjgDocDate, j.AdjgDocType, j.AdjgPerPost, j.AdjgRefNbr, GETDATE(),
        '08240', @Sol_User, j.CuryAdjdAmt * -1, j.CuryAdjdCuryId, j.CuryAdjdDiscAmt * -1,
        j.CuryAdjdMultDiv, j.CuryAdjdRate, CuryAdjgAmt * -1, CuryAdjgDiscAmt * -1, CuryRGOLAmt * -1,
        j.CustId, b.DateEnt, GETDATE(), '08400', @Sol_User,
        j.PC_Status, b.perpost, j.ProjectID, j.S4Future01, j.S4Future02,
        j.S4Future03, j.S4Future04, j.S4Future05, j.S4Future06, j.S4Future07,
        j.S4Future08, j.S4Future09, j.S4Future10, j.AdjBatnbr, 'RA',
        j.TaskID, j.User1, j.User2, j.User3, j.User4,
        j.User5, j.User6, j.User7, j.User8
   FROM WrkRelease w JOIN Batch b
                       ON w.BatNbr = b.BatNbr and w.Module = b.Module
                     JOIN ARTran t
                       ON w.batnbr = t.batnbr
                     JOIN ArAdjust j
                       ON t.S4Future10 = j.Recordid
  WHERE w.UserAddress = @UserAddress
    AND w.Module = 'AR'
    AND t.DRCR = 'U'
    AND j.s4Future12 = ' '

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

 UPDATE ARAdjust
   SET LUpd_DateTime = GETDATE(),
       LUpd_Prog     = '08400',
       LUpd_User    = @Sol_User,
       S4Future11    = w.batnbr,
       S4Future12 = 'RA'
  FROM WrkRelease w JOIN ARTran t
                      ON w.batnbr = t.batnbr
                    JOIN ArAdjust j
                      ON t.S4Future10 = j.Recordid
  WHERE w.UserAddress = @UserAddress
    AND w.Module = 'AR'
    AND t.DRCR = 'U'
    AND j.s4Future12 = ' '

IF @@ERROR <> 0
GOTO ABORT

SELECT @CRResult = 1
GOTO FINISH

ABORT:
SELECT @CRResult = 0

FINISH:



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_08400ReverseApp] TO [MSDSL]
    AS [dbo];

