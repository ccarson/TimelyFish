 CREATE PROCEDURE pp_08400 @UserAddress VARCHAR(21), @Sol_User VARCHAR(10)
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as

/********************************************************************************
*    Proc Name: pp_08400
**++* Narrative: Runs release processing for A/R batches.
*++*
*++*            Batches with the following EditScrnNbrs are handled thru this process. Note
*++*            that some EditScrnNbrs may encompass several program (ie. 08010 batches are made
*++*            by A/R screens, Service Screens and OM Screens)
*++*            -- 05610   Order Processing??? Code exists in createoffset but I don't think we still get these
*++*            -- 08010   Invoice and Memo Batches
*++*            -- 08030   Payment/Prepayment Batches
*++*            -- 08050   Payment/Prepayment Batches
*++*            -- 08240   Reversal  Batches
*++*            -- 08450   SB/SC Batches
*++*            -- 08500   Recurring Batches
*++*            -- 08510   Auto Applications -- don't think these actually get to release as this editscrnnbr
*++*            -- 08520   Finance Charge Batches
*++*
*++*            Release processing includes:
*++*            - Creates sales tax trans and sales tax history
*++*            - Creates offsetting trans for the docs (a/r entry for invoices, cash entry for payments)
*++*            - Apply payments to invoices, creating the adjust entries and reducing balances on invoices
*++*            - Updates Customer history and balances
*++*            - Updates Batch, Document, and ArTran to appropriate statuses when complete
*++*            - Successful batches will be set to status 'U' (unposted), unsuccessful batches
*++*              will be set to 'S'
**    Inputs   : UserAddress  VARCHAR(21)   Workstation id of caller
*               Sol_User     VARCHAR(10)   Calling User
**   Called by: 08400 A/R Release
*
*/

SET NOCOUNT ON
SET DEADLOCK_PRIORITY LOW

DECLARE @Debug INT
DECLARE @Msgid  INT
DECLARE @BatNbr VARCHAR(10)
DECLARE @EditScrnNbr VARCHAR (5)
DECLARE @RevDocType  VARCHAR (2)
DECLARE @PCInstalled CHAR(1)
DECLARE @ErrorMsg AS VARCHAR(255)
DECLARE @OutOfBal INT, @FirstBat VARCHAR (10)
DECLARE @FirstYr CHAR(4), @LastYr CHAR(4)
--Declare variables for numdays csr
Declare @CpnyID CHAR (10), @Custid CHAR(15), @DocType CHAR(2), @RefNbr CHAR(10),
        @DocDate SMALLDATETIME
DECLARE @R_C INT
DECLARE @Err INT
SELECT @Debug = CASE WHEN @UserAddress = 'ARDebug' THEN 1
                     ELSE 0
                END

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
    Select 'Debug is on.  Output file will contain all selects.'
    PRINT 'Debug...Step 100:  Starting AR Release: yyyy-mm-dd Rev: 1'
    PRINT 'Debug:  Clear worktables'
  END

/***** Clear Work Tables. *****/
DELETE Wrk_TimeRange
 WHERE UserAddress = @UserAddress
DELETE Wrk_SalesTax
 WHERE UserAddress = @UserAddress
DELETE WRK_GLTRAN
 WHERE UserAddress = @UserAddress

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
    PRINT 'Debug...Step 200:  Declare variables'
  END

DECLARE @Prep_Result INT, @CRResult INT, @Hist_Result INT,
	@BaseDecPl INT, @ProgId CHAR (8), @BaseCuryID CHAR(10),
	@LedgerID CHAR(10), @PerNbr CHAR(6), @PerToSub INT, @OutPerNbr VarChar(6),
	@CentralCash INT, @CentralCompany VARCHAR(10),
        @TranDescDflt CHAR(1)

/***** Set variables *****/
SELECT @ProgID =   '08400',
       @PerNbr = PerNbr,
       @TranDescDflt = TranDescDflt,
       @PerToSub = RetAvgDay
  FROM ARSetup (NOLOCK)
IF @@ERROR <> 0 GOTO Finish

SELECT  @BaseCuryID = s .BaseCuryID,
        @LedgerID = s.LedgerID,
        @BaseDecPl = c.DecPl,
        @CentralCash = s.Central_Cash_Cntl,
	@CentralCompany = s.Cpnyid
  FROM  GLSetup s (nolock)  INNER JOIN Currncy c
                      ON s.BaseCuryID = c.CuryID
IF @@ERROR <> 0 GOTO Finish
/***** Insert tran lines for zero balance documents with no trans.                            *****/
/***** Should be outside transaction so that the document is fixed even if the release fails. *****/

INSERT ARTran (Acct,AcctDist,BatNbr,CmmnPct,CnvFact,ContractID,CostType,CpnyID,Crtd_DateTime,Crtd_Prog,
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
		UnitPrice,User1,User2,User3,User4,User5,User6,User7,User8,WhseLoc)
SELECT  c.slsacct,0,d.batnbr,0,1,' ','',d.CpnyID,GetDate(),@ProgID,d.Crtd_User,0,d.curyid,
	d.curymultdiv,d.curyrate,0,0,0,0,0,0,0,0,0,0,d.custid,
	Case When d.doctype = 'CM' then 'D' else 'C' end,0,0,'',SUBSTRING(b.PerPost,1,4),0,0,'',0,b.jrnltype,1,-32765,
	'',GetDate(),@ProgID,d.Lupd_user,'',0,'','','','',d.perent,d.perpost,'',1,d.refnbr,0,'',
	'',0,0,0,0,'','',0,0,'','',' ',0,'','', '', '', '',c.slsperid,'',c.slssub,'',0,0,0,0,'','','',
	'','','','',0,'N',d.docdate,
	substring((CASE @TranDescDflt
	WHEN 'C' THEN RTRIM(d.CustID) + ' ' +
		CASE
		WHEN CHARINDEX('~', c.Name) > 0
		THEN LTRIM(RTRIM(RIGHT(c.Name, DATALENGTH(RTRIM(c.Name)) - CHARINDEX('~', c.Name)))) + ' ' + SUBSTRING(c.Name, 1, (CHARINDEX('~', c.Name) - 1))
		ELSE c.name
		END
	WHEN 'I' THEN RTRIM(d.CustID)
	ELSE 	CASE
		WHEN CHARINDEX('~', c.Name) > 0
		THEN LTRIM(RTRIM(RIGHT(c.Name, DATALENGTH(RTRIM(c.Name)) - CHARINDEX('~', c.Name)))) + ' ' + SUBSTRING(c.Name, 1, (CHARINDEX('~', c.Name) - 1))
		ELSE c.Name
		END
	END),1,30),
	d.doctype,0,0,0,0,'',0,'','',0,0,'','','','',''
  FROM wrkrelease w INNER LOOP JOIN batch b (nolock)
                       ON w.batnbr = b.batnbr and w.module = 'AR' and b.module = 'AR'
                    INNER LOOP JOIN ardoc d
                       ON d.batnbr = b.batnbr
                    INNER JOIN  customer c (nolock) on d.custid = c.custid
                    LEFT OUTER JOIN artran t
                      ON t.custid = d.custid and t.trantype = d.doctype and t.refnbr = d.refnbr
 WHERE t.custid is null
   AND w.useraddress = @useraddress
   AND d.curyorigdocamt = 0
   AND d.origdocamt = 0

IF @@ERROR < > 0 GOTO FINISH

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
    SELECT t.custid, t.trantype, t.refnbr, t.drcr, t.tranclass, t.tranamt
      FROM WrkRelease w INNER JOIN Batch b
                           ON w.Batnbr = b.Batnbr
                              AND w.Module = b.Module
                        INNER JOIN ARTran t
                           ON b.batnbr = t.batnbr
     WHERE w.Module = 'AR' AND w.UserAddress = @Useraddress
       AND b.status in ('B', 'S') AND b.jrnltype = 'OM'
       AND b.rlsed = 0 AND t.tranclass NOT IN ('D','T')
       AND t.Trantype IN ('IN','DM','CM','AD')
       AND ((t.DrCr = 'C' AND t.Trantype IN ('CM','AD')) OR
            (t.DrCr = 'D' AND t.Trantype IN ('IN','DM')))
       AND t.Rlsed = 0
    UPDATE t
      SET DRCR = CASE WHEN trantype IN ('IN','DM', 'AD') THEN 'C' ELSE 'D' END,
          Tranamt = (Tranamt * -1),
          CuryTranamt = (CuryTranamt * -1)
     FROM WrkRelease w INNER JOIN Batch b
ON w.Batnbr = b.Batnbr
                             AND w.Module = b.Module
                       INNER JOIN ARTran t
                             ON b.batnbr = t.batnbr
     WHERE w.Module = 'AR'
       AND w.UserAddress = @Useraddress
       AND b.status in ('B', 'S')
       AND b.jrnltype = 'OM'
       AND b.rlsed = 0
       AND t.tranclass NOT IN ('D','T')
       AND t.Trantype IN ('IN','DM','CM','AD')
       AND ((t.DrCr = 'C' AND t.Trantype IN ('CM')) OR
        (t.DrCr = 'D' AND t.Trantype IN ('IN','DM','AD')))
       AND t.Rlsed = 0
 END

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
    PRINT 'Debug...Step 300:  Remove exceptions'
  END

EXEC pp_08400prepwrk @UserAddress,  @Prep_Result OUTPUT
IF @Prep_Result = 0 GOTO Finish

BEGIN TRANSACTION

/*
   This next few statements place a update lock on the batch and wrkrelease records. This will
   not block other reads but will block updates. THIS MUST OCCUR DIRECTLY AFTER THE BEGIN TRAN
   to be effective.
*/
SELECT @BatNbr = ' '
SELECT @BatNbr = BatNbr
  FROM WrkRelease (UPDLOCK)
 WHERE UserAddress = @UserAddress and Module = 'AR'
IF @@ERROR <> 0
  GOTO ABORT

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
    PRINT 'Debug...Step 350:  Get EditScrnNbr and Batch info at batch lock time'
    SELECT Batnbr,EditScrnNbr,Status,Rlsed,*
      FROM Batch
     WHERE BatNbr = @BatNbr AND Module = 'AR'
  END

-- No work to do in WrkRelease, exit
IF @BatNbr = ' '
BEGIN
   GOTO Check_WrkReleaseBad
END

SELECT @EditScrnNbr = ' '
SELECT @EditScrnNbr = EditScrnNbr
  FROM Batch (UPDLOCK)
 WHERE BatNbr = @BatNbr AND Module = 'AR'
IF @@ERROR <> 0
  GOTO ABORT

-- No unreleased batches to process, exit
IF @EditScrnNBr = ' '
BEGIN
   INSERT WrkReleaseBad  (BatNbr, Module, MsgID, UserAddress)
      VALUES ( @Batnbr,'AR',12319, @UserAddress)
   GOTO Check_WrkReleaseBad
END

IF (@Debug = 1)
  BEGIN
   PRINT 'Debug...Step 351:  Removal of SB Documents where they are not being applied anymore.'
   SELECT a.Batnbr,a.Custid,a.Doctype,a.Refnbr,a.OrigDocAmt,a.applamt,a.docbal,a.origdocnbr
     FROM WrkRelease w JOIN ARDoc a
                         ON w.Batnbr = a.Batnbr
                       LEFT JOIN ARTran t
                         ON a.Batnbr = t.Batnbr
                        AND a.Custid = t.Custid
                        AND a.Doctype = t.Trantype
                        AND a.Refnbr = t.Refnbr
                        AND t.DRCR = 'U'
   WHERE a.Doctype = 'SB' AND w.Module = 'AR'
     AND t.Custid IS NULL
 END

IF @EditScrnNbr = '08030'
BEGIN
-- REMOVE ALL THE SB Documents where there are no Small Balance Writeoff's being applied.
   DELETE a
     FROM WrkRelease w JOIN ARDoc a
                         ON w.Batnbr = a.Batnbr
                       LEFT JOIN ARTran t
                         ON a.Batnbr = t.Batnbr
                        AND a.Custid = t.Custid
                        AND a.Doctype = t.Trantype
                        AND a.Refnbr = t.Refnbr
                        AND t.DRCR = 'U'
 WHERE a.Doctype = 'SB' AND w.Module = 'AR'
   AND t.Custid IS NULL
END

-- 08240 batches always have a NS or RP doc or no doc at all
-- for payment reversals. Get the Doctype if any. In the special case of a payment being
-- voided that had been partially written off with a small credit, the 08240 batch will
-- also contain a Small Balance Doc to write off or 'void' the Small Credit.
SELECT @RevDocType = ' '
IF @EditScrnNbr = '08240'
BEGIN
   SELECT @RevDocType = DocType
     FROM ArDoc
    WHERE Batnbr = @BatNbr and Doctype in ('NS','RP')
END
IF @@ERROR <> 0
  GOTO ABORT

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
    PRINT 'Debug...Step 399:  Correct PerPost'
  END

EXEC pp_08400_CorrectPerPost @UserAddress, @Prep_Result OUTPUT
IF @@ERROR<>0 OR @Prep_Result<>0 GOTO Abort

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
    PRINT 'Debug...Step 400:'
    PRINT 'Before Correction of ArDocs and ArTrans'
    SELECT d.batnbr, d.custid, d.doctype, d.refnbr, d.curyorigdocamt,
           d.origdocamt, d.curydocbal, d.docbal, d.applamt, d.curyapplamt, d.*
      FROM wrkrelease w INNER JOIN ardoc d
                           ON w.batnbr = d.batnbr
     WHERE w.module = 'AR'
       AND w.useraddress = @useraddress

    SELECT t.batnbr, t.custid, t.trantype, t.refnbr, t.tranamt,
           t.curytranamt, t.drcr, t.siteid, t.costtype, t.*
      FROM wrkrelease w INNER JOIN artran t
                           ON w.batnbr = t.batnbr
     WHERE w.module = 'AR'
       AND w.useraddress = @useraddress
  END

EXEC pp_08400BaseAmtBal @UserAddress, @Sol_User, @EditScrnNbr,
                        @BaseDecPl, @Prep_Result OUTPUT
IF @@ERROR<>0 OR @Prep_Result=0 GOTO Abort

IF @EditScrnNbr = '08030'
	BEGIN
		IF (SELECT Count(t.RefNbr)
			FROM WrkRelease w
				JOIN ARTran t
					ON w.Batnbr = t.Batnbr
					AND w.Module = 'AR'
					AND w.UserAddress = @UserAddress
				JOIN ARDoc d
					ON t.CustID = d.Custid
						AND t.Trantype = d.doctype
						AND t.RefNbr = d.REfNbr
				JOIN ARDoc a
					ON t.Custid = a.Custid
						AND t.SiteID = a.RefNbr
						AND t.Costtype = a.Doctype
			WHERE t.DRCR = 'U'
				AND t.Trantype IN ('PA','PP','CM')
				AND (d.CuryiD <> @BaseCuryID
					OR a.CuryID <> @BaseCuryID))  = 0

			BEGIN

				UPDATE ARTRAN

				SET CuryTxblAmt00 = d.DOCBAL
								- DAP.PayAmt
								- ISNULL(DAP.DiscAmt, 0)
								- ISNULL(SB.SBAmt, 0)
				FROM WrkRelease w
                    JOIN ARTRAN t
					  ON w.batnbr = t.batnbr
					JOIN ARDOC d
						ON t.CustID = d.CustID
							AND t.CostType = d.Doctype
							AND t.SiteID = d.RefNbr
								JOIN (
									SELECT	p.Custid,
											p.Costtype,
											p.SiteID,
											Sum(p.TranAmt) PayAmt,
											Sum(p.CuryUnitPrice) DiscAmt
									FROM ARTran p
									WHERE p.DRCR = 'U'
										AND p.Trantype IN ('PP','PA','CM')
									GROUP BY	p.Custid,
												p.Costtype,
												p.SiteID
								) DAP
								ON t.Custid = DAP.Custid
							AND t.SiteID = DAP.SiteID
							AND t.Costtype = DAP.Costtype
					LEFT OUTER JOIN (
						SELECT	ASB.Custid,
								ASB.Costtype,
								ASB.SiteID,
								Sum(ASB.TranAmt) SBAmt
						FROM ARTran ASB
						WHERE ASB.DRCR = 'U'
							AND ASB.Trantype = 'SB'
						GROUP BY	ASB.Custid,
									ASB.Costtype,
									ASB.SiteID
					) SB
					ON t.Custid = SB.Custid
						AND t.SiteID = SB.SiteID
						AND t.Costtype = SB.Costtype

				WHERE t.DRCR = 'U'
				AND t.Trantype IN ('PA','PP','CM')
				AND t.CurytxblAmt00 = 0
				AND w.Module = 'AR'
				AND w.useraddress = @useraddress
			END
END

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
    PRINT 'Debug...Step 400 - END:'
    PRINT 'After Correction of ArDocs and ArTrans'
    SELECT d.batnbr, d.custid, d.doctype, d.refnbr, d.curyorigdocamt,
           d.origdocamt, d.curydocbal, d.docbal, d.applamt, d.curyapplamt, d.*
      FROM wrkrelease w INNER JOIN ardoc d
                           ON w.batnbr = d.batnbr
     WHERE w.module = 'AR'
       AND w.useraddress = @useraddress

    SELECT t.batnbr, t.custid, t.trantype, t.refnbr, t.tranamt,
           t.curytranamt, t.drcr, t.siteid, t.costtype, t.*
      FROM wrkrelease w INNER JOIN artran t
                           ON w.batnbr = t.batnbr
     WHERE w.module = 'AR'
       AND w.useraddress = @useraddress
  END

--
-- If Invoice/Memo - call sales tax processing.
--
IF @EditScrnNbr IN ('08010','08500')
  BEGIN
    EXEC pp_08400SalesTax @UserAddress, @Sol_User, @BaseDecPl, @CRResult OUTPUT
    IF @CRResult = 0 GOTO ABORT
  END

--
-- For ReClass, NSF and Application Reversal Batches handle special processing in separate procs.
--
IF @EditScrnNbr = '08240'
  BEGIN
    IF @RevDocType in ('RP','NS')
      BEGIN
        IF (@Debug = 1)
          BEGIN
            PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
            PRINT 'Debug...Step 1200:  Call pp_08400CreateTransRev and create trans/adjust for NSF or Reclass.'
          END

        EXEC pp_08400CreateTransRev @UserAddress, @Sol_User, @CRResult OUTPUT
        IF @CRResult = 0 GOTO ABORT
      END

    ELSE   -- @RevDoctype = ' ', application reversal
      BEGIN
        IF (@Debug = 1)
          BEGIN
            PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
            PRINT 'Debug...Step 1250:  Call pp_08400ReverseApp and create adjust for App Reversal.'
          END

        EXEC pp_08400ReverseApp @UserAddress, @Sol_User, @CRResult OUTPUT
        IF @CRResult = 0 GOTO ABORT
      END

  END
--
-- For ReClass and NSF Reversal Batches, ArAdjusts and ArTrans are already handled,
-- for all other batches (including Reverse Applications) call create offset to make artrans and aradjust.
--
IF NOT (@EditScrnNbr = '08240' and @RevDoctype in ('NS','RP'))
  BEGIN
    IF (@Debug = 1)
      BEGIN
        PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
        PRINT 'Debug...Step 1300:  Call pp_08400CreateOffset and create offsetting trans'
      END

    EXEC pp_08400CreateOffset @UserAddress, @Sol_User, @EditScrnNbr, @CRResult OUTPUT
    IF @CRResult = 0 GOTO ABORT
  END

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
    PRINT 'Debug...Step 1400:  Create pjarpay records if needed.'
  END

SELECT @PCInstalled = p.S4Future3
  FROM PCSetup p (NOLOCK)

IF @PCInstalled = 'S'
  BEGIN
    EXEC pp_08400CreatePJARPay @UserAddress, @Sol_User, @CRResult OUTPUT
    IF @CRResult = 0 GOTO ABORT

    IF (@Debug = 1)
    BEGIN
      PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
      PRINT 'PJARPAY Records'

      SELECT j.adjamt, j.adjgrefnbr, GETDATE(), @ProgID, j.Crtd_User, j.custid, j.AdjDiscAmt, j.AdjgDocType,
             j.AdjdRefNbr, j.AdjdDocType, GETDATE(), @ProgID, j.Lupd_User, '', '', '1'
        FROM wrkrelease w INNER JOIN aradjust j
                             ON w.batnbr = j.adjbatnbr
                          INNER JOIN  ardoc i
                             ON j.custid = i.custid
                            AND j.adjdrefnbr = i.refnbr
                            AND j.adjddoctype = i.doctype
       WHERE w.useraddress = @useraddress
         AND w.module = 'AR'
         AND j.adjgdoctype IN ('PA', 'PP', 'SB')
         AND i.pc_status = '1'

    END
  END

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
    PRINT 'Debug...Step 1500:'
    Print 'Debug...Create Wrk_TimeRange records to get list of fiscyrs in this batch.'
  END

SELECT @FirstYr = (SELECT MIN(SUBSTRING(PerPost,1,4))
  FROM Batch b
 WHERE b.Module = 'AR' AND b.BatNbr = @BatNbr)

SELECT @LastYr = CASE WHEN @PerNbr >= (SELECT MAX(SUBSTRING(PerPost,1,4))
                                         FROM Batch b
                                        WHERE b.Module = 'AR' AND b.BatNbr = @BatNbr)
                         THEN @PerNbr
                      ELSE (SELECT MAX(SUBSTRING(PerPost,1,4))
                              FROM Batch b
                             WHERE b.Module = 'AR' AND b.BatNbr = @BatNbr)
	         END

WHILE (@FirstYr <= @LastYr)
	BEGIN
		INSERT Wrk_TimeRange VALUES (@FirstYr,@UserAddress)
		SELECT @FirstYr = LTRIM(STR(CONVERT(INT,@FirstYr) + 1))
	END

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
    PRINT 'Debug...Step 1600:  Create Sales Person History.'

  END

INSERT SlsPerHist (Crtd_DateTime, Crtd_Prog, Crtd_User, FiscYr, LUpd_DateTime, LUpd_Prog, LUpd_User,
	NoteID, PerNbr, PtdCOGS00, PtdCOGS01, PtdCOGS02, PtdCOGS03, PtdCOGS04, PtdCOGS05, PtdCOGS06,
	PtdCOGS07, PtdCOGS08, PtdCOGS09, PtdCOGS10, PtdCOGS11, PtdCOGS12, PtdRcpt00, PtdRcpt01,
	PtdRcpt02, PtdRcpt03, PtdRcpt04, PtdRcpt05, PtdRcpt06, PtdRcpt07, PtdRcpt08, PtdRcpt09,
	PtdRcpt10, PtdRcpt11, PtdRcpt12, PtdSls00, PtdSls01, PtdSls02, PtdSls03, PtdSls04, PtdSls05,
	PtdSls06, PtdSls07, PtdSls08, PtdSls09, PtdSls10, PtdSls11, PtdSls12, S4Future01, S4Future02,
	S4Future03, S4Future04, S4Future05, S4Future06, S4Future07, S4Future08, S4Future09, S4Future10,
	S4Future11, S4Future12, SlsperID, User1, User2, User3, User4, User5, User6, User7, User8,
	YtdCOGS, YtdRcpt, YtdSls)
SELECT DISTINCT GETDATE(), @ProgId,@Sol_User, r.FiscYr, GETDATE(), @ProgId,@Sol_User, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, '', '', 0, 0, '', '',
	v.SlsPerID, '', '', 0, 0, '', '', '', '',  0, 0, 0
  FROM Wrk_TimeRange r INNER JOIN vp_08400ARbalancesHistSls v
                          ON v.FiscYr <= r.FiscYr
 WHERE v.UserAddress = @UserAddress
   AND r.UserAddress = @UserAddress
   AND ((v.SlsPerID + r.FiscYr) NOT IN (SELECT SlsPerID + FiscYr
                                           FROM SlsPerHist))
IF @@ERROR <> 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
    PRINT 'Debug...Step 1700:  Update Sales Person History.'
    SELECT 'vp_08400ARBalancesHistSls'
    SELECT * FROM vp_08400ARReleaseDocsHistSls WHERE useraddress = @useraddress
    SELECT 'vp_08400ARbalancesHistSls'
    SELECT * FROM vp_08400ARbalancesHistSls WHERE useraddress = @useraddress

  END

UPDATE SlsPerHist SET
	PTDRcpt00 = ROUND(h.PTDRcpt00 + v.PTDRcpt00,@BaseDecpl),
	PTDRcpt01 = ROUND(h.PTDRcpt01 + v.PTDRcpt01,@BaseDecpl),
	PTDRcpt02 = ROUND(h.PTDRcpt02 + v.PTDRcpt02,@BaseDecpl),
	PTDRcpt03 = ROUND(h.PTDRcpt03 + v.PTDRcpt03, @BaseDecpl),
	PTDRcpt04 = ROUND(h.PTDRcpt04 + v.PTDRcpt04,@BaseDecpl),
	PTDRcpt05 = ROUND(h.PTDRcpt05 + v.PTDRcpt05,@BaseDecpl),
	PTDRcpt06 = ROUND(h.PTDRcpt06 + v.PTDRcpt06, @BaseDecpl),
	PTDRcpt07 = ROUND(h.PTDRcpt07 + v.PTDRcpt07, @BaseDecpl),

	PTDRcpt08 = ROUND(h.PTDRcpt08 + v.PTDRcpt08, @BaseDecpl),
	PTDRcpt09 = ROUND(h.PTDRcpt09 + v.PTDRcpt09,@BaseDecpl),
	PTDRcpt10 = ROUND(h.PTDRcpt10 + v.PTDRcpt10, @BaseDecpl),
	PTDRcpt11 = ROUND(h.PTDRcpt11 + v.PTDRcpt11, @BaseDecpl),
	PTDRcpt12 = ROUND(h.PTDRcpt12 + v.PTDRcpt12, @BaseDecpl),
	PTDSls00 = ROUND(h.PTDSls00 + v.PTDSales00,@BaseDecpl),
	PTDSls01 = ROUND(h.PTDSls01 + v.PTDSales01,@BaseDecpl),
	PTDSls02 = ROUND(h.PTDSls02 + v.PTDSales02, @BaseDecpl),
	PTDSls03 = ROUND(h.PTDSls03 + v.PTDSales03,@BaseDecpl),
	PTDSls04 = ROUND(h.PTDSls04 + v.PTDSales04, @BaseDecpl),
	PTDSls05 = ROUND(h.PTDSls05 + v.PTDSales05, @BaseDecpl),
	PTDSls06 = ROUND(h.PTDSls06 + v.PTDSales06, @BaseDecpl),

	PTDSls07 = ROUND(h.PTDSls07 + v.PTDSales07, @BaseDecpl),
	PTDSls08 = ROUND(h.PTDSls08 + v.PTDSales08, @BaseDecpl),
	PTDSls09 = ROUND(h.PTDSls09 + v.PTDSales09, @BaseDecpl),
	PTDSls10 = ROUND(h.PTDSls10 + v.PTDSales10,@BaseDecpl),
	PTDSls11 = ROUND(h.PTDSls11 + v.PTDSales11, @BaseDecpl),
	PTDSls12 = ROUND(h.PTDSls12 + v.PTDSales12,@BaseDecpl),
	YTDRcpt = ROUND(h.YTDRcpt + v.YTDRcpt, @BaseDecpl),
	YTDSls = ROUND(h.YTDSls + v.YTDSales,@BaseDecpl)
  FROM SlsPerHist h INNER JOIN vp_08400ARReleaseDocsHistSls v
                       ON h.FiscYr = v.FiscYr
                      AND h.SlsPerID = v.SlsPerID
 WHERE v.UserAddress = @UserAddress
IF @@ERROR <> 0 GOTO ABORT

IF (SELECT COUNT(*) FROM CASETUP (NOLOCK)) = 1
BEGIN
   IF (@Debug = 1)
   BEGIN
      PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
      PRINT 'Debug...Step 2100:  Call pp_08400CashSum and update Cash tables'
   END

   EXEC pp_08400CashSum @UserAddress, @Sol_User, @ProgID, @BaseDecPl, @CRResult OUTPUT
   IF @CRResult = 0 GOTO ABORT
END

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
    PRINT 'Debug...Step 2300:  Update AR Tran Records for Missing Field Values'
  END

UPDATE ARTran SET FiscYr = CASE WHEN t.FiscYr = ''
                                THEN SUBSTRING(b.PerPost, 1,4)
                                ELSE t.FiscYr
                                END,
                 PerPost = CASE WHEN t.PerPost = ''
                                THEN b.PerPost
                                ELSE t.PerPost
                                END
  FROM WrkRelease w INNER JOIN Batch b
                       ON w.BatNbr = b.BatNbr
                    INNER JOIN ARTran t
                       ON w.BatNbr = t.BatNbr
 WHERE b.Module = 'AR'
   AND w.Module = 'AR'
   AND w.UserAddress = @UserAddress

IF @@ERROR <> 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
    PRINT 'Debug...Step 2400:  Update AR Doc Balances and set PerClosed for Cash Sales'
  END
-- Close doc if Cash Sale or zero amount invoice
UPDATE Ardoc
   SET CuryDocbal = 0, DocBal =0, OpenDoc =0, PerClosed = PerPost, S4Future01 = PerPost
  FROM WrkRelease INNER JOIN ArDoc
                     ON Wrkrelease.batNbr = ArDoc.BatNbr
                    AND (ArDoc.DocType = 'CS'
                         OR Ardoc.curyorigdocamt = 0)
 WHERE WrkRelease.Module ='AR'
   AND WrkRelease.UserAddress = @Useraddress

IF @@ERROR <> 0 GOTO ABORT

-- Set PerOpen for docs in Batch, This handles all docs even though
-- Docs with adjustments may be reset later.
UPDATE Ardoc
   SET S4Future01 = PerPost
  FROM ARDoc
 WHERE BatNbr = @BatNbr

IF @@ERROR <> 0 GOTO ABORT

-- Update Adjusting Docs
UPDATE d
   SET d.DocBal = CONVERT(DEC(28,3),d.DocBal) - vc.AdjAmt,
       d.CuryDocBal = CONVERT(DEC(28,3),d.CuryDocBal) - vc.CuryAdjgAmt,
       d.RGOLAmt = CONVERT(DEC(28,3),d.RGOLAmt) - vc.RGOLAmt,
       d.Opendoc = CASE WHEN CONVERT(DEC(28,3),d.CuryDocBal) - vc.CuryAdjgAmt = 0
                        THEN 0
                        ELSE 1
                   END,
       d.PerClosed = CASE    -- Perclosed is the max of the doc's perpost and any related adjustment's perappl
                       WHEN CONVERT(DEC(28,3),d.CuryDocBal) - vc.CuryAdjgAmt = 0
                       THEN CASE WHEN d.perpost > ISNULL(ag.perclosed,' ')
                                        THEN d.perpost
                                 ELSE ISNULL(ag.perclosed,' ')
                                 END
                       ELSE ' '
                     END,
       -- Peropen(S4Future01) is the min of the doc's perpost and any related adjustment's perappl
       d.S4Future01 = CASE WHEN d.perpost < ISNULL(ag.peropen,'999999')
                              THEN d.perpost
                            ELSE ISNULL(ag.peropen,' ')
                      END,
       d.CuryDiscBal = 0, d.DiscBal = 0
  FROM vp_08400_AdjG vc JOIN ARDoc d
                          ON vc.CustID = d.CustID
                         AND vc.AdjgRefNbr = d.RefNbr AND vc.AdjgDocType = d.DocType
                        LEFT JOIN vp_08400_alladjg ag
                               ON ag.CustID = d.CustID
                              AND ag.AdjgRefNbr = d.RefNbr AND ag.AdjgDocType = d.DocType
 WHERE vc.UserAddress = @UserAddress

IF @@ERROR <> 0 GOTO ABORT

-- Update Adjusted Docs
UPDATE d
   SET d.DocBal = ROUND(d.DocBal - vi.AdjAmt, @BaseDecPl),
       d.CuryDocBal = ROUND(d.CuryDocBal - vi.CuryAdjdAmt, c.DecPl),
       d.DiscBal = ROUND(d.DiscBal - vi.AdjDiscAmt, @BaseDecPl),
       d.CuryDiscBal = ROUND(d.CuryDiscBal - vi.CuryAdjdDiscAmt, c.DecPl),
       d.Opendoc = CASE WHEN CONVERT(DEC(28,3),d.CuryDocBal) - vi.CuryAdjdAmt = 0
                        THEN 0
                        ELSE 1
                   END,
      d.PerClosed = CASE    -- Perclosed is the max of the doc's perpost and any related adjustment's perappl
                       WHEN CONVERT(DEC(28,3),d.CuryDocBal) - vi.CuryAdjdAmt = 0
                           THEN CASE WHEN d.perpost > ISNULL(ad.perclosed,' ')
                                        THEN d.perpost
                                     ELSE ISNULL(ad.perclosed,' ')
                                END
                       ELSE ' '
                     END,
       -- Peropen(S4Future01) is the min of the doc's perpost and any related adjustment's perappl
       d.S4Future01 = CASE WHEN d.perpost < ISNULL(ad.peropen,'999999')
                             THEN d.perpost
                           ELSE ISNULL(ad.peropen,' ')
                      END
 FROM vp_08400_AdjD vi JOIN ARDoc d  ON vi.CustID = d.CustID
                                     AND vi.AdjdRefNbr = d.RefNbr AND vi.AdjdDocType = d.DocType
		   INNER JOIN Currncy c ON c.CuryID=d.CuryID
                   LEFT JOIN vp_08400_alladjd ad
                          ON ad.CustID = d.CustID
                         AND ad.AdjdRefNbr = d.RefNbr AND ad.AdjdDocType = d.DocType
 WHERE vi.UserAddress = @UserAddress

IF @@ERROR <> 0 GOTO ABORT

-- Update APARLink table if record exists and the Invoice Document Balance is zero.
UPDATE a SET Status = CASE WHEN d.docbal = 0 THEN 'C' ELSE 'O' END
  FROM WrkRelease w INNER JOIN ARAdjust j
                       ON w.Batnbr = j.AdjBatnbr
                    INNER JOIN ARDoc d
                       ON j.Custid = d.Custid
                      AND j.AdjdDocType = d.Doctype
                      AND j.AdjdRefNbr = d.RefNbr
                    INNER JOIN APARLink a
                    ON d.Custid = a.Custid
                   AND d.RefNbr = a.ARRefNbr
                   AND d.Doctype = a.ARDocType
 WHERE w.Module = 'AR' AND w.UserAddress = @Useraddress
   AND d.Doctype = 'IN'

-- Update APARLink table is a zero amount invoice is created.

UPDATE a SET Status = 'C'
  FROM WrkRelease w INNER JOIN ARDoc d
                       ON w.Batnbr = d.Batnbr
                    INNER JOIN APARLink a
                    ON d.Custid = a.Custid
                   AND d.RefNbr = a.ARRefNbr
                   AND d.Doctype = a.ARDocType
 WHERE w.Module = 'AR' AND w.UserAddress = @Useraddress
   AND d.Doctype = 'IN' AND d.Docbal = 0

/***** Update Customer Balances and Hist Records*****/

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
    PRINT 'Debug...Step 2500:  Create Customer AR_Balances Record If Does Not Exist'

  END

INSERT AR_Balances (AccruedRevAgeBal00, AccruedRevAgeBal01, AccruedRevAgeBal02, AccruedRevAgeBal03, AccruedRevAgeBal04, AccruedRevBal,
	AgeBal00, AgeBal01, AgeBal02, AgeBal03, AgeBal04, AvgDayToPay, CpnyID,
        CrLmt, Crtd_DateTime, Crtd_Prog, Crtd_User, CurrBal, CuryID, CuryPromoBal, CustID,
        FutureBal, LastActDate, LastAgeDate, LastFinChrgDate, LastInvcDate, LastStmtBal00,
        LastStmtBal01, LastStmtBal02, LastStmtBal03, LastStmtBal04, LastStmtBegBal,
	LastStmtDate, LUpd_DateTime, LUpd_Prog, LUpd_User, NbrInvcPaid, NoteID, PaidInvcDays,
        PerNbr, PromoBal, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05,
        S4Future06, S4Future07, S4Future08, S4Future09, S4Future10,
	S4Future11, S4Future12, TotOpenOrd, TotPrePay, TotShipped, User1, User2, User3, User4, User5,
        User6, User7, User8)
SELECT DISTINCT 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, v.CpnyID,
        0, GETDATE(), @ProgID, @Sol_User, 0, CASE cust.curyId
                                               WHEN '' THEN @BaseCuryId
                                               ELSE cust.CuryId
                                               END,
	0, v.CustID,
        0, '', '', '', '', 0,
        0, 0, 0, 0, 0,
        '', GETDATE(), @ProgID, @Sol_User, 0, 0, 0,
        @PerNbr, 0, '', '', 0, 0, 0,
        0, '', '', 0, 0,
        '', '',	0, 0, 0, '', '', 0, 0, '',
        '', '', ''
  FROM vp_08400ARBalancesHist v INNER JOIN customer cust
       ON  v.custid = cust.custid
                                 LEFT JOIN AR_Balances b
                                   ON v.CustID = b.CustID and v.CpnyID = b.CpnyID
 WHERE v.UserAddress = @UserAddress
   AND b.CustID IS NULL

IF @@ERROR <> 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
    PRINT 'Debug...Step 2600:  Update Customer Balances'
    SELECT 'vp_08400ARBalHistSum'
    SELECT *
      FROM vp_08400ARBalHistSum
     WHERE useraddress = @useraddress
    select 'vp_08400ARFutBalHistSum'
    select * from vp_08400ARFutBalHistSum
     WHERE useraddress = @useraddress
  END

UPDATE AR_Balances
   SET CurrBal = ROUND(CurrBal + Balance,@BaseDecPl),
        TotPrePay = CASE WHEN ROUND(TotPrePay + v.PrePay,@BaseDecPl) > 0
                          THEN ROUND(TotPrePay + v.PrePay,@BaseDecPl)
                          Else 0
                         END,
        lastactdate = (Case when v.lastactdate > b.lastactdate Then v.lastactdate else b.lastactdate End),
        lastinvcdate = (Case when v.lastinvdate > b.lastinvcdate Then v.lastinvdate else b.lastinvcdate End),
        LUpd_DateTime = GETDATE(),
        LUpd_Prog = @ProgID,
        LUpd_User = @Sol_User

  FROM vp_08400ARBalHistSum v  INNER JOIN AR_Balances b
                                  ON v.CustId = b.CustID
                                 AND v.CpnyID = b.CpnyID
  WHERE v.UserAddress = @UserAddress
IF @@ERROR <> 0 GOTO ABORT

UPDATE AR_Balances
   SET TotShipped = ROUND(TotShipped - BalDue, @BaseDecPl),
        LUpd_DateTime = GETDATE(),
        LUpd_Prog = @ProgID,
        LUpd_User = @Sol_User

  FROM (select sum(s1.BalDue) as BalDue, d.BatNbr, s1.CpnyID, s1.CustID
  	from WrkRelease w
  		INNER JOIN SoShipHeader s1 ON s1.ARBatNbr = w.BatNbr AND w.Module = 'AR'
  		INNER JOIN ARDoc d ON d.BatNbr = s1.ARBatNbr AND d.RefNbr = s1.InvcNbr AND d.CustID = s1.CustID AND d.CpnyID = s1.CpnyID
  			where s1.Status = 'C' and w.UserAddress = @UserAddress
  			group by d.BatNbr, s1.CpnyID, s1.CustID) s
   		INNER JOIN AR_Balances b ON s.CustId = b.CustID AND s.CpnyID = b.CpnyID
IF @@ERROR <> 0 GOTO ABORT

-- Update accrued balance, TotShipped
UPDATE b
   SET  AccruedRevBal = ROUND(AccruedRevBal+v.Accrued, @BaseDecPl),
        TotShipped = ROUND(TotShipped - v.Accrued, @BaseDecPl),
        LUpd_DateTime = GETDATE(),
        LUpd_Prog = @ProgID,
        LUpd_User = @Sol_User
   FROM AR_Balances b INNER JOIN
   	(select CpnyID, CustID, sum(Accrued) Accrued from vp_08400ARBalancesHist WHERE UserAddress = @UserAddress GROUP BY CpnyID, CustID) v
   	ON b.CustID = v.CustID AND b.CpnyID = v.CpnyID

IF @@ERROR <> 0 GOTO ABORT

UPDATE AR_Balances  SET FutureBal = ROUND(FutureBal + Balance,@BaseDecpl), TotPrePay = Case when ROUND(TotPrePay + v.PrePay,@BaseDecPl) > 0 Then ROUND(TotPrePay + v.PrePay,@BaseDecPl) Else 0 End,
        lastactdate = (Case when v.lastactdate > b.lastactdate Then v.lastactdate else b.lastactdate End),
        lastinvcdate = (Case when v.lastinvdate > b.lastinvcdate Then v.lastinvdate else b.lastinvcdate End)
	FROM AR_Balances b, vp_08400ARFutBalHistSum v
	WHERE  v.CustId = b.CustID AND b.CpnyID = v.CpnyID AND v.UserAddress = @UserAddress
IF @@ERROR <> 0 GOTO ABORT

-- Get Average Days to Pay Retention CutOff
EXEC pp_PeriodMinusPerNbr @PerNbr,  @PerToSub , @OutPerNbr Output
IF @@ERROR <> 0 GOTO ABORT

--Find all debit documents closed by this batch
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
-- For each debit doc closed in this batch, find the max credit doc date applied (that wasn't reversed)
-- and use that date - debit doc date to calculate paid invoice days.
WHILE @@FETCH_STATUS = 0
BEGIN
  UPDATE b
     SET b.NbrInvcPaid = b.NbrInvcPaid + CASE WHEN v.AdjgDocDate = '' THEN 0 ELSE 1 END,
         b.PaidInvcDays = b.PaidInvcDays + DATEDIFF(DAY,@DocDate , ISNULL(NULLIF(v.AdjgDocDate, ''), @DocDate)),
         b.AvgDayToPay = CASE WHEN v.AdjgDocDate = ''
                              THEN b.AvgDayToPay
                              ELSE ROUND((b.PaidInvcDays + DATEDIFF(DAY,@DocDate , v.AdjgDocDate))/ (CASE WHEN (b.NbrInvcPaid + 1) <= 0
                                                                                                         THEN 1
                                                                                                         ELSE (b.NbrInvcPaid + 1)
                                                                                                     END) ,2)
                          END
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

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
    PRINT 'Debug...Step 2800:  Create/Update ARHist records, call pp_08400UpdateARHist'
  END

EXEC pp_08400UpdateARHist @UserAddress, @Sol_User, @Debug, @hist_Result OUTPUT
IF @hist_Result = 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
    PRINT 'Debug...Step 2900:  Create Wrk_GLTran records in the temporary GLTran table'

  END

INSERT wrk_GLTran (Acct, AppliedDate, BalanceType, BaseCuryID, BatNbr,
       CpnyID, CrAmt, Crtd_DateTime, Crtd_Prog, Crtd_User,
       CuryCrAmt, CuryDrAmt, CuryEffDate, CuryId, CuryMultDiv, CuryRate, CuryRateType, DrAmt, EmployeeID,
       ExtRefNbr, FiscYr, IC_Distribution, Id, JrnlType, Labor_Class_Cd, LedgerID, LineId, LineNbr, LineRef,
       LUpd_DateTime, LUpd_Prog, LUpd_User, Module, NoteID, OrigAcct,
       OrigBatNbr, OrigCpnyID, OrigSub, PC_Flag, PC_ID, PC_Status, PerEnt,
       PerPost, Posted, ProjectID, Qty, RefNbr, revEntryOption, Rlsed, S4Future01, S4Future02, S4Future03,
       S4Future04, S4Future05, S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11,S4Future12,
       ServiceDate, Sub, TaskID, TranDate, TranDesc, TranType, Units, User1, User2, User3, User4, User5, User6,
       User7, User8, FromCpnyID, Screen,Recordid,UserAddress)
SELECT Acct, AppliedDate, BalanceType, @BaseCuryID, BatNbr, CpnyID, CrAmt, Crtd_DateTime, Crtd_Prog, Crtd_User,
       CuryCrAmt, CuryDrAmt, CuryEffDate, CuryId, CuryMultDiv, CuryRate, CuryRateType, DrAmt, EmployeeID,
       ExtRefNbr, FiscYr, IC_Distribution, Id, JrnlType, Labor_Class_Cd, @LedgerID, LineId, LineNbr, LineRef,
       LUpd_DateTime, LUpd_Prog, LUpd_User, Module, NoteID, OrigAcct, OrigBatNbr, OrigCpnyID, OrigSub, PC_Flag, PC_ID, PC_Status, PerEnt,
       PerPost, Posted, ProjectID, Qty, RefNbr, revEntryOption, Rlsed, S4Future01, S4Future02, S4Future03,
       S4Future04, S4Future05, S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11,S4Future12,
       ServiceDate, Sub, TaskID, TranDate, TranDesc, TranType, Units, User1, User2, User3, User4, User5, User6,
       User7, User8, FromCpnyID, Screen,Recordid,@UserAddress
  FROM vp_08400GLTran v
 WHERE v.UserAddress = @UserAddress

IF @@ERROR <> 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
    PRINT 'Debug...Step 3000:  Create Wrk_GLTran records with suspense acct if acct is null.'
    SELECT 'vp_08400GLTran '
    SELECT *
      FROM vp_08400GLTran  where useraddress = @useraddress
    SELECT 'wrk_gltran'
    SELECT *
      FROM wrk_gltran where useraddress = @useraddress

  END

INSERT wrk_GLTran (Acct, AppliedDate, BalanceType, BaseCuryID, BatNbr, CpnyID, CrAmt, Crtd_DateTime, Crtd_Prog, Crtd_User,
       CuryCrAmt, CuryDrAmt, CuryEffDate, CuryId, CuryMultDiv, CuryRate, CuryRateType, DrAmt, EmployeeID,
       ExtRefNbr, FiscYr, IC_Distribution, Id, JrnlType, Labor_Class_Cd, LedgerID, LineId, LineNbr, LineRef,
       LUpd_DateTime, LUpd_Prog, LUpd_User, Module, NoteID, OrigAcct, OrigBatNbr, OrigCpnyID, OrigSub, PC_Flag, PC_ID, PC_Status, PerEnt,
       PerPost, Posted, ProjectID, Qty, RefNbr, revEntryOption, Rlsed, S4Future01, S4Future02, S4Future03,
       S4Future04, S4Future05, S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11,S4Future12,
       ServiceDate, Sub, TaskID, TranDate, TranDesc, TranType, Units, User1, User2, User3, User4, User5, User6,
       User7, User8, FromCpnyID, Screen,Recordid,UserAddress)
SELECT Acct, AppliedDate, BalanceType, @BaseCuryID, BatNbr, CpnyID, CrAmt, Crtd_DateTime, Crtd_Prog, Crtd_User,
       CuryCrAmt, CuryDrAmt, CuryEffDate, CuryId, CuryMultDiv, CuryRate, CuryRateType, DrAmt, EmployeeID,
       ExtRefNbr, FiscYr, IC_Distribution, Id, JrnlType, Labor_Class_Cd, @LedgerID, LineId, LineNbr, LineRef,
       LUpd_DateTime, LUpd_Prog, LUpd_User, Module, NoteID, OrigAcct, OrigBatNbr, OrigCpnyID, OrigSub, PC_Flag, PC_ID, PC_Status, PerEnt,
       PerPost, Posted, ProjectID, Qty, RefNbr, revEntryOption, Rlsed, S4Future01, S4Future02, S4Future03,
       S4Future04, S4Future05, S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11,S4Future12,
       ServiceDate, Sub, TaskID, TranDate, TranDesc, TranType, Units, User1, User2, User3, User4, User5, User6,
       User7, User8, FromCpnyID, Screen,Recordid,@UserAddress
  FROM vp_08400SuspenseGLTran v
 WHERE v.UserAddress = @UserAddress

IF @@ERROR <> 0 GOTO ABORT

/***** Multi-Company/Inter-Company Transactions *****/

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
    PRINT 'Debug...Step 3100:  Intercompany trans - Set IC flag for external db companies.'
   SELECT 'vp_08400SuspenseGLTran'
   SELECT *
     FROM vp_08400SuspenseGLTran
    WHERE useraddress = @useraddress
   SELECT 'wrk_gltran'
   SELECT *
     FROM wrk_gltran
    WHERE useraddress = @useraddress

  END

UPDATE WRK_GLTRAN
   SET IC_Distribution = CASE c1.DatabaseName
	                 WHEN c2.DatabaseName
                         THEN 0
	                 ELSE 1
                         END
  FROM WRK_GLTRAN t INNER JOIN vs_Company c1
                       ON  t.CpnyID = c1.CpnyID
                    INNER JOIN vs_Company c2
                       ON t.FromCpnyID = c2.CpnyID
 WHERE t.UserAddress = @UserAddress
IF @@ERROR <> 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
    PRINT 'Debug...Step 3200:  Intercompany trans - Intercompany pass one'

  END

INSERT Wrk_GLTran (Acct, AppliedDate, BalanceType, BaseCuryID, BatNbr, CpnyID, CrAmt, Crtd_DateTime, Crtd_Prog, Crtd_User,
  CuryCrAmt, CuryDrAmt, CuryEffDate, CuryId, CuryMultDiv, CuryRate, CuryRateType, DrAmt, EmployeeID,
       ExtRefNbr, FiscYr, IC_Distribution, Id, JrnlType, Labor_Class_Cd, LedgerID, LineId, LineNbr, LineRef,
       LUpd_DateTime, LUpd_Prog, LUpd_User, Module, NoteID, OrigAcct, OrigBatNbr, OrigCpnyID, OrigSub, PC_Flag, PC_ID, PC_Status, PerEnt,
       PerPost, Posted, ProjectID, Qty, RefNbr, RevEntryOption, Rlsed, S4Future01, S4Future02, S4Future03,
       S4Future04, S4Future05, S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11,S4Future12,
       ServiceDate, Sub, TaskID, TranDate, TranDesc, TranType, Units, User1, User2, User3, User4, User5, User6,
       User7, User8, FromCpnyID, Screen, RecordID, UserAddress)
SELECT v.FromAcct, t.AppliedDate, t.BalanceType, t.BaseCuryID, t.BatNbr, v.FromCpny, t.CrAmt,
       GETDATE(), t.Crtd_Prog, t.Crtd_User, t.CuryCrAmt, t.CuryDrAmt, t.CuryEffDate, t.CuryId,
       t.CuryMultDiv, t.CuryRate, t.CuryRateType, t.DrAmt, t.EmployeeID, t.ExtRefNbr, t.FiscYr,
       0, t.Id, t.JrnlType, t.Labor_Class_Cd, t.LedgerID, t.LineID, t.LineNbr, t.LineRef,
       GETDATE(), t.LUpd_Prog, t.LUpd_User, t.Module, 0, t.Acct, t.BatNbr, t.CpnyID, t.Sub,
       t.PC_Flag, t.PC_ID, t.PC_Status, t.PerEnt, t.PerPost, t.Posted, t.ProjectID, t.Qty, t.RefNbr,
       t.RevEntryOption, t.Rlsed, t.S4Future01, t.S4Future02, t.S4Future03, t.S4Future04, t.S4Future05,
       t.S4Future06, t.S4Future07, t.S4Future08, t.S4Future09, t.S4Future10, t.S4Future11, t.S4Future12,
       t.ServiceDate, v.FromSub, t.TaskID, t.TranDate, t.TranDesc, 'IC', t.Units,
       t.User1, t.User2, t.User3, t.User4, t.User5, t.User6, t.User7, t.User8,
       t.FromCpnyID, t.Screen, t.RecordId, @UserAddress
  FROM WRK_GLTRAN t INNER JOIN vp_ShareInterCpnyScreenAll v
                       ON t.FromCpnyID = v.FromCpny
                      AND t.CpnyID = v.ToCpny
                      AND t.Screen = v.Screen
                      AND t.Module = v.Module
 WHERE t.FromCpnyID <> t.CpnyID
   AND v.Module = 'AR'
   AND t.UserAddress = @UserAddress

SELECT @Err=@@ERROR, @R_C=@@ROWCOUNT

IF @Err <> 0 GOTO ABORT

IF @R_C <> (SELECT COUNT(*)
              FROM WRK_GLTRAN
             WHERE FromCpnyID <> CpnyID AND Module = 'AR'
               AND UserAddress = @UserAddress)
BEGIN
     INSERT WrkReleaseBad SELECT @BatNbr, 'AR', 12341, @useraddress, null
       GOTO Check_WrkReleaseBad
END

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
    PRINT 'Debug...Step 3300:  Intercompany trans - Intercompany pass two'
    select 'wrk_gltran'
    select *
      FROM wrk_gltran
     WHERE useraddress = @useraddress

  END

INSERT Wrk_GLTran (Acct, AppliedDate, BalanceType, BaseCuryID, BatNbr, CpnyID, CrAmt, Crtd_DateTime, Crtd_Prog, Crtd_User,
       CuryCrAmt, CuryDrAmt, CuryEffDate, CuryId, CuryMultDiv, CuryRate, CuryRateType, DrAmt, EmployeeID,
       ExtRefNbr, FiscYr, IC_Distribution, Id, JrnlType, Labor_Class_Cd, LedgerID, LineId, LineNbr, LineRef,
       LUpd_DateTime, LUpd_Prog, LUpd_User, Module, NoteID, OrigAcct, OrigBatNbr, OrigCpnyID, OrigSub, PC_Flag, PC_ID, PC_Status, PerEnt,
       PerPost, Posted, ProjectID, Qty, RefNbr, RevEntryOption, Rlsed, S4Future01, S4Future02, S4Future03,
       S4Future04, S4Future05, S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11,S4Future12,
       ServiceDate, Sub, TaskID, TranDate, TranDesc, TranType, Units, User1, User2, User3, User4, User5, User6,
       User7, User8, FromCpnyID, Screen, RecordID, UserAddress)
SELECT CASE t.IC_Distribution WHEN 0 THEN v.ToAcct ELSE t.Acct END,
       t.AppliedDate, t.BalanceType, t.BaseCuryID, t.BatNbr, v.ToCpny, t.DrAmt,
       GETDATE(), t.Crtd_Prog, t.Crtd_User, t.CuryDrAmt, t.CuryCrAmt, t.CuryEffDate, t.CuryId,
       t.CuryMultDiv, t.CuryRate, t.CuryRateType, t.CrAmt, t.EmployeeID, t.ExtRefNbr, t.FiscYr,
       0, t.Id, t.JrnlType, t.Labor_Class_Cd, t.LedgerID, t.LineID, t.LineNbr, t.LineRef,
       GETDATE(), t.LUpd_Prog, t.LUpd_User, t.Module, 0, t.Acct, t.BatNbr, t.CpnyID, t.Sub,
       t.PC_Flag, t.PC_ID, t.PC_Status, t.PerEnt, t.PerPost, t.Posted, t.ProjectID, t.Qty, t.RefNbr,
       t.RevEntryOption, t.Rlsed, t.S4Future01, t.S4Future02, t.S4Future03, t.S4Future04, t.S4Future05,
       t.S4Future06, t.S4Future07, t.S4Future08, t.S4Future09, t.S4Future10, t.S4Future11, t.S4Future12,
       t.ServiceDate, CASE t.IC_Distribution WHEN 0 THEN v.ToSub ELSE t.Sub END,
       t.TaskID, t.TranDate, t.TranDesc, 'IC', t.Units,
       t.User1, t.User2, t.User3, t.User4, t.User5, t.User6,
       t.User7, t.User8, t.FromCpnyID, t.Screen, t.RecordID, @UserAddress
  FROM WRK_GLTRAN t INNER JOIN vp_ShareInterCpnyScreenAll v
                       ON t.FromCpnyID = v.FromCpny
                      AND t.CpnyID = v.ToCpny
                      AND t.Screen = v.Screen
                      AND t.Module = v.Module
 WHERE t.FromCpnyID <> t.CpnyID
   AND v.Module = 'AR'
   AND t.UserAddress = @UserAddress
IF @@ERROR <> 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
    PRINT 'Debug...Step 3400:  Update LineNbr field in GLTran records'

  END

UPDATE WRK_GLTRAN SET LineNbr = t.Counter - 32768 -
	(SELECT MIN(p.Counter) FROM WRK_GLTRAN p WHERE p.BatNbr = t.BatNbr and p.useraddress = @UserAddress)
        FROM WRK_GLTRAN t
       where t.useraddress = @UserAddress

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
    PRINT 'Debug...Step 3500:  Move temporary GLTran records into GLTran table'
    SELECT 'wrk_gltran'
    SELECT *
      FROM wrk_gltran
     WHERE useraddress = @useraddress

  END

INSERT GLTran (Acct, AppliedDate, BalanceType, BaseCuryID, BatNbr, CpnyID, CrAmt, Crtd_DateTime,
               Crtd_Prog, Crtd_User, CuryCrAmt, CuryDrAmt, CuryEffDate, CuryId, CuryMultDiv,
               CuryRate, CuryRateType, DrAmt, EmployeeID, ExtRefNbr, FiscYr, IC_Distribution, Id,
               JrnlType, Labor_Class_Cd, LedgerID, LineId, LineNbr, LineRef, LUpd_DateTime, LUpd_Prog,
               LUpd_User, Module, NoteID, OrigAcct, OrigBatNbr, OrigCpnyID, OrigSub, PC_Flag, PC_ID,
               PC_Status, PerEnt, PerPost, Posted, ProjectID, Qty, RefNbr, revEntryOption, Rlsed,
               S4Future01, S4Future02, S4Future03,
	       S4Future04, S4Future05, S4Future06, S4Future07, S4Future08, S4Future09, S4Future10,
               S4Future11,S4Future12, ServiceDate, Sub, TaskID, TranDate, TranDesc, TranType,
               Units, User1, User2, User3, User4, User5, User6,	User7, User8)
SELECT Gt.Acct, '', 'A', Gt.BaseCuryID,Gt.BatNbr, Gt.CpnyID, Gt.CrAmt, GetDate(), t.Crtd_Prog, t.Crtd_User,
       Gt.CuryCrAmt, Gt.CuryDrAmt, '', t.CuryId, t.CuryMultDiv,t.CuryRate, '', Gt.DrAmt,'',
       t.ExtRefnbr, t.FiscYr, Gt.IC_Distribution, t.custid, t.JrnlType,'', Gt.LedgerID, 0, Gt.Linenbr, '',
       GetDate(), t.LUpd_Prog, t.LUpd_User, 'AR',0, Gt.OrigAcct,'', Gt.origcpnyid,  Gt.OrigSub, '', '', '', t.PerEnt,
       t.PerPost, 'U', t.ProjectID, Gt.Qty, t.RefNbr, '', 1,t.S4Future01, t.S4Future02, t.S4Future03,
       t.S4Future04, t.S4Future05, t.S4Future06, t.S4Future07, t.S4Future08, t.S4Future09, t.S4Future10,
       t.S4Future11,t.S4Future12, '', Gt.Sub, t.TaskID, t.TranDate, gt.TranDesc,gt.TranType,
       Gt.units, t.User1,t.User2, t.User3, t.User4, t.User5, t.User6, t.User7, t.User8
  FROM WRK_GLTRAN Gt,artran t
 WHERE (CrAmt <> 0 OR DrAmt <> 0 OR CuryCrAmt <> 0 OR CuryDrAmt <> 0)
   AND Gt.Recordid = t.Recordid
   AND gt.UserAddress = @UserAddress

IF @@ERROR <> 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
    PRINT 'Debug...Step 3600:  When the process is complete, change the appropriate statuses.'

  END

UPDATE t
   SET Rlsed = 1,
       AcctDist = CASE
                  WHEN DrCr IN ('D', 'C') THEN 1
                  ELSE 0
                  END
   FROM WrkRelease w INNER JOIN ArTran t
                        ON w.batnbr = t.batnbr
 WHERE w.module = 'AR'
   AND w.UserAddress = @UserAddress

IF @@ERROR <> 0 GOTO ABORT

UPDATE d SET Rlsed = 1
  FROM WrkRelease w INNER JOIN ArDoc d
                       ON w.batnbr = d.batnbr
 WHERE W.useraddress = @UserAddress
   AND w.Module = 'ar'

IF @@ERROR <> 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
    PRINT 'Debug...Step 3700:  Clear ''U'' Records'
  END

DELETE t
  FROM WrkRelease w INNER  JOIN ARTran t
                       ON W.Batnbr = t.BatNbr
 WHERE  w.Module = 'AR'
    AND w.UserAddress = @UserAddress
    AND t.DRCR = 'U'

IF @@ERROR <> 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
    PRINT 'Debug...Step 3800:  Update applied doc fields'
  END

UPDATE d
   SET d.applbatnbr = '', d.applamt = 0, d.curyapplamt = 0, d.CuryDiscApplAmt = 0, d.DiscApplAmt = 0
  FROM WrkRelease w INNER JOIN ARDoc d With(INDEX(ARDOC17))
                       ON W.BatNBr = d.applBatNbr
 WHERE d.doctype IN ('PA', 'PP', 'CM', 'SB', 'SC', 'AD')
   AND w.module = 'AR'
   AND w.useraddress = @useraddress
IF @@ERROR <> 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
    PRINT 'Debug...Step 3900:  Update batch table - release zero batch'
  END

UPDATE Batch
   SET Status =
       CASE WHEN v.DocCount = 0    -- DocCount Column contains count of gltrans in this batch
            THEN 'C'
            ELSE 'U'
            END,
       CtrlTot = CASE WHEN v.DocCount > 0
	              THEN v.CrTot
		      ELSE 0
                      END,
       CrTot = CASE WHEN v.DocCount > 0
	            THEN v.CrTot
		    ELSE 0
                    END,
	DrTot = CASE WHEN v.DocCount > 0
		     THEN v.DrTot
		     ELSE 0
	             END,
	CuryCtrlTot = CASE
                WHEN v.DocCount > 0
		THEN v.CuryCrTot
		ELSE 0
	        END,
	CuryCrTot = CASE WHEN v.DocCount > 0
		         THEN v.CuryCrTot
			 ELSE 0
	                 END,
	CuryDrTot = CASE WHEN v.DocCount > 0
		         THEN v.CuryDrTot
		         ELSE 0
	                 END, Rlsed = 1, LedgerID = l.LedgerID,
       BaseCuryID = l.BaseCuryID, BalanceType = l.BalanceType
  FROM WrkRelease w INNER JOIN Batch b
                       ON w.batnbr = b.batnbr
                    INNER JOIN vp_08400BatchUpdate v
                       ON b.BatNbr = v.BatNbr
                    INNER JOIN  Ledger l
                       ON l.LedgerID = @LedgerId
 WHERE w.UserAddress = @UserAddress
   AND w.module = 'AR'
   AND b.Module = 'AR'

IF @@ERROR <> 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
    PRINT 'Debug...Step 3950:  Update CmmnPct and CmmnAmt '
	select CmmnPct = c.creditpct, cmmnamt = ROUND (c.creditpct*d.docbal/100.0, @BaseDecPl), curycmmnamt = ROUND (c.creditpct*d.curydocbal/100, y.decpl)
	from WrkRElease w, CustSlsper c, ArDoc d left outer join  currncy y
	on y.curyid = d.curyid
	where   c.custid = d.custid and
	c.slsperid = d.slsperid
	and w.useraddress = @useraddress and w.batnbr = d.batnbr
  END
 update ArDoc
	set CmmnPct = c.creditpct, cmmnamt = ROUND (c.creditpct*d.docbal/100.0, @BaseDecPl), curycmmnamt = ROUND (c.creditpct*d.curydocbal/100, y.decpl)
	from WrkRElease w, CustSlsper c, ArDoc d left outer join  currncy y
	on y.curyid = d.curyid
	where   c.custid = d.custid and
	c.slsperid = d.slsperid
	and w.useraddress = @useraddress and w.batnbr = d.batnbr
IF @@ERROR <> 0 GOTO ABORT

IF (@Debug = 1)
  	BEGIN
    	PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
    	PRINT 'Debug Step 3960...Check for incorrect RGOL creation'
    	SELECT v.batnbr, v.AdjgRefNbr,v.CuryRGOLAmt,b.CuryID
  		FROM WRKRELEASE w INNER JOIN BATCH b
                       		ON w.batnbr = b.batnbr
                    	INNER JOIN vp_08400IncorrectRGOL v
                       		ON b.batnbr = v.BatNbr
			  AND w.UserAddress = v.UserAddress
                    LEFT OUTER JOIN currncy c (nolock)
                       ON c.curyid = b.curyid

		WHERE w.module = 'AR'
  			AND w.useraddress = @useraddress
  			AND w.BatNbr = v.BatNbr
  			AND b.module = 'AR'
  			AND (v.CuryRGOLAmt <> 0	OR c.CuryID IS NULL)

				PRINT ''
	END

INSERT WrkReleaseBad (batnbr, module, msgid, useraddress)
SELECT DISTINCT v.batnbr, 'AR', 8881, v.UserAddress
  FROM vp_08400IncorrectRGOL v INNER LOOP JOIN Batch b
                                            ON b.batnbr = v.BatNbr
                               LEFT OUTER JOIN currncy c (nolock)
                                            ON c.curyid = b.curyid
 WHERE b.module = 'AR'
   AND v.useraddress = @useraddress
   AND (v.CuryRGOLAmt <> 0 OR c.CuryID IS NULL)


 IF @@ERROR <> 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
    PRINT 'Debug...Step 4000:  check for out of balance situations'
    PRINT 'Balance totals'
    SELECT w.batnbr, w.UserAddress,
           bcurycrtot = convert(dec(28,3),b.curycrtot),
           bcurydrtot = convert(dec(28,3),b.curydrtot),
           bcrtot = convert(dec(28,3),b.crtot),
           bdrtot = convert(dec(28,3),b.drtot),
           vcramt = v.cramt, vdramt = v.dramt,
           vcurycramt = v.curycramt, vcurydramt = v.curydramt
      FROM WrkRelease w INNER JOIN Batch b
                           ON w.batnbr = b.batnbr
                        INNER JOIN vp_08400ChkSumGlTrans v
                           ON b.batnbr = v.batnbr
     WHERE w.module = 'AR'
       AND b.module = 'AR'
       AND w.useraddress = @useraddress

     PRINT 'Identify specific refnbrs that are out of balance'
     SELECT refnbr,cramt=sum(case when drcr = 'c' then tranamt else 0 end),
                  dramt = sum(case when drcr = 'd' then tranamt else 0 end)
       FROM artran t, wrkrelease w where w.batnbr = t.batnbr and w.module = 'AR'
                 and useraddress = @useraddress
      GROUP by refnbr
     HAVING ROUND(sum(case when drcr = 'c' then tranamt else 0 end),2) <>
                 ROUND(sum(case when drcr = 'd' then tranamt else 0 end),2)
    PRINT 'Artrans'
    SELECT t.batnbr, t.custid, t.trantype, t.refnbr, t.curytranamt, t.tranamt, t.drcr,
           t.tranclass, t.WhseLoc, t.*
      FROM wrkrelease w INNER JOIN ArTran t
                           ON w.batnbr = t.batnbr
     WHERE w.module = 'AR'
       AND w.useraddress = @useraddress

    PRINT 'Gltrans'
    SELECT t.batnbr, t.id, t.trantype, t.refnbr, t.curycramt, t.cramt, t.curydramt, t.dramt, t.*
      FROM wrkrelease w INNER JOIN gltran t
                           ON w.batnbr = t.batnbr
     WHERE t.module = 'AR'
       AND w.module = 'AR'
       AND w.useraddress = @useraddress

  END

SELECT @OutofBal = 0

INSERT WrkReleaseBad (batnbr, module, msgid, useraddress)
SELECT w.batnbr, 'AR', 8888, w.UserAddress
  FROM WRKRELEASE w INNER JOIN BATCH b
                       ON w.batnbr = b.batnbr
                    INNER JOIN vp_08400ChkSumGlTrans v
                       ON b.batnbr = v.batnbr
                    INNER JOIN currncy c (nolock)
                       ON c.curyid = b.curyid
WHERE w.module = 'AR'
  AND b.module = 'AR'
  AND (CONVERT(DEC(28,3),ROUND(b.curycrtot, c.decpl)) <> CONVERT(DEC(28,3),ROUND(b.curydrtot, c.decpl))
       OR CONVERT(DEC(28,3),ROUND(b.crtot, @BaseDecPl))  <> CONVERT(DEC(28,3),ROUND(b.drtot,@BaseDecPl))
       OR ROUND(v.cramt,@BaseDecPl)   <>  ROUND(v.dramt, @BaseDecPl)
       OR ROUND(v.curycramt, c.decpl) <> ROUND(v.curydramt, c.decpl) )
  AND w.useraddress = @useraddress
 IF @@ERROR < > 0 GOTO ABORT

SELECT @OutofBal = COUNT(*),
       @FirstBat = MIN(batnbr)
  FROM wrkreleasebad
 WHERE msgid = 8888
   AND useraddress = @useraddress

IF @outofbal > 0
  BEGIN
   SET @Msgid = 8888
   GOTO ABORT
  END

CHECK_WRKRELEASEBAD:
IF (@Debug = 1)
  BEGIN
    Select @Msgid = 0

    Select @Msgid = Msgid
      from Wrkreleasebad
      Where useraddress = @useraddress

    Select @ErrorMsg = Case @Msgid
                          When 0     Then 'Batch okay, will release normally.'
                          When 12347 Then 'Error 12347, ARDocs have invalid Customer id.'
                          When 12348 Then 'Error 12348, ARDocs have invalid Tax ID.'
                          When 6019  Then 'Error 6019, ARTrans are missing or ARtrans have blank refnbr.'
                          When 6624  Then 'Error 6624, Sales Tax ID is used as an individual tax and group tax in the same document.'
                          When 6928  Then 'Error 6928, ARDocs or ARTrans have invalid Account.'
                          When 6929  Then 'Error 6929, ARDocs or Artrans have invalid Sub. Account.'
                          When 6958  Then 'Error 6958, Sales Tax has invalid TaxType.'
                          When 12008 Then 'Error 12008, Batch is already released'
                          When 12014 Then 'Error 12014, Multiple installment document is missing it installments.'
                          When 12123 Then 'Error 12123, Batch totals do not equal the sum of the documents.'
                          When 12124 Then 'Error 12124, Curytranamt not equal to tranamt for base currency documents.'
                          When 12125 Then 'Error 12125, ARTrans are missing or ARtrans have blank refnbr.'
                          When 12126 Then 'Error 12126, Invoice and Debit Memo transactions have no documents.'
                          When 12306 Then 'Error 12306, Payment batch should be released after the corresponding invoice(s) is released.'
                          When 12319 Then 'Error 12319, Batch record is missing or Batch has blank Edit Screen Number.'
                          When 8881  Then 'Error 8881, Invalid currency information in a base currency batch'
                          When 12341 Then 'Error 12341, There is no inter-company account/subaccount.'
                          When 12426 Then 'Error 12426, Reverse Accrual batch should be released after the corresponding Accrual Document(s) batch is released.'
                          When 12427 Then 'Error 12427, Invoice Account is denominated to a currency and the Payment is not the correct currency.'
                          When 8058 Then 'Error 8058, CuryID does not exist in the Currncy table.'
                          Else 'UnKnown Error.'
                       End
    Print ''
    Print ''
    Print 'Batch Diagnostics'
    Print @ErrorMsg
    Print ''
    If @Msgid <> 0
       Begin
           Select @Batnbr = Batnbr
              from WrkReleaseBad
              Where useraddress = @useraddress
           Exec pp_08400ExceptionReason @Msgid, @batnbr
       End

    ROLLBACK TRANSACTION
    PRINT 'Rolling back transaction'

  END
ELSE
  BEGIN

        SELECT @OutofBal = COUNT(*),
               @FirstBat = MIN(batnbr)
          FROM wrkreleasebad
         WHERE msgid IN (8881, 12341)
           AND useraddress = @useraddress AND MODULE = 'AR'

	IF @outofbal > 0
            BEGIN
              SELECT @Msgid = MIN(msgid)
                FROM wrkreleasebad
               WHERE batnbr= @FirstBat
                 AND useraddress = @useraddress
                 AND MODULE = 'AR'
                GOTO ABORT
  	    END

	ELSE
  		BEGIN
    		COMMIT TRANSACTION
  		END

  END
DELETE Wrk_TimeRange
 WHERE UserAddress = @UserAddress
DELETE Wrk_SalesTax
 WHERE UserAddress = @UserAddress
DELETE WRK_GLTRAN
 WHERE UserAddress = @UserAddress
GOTO FINISH

ABORT:
ROLLBACK TRANSACTION

IF @Outofbal > 0
  IF (@Debug = 1)
    BEGIN
      Print  'Batch Diagnostics'
      SELECT 'Unexpected error ' + convert(char(4),@msgid)

    END
  ELSE
    BEGIN

        INSERT WrkReleaseBad (batnbr, module, msgid, useraddress)
        SELECT @FirstBat, 'AR', @msgid, @useraddress

    END

FINISH:



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_08400] TO [MSDSL]
    AS [dbo];

