 CREATE PROCEDURE pp_03400
	@UserAddress VARCHAR(21),
	@Sol_User varchar(10) AS

SET NOCOUNT ON
SET DEADLOCK_PRIORITY  Low

DECLARE @Debug INT
SELECT @Debug = CASE WHEN @UserAddress = 'APDebug' THEN 1
                     ELSE 0
                END

IF (@Debug = 1)
  BEGIN
    SELECT 'Debug...Step 100: Starting AP Release', CONVERT(varchar(30), GETDATE(), 113)
    SELECT 'Version 09/06/2001 4.60'
  END
/***** Clear Work tables *****/
delete Wrk_TimeRange      where UserAddress = @UserAddress
delete wrk_aptran         where UserAddress = @UserAddress
delete Wrk_gltran        where Useraddress = @useraddress

/***** Declare variables *****/
DECLARE @Result INT, @VORefNbr Char(10), @PPRefNbr VarChar(10), @OperType Char(1), @Rlsed VarChar(1),
        @RetChkRcncl INT,@BaseDecPl INT, @Progid CHAR(8), @BaseCuryID CHAR(10),
        @LedgerID CHAR(10), @TranDescDflt CHAR(1), @PerNbr CHAR(6), @CurrPerNbr CHAR(6),
        @FirstYr CHAR(4), @LastYr CHAR(4), @DiscTknAcct char(10),@DiscTknSub char(24),  @BkupWthldAcct char(10),@BkupWthldSub char(24),
	  @POSetup INT
DECLARE @BatNbr VARCHAR(10)
DECLARE @EditScrnNbr VARCHAR (5)

/***** Set variables *****/
SELECT @ProgID =   '03400',
       @BaseDecPl = c.DecPl,@BaseCuryId = g.BaseCuryId,@LedgerId = g.LedgerId
  from Currncy c, Glsetup g (nolock)
 WHERE g.BaseCuryID = c.CuryID

select @RetChkRcncl = RetChkRcncl,
       @TranDescDflt = TranDescDflt ,
       @PerNbr = PerNbr,
       @CurrPerNbr = CurrPerNbr,
       @DiscTknAcct = DiscTknAcct,
       @DiscTknSub = DiscTknSub,
       @BkupWthldAcct = BkupWthldAcct,
       @BkupWthldSub = BkupWthldSub
  from Apsetup (nolock)

select @POSetup = 1
from posetup (nolock)
where exists(select * from posetup (nolock))

/***** Remove Exceptions *****/
EXEC pp_03400prepwrk @UserAddress, @ProgID, @Sol_User, @CurrPerNbr, @Result OUTPUT
IF @Result = 0 GOTO PREABORT

/***** Create Tax Application Records *****/
IF (@Debug = 1)
  BEGIN
    SELECT 'Debug...Step 200: Prep Work', CONVERT(varchar(30), GETDATE(), 113)
    SELECT * from Batch B, Wrkrelease w
     Where W.Useraddress = @useraddress AND
     W.BatNbr = B.BatNbr AND
     B.Module = 'AP' AND
     W.Module = 'AP'

END

BEGIN TRANSACTION

/*
   This next few statements place a update lock on the batch and wrkrelease records. This will
   not block other reads but will block updates. THIS MUST OCCUR DIRECTLY AFTER THE BEGIN TRAN
   to be effective.
*/
SELECT @BatNbr = ' '
SELECT @BatNbr = BatNbr
  FROM WrkRelease (UPDLOCK)
 WHERE UserAddress = @UserAddress and Module = 'AP'
IF @@ERROR <> 0
  GOTO ABORT

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
    PRINT 'Debug...Step 250:  Get EditScrnNbr'
    SELECT Batch=@BatNbr,EditScrnNbr,*
      FROM Batch (NOLOCK)
     WHERE BatNbr = @BatNbr AND Module = 'AP'
  END

-- No work to do in WrkRelease, exit
IF @BatNbr = ' '
BEGIN
  GOTO Check_WrkReleaseBad
END

SELECT @EditScrnNbr = ' '
SELECT @EditScrnNbr = EditScrnNbr
  FROM Batch (UPDLOCK)
 WHERE BatNbr = @BatNbr AND Module = 'AP'

-- apply/unapply prepayments via the 03070 screen.
IF @EditScrnNbr = '03070'
BEGIN
    Declare ppCsr Cursor for
       		SELECT	VORefNbr, OperType, PPRefNbr
		  FROM	AP_PPApplicDet
		 WHERE	BatNbr = @BatNbr
		 ORDER By BatNbr
    OPEN ppCsr
    FETCH ppCsr INTO @VORefNbr, @OperType, @PPrefNbr
	WHILE @@Fetch_status = 0
	BEGIN
		IF @OperType = 'A'
        BEGIN
			EXEC @Result = AP_ApplyPP @BatNbr, @VORefNbr, @BaseCuryID, @Sol_User, @PPrefNbr
        END
		ELSE
        BEGIN
		    EXEC @Result = AP_UnApplyPP @BatNbr, @VORefNbr, @BaseCuryID, @Sol_User, @PPrefNbr
        END
        IF @Result <> 1
        BEGIN
			INSERT WrkReleaseBad VALUES (@BatNbr, 'AP', @Result, @UserAddress, null)
			CLOSE ppCsr
			DEALLOCATE ppCsr
            GOTO Check_WrkReleaseBad
        END
        FETCH ppCsr into @VORefNbr, @OperType, @PPrefNbr
	END
    CLOSE ppCsr
    DEALLOCATE ppCsr

--Create wrk_GLTran(s) for screen 03070 because there are no docs in these batches

/*** Posting GLTran(s) ***/
/***       1           ***/
INSERT Wrk_GLTran
       (Acct, AppliedDate, BalanceType, BaseCuryID, BatNbr, CpnyID,
       CrAmt,
       Crtd_DateTime, Crtd_Prog, Crtd_User,
       CuryCrAmt,
       CuryDrAmt,
       CuryEffDate, CuryId, CuryMultDiv, CuryRate, CuryRateType,
       DrAmt,
       EmployeeID, ExtRefNbr, FiscYr, IC_Distribution, Id, JrnlType, Labor_Class_Cd, LedgerID,
       LineId, LineNbr, LineRef,
       LUpd_DateTime, LUpd_Prog, LUpd_User,
       Module, NoteID, OrigAcct, OrigBatNbr, OrigCpnyID, OrigSub, PC_Flag, PC_ID, PC_Status,
       PerEnt, PerPost, Posted, ProjectID, Qty, RefNbr, RevEntryOption, Rlsed,
       S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
       S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12,
       ServiceDate, Sub, TaskID, TranDate, TranDesc, TranType, Units,
       User1, User2, User3, User4, User5, User6, User7, User8,
       FromCpnyID, Screen, RecordID, UserAddress)
SELECT pt.Acct, GetDate(), 'A', @BaseCuryID, pt.BatNbr, pt.CpnyId,
       CASE WHEN pt.DrCr='C'            -- CrAmt
            THEN pt.TranAmt
            ELSE 0
       END,
       GETDATE(), @ProgID, @Sol_User,
       CASE WHEN pt.DrCr='C'            -- CuryCrAmt
            THEN pt.CuryTranAmt
            ELSE 0
       END,
       CASE WHEN pt.DrCr='D'            -- CuryDrAmt
            THEN pt.CuryTranAmt
            ELSE 0
       END,
       '', pt.CuryId, pt.CuryMultDiv, pt.CuryRate, '',
       CASE WHEN pt.DrCr='D'            -- DrAmt
            THEN pt.TranAmt
            ELSE 0
       END,
       pt.EmployeeID, pt.ExtRefNbr, pt.FiscYr, 0, '', 'AP', pt.Labor_Class_Cd, s.LedgerID,
       0, 0, '',
       GETDATE(), @ProgID, @Sol_User,
       'AP', 0, '', '', '', '', pt.PC_Flag, pt.PC_ID, pt.PC_Status,
       pt.PerEnt, pt.PerPost, 'U', pt.ProjectID, 0, pt.RefNbr, '', 1,
       '', '', 0, 0, 0, 0, '', '', 0, 0, '', '',
       '', pt.Sub, pt.TaskID, pt.TranDate, pt.TranDesc, pt.TranType, 0,
       '', '', 0, 0, '', '', '', '',
       b.CpnyID,b.EditScrnNbr + '00',pt.RecordID,@UserAddress
FROM	APTran pt
     INNER JOIN Account a (NOLOCK)
         ON pt.Acct = a.Acct
     INNER JOIN Batch b with (NoLock) on b.BatNbr = pt.BatNbr and b.Module = 'AP',
     GLSetup s (NOLOCK)
WHERE	pt.BatNbr = @BatNbr
AND	a.SummPost = 'N'

IF @@ERROR <> 0 GOTO ABORT

/***       2           ***/
INSERT Wrk_GLTran
       (Acct, AppliedDate, BalanceType, BaseCuryID, BatNbr, CpnyID,
       CrAmt,
       Crtd_DateTime, Crtd_Prog, Crtd_User,
       CuryCrAmt,
       CuryDrAmt,
       CuryEffDate, CuryId, CuryMultDiv, CuryRate, CuryRateType,
       DrAmt,
       EmployeeID, ExtRefNbr, FiscYr, IC_Distribution, Id, JrnlType, Labor_Class_Cd, LedgerID,
       LineId, LineNbr, LineRef,
       LUpd_DateTime, LUpd_Prog, LUpd_User,
       Module, NoteID, OrigAcct, OrigBatNbr, OrigCpnyID, OrigSub, PC_Flag, PC_ID, PC_Status,
       PerEnt, PerPost, Posted, ProjectID, Qty,
       RefNbr,
       RevEntryOption, Rlsed,
       S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
       S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12,
       ServiceDate, Sub, TaskID, TranDate, TranDesc,
       TranType,
       Units, User1, User2, User3, User4, User5, User6, User7, User8,
       FromCpnyID, Screen, RecordID, UserAddress)
SELECT pt.Acct, GetDate(), 'A', @BaseCuryID, @BatNbr, pt.CpnyId,
       SUM(CASE WHEN pt.DrCr='C'            -- CrAmt
            THEN pt.TranAmt
            ELSE 0
       END),                                            -- CrAmt
       GETDATE(), @ProgID, @Sol_User,
       SUM(CASE WHEN pt.DrCr='C'            -- CuryCrAmt
            THEN pt.CuryTranAmt
            ELSE 0
       END),
       SUM(CASE WHEN pt.DrCr='D'            -- CuryDrAmt
            THEN pt.CuryTranAmt
            ELSE 0
       END),
       '', MAX(pt.CuryId), MAX(pt.CuryMultDiv), MAX(pt.CuryRate), '',
       SUM(CASE WHEN pt.DrCr='D'            -- DrAmt
            THEN pt.TranAmt
            ELSE 0
       END),                                       -- DrAmt
       '', '', MAX(pt.FiscYr), 0, '', 'AP', '', MAX(s.LedgerID),
       0, 0, '',
       GETDATE(), @ProgID, @Sol_user,
       'AP', 0, '', '', '', '', MAX(pt.PC_Flag), MAX(pt.PC_ID), MAX(pt.PC_Status),
       MAX(pt.PerEnt), MAX(pt.PerPost), 'U', '', 0,
       CASE WHEN Count(distinct pt.RefNbr)>1
            THEN ''
            ELSE max(pt.RefNbr)
       END,
       '', 1,
       '', '', 0, 0, 0, 0, '', '', 0, 0, '', '',
       '', MAX(pt.Sub), '', MAX(pt.TranDate), 'Summary Posting',
       CASE WHEN Count(distinct pt.TranType)>1
            THEN ''
            ELSE max(pt.TranType)
       END,
       0, '', '', 0, 0, '', '', '', '',
       b.CpnyID,b.EditScrnNbr + '00',pt.RecordID,@UserAddress
FROM	APTran pt
     INNER JOIN Account a (NOLOCK)
         ON pt.Acct = a.Acct
     INNER JOIN Batch b with (NoLock) on b.BatNbr = pt.BatNbr and b.Module = 'AP',
     GLSetup s (NOLOCK)
WHERE	pt.BatNbr = @BatNbr
AND	a.SummPost='Y'
GROUP BY pt.CpnyID, pt.Acct, pt.Crtd_Prog, pt.RecordID, b.CpnyID, b.EditScrnNbr, pt.DRCR

IF @@ERROR <> 0 GOTO ABORT
    GOTO GLTRAN_Processing
END
EXEC pp_SalesTaxAPRelease @UserAddress, @ProgID, @Sol_User, @BaseDecpl, @Result OUTPUT
IF @@ERROR < > 0 GOTO ABORT
IF @Result = 0 GOTO ABORT
IF (@Debug = 1)

  BEGIN
    SELECT 'Debug...Step 300: SalesTaxApRelease', CONVERT(varchar(30), GETDATE(), 113)
     SELECT * from Wrk_SalesTax A, Wrkrelease W
        Where W.Useraddress = @useraddress AND
              W.Module = 'AP' AND
              A.Useraddress = @useraddress

     SELECT * from aptran A, Wrkrelease W
        Where W.Useraddress = @useraddress AND
              W.Module = 'AP' AND
              W.batnbr = A.BatNbr
  END

/***** Create history records from activity. *****/
INSERT HistDocSlsTax (BOCntr, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User, CuryDocTot, CuryID,
        CuryMultDiv, CuryRate, CuryTaxTot, CuryTxblTot, CustVendId, DocTot, DocType, JrnlType,
        LUpd_DateTime, LUpd_Prog, LUpd_User, RefNbr, Reported, RptBegDate, RptEndDate,
        S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06, S4Future07,
S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, TaxId, TaxTot, TxblTot,
        User1, User2, User3, User4, User5, User6, User7, User8, YrMon)
SELECT 0, d.CpnyID, GETDATE(), @ProgID, @Sol_User, d.CuryOrigDocAmt, d.CuryId, d.CuryMultDiv,
        d.CuryRate, Round(Sum(t.CuryTaxTot), c.DecPl), Round(Sum(t.CuryTxblTot), c.DecPl),
        d.VendID, d.OrigDocAmt, t.DocType, 'AP', GETDATE(), @ProgID, @Sol_User, t.RefNbr,
        0, '', '', '', '', 0, 0, 0, 0, '', '', 0, 0, '', '', t.TaxID, Round(Sum(t.TaxTot),
        @BaseDecPl), Round(Sum(t.TxblTot), @BaseDecPl), '','', 0, 0, '', '', '', '', t.YrMon
FROM APDoc d, Wrk_SalesTax t, Currncy c
WHERE t.RefNbr = d.RefNbr AND t.DocType = d.DocType AND d.CuryId = c.CuryId and t.UserAddress = @UserAddress
GROUP BY d.CpnyID, t.TaxID, t.RefNbr, t.DocType, t.YrMon, d.CuryOrigDocAmt, d.CuryId,
        d.CuryMultDiv, d.CuryRate, d.VendID, d.OrigDocAmt, c.DecPl
IF @@ERROR <> 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    SELECT 'Debug...Step 400: Create history Records', CONVERT(varchar(30), GETDATE(), 113)

  END

/***** Create history records that are missing. *****/
INSERT SlsTaxHist (CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User, LUpd_DateTime, LUpd_Prog,
        LUpd_User, NoteId, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05,
        S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12,
        TaxId, TotTaxColl, TotTaxPaid, TxblPurchTot, TxblSlsTot,
        User1, User2, User3, User4, User5, User6, User7, User8, YrMon)
SELECT t.CpnyID, GETDATE(), @ProgID, @Sol_User, GETDATE(), @ProgID, @Sol_User, 0, '', '', 0, 0, 0, 0,
        '', '', 0, 0, '', '', t.TaxId, 0, 0, 0, 0, '', '', 0, 0, '', '', '', '', t.YrMon
FROM Wrk_SalesTax t LEFT JOIN SlsTaxHist h ON  h.CpnyID = t.CpnyID AND t.TaxId = h.TaxId AND t.YrMon = h.YrMon
WHERE h.TaxId is Null  and UserAddress = @UserAddress

GROUP BY t.CpnyID, t.TaxId, t.YrMon
IF @@ERROR <> 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    SELECT 'Debug...Step 500: Insert SlsTaxHist', CONVERT(varchar(30), GETDATE(), 113)
END

/***** Update the history records with activity. *****/

UPDATE h SET
	h.LUpd_Prog = @ProgID,
	h.LUpd_User = @Sol_User,
	h.LUpd_DateTime= getdate(),
        h.TotTaxPaid = h.TotTaxPaid+ROUND(t.TotTaxPaid, @BaseDecPl),
	h.TxblPurchTot = h.TxblPurchTot+ROUND(t.TxblPurchTot, @BaseDecPl)
FROM SlsTaxHist h, vp_SumSlsTaxHist t
WHERE h.CpnyID = t.CpnyID AND h.TaxId = t.TaxId AND h.YrMon = t.YrMon and t.UserAddress = @UserAddress

IF @@ERROR <> 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    SELECT 'Debug...Step 600: update slstaxhist', CONVERT(varchar(30), GETDATE(), 113)
  END

/***** Process Main AP Release *****/

/***** adjust the first aptran detail line for any rounding errors in base currency conversion *****/
UPDATE t
   SET tranamt = tranamt + RoundDiff,
	t.LUpd_DateTime= getdate(),
	t.LUpd_Prog = @ProgID,
	t.LUpd_User = @Sol_User
  FROM aptran t ,vp_03400CuryDiffVo v
 WHERE useraddress = @UserAddress
   AND v.batnbr = t.batnbr and v.refnbr = t.refnbr
   AND v.doctype = t.trantype and v.linenbr = t.linenbr
   AND t.TranType IN ('VO', 'AD', 'AC', 'PP')

---IF @@ERROR < > 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    SELECT 'Debug...Step 700: Update Aptrans', CONVERT(varchar(30), GETDATE(), 113)
    SELECT * FROM Aptran A, WrkRelease w
    WHERE w.UserAddress = @UserAddress AND
          w.Module = 'AP' AND
          w.BatNbr = A.BatNbr
  END

IF  @POSetup = 1
BEGIN
	/**** Update PO and Receipts Qty and Cost Vouched ****/
      EXEC pp_03400_APPO_INT @UserAddress, @ProgID, @Sol_User, @Result OUTPUT
	IF @Result = 0 GOTO ABORT

	/****** Compute PPV for APTranDt Variances ****/

	EXEC pp_03400create_ppv 'PPV for APDoc#: ', @UserAddress, @ProgID , @Sol_User, @Result OUTPUT
	IF @Result = 0 GOTO ABORT

   IF (@Debug = 1)
     BEGIN
       SELECT 'Debug...Step 900: After PP_03400create_ppv', CONVERT(varchar(30), GETDATE(), 113)
       SELECT * FROM ApTran A, WrkRelease w
       WHERE w.UserAddress = @UserAddress AND
             w.Module = 'AP' AND
             w.BatNbr = A.BatNbr
  END

END

/***** Handle updates for adjustments,checks,voids... *****/
EXEC pp_03400adj @UserAddress, @ProgID, @Sol_User, @DiscTknAcct, @DiscTknSub, @BaseDecPl, @BaseCuryID, @BkupWthldAcct, @BkupWthldSub, @Result OUTPUT
IF @Result = 0 GOTO ABORT
IF (@Debug = 1)

  BEGIN
    SELECT 'Debug...Step 1000: After pp_03400adj', CONVERT(varchar(30), GETDATE(), 113)
    SELECT * FROM Apadjust A, WrkRelease w
    WHERE w.UserAddress = @UserAddress AND
          w.Module = 'AP' AND
          w.BatNbr = A.AdjBatNbr

  END

/***** APTran Records - Checks *****/

/***** Debit to AP - Hand Check *****/
INSERT Wrk_APTran (Acct, BatNbr, CpnyId, CuryId, CuryMultDiv, CuryRate,
        CuryTranAmt, DrCr, FiscYr, LineNbr,
        PerEnt, PerPost,RefNbr,
        Sub,TranAmt,
        TranDate, TranDesc, TranType, VendId,
        Crtd_Prog, Crtd_User, InstallNbr,
        LUpd_Prog, LUpd_User,MasterDocNbr,
        PmtMethod,UserAddress)
SELECT d.Acct, t.Batnbr, t.CpnyId, min(c.CuryID), min(c.CuryMultDiv), min(c.CuryRate),
        /***** Hand Check Aptrans store CURY discount in Curyunitprice and PmtAmt in Curytranamt! ******/
        /***** Hand Check Aptrans store       discount in Jobrate and PmtAmt in TranAmt ! ******/
        /***** UnitPrice is signed correctly with AC AD...                                ******/
	CASE WHEN min(adj.CuryAdjdCuryId) = c.CuryID THEN
		SUM((round(adj.CuryAdjdAmt,cur.DecPl)+round(adj.CuryAdjdDiscAmt,cur.DecPl)+round(adj.CuryAdjdBkupWthld,cur.DecPl)) * CASE WHEN adj.adjddoctype ='AD' then -1 else 1 END)
	ELSE
		SUM((round(adj.CuryAdjgAmt,cur.DecPl)+round(adj.CuryAdjgDiscAmt,cur.DecPl)+round(adj.CuryAdjgBkupWthld,cur.DecPl)) * CASE WHEN adj.adjddoctype ='AD' then -1 else 1 END)
	END,
	'D',  SUBSTRING(c.PerPost, 1, 4),
        0,
        t.PerEnt, t.PerPost, t.RefNbr, d.Sub,
	CASE WHEN min(adj.CuryAdjdCuryId) = c.CuryID THEN
		SUM((round(adj.CuryAdjgAmt,@BaseDecPl)+round(adj.CuryAdjgDiscAmt,@BaseDecPl)+round(adj.AdjBkupWthld,@BaseDecPl)-round(adj.CuryRGOLAmt,@BaseDecPl)) * CASE WHEN adj.adjddoctype ='AD' then -1 else 1 END)
	ELSE
		SUM((round(adj.AdjAmt,@BaseDecPl)+round(adj.AdjDiscAmt,@BaseDecPl)+round(adj.AdjBkupWthld,@BaseDecPl)) * CASE WHEN adj.adjddoctype ='AD' then -1 else 1 END)
	END,
	c.DocDate, substring(
		CASE @TranDescDflt
                WHEN 'I' THEN t.VendID
                WHEN 'N' THEN CASE
                        WHEN CHARINDEX('~', v.Name) > 0
                        THEN LTRIM(RTRIM(RIGHT(v.Name, LEN(v.Name) - CHARINDEX('~', v.Name)))) + ' ' + SUBSTRING(v.Name, 1, (CHARINDEX('~', v.Name) - 1))
                        ELSE v.Name
                END
                WHEN 'C' THEN RTRIM(t.VendID) + ' ' + CASE
                        WHEN CHARINDEX('~', v.Name) > 0
                        THEN LTRIM(RTRIM(RIGHT(v.Name, LEN(v.Name) - CHARINDEX('~', v.Name)))) + ' ' + SUBSTRING(v.Name, 1, (CHARINDEX('~', v.Name) - 1))

                        ELSE v.Name
                END
                ELSE t.TranDesc
        END,1,30), t.TranType, t.VendId,  MIN(c.Crtd_Prog), MIN(c.Crtd_User), 0,

        MIN(c.LUpd_Prog), MIN(c.LUpd_User), '', '',@UserAddress
FROM WrkRelease w inner loop join APTran t on t.BatNbr = w.BatNbr,
Apadjust adj,Vendor v, APDoc c, APDoc d, Currncy cur (nolock)
WHERE w.Module = 'AP' AND t.VendID = v.VendID AND t.BatNbr = c.BatNbr AND
        t.DRCR = 'S' AND adj.adjbatnbr = w.batnbr AND adj.adjdrefnbr=t.unitdesc AND adj.adjddoctype = t.costtype  AND
        t.TranType = c.DocType AND t.RefNbr = c.RefNbr  AND
	cur.CuryID = c.Curyid AND t.acct = c.acct and t.sub = c.sub and
        w.UserAddress = @UserAddress AND c.DocType NOT IN ('CK', 'QC', 'ZC', 'VC')
	AND d.refnbr = t.Unitdesc and d.DocType = t.CostType
GROUP BY d.Acct, d.Sub, t.BatNbr, t.CpnyId, c.CuryID, t.curyid, t.CuryMultDiv, t.CuryRate, t.PerEnt, t.PerPost,
        t.RefNbr, c.DocDate, t.VendID, t.TranType, v.Name, c.PerPost, t.TranDesc
IF @@ERROR <> 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    SELECT 'Debug...Step 2000: Create Wrk_APTran Debit to HC', CONVERT(varchar(30), GETDATE(), 113)
    SELECT * FROM Wrk_APTran wt, WrkRelease w
    WHERE w.UserAddress = @UserAddress AND
          w.Module = 'AP' AND
          w.Batnbr = wt.BatNbr
  END

/***** Debit to AP - Checks Only *****/
INSERT Wrk_APTran (Acct, BatNbr, CpnyId, CuryId, CuryMultDiv, CuryRate,
        CuryTranAmt, DrCr, FiscYr, LineNbr,
        PerEnt, PerPost,RefNbr,
        Sub,TranAmt,
        TranDate, TranDesc, TranType, VendId,
        Crtd_Prog, Crtd_User, InstallNbr,
        LUpd_Prog, LUpd_User,MasterDocNbr,
        PmtMethod,UserAddress)
SELECT o.Acct, b.Batnbr,  d.CpnyId, min(c.CuryID), min(c.CuryMultDiv), min(c.CuryRate),
        CASE WHEN min(adj.CuryAdjdCuryId) = min(c.CuryID) THEN
		SUM((round(adj.CuryAdjdAmt,cur.DecPl)+round(adj.CuryAdjdDiscAmt,cur.DecPl)+round(adj.CuryAdjdBkupWthld,cur.DecPl)) * CASE WHEN adj.adjddoctype ='AD' then -1 else 1 END)
	ELSE
		SUM((round(adj.CuryAdjgAmt,cur.DecPl)+round(adj.CuryAdjgDiscAmt,cur.DecPl)+round(adj.CuryAdjgBkupWthld,cur.DecPl)) * CASE WHEN adj.adjddoctype ='AD' then -1 else 1 END)
	END,
	'D',SUBSTRING(b.PerPost, 1, 4),0,
        b.PerEnt, b.PerPost,  c.CheckNbr, o.Sub,
	CASE WHEN min(adj.CuryAdjdCuryId) = min(c.CuryID) THEN
		SUM((round(adj.CuryAdjgAmt,@BaseDecPl)+round(adj.CuryAdjgDiscAmt,@BaseDecPl)+round(adj.AdjBkupWthld,@BaseDecPl)-round(adj.CuryRGOLAmt,@BaseDecPl)) * CASE WHEN adj.adjddoctype ='AD' then -1 else 1 END)
	ELSE
		SUM((round(adj.AdjAmt,@BaseDecPl)+round(adj.AdjDiscAmt,@BaseDecPl)+round(adj.AdjBkupWthld,@BaseDecPl)) * CASE WHEN adj.adjddoctype ='AD' then -1 else 1 END)
	END,

	   c.DateEnt,
	substring(
        CASE @TranDescDflt
                WHEN 'I' THEN c.VendID

                WHEN 'N' THEN CASE
                        WHEN CHARINDEX('~', v.Name) > 0
                        THEN LTRIM(RTRIM(RIGHT(v.Name, LEN(v.Name) - CHARINDEX('~', v.Name)))) + ' ' + SUBSTRING(v.Name, 1, (CHARINDEX('~', v.Name) - 1))
                        ELSE v.Name
                END
                ELSE RTRIM(c.VendID) + ' ' + CASE
                        WHEN CHARINDEX('~', v.Name) > 0

                        THEN LTRIM(RTRIM(RIGHT(v.Name, LEN(v.Name) - CHARINDEX('~', v.Name)))) + ' ' + SUBSTRING(v.Name, 1, (CHARINDEX('~', v.Name) - 1))
                        ELSE v.Name
                END
        END,1,30), c.CheckType,  c.VendId, MIN(d.Crtd_Prog),
        MIN(d.Crtd_User), o.InstallNbr, MIN(d.LUpd_Prog), MIN(d.LUpd_User), o.MasterDocNbr,
        'C',@UserAddress
FROM Batch b, WrkRelease w, Vendor v, APCheck c, APCheckDet d, Apadjust adj, APDoc o, Currncy cur
WHERE b.BatNbr = w.BatNbr AND b.BatNbr = c.BatNbr AND w.Module = 'AP' AND b.Module = 'AP' AND
        c.BatNbr = d.BatNbr AND c.CheckRefNbr = d.CheckRefNbr AND c.VendID = v.VendID AND
	adj.adjbatnbr = w.batnbr AND adj.adjdrefnbr=d.RefNbr AND adj.adjddoctype = d.DocType  AND adj.adjgrefnbr = c.CheckNbr AND
        d.RefNbr = o.RefNbr AND d.DocType = o.DocType AND cur.CuryID = c.CuryID AND w.UserAddress = @UserAddress
GROUP BY o.Acct,b.Batnbr,d.CpnyId,c.CuryMultDiv,c.CuryRate,b.PerPost,b.PerEnt,d.CuryID,c.CheckNbr,o.Sub,c.VendID,v.Name,c.CheckType,c.DateEnt,o.InstallNbr,o.MasterDocNbr
IF @@ERROR <> 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    SELECT 'Debug...Step 4000:Wrk_APTran Records Debit to System Checks', CONVERT(varchar(30), GETDATE(), 113)
    SELECT * FROM Wrk_APTran wt, WrkRelease w
    WHERE w.UserAddress = @UserAddress AND
	    wt.UserAddress = @UserAddress AND
          w.Module = 'AP' AND
          w.Batnbr = wt.BatNbr
  END

  
/***** Update APDoc Document Type for Temporary Holding Checks  *****/
UPDATE d  SET PerEnt = b.PerEnt, PerPost = b.PerPost, DocType = c.CheckType, d.LUpd_DateTime= getdate(), d.LUpd_Prog = @ProgID, d.LUpd_User = @Sol_User
FROM WrkRelease w inner loop join   APDoc d on d.BatNbr = w.BatNbr, Batch b, APCheck c
WHERE b.BatNbr = d.BatNbr AND b.Module = 'AP' AND
        w.Module = 'AP' AND w.UserAddress = @UserAddress AND
        d.DocType = 'VC' AND d.Status = 'T' AND d.BatNbr = c.BatNbr AND
        d.RefNbr = c.CheckNbr
IF @@ERROR <> 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    SELECT 'Debug...Step 4001: update Apdocs', CONVERT(varchar(30), GETDATE(), 113)
    SELECT * FROM Apdoc A, WrkRelease w
    WHERE w.UserAddress = @UserAddress AND
          w.Module = 'AP' AND
          w.BatNbr = A.BatNbr

    IF @EditScrnNbr = '03620'
	BEGIN
    	SELECT 'Debug...Step 4002: Display system check records', CONVERT(varchar(30), GETDATE(), 113)
    	SELECT * FROM APCheck A, WrkRelease w
    	WHERE w.UserAddress = @UserAddress AND
          w.Module = 'AP' AND
          w.BatNbr = A.BatNbr

   	SELECT 'Debug...Step 4003: Display system check detail records', CONVERT(varchar(30), GETDATE(), 113)
    	SELECT * FROM APCheckdet A, WrkRelease w
    	WHERE w.UserAddress = @UserAddress AND
          w.Module = 'AP' AND
          w.BatNbr = A.BatNbr

	SELECT 'Debug...Step 4004: Display documents being paid with system check detail records', CONVERT(varchar(30), GETDATE(), 113)
    	SELECT APDoc.* FROM APDoc, APCheckdet A, WrkRelease w
    	WHERE w.UserAddress = @UserAddress AND
          w.Module = 'AP' AND
          w.BatNbr = A.BatNbr AND
	  APDoc.doctype = A.doctype AND
	  APDoc.refnbr = A.refnbr
    END

  END

/***** Update Quick Check to Regular Checks *****/
UPDATE APDoc Set DocType = 'CK', LUpd_Datetime = GETDATE(), LUpd_Prog = @ProgID, LUpd_User = @Sol_User
FROM APDoc, WrkRelease w
WHERE APDoc.BatNbr = w.BatNbr AND w.Module = 'AP' AND w.UserAddress = @UserAddress AND APDoc.DocType = 'QC'
IF @@ERROR < > 0 GOTO ABORT


/***** Update and remaining Void Checks in this batch to Stub Checks *****/
UPDATE APDoc
	set APDoc.doctype = 'SC',
		APDoc.PerClosed = Batch.PerEnt,
		APDoc.PerEnt= Batch.PerEnt,
		APDoc.PerPost= Batch.PerPost,
		APDoc.Rlsed = 1,
		APDoc.Status = 'C',
		APDoc.ClearDate = APDoc.DocDate,
		APDoc.LUpd_Datetime = GETDATE(),
		APDoc.LUpd_Prog = @ProgID,
		APDoc.LUpd_User = @Sol_User
	from APDoc, Batch, WrkRelease
	where Batch.BatNbr = WrkRelease.BatNbr AND Batch.Module = WrkRelease.Module AND WrkRelease.UserAddress = @UserAddress AND
	Batch.EditScrnNbr in ('03030', '03620') AND APDoc.Batnbr = Batch.BatNbr and APDoc.doctype = 'VC' and APDoc.rlsed = 0

IF @@ERROR < > 0 GOTO ABORT

/***** Credit Discounts *****/
INSERT APTran (Acct, AcctDist, Applied_PPrefNbr, BatNbr, BoxNbr, CostType, CpnyId, CuryId, CuryMultDiv, CuryRate,
	CuryTaxAmt00, CuryTaxAmt01, CuryTaxAmt02, CuryTaxAmt03, CuryTranAmt, CuryTxblAmt00,
	CuryTxblAmt01, CuryTxblAmt02, CuryTxblAmt03, CuryUnitPrice, DrCr, Employee,
	EmployeeID, Excpt, ExtRefNbr, FiscYr, JobRate, JrnlType, Labor_Class_Cd, LineId,
	LineNbr, NoteID, PC_Flag, PC_ID, PC_Status, PerEnt, PerPost, ProjectID, Qty, RefNbr,
	Rlsed, Sub, TaskID, TaxAmt00, TaxAmt01, TaxAmt02, TaxAmt03, TaxCalced,
	TaxCat, TaxId00, TaxId01, TaxId02, TaxId03, TaxIdDflt, TranAmt, TranClass,
	TrANDate, TrANDesc, TranType, TxblAmt00, TxblAmt01, TxblAmt02, TxblAmt03, UnitDesc,
	UnitPrice, User1, User2, User3, User4, VendId,
        Component, CostTypeWo, Crtd_DateTime, Crtd_Prog, Crtd_User, installNbr, InvcTypeID,
        Lineref, LineType, LUpd_dateTime, LUpd_prog, LUpd_User, MasterDocNbr,
        PmtMethod, POLineRef, RcptNbr,
        S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
        S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ServiceDate,
        User5, User6, User7, User8,
	AlternateID, BOMLineRef, CuryPOExtPrice, CuryPOUnitPrice, CuryPPV, InvtID, POExtPrice,
	PONbr, POQty, POUnitPrice, PPV, QtyVar, RcptLineRef, RcptQty,
	SiteId, SoLineRef, SOOrdNbr, SOTypeID, WONbr, WOStepNbr)

SELECT  @DiscTknAcct, 1, '',c.Batnbr, '', '', c.CpnyId, MIN(c.CuryID),
        MIN(c.CuryMultDiv), MIN(c.CuryRate), 0, 0, 0, 0,
	CASE WHEN MIN(adj.CuryAdjdCuryId) = MIN(C.Curyid) THEN
		Sum(adj.curyadjDdiscamt * CASE WHEN adj.AdjdDocType = 'AD' then -1 ELSE 1 END)
	ELSE
		Sum(adj.curyadjgdiscamt * CASE WHEN adj.AdjdDocType = 'AD' then -1 ELSE 1 END)
	END, 0, 0, 0, 0, 0,
        'C', '', '', 0, '', MIN(SUBSTRING(c.PerPost, 1, 4)), 0, 'AP', '', 0, 32766, 0,
	'', '', '', MIN(c.PerEnt), MIN(c.PerPost), '', 0, MIN(c.RefNbr), 0,
        @DiscTknSub , '', 0, 0, 0, 0,
	'', '', '', '', '', '', '',
	CASE WHEN MIN(adj.CuryAdjdCuryId) = MIN(C.Curyid) THEN
		Sum(adj.curyadjgdiscamt * CASE WHEN adj.AdjdDocType = 'AD' then -1 ELSE 1 END)
	ELSE
		Sum(adj.adjdiscamt * CASE WHEN adj.AdjdDocType = 'AD' then -1 ELSE 1 END)
	END,
	'', MIN(c.DocDate),
	'Discount Taken ' + c.VendID, 'DT', 0, 0, 0, 0, '', 0, '', '', 0, 0, MIN(c.VendId),
        '', '', GETDATE(), @ProgID, @Sol_user, 0, '', '', '',
        GETDATE(), @ProgID, @Sol_user, '', '', '', '', '', '',
        0, 0, 0, 0, '', '', 0, 0, '', '', '', '', '', '', '',
	'','',0,0,0,'',0,'',0,0,0,0,'',0,'','','','','',''
FROM WrkRelease w, Vendor v, APDoc c, Apadjust adj---, aptran t
WHERE adj.adjBatNbr = w.BatNbr AND w.Module = 'AP' AND
	c.BatNbr = adj.adjBatNbr AND c.RefNbr = adj.AdjgRefNbr AND
	c.acct = adj.adjgacct and c.sub = adj.adjgsub and
	c.VendID = v.VendID AND w.UserAddress = @UserAddress AND
	c.DocType NOT IN ('CK', 'QC', 'ZC', 'VC')

GROUP BY c.BatNbr, c.VendID, v.Name, c.CpnyId
HAVING SUM(adj.curyadjddiscamt) <> 0

IF @@ERROR < > 0 GOTO ABORT

/***** Backup Withholding *****/
INSERT APTran (Acct, AcctDist, Applied_PPrefNbr, BatNbr, BoxNbr, CostType, CpnyId, CuryId, CuryMultDiv, CuryRate,
	CuryTaxAmt00, CuryTaxAmt01, CuryTaxAmt02, CuryTaxAmt03, CuryTranAmt, CuryTxblAmt00,
	CuryTxblAmt01, CuryTxblAmt02, CuryTxblAmt03, CuryUnitPrice, DrCr, Employee,
	EmployeeID, Excpt, ExtRefNbr, FiscYr, JobRate, JrnlType, Labor_Class_Cd, LineId,
	LineNbr, NoteID, PC_Flag, PC_ID, PC_Status, PerEnt, PerPost, ProjectID, Qty, RefNbr,
	Rlsed, Sub, TaskID, TaxAmt00, TaxAmt01, TaxAmt02, TaxAmt03, TaxCalced,
	TaxCat, TaxId00, TaxId01, TaxId02, TaxId03, TaxIdDflt, TranAmt, TranClass,
	TrANDate, TrANDesc, TranType, TxblAmt00, TxblAmt01, TxblAmt02, TxblAmt03, UnitDesc,
	UnitPrice, User1, User2, User3, User4, VendId,
        Component, CostTypeWo, Crtd_DateTime, Crtd_Prog, Crtd_User, installNbr, InvcTypeID,
        Lineref, LineType, LUpd_dateTime, LUpd_prog, LUpd_User, MasterDocNbr,
        PmtMethod, POLineRef, RcptNbr,
        S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
        S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ServiceDate,
        User5, User6, User7, User8,
	AlternateID, BOMLineRef, CuryPOExtPrice, CuryPOUnitPrice, CuryPPV, InvtID, POExtPrice,
	PONbr, POQty, POUnitPrice, PPV, QtyVar, RcptLineRef, RcptQty,
	SiteId, SoLineRef, SOOrdNbr, SOTypeID, WONbr, WOStepNbr)

SELECT  @BkupWthldAcct, 1, '', c.Batnbr, '4', '', c.CpnyId, MIN(c.CuryID),
        MIN(c.CuryMultDiv), MIN(c.CuryRate), 0, 0, 0, 0,
	CASE WHEN MIN(adj.CuryAdjdCuryId) = MIN(C.Curyid) THEN
		Sum(adj.CuryAdjdBkupWthld * CASE WHEN adj.AdjdDocType = 'AD' then -1 ELSE 1 END)
	ELSE
		Sum(adj.CuryAdjgBkupWthld * CASE WHEN adj.AdjdDocType = 'AD' then -1 ELSE 1 END)
	END, 0, 0, 0, 0, 0,
        'C', '', '', 0, '', MIN(SUBSTRING(c.PerPost, 1, 4)), 0, 'AP', '', 0, -32766, 0,
	'', '', '', MIN(c.PerEnt), MIN(c.PerPost), '', 0, MIN(c.RefNbr), 0,
        @BkupWthldSub , '', 0, 0, 0, 0,
	'', '', '', '', '', '', '',
		Sum(adj.AdjBkupWthld * CASE WHEN adj.AdjdDocType = 'AD' then -1 ELSE 1 END),
	'', MIN(c.DocDate),
	'Backup Withholding ' + c.VendID, 'BW', 0, 0, 0, 0, '', 0, '', '', 0, 0, MIN(c.VendId),
        '', '', GETDATE(), @ProgID, @Sol_user, 0, '', '', '',
        GETDATE(), @ProgID, @Sol_user, '', '', '', '', '', '',
        0, 0, 0, 0, '', '', 0, 0, '', '', '', '', '', '', '',
	'','',0,0,0,'',0,'',0,0,0,0,'',0,'','','','','',''
FROM WrkRelease w, Vendor v, APDoc c, Apadjust adj---, aptran t
WHERE adj.adjBatNbr = w.BatNbr AND w.Module = 'AP' AND
	c.BatNbr = adj.adjBatNbr AND c.RefNbr = adj.AdjgRefNbr AND
	c.acct = adj.adjgacct and c.sub = adj.adjgsub and
	c.VendID = v.VendID AND w.UserAddress = @UserAddress AND
	c.DocType NOT IN ('CK', 'QC', 'ZC', 'VC')

GROUP BY c.BatNbr, c.VendID, v.Name, c.CpnyId
HAVING SUM(adj.CuryAdjdBkupWthld) <> 0

IF @@ERROR < > 0 GOTO ABORT



/***** Credit Discounts (Checks Only) no VM *****/
INSERT APTran (Acct, AcctDist, Applied_PPrefNbr, BatNbr, BoxNbr, CostType, CpnyId, CuryId, CuryMultDiv, CuryRate,
	CuryTaxAmt00, CuryTaxAmt01, CuryTaxAmt02, CuryTaxAmt03, CuryTranAmt, CuryTxblAmt00,
	CuryTxblAmt01, CuryTxblAmt02, CuryTxblAmt03, CuryUnitPrice, DrCr, Employee,
	EmployeeID, Excpt, ExtRefNbr, FiscYr, JobRate, JrnlType, Labor_Class_Cd, LineId,
	LineNbr, NoteID, PC_Flag, PC_ID, PC_Status, PerEnt, PerPost, ProjectID, Qty, RefNbr,
	Rlsed, Sub, TaskID, TaxAmt00, TaxAmt01, TaxAmt02, TaxAmt03, TaxCalced,
	TaxCat, TaxId00, TaxId01, TaxId02, TaxId03, TaxIdDflt, TranAmt, TranClass,
	TrANDate, TrANDesc, TranType, TxblAmt00, TxblAmt01, TxblAmt02, TxblAmt03, UnitDesc,
	UnitPrice, User1, User2, User3, User4, VendId,
        Component, CostTypeWo, Crtd_DateTime, Crtd_Prog, Crtd_User, installNbr, InvcTypeID,
        Lineref, LineType, LUpd_dateTime, LUpd_prog, LUpd_User, MasterDocNbr,
        PmtMethod, POLineRef, RcptNbr,
        S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
        S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ServiceDate,
        User5, User6, User7, User8,
	AlternateID, BOMLineRef, CuryPOExtPrice, CuryPOUnitPrice, CuryPPV, InvtID, POExtPrice,
	PONbr, POQty, POUnitPrice, PPV, QtyVar, RcptLineRef, RcptQty,
	SiteId, SoLineRef, SOOrdNbr, SOTypeID, WONbr, WOStepNbr)

SELECT  @DiscTknAcct, 1, '', adj.AdjBatnbr, '', '', d.CpnyId, d.CuryID,
	d.CuryMultDiv, d.CuryRate, 0, 0, 0, 0,
	CASE WHEN (adj.CuryAdjdCuryId) = (C.Curyid) THEN
		(adj.curyadjDdiscamt * CASE WHEN adj.AdjdDocType = 'AD' then -1 ELSE 1 END)
	ELSE
		(adj.curyadjgdiscamt * CASE WHEN adj.AdjdDocType = 'AD' then -1 ELSE 1 END)
	END,
	0, 0, 0, 0, 0,
	'C', '', '', 0, '', (SUBSTRING(d.PerPost, 1, 4)), 0, 'AP', '', 0, 32766, 0,
	'', '', '', d.PerEnt, d.PerPost, '', 0, c.CheckNbr, 0, @DiscTknSub , '', 0, 0, 0, 0,
	'', '', '', '', '', '', '',
	CASE WHEN (adj.CuryAdjdCuryId) = (C.Curyid) THEN
		(adj.curyadjgdiscamt * CASE WHEN adj.AdjdDocType = 'AD' then -1 ELSE 1 END)
	ELSE
		(adj.adjdiscamt * CASE WHEN adj.AdjdDocType = 'AD' then -1 ELSE 1 END)
	END,
 	'', d.DocDate,
	'Discount Taken ' + adj.VendID, 'DT', 0, 0, 0, 0, '', 0, '', '', 0, 0, adj.VendId,
        '', '', GETDATE(), @ProgID, @Sol_User, 0, '', '', '',
        GETDATE(), @ProgID, @Sol_User, '', '', '', '', '', '', 0, 0, 0, 0, '', '', 0, 0, '', '', '', '', '', '', '',
	'','',0,0,0,'',0,'',0,0,0,0,'',0,'','','','','',''
FROM WrkRelease w, Vendor v, APDoc d, APCheck c, apadjust adj
WHERE d.BatNbr = w.BatNbr AND w.Module = 'AP' AND d.VendID = v.VendID AND
	c.CheckNbr = d.RefNbr AND c.S4Future02 <> 'VM' AND adj.adjbatnbr = c.batnbr and adj.adjgrefnbr = c.checknbr and
	w.UserAddress = @UserAddress AND d.DiscTkn <> 0 AND d.DocType IN ('CK', 'QC', 'ZC')
	IF @@ERROR < > 0 GOTO ABORT

/*-----------------Backup Withholding No VM------------------------*/
		INSERT APTran (Acct, AcctDist,  AlternateID, Applied_PPrefNbr, BatNbr, BOMLineRef, BoxNbr, Component,
			CostType, CostTypeWO, CpnyId, Crtd_DateTime, Crtd_Prog, Crtd_User, CuryId,
			CuryMultDiv, CuryPOExtPrice, CuryPOUnitPrice, CuryPPV, CuryRate, CuryTaxAmt00, CuryTaxAmt01,
			CuryTaxAmt02, CuryTaxAmt03, CuryTranAmt, CuryTxblAmt00, CuryTxblAmt01, CuryTxblAmt02, CuryTxblAmt03,
			CuryUnitPrice, DrCr, Employee, EmployeeId, Excpt, ExtRefNbr, FiscYr,
			InstallNbr, InvcTypeId, InvtID, JobRate, JrnlType, Labor_Class_Cd, LineId,
			LineNbr, LineRef, LineType, Lupd_DateTime, Lupd_Prog, Lupd_user, MasterDocNbr,
			NoteId, PC_Flag, PC_Id, PC_Status, PerEnt, PerPost, PmtMethod,
			POExtPrice, POLineRef, PONbr, POQty, POUnitPrice, PPV, ProjectId,
			Qty, QtyVar, RcptLineRef, RcptNbr, RcptQty, RefNbr, Rlsed,
			S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06, S4Future07,
			S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ServiceDate, SiteId,
			SoLineRef, SOOrdNbr, SOTypeID, Sub, TaskId, TaxAmt00, TaxAmt01,
			TaxAmt02, TaxAmt03, TaxCalced, TaxCat, TaxId00, TaxId01, TaxId02,
			TaxId03, TaxIdDflt, TranAmt, TranClass, TranDate, TranDesc, TranType,
			TxblAmt00, TxblAmt01, TxblAmt02, TxblAmt03, UnitDesc, UnitPrice, User1,
			User2, User3, User4, User5, User6, User7, User8,
			VendId, WONbr, WOStepNbr)
		SELECT @BkupWthldAcct, 0 ,'', '', adj.AdjBatNbr, '', '4', '', '',
			'', d.CpnyID, GETDATE(), '03400', @Sol_User, d.CuryId, d.CuryMultDiv, 0,
			0, 0, d.CuryRate, 0, 0, 0, 0,
		CASE WHEN (adj.CuryAdjdCuryId) = (d.Curyid) THEN
		(adj.CuryAdjdBkupWthld * CASE WHEN adj.AdjdDocType = 'AD' then -1 ELSE 1 END)
		ELSE
		(adj.CuryAdjgBkupWthld * CASE WHEN adj.AdjdDocType = 'AD' then -1 ELSE 1 END)
		END
		
			, 0, 0, 0, 0, 0, 'C',
			'', '', 0, '', (SUBSTRING(d.PerPost, 1, 4)), 0, '',
			'', 0, 'AP', '', 0, -32766,'',
			'', GETDATE(), '03400', @Sol_User, '', 0, '',
			'', '', d.PerEnt, d.PerPost, '', 0, '',
			'', 0, 0, 0, '', 0, 0,
			'', '', 0, d.RefNbr, 0, '', '', 0, 0, 0, 0, '', '', 0, 0, '', '',
			'', '', '', '',
			'', @BkupWthldSub, '', 0, 0, 0, 0,
			'', '', '', '', '', '', '',
			CASE WHEN (adj.CuryAdjdCuryId) = (d.Curyid) THEN
			(adj.CuryAdjgBkupWthld * CASE WHEN adj.AdjdDocType = 'AD' then -1 ELSE 1 END)
			ELSE
			(adj.AdjBkupWthld * CASE WHEN adj.AdjdDocType = 'AD' then -1 ELSE 1 END)
		END, 

			'', d.DocDate,
			'Backup Withholding ' + d.VendId, 'BW', --'test', 'bw',
			0, 0, 0, 0, '', 0, '',
			'', 0, 0, '', '', '','',
			adj.VendId, '', ''
			
			from WrkRelease w , Vendor v, APDoc d, APAdjust adj, APCheck c
			WHERE d.BatNbr = w.BatNbr AND w.Module = 'AP' AND d.VendID = v.VendID AND
			c.CheckNbr = d.RefNbr AND adj.adjbatnbr = c.batnbr and adj.adjgrefnbr = d.RefNbr and
			w.UserAddress = @UserAddress AND c.S4Future02 <> 'VM' AND d.BWAmt <> 0 AND d.DocType IN ('CK', 'QC', 'ZC')
	IF @@ERROR < > 0 GOTO ABORT
/*-----------------Backup Withholding No VM------------------------*/

/***** Credit Discounts (Checks Only) with VM *****/
INSERT APTran (Acct, AcctDist,  Applied_PPrefNbr, BatNbr, BoxNbr, CostType, CpnyId, CuryId, CuryMultDiv, CuryRate,
	CuryTaxAmt00, CuryTaxAmt01, CuryTaxAmt02, CuryTaxAmt03, CuryTranAmt, CuryTxblAmt00,
	CuryTxblAmt01, CuryTxblAmt02, CuryTxblAmt03, CuryUnitPrice, DrCr, Employee,
	EmployeeID, Excpt, ExtRefNbr, FiscYr, JobRate, JrnlType, Labor_Class_Cd, LineId,
	LineNbr, NoteID, PC_Flag, PC_ID, PC_Status, PerEnt, PerPost, ProjectID, Qty, RefNbr,
	Rlsed, Sub, TaskID, TaxAmt00, TaxAmt01, TaxAmt02, TaxAmt03, TaxCalced,
	TaxCat, TaxId00, TaxId01, TaxId02, TaxId03, TaxIdDflt, TranAmt, TranClass,
	TrANDate, TrANDesc, TranType, TxblAmt00, TxblAmt01, TxblAmt02, TxblAmt03, UnitDesc,
	UnitPrice, User1, User2, User3, User4, VendId,
        Component, CostTypeWo, Crtd_DateTime, Crtd_Prog, Crtd_User, installNbr, InvcTypeID,
        Lineref, LineType, LUpd_dateTime, LUpd_prog, LUpd_User, MasterDocNbr,
        PmtMethod, POLineRef, RcptNbr,
        S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
        S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ServiceDate,
        User5, User6, User7, User8,
	AlternateID, BOMLineRef, CuryPOExtPrice, CuryPOUnitPrice, CuryPPV, InvtID, POExtPrice,
	PONbr, POQty, POUnitPrice, PPV, QtyVar, RcptLineRef, RcptQty,
	SiteId, SoLineRef, SOOrdNbr, SOTypeID, WONbr, WOStepNbr)

SELECT  @DiscTknAcct, 1, '', d.Batnbr, '', '', t.CpnyId, d.CuryID,
	d.CuryMultDiv, d.CuryRate, 0, 0, 0, 0, t.CuryDiscAmt, 0, 0, 0, 0, 0,
	'C', '', '', 0, '', (SUBSTRING(d.PerPost, 1, 4)), 0, 'AP', '', 0, 32766, 0,
	'', '', '', d.PerEnt, d.PerPost, '', 0, d.RefNbr, 0, @DiscTknSub , '', 0, 0, 0, 0,
	'', '', '', '', '', '', '',
	t.DiscAmt,
	'', d.DocDate,
	'Discount Taken ' + d.VendID, 'DT', 0, 0, 0, 0, '', 0, '', '', 0, 0, d.VendId,
        '', '', GETDATE(), @ProgID, @Sol_User, 0, '', '', '',
        GETDATE(), @ProgID, @Sol_User, '', '', '', '', '', '', 0, 0, 0, 0, '', '', 0, 0, '', '', '', '', '', '', '',
	'','',0,0,0,'',0,'',0,0,0,0,'',0,'','','','','',''
FROM WrkRelease w, Vendor v, APDoc d, APCheck c, APCheckDet t
WHERE d.BatNbr = w.BatNbr AND w.Module = 'AP' AND d.VendID = v.VendID AND
	c.CheckNbr = d.RefNbr AND c.S4Future02 = 'VM' AND
	t.CheckRefNbr = c.CheckRefNbr AND
	w.UserAddress = @UserAddress AND t.DiscAmt <> 0 AND d.DocType IN ('CK', 'QC', 'ZC')

IF @@ERROR < > 0 GOTO ABORT

/***** Backup Withholding with VM *****/
INSERT APTran (Acct, AcctDist,  Applied_PPrefNbr, BatNbr, BoxNbr, CostType, CpnyId, CuryId, CuryMultDiv, CuryRate,
	CuryTaxAmt00, CuryTaxAmt01, CuryTaxAmt02, CuryTaxAmt03, CuryTranAmt, CuryTxblAmt00,
	CuryTxblAmt01, CuryTxblAmt02, CuryTxblAmt03, CuryUnitPrice, DrCr, Employee,
	EmployeeID, Excpt, ExtRefNbr, FiscYr, JobRate, JrnlType, Labor_Class_Cd, LineId,
	LineNbr, NoteID, PC_Flag, PC_ID, PC_Status, PerEnt, PerPost, ProjectID, Qty, RefNbr,
	Rlsed, Sub, TaskID, TaxAmt00, TaxAmt01, TaxAmt02, TaxAmt03, TaxCalced,
	TaxCat, TaxId00, TaxId01, TaxId02, TaxId03, TaxIdDflt, TranAmt, TranClass,
	TrANDate, TrANDesc, TranType, TxblAmt00, TxblAmt01, TxblAmt02, TxblAmt03, UnitDesc,
	UnitPrice, User1, User2, User3, User4, VendId,
        Component, CostTypeWo, Crtd_DateTime, Crtd_Prog, Crtd_User, installNbr, InvcTypeID,
        Lineref, LineType, LUpd_dateTime, LUpd_prog, LUpd_User, MasterDocNbr,
        PmtMethod, POLineRef, RcptNbr,
        S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
        S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ServiceDate,
        User5, User6, User7, User8,
	AlternateID, BOMLineRef, CuryPOExtPrice, CuryPOUnitPrice, CuryPPV, InvtID, POExtPrice,
	PONbr, POQty, POUnitPrice, PPV, QtyVar, RcptLineRef, RcptQty,
	SiteId, SoLineRef, SOOrdNbr, SOTypeID, WONbr, WOStepNbr)

SELECT  @BkupWthldAcct, 1, '', d.Batnbr, '4', '', t.CpnyId, d.CuryID,
	d.CuryMultDiv, d.CuryRate, 0, 0, 0, 0, t.CuryBWAmt, 0, 0, 0, 0, 0,
	'C', '', '', 0, '', (SUBSTRING(d.PerPost, 1, 4)), 0, 'AP', '', 0, -32766, 0,
	'', '', '', d.PerEnt, d.PerPost, '', 0, d.RefNbr, 0, @BkupWthldSub , '', 0, 0, 0, 0,
	'', '', '', '', '', '', '',
	t.BWAmt,
	'', d.DocDate,
	'Backup Withholding' + d.VendID, 'BW', 0, 0, 0, 0, '', 0, '', '', 0, 0, d.VendId,
        '', '', GETDATE(), @ProgID, @Sol_User, 0, '', '', '',
        GETDATE(), @ProgID, @Sol_User, '', '', '', '', '', '', 0, 0, 0, 0, '', '', 0, 0, '', '', '', '', '', '', '',
	'','',0,0,0,'',0,'',0,0,0,0,'',0,'','','','','',''
FROM WrkRelease w, Vendor v, APDoc d, APCheck c, APCheckDet t
WHERE d.BatNbr = w.BatNbr AND w.Module = 'AP' AND d.VendID = v.VendID AND
	c.CheckNbr = d.RefNbr AND c.S4Future02 = 'VM' AND
	t.CheckRefNbr = c.CheckRefNbr AND
	w.UserAddress = @UserAddress AND t.BWAmt <> 0 AND d.DocType IN ('CK', 'QC', 'ZC')

IF @@ERROR < > 0 GOTO ABORT

/***** Move temporary APTrans to APTran table *****/
INSERT APTran (Acct,AcctDist,  Applied_PPrefNbr, BatNbr, BoxNbr, CostType, CpnyId, CuryId, CuryMultDiv, CuryRate,
        CuryTaxAmt00, CuryTaxAmt01, CuryTaxAmt02, CuryTaxAmt03, CuryTranAmt, CuryTxblAmt00,
        CuryTxblAmt01, CuryTxblAmt02, CuryTxblAmt03, CuryUnitPrice, DrCr, Employee,
        EmployeeID, Excpt, ExtRefNbr, FiscYr, JobRate, JrnlType, Labor_Class_Cd, LineId,
        LineNbr, NoteID, PC_Flag, PC_ID, PC_Status, PerEnt, PerPost, ProjectID, Qty, RefNbr,
        Rlsed,  Sub, TaskID, TaxAmt00, TaxAmt01, TaxAmt02, TaxAmt03, TaxCalced,
        TaxCat, TaxId00, TaxId01, TaxId02, TaxId03, TaxIdDflt, TranAmt, TranClass,
        TrANDate, TrANDesc, TranType, TxblAmt00, TxblAmt01, TxblAmt02, TxblAmt03, UnitDesc,
        UnitPrice, User1, User2, User3, User4, VendId,
        Component, CostTypeWo, Crtd_DateTime, Crtd_Prog, Crtd_User, installNbr, InvcTypeID,
        Lineref, LineType, LUpd_dateTime, LUpd_prog, LUpd_User, MasterDocNbr,
        PmtMethod, POLineRef, RcptNbr,
        S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
        S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ServiceDate,
        User5, User6, User7, User8,
	AlternateID, BOMLineRef, CuryPOExtPrice, CuryPOUnitPrice, CuryPPV, InvtID, POExtPrice,
	PONbr, POQty, POUnitPrice, PPV, QtyVar, RcptLineRef, RcptQty,
	SiteId, SoLineRef, SOOrdNbr, SOTypeID, WONbr, WOStepNbr)
	SELECT Acct, 1, '',BatNbr, '','', CpnyId, CuryId, CuryMultDiv, CuryRate,
        0,0,0,0, CuryTranAmt, 0,0,0,0,0, DrCr,'',
        '', 0, '', FiscYr, 0,'AP','',0,Linenbr,
        0,'','','', PerEnt, PerPost, '', 0, RefNbr,
        0,  Sub, '', 0,0,0,0, '',
        '','','','','','', TranAmt, '',

        TrANDate, TrANDesc, TranType, 0,0,0,0,'',

        0,'','',0,0, VendId,
        '', '', getdate(), @ProgID, @Sol_User, installNbr, '',
        '','', getdate(), @ProgID, @Sol_User, MasterDocNbr,
        PmtMethod, '','',
        '','',0,0,0,0,
        '','',0,0,'','', '',
        '','','','',
	'','',0,0,0,'',0,'',0,0,0,0,'',0,'','','','','',''

FROM Wrk_APTran where UserAddress = @UserAddress
IF @@ERROR <> 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    SELECT 'Debug...Step 5000: Create APTran Records From Wrk_Aptran', CONVERT(varchar(30), GETDATE(), 113)
    SELECT * FROM APTran t, WrkRelease w
    WHERE w.UserAddress = @UserAddress AND
          w.module = 'AP' AND
          w.Batnbr = t.BatNbr
 END

UPDATE APTran SET LUpd_Prog = @ProgID, LUpd_User = @Sol_User, LUpd_DateTime = getdate(),
	LineNbr = t.recordid + 9999 -
        (SELECT MAX(p.recordid) FROM APTran p
                WHERE p.Acct = t.Acct AND p.Sub = t.Sub AND p.RefNbr = t.RefNbr AND
                        p.VendID = t.VendID AND p.TranType = t.TranType)

        FROM APTran t,Wrkrelease w
        where  t.batnbr = w.batnbr
          and w.useraddress = @useraddress
          and t.linenbr = 0

IF @@ERROR <> 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    SELECT 'Debug...Step 6000: Update APTran linenbr', CONVERT(varchar(30), GETDATE(), 113)
    SELECT * FROM APTran A, WrkRelease w
    WHERE w.UserAddress = @UserAddress AND
          w.module = 'AP' AND
          w.Batnbr = A.batnbr
 END

/***** Offsetting AP Entry - Vouchers AND Adjustments ********/
/***** Screen 03010, 03020 *****/
INSERT APTran (Acct, AcctDist,  Applied_PPrefNbr, BatNbr, BoxNbr, Component, CostType, CostTypeWO, CpnyId,
        Crtd_DateTime, Crtd_Prog, Crtd_User, CuryId, CuryMultDiv, CuryRate,
        CuryTaxAmt00, CuryTaxAmt01, CuryTaxAmt02, CuryTaxAmt03, CuryTranAmt, CuryTxblAmt00,
        CuryTxblAmt01, CuryTxblAmt02, CuryTxblAmt03, CuryUnitPrice, DrCr, Employee,
        EmployeeID, Excpt, ExtRefNbr, FiscYr, InstallNbr, InvcTypeId,
        JobRate, JrnlType, Labor_Class_Cd, LineId, LineNbr,
        LineRef, LineType, LUpd_dateTime, LUpd_Prog, LUpd_User, MasterDocNbr,

        NoteID, PC_Flag, PC_ID, PC_Status, PerEnt, PerPost, PmtMethod, POLineRef,
        ProjectID, Qty, Rcptnbr, RefNbr,        Rlsed,
        S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
        S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ServiceDate,
        Sub, TaskID, TaxAmt00, TaxAmt01, TaxAmt02, TaxAmt03, TaxCalced,
        TaxCat, TaxId00, TaxId01, TaxId02, TaxId03, TaxIdDflt, TranAmt, TranClass,
        TrANDate, TrANDesc, TranType, TxblAmt00, TxblAmt01, TxblAmt02, TxblAmt03, UnitDesc,
        UnitPrice, User1, User2, User3, User4, User5, User6, User7, User8, VendId,
	AlternateID, BOMLineRef, CuryPOExtPrice, CuryPOUnitPrice, CuryPPV, InvtID, POExtPrice,
	PONbr, POQty, POUnitPrice, PPV, QtyVar, RcptLineRef, RcptQty,
	SiteId, SoLineRef, SOOrdNbr, SOTypeID, WONbr, WOStepNbr)

SELECT d.Acct , 1, CASE WHEN (ISNULL(p.PrePay_RefNbr,' ') = ' ') then '' else p.PrePay_RefNbr end, d.BatNbr, '', '', '', '', d.CpnyId, GETDATE(), @ProgID, @Sol_User, d.CuryId, d.CuryMultDiv,
        d.CuryRate, 0, 0, 0, 0, d.CuryDocBal, 0, 0, 0, 0, 0,
        CASE WHEN d.DocType IN ('VO', 'AC', 'PP') THEN 'C'
             WHEN d.s4Future11 = 'VM' THEN 'C'
                ELSE 'D' END, '',
        '', 0, d.InvcNbr, SUBSTRING(d.PerPost, 1, 4), d.installnbr, '',

        0, 'AP', '', 0, 32767, '', '', GETDATE(), @ProgID, @Sol_User, d.MasterDocNbr,
        0, '', '', '', d.PerEnt, d.PerPost, '', '', '', 0, '', d.RefNbr, 0, '', '', 0, 0, 0, 0,
        '', '', 0, 0,
        Case d.s4Future11
                When 'VM' Then d.s4Future11
                        Else ''
                End,
        Case d.s4Future11
                When 'VM' Then d.s4future12
                Else ''
                End,

         '', d.Sub , '', 0, 0, 0, 0, '', '', '', '', '', '', '',
	---d.OrigDocAmt,
	d.DocBal,
	   '', d.DocDate,
	substring(
        CASE @TranDescDflt
                WHEN 'I' THEN d.VendID
                WHEN 'N' THEN CASE
                        WHEN CHARINDEX('~', v.Name) > 0
                        THEN LTRIM(RTRIM(RIGHT(v.Name, LEN(v.Name) - CHARINDEX('~', v.Name)))) + ' ' + SUBSTRING(v.Name, 1, (CHARINDEX('~', v.Name) - 1))
                        ELSE v.Name
                END
                ELSE RTRIM(d.VendID) + ' ' + CASE
                        WHEN CHARINDEX('~', v.Name) > 0
                        THEN LTRIM(RTRIM(RIGHT(v.Name, LEN(v.Name) - CHARINDEX('~', v.Name)))) + ' ' + SUBSTRING(v.Name, 1, (CHARINDEX('~', v.Name) - 1))

                        ELSE v.Name

                END
         END,1,30), d.DocType, 0, 0, 0, 0, '',
        0, '', '', 0, 0, '', '', '', '', d.VendId,
	'','',0,0,0,'',0,'',0,0,0,0,'',0,'','','','','',''

FROM WrkRelease w inner loop join APDoc d on w.BatNbr = d.BatNbr Left join AP_PPApplic p on d.RefNbr = p.AdjdRefNbr and p.Crtd_Prog = '03010',
 Vendor v
WHERE d.VendId = v.VendId AND w.Module = 'AP' AND
        w.UserAddress = @UserAddress AND d.DocType IN ('AC', 'AD', 'VO', 'PP')

IF @@ERROR <> 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    SELECT 'Debug...Step 7000: Aptrans for Vouchers AND Adjustments ', CONVERT(varchar(30), GETDATE(), 113)
    SELECT * FROM APTran A, WrkRelease w
    WHERE w.UserAddress = @UserAddress AND
          w.module = 'AP' AND
          w.Batnbr = A.BatNbr
 END
 

/***** Create History for Vendor/Company if Not Already Exist *****/
SELECT @FirstYr = (SELECT MIN(SUBSTRING(PerPost, 1, 4)) FROM Batch b, WrkRelease w
        WHERE b.Module = w.Module AND b.BatNbr = w.BatNbr AND w.UserAddress = @UserAddress AND w.Module = 'AP')

SELECT @LastYr = CASE WHEN @PerNbr >= (SELECT MAX(SUBSTRING(PerPost, 1, 4)) FROM Batch b, WrkRelease w
                WHERE b.Module = w.Module AND b.BatNbr = w.BatNbr AND w.UserAddress = @UserAddress AND w.Module = 'AP')
        THEN @PerNbr
        ELSE (SELECT MAX(SUBSTRING(PerPost, 1, 4)) FROM Batch b, WrkRelease w
                WHERE b.Module = w.Module AND b.BatNbr = w.BatNbr AND w.UserAddress = @UserAddress AND w.Module = 'AP')
        END

WHILE (@FirstYr <= @LastYr)
        BEGIN
                INSERT Wrk_TimeRange VALUES (@FirstYr,@UserAddress)

                SELECT @FirstYr = LTRIM(STR(CONVERT(INT, @FirstYr) + 1))
        END
IF @@ERROR <> 0 GOTO ABORT

/***** Add New AP_Hist Record if Vendor Does Not Exist *****/
INSERT APHist (BegBal, CpnyId, Crtd_DateTime, Crtd_Prog, Crtd_User, CuryID, FiscYr,
        LUpd_DateTime, LUpd_Prog, LUpd_User, NoteID, PerNbr, PtdBkupWthld00, PtdBkupWthld01,
        PtdBkupWthld02, PtdBkupWthld03, PtdBkupWthld04, PtdBkupWthld05, PtdBkupWthld06, PtdBkupWthld07,
        PtdBkupWthld08, PtdBkupWthld09, PtdBkupWthld10, PtdBkupWthld11, PtdBkupWthld12, PtdCrAdjs00, PtdCrAdjs01,
        PtdCrAdjs02, PtdCrAdjs03, PtdCrAdjs04, PtdCrAdjs05, PtdCrAdjs06, PtdCrAdjs07,
        PtdCrAdjs08, PtdCrAdjs09, PtdCrAdjs10, PtdCrAdjs11, PtdCrAdjs12, PtdDiscTkn00,
        PtdDiscTkn01, PtdDiscTkn02, PtdDiscTkn03, PtdDiscTkn04, PtdDiscTkn05, PtdDiscTkn06,
        PtdDiscTkn07, PtdDiscTkn08, PtdDiscTkn09, PtdDiscTkn10, PtdDiscTkn11, PtdDiscTkn12,
        PtdDrAdjs00, PtdDrAdjs01, PtdDrAdjs02, PtdDrAdjs03, PtdDrAdjs04, PtdDrAdjs05, PtdDrAdjs06,

        PtdDrAdjs07, PtdDrAdjs08, PtdDrAdjs09, PtdDrAdjs10, PtdDrAdjs11, PtdDrAdjs12,
        PtdPaymt00, PtdPaymt01, PtdPaymt02, PtdPaymt03, PtdPaymt04, PtdPaymt05, PtdPaymt06,
        PtdPaymt07, PtdPaymt08, PtdPaymt09, PtdPaymt10, PtdPaymt11, PtdPaymt12,
        PtdPurch00, PtdPurch01, PtdPurch02, PtdPurch03, PtdPurch04, PtdPurch05, PtdPurch06,
        PtdPurch07, PtdPurch08, PtdPurch09, PtdPurch10, PtdPurch11, PtdPurch12,

        S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,

        S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12,
        User1, User2, User3, User4, User5, User6, User7, User8,
      VendId, YtdBkupWthld, YtdCrAdjs, YtdDiscTkn, YtdDrAdjs, YtdPaymt, YtdPurch)
SELECT DISTINCT 0, v.CpnyId, GETDATE(), @ProgID, @Sol_User, v.CuryID, r.FiscYr, GETDATE(), @ProgID, @Sol_User,
        0, CASE WHEN r.FiscYr < SUBSTRING(@PerNbr, 1, 4)
                THEN RTRIM(r.FiscYr) + '12'
                ELSE @PerNbr END,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        '', '', 0, 0, 0, 0, '', '', 0, 0, '', '',
        '', '', 0, 0, '', '', '', '', v.VendId, 0, 0, 0, 0, 0, 0
  FROM Wrk_TimeRange r
 inner join vp_03400ReleaseDocs v
           on v.FiscYr <= r.FiscYr
  left outer join aphist h
           on v.vendid = h.vendid and v.cpnyid = h.cpnyid and r.fiscyr = h.fiscyr
 WHERE v.UserAddress = @UserAddress
   AND r.UserAddress = @UserAddress
   And h.cpnyid is null
IF @@ERROR <> 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    SELECT 'Debug...Step 8000: Added New AP_Hist Record ', CONVERT(varchar(30), GETDATE(), 113)

 END

/***** Create AP Tran for RGOL Amount *****/
INSERT APTran (Acct, AcctDist, Applied_PPrefNbr, BatNbr, BoxNbr, Component, CostType, CostTypeWO, CpnyId,
        Crtd_DateTime, Crtd_Prog, Crtd_User, CuryId, CuryMultDiv, CuryRate,
        CuryTaxAmt00, CuryTaxAmt01, CuryTaxAmt02, CuryTaxAmt03, CuryTranAmt, CuryTxblAmt00,
        CuryTxblAmt01, CuryTxblAmt02, CuryTxblAmt03, CuryUnitPrice, DrCr, Employee,
        EmployeeID, Excpt, ExtRefNbr, FiscYr, InstallNbr, InvcTypeId,
        JobRate, JrnlType, Labor_Class_Cd, LineId, LineNbr,
        LineRef, LineType, LUpd_dateTime, LUpd_Prog, LUpd_User, MasterDocNbr,
        NoteID, PC_Flag, PC_ID, PC_Status, PerEnt, PerPost, PmtMethod, POLineRef,
        ProjectID, Qty, Rcptnbr, RefNbr,        Rlsed,
        S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
        S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ServiceDate,
        Sub, TaskID, TaxAmt00, TaxAmt01, TaxAmt02, TaxAmt03, TaxCalced,
        TaxCat, TaxId00, TaxId01, TaxId02, TaxId03, TaxIdDflt, TranAmt, TranClass,
        TranDate, TranDesc, TranType, TxblAmt00, TxblAmt01, TxblAmt02, TxblAmt03, UnitDesc,
        UnitPrice, User1, User2, User3, User4, User5, User6, User7, User8, VendId,
	AlternateID, BOMLineRef, CuryPOExtPrice, CuryPOUnitPrice, CuryPPV, InvtID, POExtPrice,
	PONbr, POQty, POUnitPrice, PPV, QtyVar, RcptLineRef, RcptQty,
	SiteId, SoLineRef, SOOrdNbr, SOTypeID, WONbr, WOStepNbr)

SELECT (SELECT Acct =
		CASE WHEN v.cRGOLAmt > 0
                	THEN c.RealLossAcct
		     ELSE c.RealGainAcct
		END
        FROM Currncy c
        WHERE c.CuryID = v.CuryAdjdCuryId), 1, '', d.BatNbr, '', '', '', '', v.CpnyId, GETDATE(),
        @ProgID, @Sol_User, d.CuryId, d.CuryMultDiv,
        d.CuryRate, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        CASE WHEN v.cRGOLAmt > 0
	THEN
        	'D'
        ELSE
        	'C'
        END, '',
        '', 0, d.InvcNbr, SUBSTRING(d.PerPost, 1, 4), d.InstallNbr, '',
        0, 'AP', '', 0, 32767, '', '', GETDATE(), @ProgID, @Sol_User, d.MasterDocNbr,
        0, '', '', '', d.PerEnt, d.PerPost, '', '', '', 0, '', d.RefNbr, 0, '', '', 0, 0, 0, 0,
        '', '', 0, 0, '', '', '',
        (SELECT SubAcct = CASE WHEN v.cRGOLAmt > 0
                           	THEN c.RealLossSub
        ELSE c.RealGainSub
			  END
        FROM Currncy c
        WHERE c.CuryID = v.CuryAdjdCuryId), '', 0, 0, 0, 0, '', '', '', '', '', '', '', abs(v.cRGOLAmt), '', d.DocDate,
	CASE WHEN v.cRGOLAmt > 0
      		THEN 'Realized Loss' + ' ' + d.CuryID
 	      ELSE 'Realized Gain' + ' ' + d.CuryID
	END,
         CASE  WHEN v.cRGOLAmt > 0 THEN
         		'RL'
        	ELSE
         		'RG'
  	END,

        0, 0, 0, 0, '',
        0, '', '', 0, 0, '', '', '', '', d.VendId,
	'','',0,0,0,'',0,'',0,0,0,0,'',0,'','','','','',''

FROM APDoc d, vp_03400RGOL v, WrkRelease w
WHERE d.BatNbr = v.BatNbr AND w.BatNbr = d.BatNbr AND d.RefNbr = v.RefNbr AND d.DocType = v.cDocType AND
        w.Module = 'AP' AND v.UserAddress = w.UserAddress AND w.UserAddress = @UserAddress AND
        d.DocType IN ('CK', 'HC','EP', 'QC', 'ZC') AND v.cRGOLAmt <> 0
IF @@ERROR <> 0 GOTO ABORT

/***** Create AP Tran for RGOL Amount from applied pre-payments *****/
INSERT APTran (Acct, AcctDist, Applied_PPrefNbr, BatNbr, BoxNbr, Component, CostType, CostTypeWO, CpnyId,
        Crtd_DateTime, Crtd_Prog, Crtd_User, CuryId, CuryMultDiv, CuryRate,
        CuryTaxAmt00, CuryTaxAmt01, CuryTaxAmt02, CuryTaxAmt03, CuryTranAmt, CuryTxblAmt00,
        CuryTxblAmt01, CuryTxblAmt02, CuryTxblAmt03, CuryUnitPrice, DrCr, Employee,
        EmployeeID, Excpt, ExtRefNbr, FiscYr, InstallNbr, InvcTypeId,
        JobRate, JrnlType, Labor_Class_Cd, LineId, LineNbr,
        LineRef, LineType, LUpd_dateTime, LUpd_Prog, LUpd_User, MasterDocNbr,
        NoteID, PC_Flag, PC_ID, PC_Status, PerEnt, PerPost, PmtMethod, POLineRef,
        ProjectID, Qty, Rcptnbr, RefNbr,        Rlsed,
        S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
        S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ServiceDate,
        Sub, TaskID, TaxAmt00, TaxAmt01, TaxAmt02, TaxAmt03, TaxCalced,
        TaxCat, TaxId00, TaxId01, TaxId02, TaxId03, TaxIdDflt, TranAmt, TranClass,
        TranDate, TranDesc, TranType, TxblAmt00, TxblAmt01, TxblAmt02, TxblAmt03, UnitDesc,
        UnitPrice, User1, User2, User3, User4, User5, User6, User7, User8, VendId,
	AlternateID, BOMLineRef, CuryPOExtPrice, CuryPOUnitPrice, CuryPPV, InvtID, POExtPrice,
	PONbr, POQty, POUnitPrice, PPV, QtyVar, RcptLineRef, RcptQty,
	SiteId, SoLineRef, SOOrdNbr, SOTypeID, WONbr, WOStepNbr)

SELECT (SELECT Acct =
		CASE WHEN v.CuryRGOLAmt > 0
                	THEN c.RealLossAcct
		     ELSE c.RealGainAcct
		END
        FROM Currncy c
        WHERE c.CuryID = v.CuryAdjdCuryId), 1, '', d.BatNbr, '', '', '', '', d.CpnyId, GETDATE(),
        @ProgID, @Sol_User, d.CuryId, d.CuryMultDiv,
        d.CuryRate, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        CASE WHEN v.CuryRGOLAmt > 0
	THEN
        	'D'
        ELSE
        	'C'
        END, '',
        '', 0, d.InvcNbr, SUBSTRING(d.PerPost, 1, 4), d.InstallNbr, '',
        0, 'AP', '', 0, 32767, '', '', GETDATE(), @ProgID, @Sol_User, d.MasterDocNbr,
        0, '', '', '', d.PerEnt, d.PerPost, '', '', '', 0, '', d.RefNbr, 0, '', '', 0, 0, 0, 0,
        '', '', 0, 0, '', '', '',
        (SELECT SubAcct = CASE WHEN v.CuryRGOLAmt > 0
                           	THEN c.RealLossSub
                               ELSE c.RealGainSub
			  END
        FROM Currncy c
        WHERE c.CuryID = v.CuryAdjdCuryId), '', 0, 0, 0, 0, '', '', '', '', '', '', '', abs(v.CuryRGOLAmt), '', d.DocDate,
	CASE WHEN v.CuryRGOLAmt > 0
      		THEN 'Realized Loss' + ' ' + d.CuryID
 	      ELSE 'Realized Gain' + ' ' + d.CuryID
	END,
         CASE  WHEN v.CuryRGOLAmt > 0 THEN
         		'RL'
        	ELSE
         		'RG'
  	END,

        0, 0, 0, 0, '',
        0, '', '', 0, 0, '', '', '', '', d.VendId,
	'','',0,0,0,'',0,'',0,0,0,0,'',0,'','','','','',''

FROM APDoc d, apadjust v, WrkRelease w
WHERE w.BatNbr = d.BatNbr AND d.RefNbr = v.adjdRefNbr AND d.DocType = v.adjdDocType AND
        w.Module = 'AP' AND  w.UserAddress = @UserAddress AND
        d.DocType IN ('VO', 'AC') AND d.PrePay_RefNbr <> '' and v.CuryRGOLAmt <> 0
IF @@ERROR <> 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    SELECT 'Debug...Step 9000:  Create AP Tran for RGOL Amount ', CONVERT(varchar(30), GETDATE(), 113)
    SELECT * FROM APTran A, WrkRelease w
    WHERE w.UserAddress = @UserAddress AND
          w.module = 'AP' AND
          w.Batnbr = A.BatNbr
 END

---update ap check doc rgol amount
UPDATE c SET c.LUpd_Prog = @ProgID,
	     c.LUpd_User = @Sol_User,
	     c.LUpd_DateTime= getdate(),
	     c.RGOLAmt = c.RGOLAmt + v.RGOLAmt
FROM WrkRelease w, vp_03400APRGOLSum v, APDoc c
WHERE w.UserAddress = @UserAddress AND
      w.Module = 'AP' AND w.BatNbr = v.BatNbr AND
      w.BatNbr = c.BatNbr AND
      c.refnbr = v.refnbr and
      c.DocType IN ('CK', 'HC','EP', 'ZC')
IF @@ERROR <> 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    SELECT 'Debug...Step 10000:  Update AP check document RGOL ', CONVERT(varchar(30), GETDATE(), 113)
    SELECT * FROM APTran A, WrkRelease w
    WHERE w.UserAddress = @UserAddress AND
          w.module = 'AP' AND
          w.Batnbr = A.BatNbr
 END

/***** Credit Cash *****/
INSERT APTran (Acct, AcctDist, Applied_PPrefNbr, BatNbr, BoxNbr, CostType, CpnyId, CuryId, CuryMultDiv, CuryRate,
        CuryTaxAmt00, CuryTaxAmt01, CuryTaxAmt02, CuryTaxAmt03, CuryTranAmt, CuryTxblAmt00,

        CuryTxblAmt01, CuryTxblAmt02, CuryTxblAmt03, CuryUnitPrice, DrCr, Employee,
        EmployeeID, Excpt, ExtRefNbr, FiscYr, JobRate, JrnlType, Labor_Class_Cd, LineId,
        LineNbr, NoteID, PC_Flag, PC_ID, PC_Status, PerEnt, PerPost, ProjectID, Qty, RefNbr,

        Rlsed,  Sub, TaskID, TaxAmt00, TaxAmt01, TaxAmt02, TaxAmt03, TaxCalced,
        TaxCat, TaxId00, TaxId01, TaxId02, TaxId03, TaxIdDflt, TranAmt, TranClass,
        TrANDate, TrANDesc, TranType, TxblAmt00, TxblAmt01, TxblAmt02, TxblAmt03, UnitDesc,
        UnitPrice, User1, User2, User3, User4, VendId,
        Component, CostTypeWo, Crtd_DateTime, Crtd_Prog, Crtd_User, installNbr, InvcTypeID,
        Lineref, LineType, LUpd_dateTime, LUpd_prog, LUpd_User, MasterDocNbr,
        PmtMethod, POLineRef, rcptnbr,

        S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,

        S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ServiceDate,
        User5, User6, User7, User8,
	AlternateID, BOMLineRef, CuryPOExtPrice, CuryPOUnitPrice, CuryPPV, InvtID, POExtPrice,
	PONbr, POQty, POUnitPrice, PPV, QtyVar, RcptLineRef, RcptQty,
	SiteId, SoLineRef, SOOrdNbr, SOTypeID, WONbr, WOStepNbr)

SELECT d.Acct, 1, '', d.Batnbr, '', '', d.CpnyId, d.CuryID, d.CuryMultDiv, d.CuryRate, 0, 0, 0, 0,

        CASE WHEN d.CuryID = a.CuryAdjdCuryId then cCuryCRdCash ELSE cCuryCRgCash END, 0, 0, 0, 0, 0, 'C', '', '', 0, '', SUBSTRING(d.PerPost, 1, 4), 0, 'AP', '', 0, 32767, 0,
        '', '', '', d.PerEnt, d.PerPost, '', 0, d.RefNbr, 0, d.Sub, '', 0, 0, 0, 0,
        '', '', '', '', '', '', '',
	CASE WHEN d.CuryID = a.CuryAdjdCuryId then Round(a.cCuryCRgCash,@BaseDecPl ) ELSE Round(a.cCRCash,@BaseDecPl ) END,
    	'', d.DocDate,
	substring(
        CASE @TranDescDflt
                WHEN 'I' THEN d.VendID
                WHEN 'N' THEN CASE
                        WHEN CHARINDEX('~', v.Name) > 0
                        THEN LTRIM(RTRIM(RIGHT(v.Name, LEN(v.Name) - CHARINDEX('~', v.Name)))) + ' ' + SUBSTRING(v.Name, 1, (CHARINDEX('~', v.Name) - 1))
                        ELSE v.Name
                END

                ELSE RTRIM(d.VendID) + ' ' + CASE
                        WHEN CHARINDEX('~', v.Name) > 0
                        THEN LTRIM(RTRIM(RIGHT(v.Name, LEN(v.Name) - CHARINDEX('~', v.Name)))) + ' ' + SUBSTRING(v.Name, 1, (CHARINDEX('~', v.Name) - 1))
                        ELSE v.Name
                END
        END,1,30), CASE WHEN d.DocType = 'QC' THEN 'CK' ELSE d.DocType END, 0, 0, 0, 0, '', 0, '', '', 0, 0, d.VendId, '', '', GETDATE(), @ProgID, @Sol_User, d.InstallNbr, '', '', '',
        GETDATE(), @ProgID, @Sol_User, d.MasterDocNbr, d.PmtMethod, '', '', '', '', 0, 0, 0, 0, '', '', 0, 0, '', '', '', '', '', '', '',
	'','',0,0,0,'',0,'',0,0,0,0,'',0,'','','','','',''

FROM APDoc d, WrkRelease w, Vendor v, vp_03400CRCash a
WHERE d.BatNbr = w.BatNbr AND w.Module = 'AP' AND d.DocType IN ('HC','EP', 'QC', 'CK', 'ZC') AND
        d.VendID = v.VendID AND d.acct = a.AdjgAcct and d.sub = a.Adjgsub and
	  d.BatNbr = a.AdjBatNbr AND d.RefNbr = a.AdjgRefNbr AND d.DocType = a.AdjgDocType
	  AND w.UserAddress = @UserAddress

IF @@ERROR <> 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    SELECT 'Debug...Step 11000:  Aptrans...Credit Cash ', CONVERT(varchar(30), GETDATE(), 113)
    SELECT * FROM APTran A, WrkRelease w
    WHERE w.UserAddress = @UserAddress AND
          w.module = 'AP' AND
          W.Batnbr = A.BatNbr
	    ORDER BY A.Batnbr
 END

---update ap check doc to true credit amount?
---UPDATE c SET c.origdocamt = round(cCRCash, @BaseDecPl), c.LUpd_Prog = @ProgID, c.LUpd_User = @Sol_User,
---  	        c.LUpd_DateTime= getdate()
---FROM WrkRelease w, vp_03400CRCash a, APDoc c
---WHERE w.UserAddress = @UserAddress AND
---      w.Module = 'AP' AND w.BatNbr = c.BatNbr AND c.DocType IN ('CK', 'HC', 'VC') AND
---	c.BatNbr = a.AdjBatNbr AND c.RefNbr = a.AdjgRefNbr AND c.DocType = a.AdjgDocType
---IF @@ERROR <> 0 GOTO ABORT

/*** Round fields that impact RGOL now that we are finished calcing RGOL ***/
UPDATE c SET c.OrigDocAmt = round(c.OrigDocAmt, @BaseDecPl), c.LUpd_Prog = @ProgID,
	     c.LUpd_User = @Sol_User, c.LUpd_DateTime= getdate()
FROM WrkRelease w, APDoc c
WHERE w.UserAddress = @UserAddress AND
      w.Module = 'AP' AND
      w.BatNbr = c.BatNbr AND c.DocType IN ('CK', 'HC','EP', 'VC')
IF @@ERROR < > 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    SELECT 'Debug...Step 12000: Update APDOCS  RGOL ', CONVERT(varchar(30), GETDATE(), 113)
    SELECT * FROM APDoc A, WrkRelease w
    WHERE w.UserAddress = @UserAddress AND
          w.module = 'AP' AND
          W.Batnbr = A.BatNbr AND
          A.DocType IN ('CK', 'HC','EP', 'VC')

 END


/*** Round fields that impact RGOL now that we are finished calcing RGOL ***/
UPDATE t SET t.TranAmt = round(t.TranAmt, @BaseDecPl), t.LUpd_Prog = @ProgID, t.LUpd_User = @Sol_User, t.LUpd_DateTime= getdate()
FROM WrkRelease w, APTran t
WHERE w.UserAddress = @UserAddress AND
      w.Module = 'AP' AND
      w.BatNbr = t.BatNbr AND t.TranType IN ('CK', 'HC','EP', 'VC', 'RL', 'RG')
IF @@ERROR < > 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    SELECT 'Debug...Step 13000: Update APTRANS RGOL ', CONVERT(varchar(30), GETDATE(), 113)
    SELECT * FROM APTran A, WrkRelease w
    WHERE w.UserAddress = @UserAddress AND
          w.module = 'AP' AND
          W.Batnbr = A.BatNbr AND
          A.TranType IN ('CK', 'HC','EP', 'VC', 'RL', 'RG')
 END

/*** update RGOL with rounding differences non VC ***/
UPDATE t SET t.LUpd_Prog = @ProgID, t.LUpd_User = @Sol_User, t.LUpd_DateTime= getdate(),
	     t.TranAmt = t.Tranamt -
		CASE WHEN
			round(v.cRGOLAmtRound,@BaseDecPl) <> 0
			AND abs(round(v.cRGOLAmtRound,@BaseDecPl)) < .25
		THEN
			round(cRGOLAmtRound,@BaseDecPl)
		ELSE
			0
		END
FROM WrkRelease w, APTran t, apdoc d, vp_03400RGOLRound v
WHERE w.UserAddress = @UserAddress AND
      w.Module = 'AP' AND
      w.BatNbr = t.BatNbr AND t.TranType IN ( 'RL')
      and v.UserAddress = @UserAddress AND v.BatNbr = t.BatNbr
      and d.batnbr = t.batnbr and d.refnbr = t.refnbr and d.doctype <> 'VC'
      and t.Recordid = (select min(recordid) from aptran x where x.Batnbr = t.BATNBR and x.TranType IN ( 'RL') )

IF @@ERROR < > 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    SELECT 'Debug...Step 14000: Update APTRANS for non VC (RL)', CONVERT(varchar(30), GETDATE(), 113)
    SELECT * FROM APTran A, WrkRelease w
    WHERE w.UserAddress = @UserAddress AND
          w.module = 'AP' AND
          W.Batnbr = A.BatNbr
          AND A.TranType IN ( 'RL')
 END

/*** update RGOL with rounding differences non VC***/
UPDATE t SET t.LUpd_Prog = @ProgID, t.LUpd_User = @Sol_User, t.LUpd_DateTime= getdate(),
	     t.TranAmt = t.Tranamt +
		CASE WHEN
			round(v.cRGOLAmtRound,@BaseDecPl) <> 0
			AND abs(round(v.cRGOLAmtRound,@BaseDecPl)) < .25
		THEN
			round(v.cRGOLAmtRound,@BaseDecPl)
		ELSE
			0
		END
FROM WrkRelease w, APTran t, apdoc d, vp_03400RGOLRound v
WHERE w.UserAddress = @UserAddress AND
      w.Module = 'AP' AND w.BatNbr = t.BatNbr AND t.TranType IN ( 'RG')
      and v.UserAddress = @UserAddress AND v.BatNbr = t.BatNbr
      and d.batnbr = t.batnbr and d.refnbr = t.refnbr and d.doctype <> 'VC'
      and t.Recordid = (select min(recordid) from aptran x where x.Batnbr = t.BATNBR and x.TranType IN ( 'RG') )

IF @@ERROR < > 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    SELECT 'Debug...Step 15000: Update APTRANS RGOL non VC. (RG)', CONVERT(varchar(30), GETDATE(), 113)
    SELECT * FROM APTran A, WrkRelease w
    WHERE w.UserAddress = @UserAddress AND
          w.module = 'AP' AND
          W.Batnbr = A.BatNbr AND
          A.TranType IN ( 'RG')
 END


/*** update RGOL with rounding differences VC  ***/
UPDATE t SET t.LUpd_Prog = @ProgID, t.LUpd_User = @Sol_User, t.LUpd_DateTime= getdate(),
	     t.TranAmt = t.Tranamt -
		CASE WHEN
			round(((select sum(d.tranamt * case when d.trantype = 'AD' then -1 else 1 end) from  WrkRelease w1, aptran d
			where d.batnbr = w1.batnbr AND
 		      	w1.Module = 'AP'  AND
			d.drcr = 'C')
			-
			(select sum(c.tranamt * case when c.trantype = 'AD' then -1 else 1 end) from  WrkRelease w2, aptran c
			where c.batnbr = w2.batnbr  AND
			w2.Module = 'AP' AND
			c.drcr = 'D')),@BaseDecPl) <> 0
		THEN
			round(((select sum(d.tranamt * case when d.trantype = 'AD' then -1 else 1 end) from  WrkRelease w1, aptran d
			where d.batnbr = w1.batnbr AND
 		      	w1.Module = 'AP'  AND
			d.drcr = 'C')
			-
			(select sum(c.tranamt * case when c.trantype = 'AD' then -1 else 1 end) from  WrkRelease w2, aptran c
			where c.batnbr = w2.batnbr  AND
			w2.Module = 'AP' AND
			c.drcr = 'D')),@BaseDecPl)
		ELSE
			0
		END
FROM WrkRelease w inner loop join APTran t on w.BatNbr = t.BatNbr,
	apdoc d
WHERE w.UserAddress = @UserAddress AND
      w.Module = 'AP' AND
      t.TranType IN ( 'RL')
      and d.batnbr = t.batnbr and d.refnbr = t.refnbr and d.doctype = 'VC'
      and t.Recordid = (select min(recordid) from aptran x where x.Batnbr = t.BATNBR and x.TranType IN ( 'RL') )

IF @@ERROR < > 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    SELECT 'Debug...Step 16000:update Aptran RGOL for VC. (RL)', CONVERT(varchar(30), GETDATE(), 113)
    SELECT * FROM APTran A, WrkRelease w, APDoc D
    WHERE w.UserAddress = @UserAddress AND
          w.module = 'AP' AND
          W.Batnbr = A.BatNbr
          AND A.TranType IN ( 'RL')
          AND D.BatNbr = A.BatNbr
          ANd D.DocType = 'VC'
 END

/*** update RGOL with rounding differences VC ***/
UPDATE t SET t.LUpd_Prog = @ProgID, t.LUpd_User = @Sol_User, t.LUpd_DateTime= getdate(),
	     t.TranAmt = t.Tranamt +
		CASE WHEN
			round(((select sum(d.tranamt * case when d.trantype = 'AD' then -1 else 1 end) from  WrkRelease w1, aptran d
			where d.batnbr = w1.batnbr AND
 		      	w1.Module = 'AP'  AND
			d.drcr = 'C')
			-
			(select sum(c.tranamt * case when c.trantype = 'AD' then -1 else 1 end) from  WrkRelease w2, aptran c
			where c.batnbr = w2.batnbr  AND
			w2.Module = 'AP' AND
			c.drcr = 'D')),@BaseDecPl)<> 0
		THEN
			round(((select sum(d.tranamt * case when d.trantype = 'AD' then -1 else 1 end) from  WrkRelease w1, aptran d
			where d.batnbr = w1.batnbr AND
 		      	w1.Module = 'AP'  AND
			d.drcr = 'C')
			-
			(select sum(c.tranamt * case when c.trantype = 'AD' then -1 else 1 end) from  WrkRelease w2, aptran c
			where c.batnbr = w2.batnbr  AND
			w2.Module = 'AP' AND
			c.drcr = 'D')),@BaseDecPl)
		ELSE
			0
		END
FROM WrkRelease w inner loop join APTran t on w.BatNbr = t.BatNbr,
	apdoc d
WHERE w.UserAddress = @UserAddress AND
      w.Module = 'AP' AND t.TranType IN ( 'RG')
      and d.batnbr = t.batnbr and d.refnbr = t.refnbr and d.doctype = 'VC'
      and t.Recordid = (select min(recordid) from aptran x where x.Batnbr = t.BATNBR and x.TranType IN ( 'RG') )

IF @@ERROR < > 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    SELECT 'Debug...Step :update Aptran RGOL for  VC. (RG)', CONVERT(varchar(30), GETDATE(), 113)
    SELECT * FROM APTran A, WrkRelease w, APDoc d
    WHERE w.UserAddress = @UserAddress AND
          w.module = 'AP' AND
          W.Batnbr = A.BatNbr
          AND A.TranType IN ( 'RG')
          AND D.BatNbr = A.BatNbr
          AND D.DocType = 'VC'
	    ORDER BY A.Batnbr
 END

/***** Clear 'S' Records *****/
DELETE APTran
FROM APTran t, WrkRelease w
WHERE t.BatNbr = w.BatNbr AND w.Module = 'AP' AND w.UserAddress = @UserAddress AND t.DRCR = 'S'
IF @@ERROR < > 0 GOTO ABORT

/***** Clear APCheck And APCheckDet Records *****/

DELETE APCHeck
FROM APCheck t, WrkRelease w
WHERE t.BatNbr = w.BatNbr AND w.Module = 'AP' AND w.UserAddress = @UserAddress

DELETE APCheckDet
FROM APCheckDet t, WrkRelease w
WHERE t.BatNbr = w.BatNbr AND w.Module = 'AP' AND w.UserAddress = @UserAddress

IF @@ERROR < > 0 GOTO ABORT

/***** Update AP History and vendor balances *****/



EXEC pp_03400aphistbal @UserAddress, @ProgID, @Sol_User, @PerNbr, @BaseDecPl ,@Result OUTPUT
IF @Result = 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    SELECT 'Debug...Step 19000: After pp_03400aphistbal', CONVERT(varchar(30), GETDATE(), 113)
 END

/**** Update Cash *****/
EXEC pp_03400cashsum @UserAddress, @ProgID, @Sol_User, @Result OUTPUT
IF @Result = 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    SELECT 'Debug...Step 20000: After pp_03400cashsum', CONVERT(varchar(30), GETDATE(), 113)
 END

GLTRAN_Processing:
/***** Create GLTran records *****/
INSERT Wrk_GLTran (Acct, AppliedDate, BalanceType, BaseCuryID, BatNbr, CpnyID, CrAmt, Crtd_DateTime, Crtd_Prog, Crtd_User,
        CuryCrAmt, CuryDrAmt, CuryEffDate, CuryId, CuryMultDiv, CuryRate, CuryRateType, DrAmt, EmployeeID,
        ExtRefNbr, FiscYr, IC_Distribution, Id, JrnlType, Labor_Class_Cd, LedgerID, LineId, LineNbr, LineRef,
        LUpd_DateTime, LUpd_Prog, LUpd_User, Module, NoteID, OrigAcct, OrigBatNbr, OrigCpnyID, OrigSub, PC_Flag, PC_ID, PC_Status, PerEnt,
        PerPost, Posted, ProjectID, Qty, RefNbr, revEntryOption, Rlsed, S4Future01, S4Future02, S4Future03,
        S4Future04, S4Future05, S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11,S4Future12,
        ServiceDate, Sub, TaskID, TranDate, TranDesc, TranType, Units, User1, User2, User3, User4, User5, User6,
        User7, User8, FromCpnyID, Screen, RecordID, UserAddress)
SELECT Acct, AppliedDate, BalanceType, @BaseCuryID, BatNbr, CpnyID, CrAmt, Crtd_DateTime, Crtd_Prog, Crtd_User,
        CuryCrAmt, CuryDrAmt, CuryEffDate, CuryId, CuryMultDiv, CuryRate, CuryRateType, DrAmt, EmployeeID,
        ExtRefNbr, FiscYr, IC_Distribution, Id, JrnlType, Labor_Class_Cd, @LedgerID, LineId, LineNbr, LineRef,
        LUpd_DateTime, LUpd_Prog, LUpd_User, Module, NoteID, OrigAcct, OrigBatNbr, OrigCpnyID, OrigSub, PC_Flag, PC_ID, PC_Status, PerEnt,
        PerPost, Posted, ProjectID, Qty, RefNbr, revEntryOption, Rlsed, S4Future01, S4Future02, S4Future03,
        S4Future04, S4Future05, S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11,S4Future12,
        ServiceDate, Sub, TaskID, TranDate, TranDesc, TranType, Units, User1, User2, User3, User4, User5, User6,
        User7, User8, FromCpnyID, Screen, RecordID, @UserAddress
FROM vp_03400GLTran v
WHERE v.UserAddress = @UserAddress
IF @@ERROR <> 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    SELECT 'Debug...Step 21000:Create Wrk_Gltran', CONVERT(varchar(30), GETDATE(), 113)
    SELECT * FROM Wrk_gltran Gl, WrkRelease w
    WHERE  gl.UserAddress = @UserAddress
           AND w.module = 'AP'

 END

/***** Create GLTran records where the account doesn't exist  and a suspense acct will be used during posting *****/
INSERT Wrk_GLTran (Acct, AppliedDate, BalanceType, BaseCuryID, BatNbr, CpnyID, CrAmt, Crtd_DateTime, Crtd_Prog, Crtd_User,
        CuryCrAmt, CuryDrAmt, CuryEffDate, CuryId, CuryMultDiv, CuryRate, CuryRateType, DrAmt, EmployeeID,
        ExtRefNbr, FiscYr, IC_Distribution, Id, JrnlType, Labor_Class_Cd, LedgerID, LineId, LineNbr, LineRef,
        LUpd_DateTime, LUpd_Prog, LUpd_User, Module, NoteID, OrigAcct, OrigBatNbr, OrigCpnyID, OrigSub, PC_Flag, PC_ID, PC_Status, PerEnt,
        PerPost, Posted, ProjectID, Qty, RefNbr, revEntryOption, Rlsed, S4Future01, S4Future02, S4Future03,
        S4Future04, S4Future05, S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11,S4Future12,
        ServiceDate, Sub, TaskID, TranDate, TranDesc, TranType, Units, User1, User2, User3, User4, User5, User6,
        User7, User8, FromCpnyID, Screen, RecordID, UserAddress)
SELECT Acct, AppliedDate, BalanceType, @BaseCuryID, BatNbr, CpnyID, CrAmt, Crtd_DateTime, Crtd_Prog, Crtd_User,
        CuryCrAmt, CuryDrAmt, CuryEffDate, CuryId, CuryMultDiv, CuryRate, CuryRateType, DrAmt, EmployeeID,
        ExtRefNbr, FiscYr, IC_Distribution, Id, JrnlType, Labor_Class_Cd, @LedgerID, LineId, LineNbr, LineRef,
        LUpd_DateTime, LUpd_Prog, LUpd_User, Module, NoteID, OrigAcct, OrigBatNbr, OrigCpnyID, OrigSub, PC_Flag, PC_ID, PC_Status, PerEnt,
        PerPost, Posted, ProjectID, Qty, RefNbr, revEntryOption, Rlsed, S4Future01, S4Future02, S4Future03,
        S4Future04, S4Future05, S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11,S4Future12,
        ServiceDate, Sub, TaskID, TranDate, TranDesc, TranType, Units, User1, User2, User3, User4, User5, User6,
        User7, User8, FromCpnyID, Screen, RecordID, @UserAddress
FROM vp_03400SuspenseGLTran v
WHERE v.UserAddress = @UserAddress
IF @@ERROR <> 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    SELECT 'Debug...Step 22000:Create WRK GLTran acct does not exist',     CONVERT(varchar(30), GETDATE(), 113)
    SELECT * FROM Wrk_gltran Gl, WrkRelease w
    WHERE  gl.UserAddress = @UserAddress
           AND w.module = 'AP'
  END

/***** Multi-Company/Inter-Company Transactions *****/
EXEC pp_03400GLInterComp @UserAddress, @Sol_User, @Debug,  @Result OUTPUT
IF @Result = 0 or @Result = 12341 or @@ERROR <> 0
BEGIN
  GOTO ABORT
END

/***** Create AP Tran for RGOL Amount when PO receipt is at a different rate*****/
/***** Adjust AP Accrual acct for this ******/
INSERT Wrk_GLTran (Acct, AppliedDate, BalanceType, BaseCuryID, BatNbr, CpnyID, CrAmt, Crtd_DateTime, Crtd_Prog, Crtd_User,
        CuryCrAmt, CuryDrAmt, CuryEffDate, CuryId, CuryMultDiv, CuryRate, CuryRateType, DrAmt, EmployeeID,
        ExtRefNbr, FiscYr, IC_Distribution, Id, JrnlType, Labor_Class_Cd, LedgerID, LineId, LineNbr, LineRef,
        LUpd_DateTime, LUpd_Prog, LUpd_User, Module, NoteID, OrigAcct, OrigBatNbr, OrigCpnyID, OrigSub, PC_Flag, PC_ID, PC_Status, PerEnt,
        PerPost, Posted, ProjectID, Qty, RefNbr, revEntryOption, Rlsed, S4Future01, S4Future02, S4Future03,
        S4Future04, S4Future05, S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11,S4Future12,
        ServiceDate, Sub, TaskID, TranDate, TranDesc, TranType, Units, User1, User2, User3, User4, User5, User6,
        User7, User8, FromCpnyID, Screen, RecordID, UserAddress)
SELECT  v.acct,
	'','A', @BaseCuryID, d.BatNbr, v.CpnyID,
 	CASE WHEN v.tRGOLAmt > 0 THEN abs(v.tRGOLAmt) else 0 END, ---gl.CrAmt,
	getdate(), @Progid, @Sol_User,
	0, ---gl.CuryCrAmt,
	0, ---gl.CuryDrAmt,
	'', d.CuryId, d.CuryMultDiv, d.CuryRate, '',
	CASE WHEN v.tRGOLAmt < 0 THEN abs(v.tRGOLAmt) else 0 END, ---gl.DrAmt,
	'',---t.EmployeeID,
        '',---t.ExtRefNbr,
	v.FiscYr, '', d.vendid, 'AP', '', @LedgerID, 0,
	0,---t.LineNbr,
	'',
        getdate(), @Progid, @Sol_User, 'AP', 0, '', '', v.cpnyid, '',
        '', '', '', d.PerEnt,
        d.PerPost, 'U','',---t.ProjectID,
	0, d.RefNbr, '', 1, d.S4Future01, d.S4Future02, d.S4Future03,
        d.S4Future04, d.S4Future05, d.S4Future06, d.S4Future07, d.S4Future08,
        d.S4Future09, d.S4Future10, d.S4Future11, 'PO',
        '', v.sub,
	'',---t.TaskID,
	d.docdate,---t.TranDate,
	CASE WHEN v.tRGOLAmt > 0
      		THEN 'Realized Loss' + ' ' + d.CuryID
 	      ELSE 'Realized Gain' + ' ' + d.CuryID
	END,
	CASE  WHEN v.tRGOLAmt > 0 THEN
         		'RL'
        	ELSE
         		'RG'
  	END, 0, d.User1, d.User2, d.User3, d.User4,
        d.User5, d.User6, d.User7, d.User8,
	'', 'APPORGOL', 0, w.UserAddress
FROM Batch b, APDoc d, vp_03400RGOL_PO v, WrkRelease w
WHERE b.batnbr = w.BatNbr and b.module = 'AP' and b.module = w.module and d.BatNbr = v.BatNbr AND
	w.BatNbr = d.BatNbr AND d.RefNbr = v.RefNbr AND d.DocType = v.TranType AND
        w.Module = 'AP' AND v.UserAddress = w.UserAddress AND w.UserAddress = @UserAddress AND
        d.DocType IN ('VO', 'AD', 'AC') AND d.curyid <> @basecuryid  AND v.tRGOLAmt <> 0
IF @@ERROR <> 0 GOTO ABORT

/***** create gain or loss for AP/PO ******/
INSERT Wrk_GLTran (Acct, AppliedDate, BalanceType, BaseCuryID, BatNbr, CpnyID, CrAmt, Crtd_DateTime, Crtd_Prog, Crtd_User,
        CuryCrAmt, CuryDrAmt, CuryEffDate, CuryId, CuryMultDiv, CuryRate, CuryRateType, DrAmt, EmployeeID,
        ExtRefNbr, FiscYr, IC_Distribution, Id, JrnlType, Labor_Class_Cd, LedgerID, LineId, LineNbr, LineRef,
        LUpd_DateTime, LUpd_Prog, LUpd_User, Module, NoteID, OrigAcct, OrigBatNbr, OrigCpnyID, OrigSub, PC_Flag, PC_ID, PC_Status, PerEnt,
        PerPost, Posted, ProjectID, Qty, RefNbr, revEntryOption, Rlsed, S4Future01, S4Future02, S4Future03,
        S4Future04, S4Future05, S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11,S4Future12,
        ServiceDate, Sub, TaskID, TranDate, TranDesc, TranType, Units, User1, User2, User3, User4, User5, User6,
        User7, User8, FromCpnyID, Screen, RecordID, UserAddress)
SELECT (SELECT Acct =
		CASE WHEN v.tRGOLAmt > 0
                	THEN c.RealLossAcct
		     ELSE c.RealGainAcct
		END
        FROM Currncy c
        WHERE c.CuryID = d.CuryId),
	'','A',  @BaseCuryID, d.BatNbr, v.CpnyID,
 	CASE WHEN v.tRGOLAmt < 0 THEN abs(v.tRGOLAmt) else 0 END, ---gl.CrAmt,
	getdate(), @Progid, @Sol_User,
	0, ---gl.CuryCrAmt,
	0, ---gl.CuryDrAmt,
	'', d.CuryId, d.CuryMultDiv, d.CuryRate, '',
	CASE WHEN v.tRGOLAmt > 0 THEN abs(v.tRGOLAmt) else 0 END, ---gl.DrAmt,
	'',---t.EmployeeID,
        '',---t.ExtRefNbr,
	v.FiscYr, '', d.vendid, 'AP', '', @LedgerID, 0,
	0,---t.LineNbr,
	'',
        getdate(), @Progid, @Sol_User, 'AP', 0, '', '', v.cpnyid, '',
        '', '', '', d.PerEnt,
        d.PerPost, 'U','',---t.ProjectID,
	0, d.RefNbr, '', 1, d.S4Future01, d.S4Future02, d.S4Future03,
        d.S4Future04, d.S4Future05, d.S4Future06, d.S4Future07, d.S4Future08,
        d.S4Future09, d.S4Future10, d.S4Future11, 'PO',
        '', (SELECT SubAcct = CASE WHEN v.tRGOLAmt > 0
                           	THEN c.RealLossSub
                               ELSE c.RealGainSub
			  END
        FROM Currncy c
        WHERE c.CuryID = d.CuryId),
	'',---t.TaskID,
	d.docdate,---t.TranDate,
	CASE WHEN v.tRGOLAmt > 0
      		THEN 'Realized Loss' + ' ' + d.CuryID
 	      ELSE 'Realized Gain' + ' ' + d.CuryID
	END,
	CASE  WHEN v.tRGOLAmt > 0 THEN
         		'RL'
        	ELSE
         		'RG'
  	END, 0, d.User1, d.User2, d.User3, d.User4,
        d.User5, d.User6, d.User7, d.User8,
	'', 'APPORGOL', 0, w.UserAddress
FROM Batch b, APDoc d, vp_03400RGOL_PO v, WrkRelease w
WHERE b.batnbr = w.BatNbr and b.module = 'AP' and b.module = w.module and d.BatNbr = v.BatNbr AND
	w.BatNbr = d.BatNbr AND d.RefNbr = v.RefNbr AND d.DocType = v.TranType AND
        w.Module = 'AP' AND v.UserAddress = w.UserAddress AND w.UserAddress = @UserAddress AND
        d.DocType IN ('VO', 'AD', 'AC') AND d.curyid <> @basecuryid  AND v.tRGOLAmt <> 0
IF @@ERROR <> 0 GOTO ABORT

/***** Update LineNbr field *****/
UPDATE Wrk_gltran SET LineNbr = t.Counter - 32766 -
        (SELECT MIN(p.Counter) FROM Wrk_gltran p WHERE p.BatNbr = t.BatNbr and p.useraddress = @UserAddress)
        FROM Wrk_gltran t
       where t.useraddress = @UserAddress
IF @@ERROR <> 0 GOTO ABORT

/***** Move temporary GLTran records to GLTran table *****/

INSERT GLTran (Acct, AppliedDate, BalanceType, BaseCuryID, BatNbr, CpnyID, CrAmt, Crtd_DateTime, Crtd_Prog, Crtd_User,
        CuryCrAmt, CuryDrAmt, CuryEffDate, CuryId, CuryMultDiv, CuryRate, CuryRateType, DrAmt, EmployeeID,
        ExtRefNbr, FiscYr, IC_Distribution, Id, JrnlType, Labor_Class_Cd, LedgerID, LineId, LineNbr, LineRef,
        LUpd_DateTime, LUpd_Prog, LUpd_User, Module, NoteID, OrigAcct, OrigBatNbr, OrigCpnyID, OrigSub, PC_Flag, PC_ID, PC_Status, PerEnt,
        PerPost, Posted, ProjectID, Qty, RefNbr, revEntryOption, Rlsed, S4Future01, S4Future02, S4Future03,
        S4Future04, S4Future05, S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11,S4Future12,
        ServiceDate, Sub, TaskID, TranDate, TranDesc, TranType, Units, User1, User2, User3, User4, User5, User6,
        User7, User8)
SELECT gl.Acct, '','A', gl.BaseCuryID, gl.BatNbr, gl.CpnyID, gl.CrAmt, getdate(), @Progid, @Sol_User,
        gl.CuryCrAmt, gl.CuryDrAmt, '', t.CuryId, t.CuryMultDiv, t.CuryRate, '', gl.DrAmt, t.EmployeeID,
        t.ExtRefNbr, t.FiscYr, gl.IC_Distribution, t.vendid, t.JrnlType, t.Labor_Class_Cd, gl.LedgerID, 0, gl.LineNbr, '',
        getdate(), @Progid, @Sol_User, gl.Module, 0, gl.OrigAcct, '', gl.origcpnyid, gl.OrigSub,
        t.PC_Flag, '', '', t.PerEnt,
        t.PerPost, 'U',t.ProjectID, 0, t.RefNbr, '', 1, t.S4Future01, t.S4Future02, t.S4Future03,
        t.S4Future04, t.S4Future05, t.S4Future06, t.S4Future07, t.S4Future08,
        t.S4Future09, t.S4Future10, t.S4Future11,t.S4Future12,
        t.ServiceDate, gl.Sub, t.TaskID, t.TranDate, gl.tranDesc, gl.TranType, 0, t.User1, t.User2, t.User3, t.User4,
        t.User5, t.User6, t.User7, t.User8
FROM Wrk_gltran gl,aptran t
where gl.recordid = t.recordid and gl.useraddress = @UserAddress and gl.Screen <> 'APPORGOL'
IF @@ERROR <> 0 GOTO ABORT

INSERT GLTran (Acct, AppliedDate, BalanceType, BaseCuryID, BatNbr, CpnyID, CrAmt, Crtd_DateTime, Crtd_Prog, Crtd_User,
        CuryCrAmt, CuryDrAmt, CuryEffDate, CuryId, CuryMultDiv, CuryRate, CuryRateType, DrAmt, EmployeeID,
        ExtRefNbr, FiscYr, IC_Distribution, Id, JrnlType, Labor_Class_Cd, LedgerID, LineId, LineNbr, LineRef,
        LUpd_DateTime, LUpd_Prog, LUpd_User, Module, NoteID, OrigAcct, OrigBatNbr, OrigCpnyID, OrigSub, PC_Flag, PC_ID, PC_Status, PerEnt,
        PerPost, Posted, ProjectID, Qty, RefNbr, revEntryOption, Rlsed, S4Future01, S4Future02, S4Future03,
        S4Future04, S4Future05, S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11,S4Future12,
        ServiceDate, Sub, TaskID, TranDate, TranDesc, TranType, Units, User1, User2, User3, User4, User5, User6,
        User7, User8)
SELECT  Acct, AppliedDate, BalanceType, BaseCuryID, BatNbr, CpnyID, CrAmt, Crtd_DateTime, Crtd_Prog, Crtd_User,
        CuryCrAmt, CuryDrAmt, CuryEffDate, CuryId, CuryMultDiv, CuryRate, CuryRateType, DrAmt, EmployeeID,
        ExtRefNbr, FiscYr, IC_Distribution, Id, JrnlType, Labor_Class_Cd, LedgerID, LineId, LineNbr, LineRef,
        LUpd_DateTime, LUpd_Prog, LUpd_User, Module, NoteID, OrigAcct, OrigBatNbr, OrigCpnyID, OrigSub, PC_Flag, PC_ID, PC_Status, PerEnt,
        PerPost, Posted, ProjectID, Qty, RefNbr, revEntryOption, Rlsed, S4Future01, S4Future02, S4Future03,
        S4Future04, S4Future05, S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11,S4Future12,
        ServiceDate, Sub, TaskID, TranDate, TranDesc, TranType, Units, User1, User2, User3, User4, User5, User6,
        User7, User8
FROM Wrk_gltran gl
where gl.useraddress = @UserAddress and gl.Screen = 'APPORGOL'
IF @@ERROR <> 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    SELECT 'Debug...Step 24000: Create GLTran Records from wrk_gltran', CONVERT(varchar(30), GETDATE(), 113)
    SELECT * FROM WrkRelease w, GLTran t
    WHERE w.UserAddress = @UserAddress AND
	    w.Batnbr = t.Batnbr AND
          w.Module = 'AP' AND
          w.Module = t.Module
    ORDER BY w.Batnbr
  END

/**** When the process is complete, change the appropriate statuses. ****/

UPDATE t
   SET Rlsed = 1,
       AcctDist = CASE
                  WHEN DrCr IN ('D', 'C') THEN 1
                  ELSE 0
                  END
  FROM ApTran t, WrkRelease w
 WHERE w.UserAddress = @UserAddress
   AND W.Module = 'AP'
   AND W.BatNbr = t.BatNbr

IF (@Debug = 1)
  BEGIN
    SELECT 'Debug...Step 25000: Update APTran Records to Rlsed = 1', CONVERT(varchar(30), GETDATE(), 113)
    SELECT * FROM WrkRelease w, APTran t
    WHERE w.UserAddress = @UserAddress
    AND W.Module = 'AP'
    AND W.BatNbr = t.BatNbr

  END


UPDATE d
   SET Rlsed = 1,

       ApplyDate = CASE WHEN (DocType IN ('VO', 'AC', 'AD')
				AND ApplyRefnbr = '')
		        THEN  '1/1/1900'
		   ELSE
			ApplyDate
		   END,
       Status = CASE WHEN (DocType IN ('HC','EP', 'CK', 'QC')
                              AND (@RetChkRcncl= 0
                                        OR OrigDocAmt = 0))
                      OR DocType = 'ZC' THEN 'C'
                WHEN DocType IN ('HC','EP', 'CK', 'QC')
                              AND @RetChkRcncl = 1
                              AND OrigDocAmt <> 0 THEN 'O'
                ELSE Status
                END,
       ClearDate = CASE WHEN (DocType IN ('HC','EP', 'CK', 'QC')
                      AND (@RetChkRcncl= 0
                                OR OrigDocAmt = 0))
              OR DocType = 'ZC' THEN DocDate
        ELSE ClearDate
        END,
	PerClosed = CASE
            WHEN DocType IN ('HC','EP', 'CK', 'QC')
                    AND(@RetChkRcncl = 0 OR OrigDocAmt = 0)
             THEN PerPost
            WHEN DocType = 'ZC'
             THEN Perpost
            ELSE PerClosed
            END,
            CuryPmtAmt = 0, PmtAmt = 0
  FROM APDOC d, WrkRelease w
 WHERE w.UserAddress = @UserAddress
   AND W.Module = 'AP'
   AND W.BatNbr = d.BatNbr

IF (@Debug = 1)
  BEGIN
    SELECT 'Debug...Step 26000: Update APDocs Records to Rlsed = 1 and PerClosed', CONVERT(varchar(30), GETDATE(), 113)
    SELECT * FROM WrkRelease w, APDoc d
   WHERE w.UserAddress = @UserAddress
   AND W.Module = 'AP'
   AND W.BatNbr = d.BatNbr

  END


/***** Update Batches *****/
UPDATE Batch Set
        Status = CASE WHEN (ISNULL(v.batnbr,' ') = ' ' or b.EditScrnNbr = '03060')
                      THEN 'C'
                      ELSE 'U'
                 END, Rlsed = 1,
        CtrlTot = ISNULL(v.CrAmt,0),
        CrTot = ISNULL(v.CrAmt,0),
        DrTot = ISNULL(v.DrAmt,0),
        CuryCtrlTot = ISNULL(v.CrCuryAmt,0),
        CuryCrTot = ISNULL(v.CrCuryAmt,0),
        CuryDrTot = ISNULL(v.DrCuryAmt,0),
        LedgerID = l.LedgerID, BaseCuryID = l.BaseCuryID, BalanceType = l.BalanceType,
	LUpd_Prog = @ProgID, LUpd_User = @Sol_User, LUpd_DateTime = getdate()
FROM WrkRelease w JOIN Batch b
                    ON b.BatNbr = w.BatNbr
                   AND b.Module = w.module
                  JOIN Ledger l
                    ON l.LedgerID = @LedgerId
             LEFT JOIN vp_03400APBatchUpdate v
                    ON v.BatNbr = b.BatNbr 
WHERE w.UserAddress = @UserAddress AND
        w.Module = 'AP'

IF @@ERROR <> 0 GOTO ABORT



IF (@Debug = 1)
  BEGIN
    SELECT 'Debug...Step 27000: Updating Standard Batch', CONVERT(varchar(30), GETDATE(), 113)
    SELECT * FROM WrkRelease w, Batch b
    WHERE w.UserAddress = @UserAddress AND
          w.Module = 'AP' AND
          w.BatNbr = b.BatNbr AND
	    w.Module = b.Module
    ORDER BY w.Batnbr
    SELECT * FROM vp_03400APBatchUpdate
  END

DECLARE @OutOfBal INT, @FirstBat VARCHAR (10)
SELECT @OutofBal = 0
 INSERT WrkReleaseBad
SELECT w.BatNbr, w.Module, 8888, w.UserAddress, null
FROM wrkrelease w, batch b, currncy c (nolock)
WHERE w.batnbr = b.batnbr and w.module = 'AP' and b.module = 'AP' AND w.UserAddress = @UserAddress  and
b.curyid = c.curyid and
 (round(b.curycrtot, c.decpl) <> round(b.curydrtot, c.decpl) or
  round(b.crtot, @Basedecpl)      <> round(b.drtot, @Basedecpl))

IF @@ERROR < > 0 GOTO ABORT

SELECT @OutofBal = count(*), @FirstBat = min(batnbr)
FROM wrkreleasebad WHERE msgid = 8888 AND useraddress = @useraddress

Select  Top 1 @OutofBal = 1, @FirstBat = w.batnbr
from wrkrelease w, batch b
WHERE
w.batnbr = b.batnbr and w.module = 'AP' and b.module = 'AP' AND w.UserAddress = @UserAddress
and b.Status = 'S'
order by w.batnbr

IF @@ERROR < > 0 GOTO ABORT

CHECK_WRKRELEASEBAD:
IF (@Debug = 1)
  BEGIN
    SELECT 'Debug...Step 80000: Setting ROLLBACK flag', CONVERT(varchar(30), GETDATE(), 113)
    SELECT @outofbal = 1

   Declare @Msgid as Int
    Declare @ErrorMsg As VarChar(255)

    Select @Msgid = 0

    Select @Msgid = Msgid
      from Wrkreleasebad
      Where useraddress = @useraddress

      Select @ErrorMsg = Case @Msgid
                          When 0    Then 'Batch okay, will release normally.'
                          When -1   Then 'Error -1, APDocs have invalid Vendor ID.'
                          When -2   Then 'Error -2, APDocs have invalid Tax ID.'
                          When 6019 Then 'Error 6019, APTrans are missing or the sum of amounts does not match the APDoc'
                          When 12008 Then 'Error 12008, Batch is already released'
                          When 8058 Then 'Error 8058, CuryID does not exist in the Currncy table.'
                          When 16210 Then 'Error 16210, Error in AP_ApplyPP or AP_UnapplyPP.'
                          When 12902 Then 'Error 12902, Application amount is greater than the outstanding document balance.'
                          Else 'UnKnown Error.'
                       End
    Print ''
    Print 'Batch Diagnostics'
    Print @ErrorMsg
    Print ''

    If @Msgid <> 0
       Begin
           Select @Batnbr = Batnbr
              from WrkReleaseBad
              Where useraddress = @useraddress
           Exec pp_03400ExceptionReason @Msgid, @batnbr
       End

    PRINT 'Rolling back transaction'

  END

IF @outofbal > 0 or @Result <> 1 GOTO ABORT
--After releasing original batch, create new manual check batch, if necessary.
EXEC pp_03400CreateApplyManualPmt @Sol_User, @BatNbr, @Result
IF @Result <> 1	GOTO ABORT

COMMIT TRANSACTION

/***** Clear temp tables *****/
delete Wrk_TimeRange      where UserAddress = @UserAddress
delete Wrk_SalesTax  where UserAddress = @UserAddress
delete wrk_aptran         where UserAddress = @UserAddress
delete Wrk_gltran        where Useraddress = @useraddress

GOTO FINISH

ABORT:
ROLLBACK TRANSACTION

IF (@Outofbal > 0 AND(@Debug <> 1))
  BEGIN
    INSERT WrkReleaseBad
    SELECT @FirstBat, 'AP', 8888, @useraddress, null
  END

IF (@Result <> 1) AND (@Debug <> 1)
BEGIN
    INSERT WrkReleaseBad SELECT @BatNbr, 'AP', @Result, @useraddress, null
END

PREABORT:

FINISH:




GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_03400] TO [MSDSL]
    AS [dbo];

