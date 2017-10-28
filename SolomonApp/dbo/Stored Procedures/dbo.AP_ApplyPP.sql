 CREATE PROCEDURE AP_ApplyPP
	@BatNbr		VARCHAR(10),
	@VORefNbr	VARCHAR(10),
	@BaseCuryID	VARCHAR(10),
	@UserID		VARCHAR(10),
	@PPREfNbr VarCHAR(10)  
AS

DECLARE @Cnt		int
DECLARE @BaseDecPl	int
DECLARE @ErrMess	smallInt
DECLARE	@PrevLineNbr	smallint
DECLARE	@ProgID		VARCHAR(8)
DECLARE @PerPost	VarChar(6)

SELECT @PerPost = PerPost from Batch WITH (NOLOCK) where Batnbr = @batnbr and module = 'ap'

SELECT	@ErrMess = 0, @ProgID  = '03070'

IF NOT EXISTS (	SELECT	*
		FROM	AP_PPApplicDet
		WHERE	BatNbr = @BatNbr
		AND	VORefNbr = @VORefNbr
		AND PPRefNbr = @PPRefNbr
		AND	OperType = 'A'
		AND	Rlsed = 0)
   GOTO FINISH

SELECT @BaseDecPl = (SELECT DecPl FROM Currncy (NOLOCK) WHERE CuryID = @BaseCuryID)

/*	application amount is greater than outstanding document balance. Batch cannot be released.
	Please amend corresponding line (12902)
*/
IF EXISTS(
	SELECT	*
	FROM	AP_PPApplicDet pd INNER JOIN APDoc d ON d.RefNbr = pd.VORefNbr AND d.DocType = pd.AppliedDocType
	WHERE	pd.BatNbr = @BatNbr
	AND	pd.VORefNbr = @VORefNbr
	AND pd.PPRefNbr = @PPRefNbr
	AND	pd.Rlsed = 0
	AND	pd.CuryApplyAmt > d.CuryDocBal)

OR EXISTS(
 SELECT pd.PPRefNbr
	FROM	AP_PPApplicDet pd
        INNER JOIN APDoc d ON d.RefNbr = pd.VORefNbr AND d.DocType=pd.AppliedDocType
		INNER JOIN APAdjust j ON pd.PPRefNbr = j.AdjdRefNbr AND j.AdjdDocType = 'PP'
	WHERE	pd.BatNbr = @BatNbr
	AND	pd.VORefNbr = @VORefNbr
	AND pd.PPRefNbr = @PPRefNbr
	AND	pd.Rlsed = 0
	AND	j.CuryAdjdCuryID = d.CuryID
 GROUP BY pd.PPRefNbr
 HAVING max(pd.CuryApplyAmt) > sum(j.CuryAdjdAmt))

OR EXISTS(
	SELECT	*
	FROM	AP_PPApplicDet pd
	     INNER JOIN APDoc d ON d.RefNbr = pd.VORefNbr AND d.DocType = pd.AppliedDocType
	     INNER JOIN APAdjust j ON pd.PPRefNbr = j.AdjdRefNbr AND j.AdjdDocType = 'PP'
	     INNER JOIN Currncy cur (NOLOCK) ON cur.CuryID = d.CuryID
	WHERE	pd.BatNbr = @BatNbr
	AND	pd.VORefNbr = @VORefNbr
	AND pd.PPRefNbr = @PPRefNbr
	AND	pd.Rlsed = 0
	AND	j.CuryAdjdCuryID <> d.CuryID
	AND	j.CuryAdjdCuryID = @BaseCuryID
	AND	CASE
	     WHEN d.CuryMultDiv='M'
             THEN CASE WHEN ROUND(CONVERT(DEC(28,3),j.CuryAdjdAmt)/CONVERT(DEC(19,9),d.CuryRate),cur.DecPl) < pd.CuryApplyAmt
                       THEN ROUND(CONVERT(DEC(28,3),j.CuryAdjdAmt)/CONVERT(DEC(19,9),d.CuryRate),cur.DecPl)
                       ELSE pd.CuryApplyAmt
                  END
             ELSE CASE WHEN ROUND(CONVERT(DEC(28,3),j.CuryAdjdAmt)*CONVERT(DEC(19,9),d.CuryRate),cur.DecPl) < pd.CuryApplyAmt
                       THEN ROUND(CONVERT(DEC(28,3),j.CuryAdjdAmt)*CONVERT(DEC(19,9),d.CuryRate),cur.DecPl)
                       ELSE pd.CuryApplyAmt
                  END
	     END < pd.CuryApplyAmt)

   BEGIN
	SELECT	@ErrMess = 12902
	GOTO ABORT
   END

SELECT	@ErrMess = 16210 /* Error occurred in Batch %s while executing the following procedure: %s */

/***** APAdjust - Prepayment Application - no MC or MC with non base check*****/
INSERT APAdjust
       (AdjAmt,
       AdjBatNbr, AdjBkupWthld, AdjdDocType, AdjDiscAmt, AdjdRefNbr, AdjgAcct, AdjgDocDate,
       AdjgDocType, AdjgPerPost, AdjgRefNbr, AdjgSub,
       Crtd_DateTime, Crtd_Prog, Crtd_User,
       CuryAdjdAmt, CuryAdjdBkupWthld,
       CuryAdjdCuryId, CuryAdjdDiscAmt, CuryAdjdMultDiv, CuryAdjdRate,
       CuryAdjgAmt, CuryAdjgBkupWthld,
       CuryAdjgDiscAmt,
       CuryRGOLAmt,
       DateAppl, LUpd_dateTime, LUpd_prog, LUpd_User, PerAppl, prepay_refnbr,
       S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
       S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12,
       User1, User2, User3, User4, User5, User6, User7, User8, VendId)
SELECT CASE WHEN t.CuryMultDiv = 'M'
            THEN abs(Round(convert(dec(28,3), pd.CuryApplyAmt) * convert(dec(19,9), t.Curyrate), @BaseDecPl))
            ELSE abs(Round(convert(dec(28,3), pd.CuryApplyAmt) / convert(dec(19,9), t.Curyrate), @BaseDecPl))
       END,                                                                                        --AdjAmt
       j.AdjBatNbr, j.AdjBkupWthld, t.TranType, 0, t.RefNbr, j.AdjgAcct, j.AdjgDocDate,
       j.AdjgDocType, j.AdjgPerPost, j.AdjgRefNbr,  j.AdjgSub,
       GETDATE(), @ProgID, @UserID,
       abs(Round(convert(dec(28,3), pd.CuryApplyAmt), cur.DecPl)),                                 --CuryAdjdAmt
       j.CuryAdjdBkupWthld, t.CuryId, 0, t.CuryMultDiv, t.CuryRate,
	   Round(
       CASE WHEN j.CuryadjdMultDiv = 'M'
            THEN abs(Round(convert(dec(28,3), pd.CuryApplyAmt) * convert(dec(19,9), j.Curyadjdrate), cur.DecPl))
            ELSE abs(Round(convert(dec(28,3), pd.CuryApplyAmt) / convert(dec(19,9), j.Curyadjdrate), cur.DecPl))
       END,@BaseDecPl),     j.CuryAdjgBkupWthld,                                                                        --CuryAdjgAmt
       0,
       Round(
       CASE WHEN convert(dec(19,9),t.Curyrate) = convert(dec(19,9),j.CuryAdjdRate)
            THEN 0
            ELSE CASE WHEN j.CuryadjdMultDiv = 'M'
                      THEN abs(Round(convert(dec(28,3), pd.CuryApplyAmt) * convert(dec(19,9), j.Curyadjdrate), @BaseDecPl))
                      ELSE abs(Round(convert(dec(28,3), pd.CuryApplyAmt) / convert(dec(19,9), j.Curyadjdrate), @BaseDecPl))
                 END
                 - /*substract*/
                 CASE WHEN t.CuryMultDiv = 'M'
                      THEN abs(Round(convert(dec(28,3), pd.CuryApplyAmt)  *convert(dec(19,9), t.Curyrate), @BaseDecPl))
                      ELSE abs(Round(convert(dec(28,3), pd.CuryApplyAmt) / convert(dec(19,9), t.Curyrate), @BaseDecPl))
                 END
       END,@BaseDecPl),                                                                             --CuryRGOLAmt
       t.TranDate, GETDATE(), @ProgID, @UserID, @PerPost, pd.PPRefNbr, 
       '', '', 0, 0, 0, 0, '', '', 0, 0, '', @BatNbr,
       '', '', 0, 0, '', '', '', '', t.VendId
FROM AP_PPApplicDet pd
     INNER JOIN APDoc d                       -- VO
         ON pd.VORefNbr=d.RefNbr
            AND d.DocType=pd.AppliedDocType
     INNER JOIN APAdjust j                    -- CK to PP
         ON pd.PPRefNbr=j.AdjdRefNbr
            AND j.AdjdDocType = 'PP'
            AND j.s4future11 <> 'V'           -- new
            AND j.curyadjdcuryid = d.curyid   -- new
     INNER JOIN APTran t                      -- VO APTrans
         ON t.BatNbr = d.BatNbr
            AND d.RefNbr = t.RefNbr
     INNER JOIN Currncy cur (NOLOCK)          -- VO currency
         ON cur.CuryID=d.CuryID
WHERE t.RecordID = (SELECT	MIN(recordid)
                    FROM	aptran x
                    WHERE	x.Batnbr = t.BATNBR
                    AND		x.refnbr = t.refnbr
                    AND		x.TranType IN ('VO','AC'))
AND	pd.BatNbr = @BatNbr
AND	pd.VORefNbr = @VORefNbr
AND pd.pprefnbr = @PPRefNbr
AND	pd.Rlsed = 0

IF @@ERROR < > 0 GOTO ABORT

/** If there are any base PPs applied to non-base VOs, we need to
    ensure that all appropriate rates exist. **/
-- Corrected. Only PP with voucher currency should be recalculated. No RGOL!!!

/***** APAdjust - Prepayment Application MC with Base check*****/
INSERT APAdjust
       (AdjAmt,
       AdjBatNbr, AdjBkupWthld, AdjdDocType, AdjDiscAmt, AdjdRefNbr, AdjgAcct, AdjgDocDate,
       AdjgDocType, AdjgPerPost, AdjgRefNbr, AdjgSub,
       Crtd_DateTime, Crtd_Prog, Crtd_User,
       CuryAdjdAmt, CuryAdjdBkupWthld,
       CuryAdjdCuryId, CuryAdjdDiscAmt, CuryAdjdMultDiv, CuryAdjdRate,
       CuryAdjgAmt, CuryAdjgBkupWthld,
       CuryAdjgDiscAmt,
       CuryRGOLAmt,
       DateAppl, LUpd_dateTime, LUpd_prog, LUpd_User, PerAppl, prepay_refnbr,
       S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
       S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12,
       User1, User2, User3, User4, User5, User6, User7, User8, VendId)
SELECT CASE WHEN t.CuryMultDiv = 'M'
            THEN abs(Round(convert(dec(28,3), pd.CuryApplyAmt) * convert(dec(19,9), t.Curyrate), @BaseDecPl))
            ELSE abs(Round(convert(dec(28,3), pd.CuryApplyAmt) / convert(dec(19,9), t.Curyrate), @BaseDecPl))
       END,                                                                                        --AdjAmt
       j.AdjBatNbr, j.AdjBkupWthld, t.TranType, 0, t.RefNbr, j.AdjgAcct, j.AdjgDocDate,
       j.AdjgDocType, j.AdjgPerPost, j.AdjgRefNbr, j.AdjgSub,
       GETDATE(), @ProgID, @UserID,
       abs(Round(convert(dec(28,3), pd.CuryApplyAmt), Currncy.DecPl)),                        --CuryAdjdAmt
       j.CuryAdjdBkupWthld,t.CuryId, 0, t.CuryMultDiv, t.CuryRate,
       abs(Round(convert(dec(28,3), pd.CuryApplyAmt), Currncy.DecPl)),                                 --CuryAdjgAmt
       j.CuryAdjgBkupWthld, 0,
       0,                                                                                        --CuryRGOLAmt
       t.TranDate, GETDATE(), @ProgID, @UserID, @PerPost, pd.PPRefNbr,
       '', '', 0, 0, 0, 0, '', '', 0, 0, '', @BatNbr,
       '', '', 0, 0, '', '', '', '', t.VendId
FROM AP_PPApplicDet pd
     INNER JOIN APDoc d                       -- VO
         ON pd.VORefNbr=d.RefNbr
            AND d.DocType=pd.AppliedDocType
     INNER JOIN APAdjust j                    -- CK to PP
         ON pd.PPRefNbr=j.AdjdRefNbr
            AND j.AdjdDocType = 'PP'
            AND j.s4future11 <> 'V'           -- new
            AND j.curyadjdcuryid <> d.curyid  -- new
            AND j.curyadjdcuryid = @BaseCuryID-- new
     INNER JOIN APTran t                      -- VO APTrans
         ON t.BatNbr = d.BatNbr
            AND d.RefNbr = t.RefNbr
     INNER JOIN Currncy (NOLOCK)              -- VO currency
         ON Currncy.CuryID=d.CuryID
WHERE	t.RecordID = (SELECT	MIN(recordid)
                      FROM	aptran x
                      WHERE	x.Batnbr = t.BATNBR
                      AND	x.refnbr = t.refnbr
                      AND	x.TranType IN ('VO','AC'))
AND	pd.BatNbr=@BatNbr
AND	pd.VORefNbr = @VORefNbr
AND pd.pprefnbr = @PPRefNbr
AND	pd.Rlsed = 0

IF @@ERROR < > 0 GOTO ABORT

UPDATE	pd
SET	CuryApplyAmt = j.CuryAdjdAmt
FROM	AP_PPApplicDet pd
     INNER JOIN APAdjust jj
         ON jj.AdjdRefNbr = pd.PPRefNbr
            AND jj.AdjdDocType = 'PP'
     INNER JOIN APAdjust j
         ON j.AdjdRefNbr = pd.VORefNbr
            AND j.AdjdDocType = pd.AppliedDocType
            AND j.AdjgRefNbr = jj.AdjgRefNbr
            AND j.AdjgDocType = jj.AdjgDocType
WHERE	pd.BatNbr = @BatNbr
AND	pd.VORefNbr = @VORefNbr
AND pd.pprefnbr = @PPRefNbr
AND	pd.Rlsed = 0

IF @@ERROR < > 0 GOTO ABORT

/*   If the Voucher being applied to the prepayment is only a portion of the original prepayment amount, the original 
     prepayment accounts are relieved proportionally as their percent of the original total. In this process, a
     rounding error could occur. The following statement determines if rounding errors will occur and stores that amount to 
     apply to the last PP offset line when subsequently generating the AP Trans.
*/

SELECT rectoadjust = Max(t.RecordID),
       offset_tranamt = Max(j.AdjAmt + j.CuryRGOLAmt) - Sum(round(round(((convert(dec(28,3),t.tranamt)/convert(dec(28,3),pp.origdocamt)) * convert(dec(28,3),j.AdjAmt+j.CuryRGOLAmt)),@BaseDecPl),@BaseDecPl)),
       offset_curytranamt = Max(j.CuryAdjdAmt) - Sum(round(round(((convert(dec(28,3),t.tranamt)/convert(dec(28,3),pp.origdocamt)) * convert(dec(28,3),j.CuryAdjdAmt)),Currncy.DecPl),Currncy.DecPl))
  INTO #temp_round_adjpp
  FROM AP_PPApplicDet pd
     INNER JOIN APDoc d                                                   -- VO
         ON d.RefNbr=pd.VORefNbr AND d.DocType=pd.AppliedDocType
     INNER JOIN APAdjust jj                                               -- CK to PP
         ON jj.AdjdRefNbr=pd.PPRefNbr AND jj.AdjdDocType='PP'
     INNER JOIN APAdjust j                                                -- CK to VO
         ON j.AdjdRefNbr = d.RefNbr
            AND j.AdjdDocType = d.DocType
            AND j.AdjgRefNbr = jj.AdjgRefNbr
            AND j.AdjgDocType = jj.AdjgDocType
            AND j.s4future11 <> 'V'                                       -- new
     INNER JOIN APDoc pp                                                  -- PP
         ON pp.RefNbr = pd.PPRefNbr AND pp.DocType='PP'
     INNER JOIN APTran t                                                  -- PP APTran
         ON t.RefNbr = pd.PPRefNbr AND t.TranType = 'PP' and t.DrCr = 'D'
     INNER JOIN Currncy (NOLOCK)                                          -- VO Currency
         ON d.CuryID = Currncy.CuryID
     INNER JOIN Vendor v                                                  -- Vendor (new)
          ON d.VendId = v.VendId
WHERE	pd.BatNbr = @BatNbr
AND	pd.VORefNbr = @VORefNbr
AND pd.pprefnbr = @PPRefNbr
AND	pd.Rlsed = 0
Group by j.AdjdRefNbr, j.AdjdDocType, j.AdjgRefNbr, j.AdjgDocType


/*** Insert APTran Pre-payment Offset ***/
INSERT APTran (Acct, AcctDist,  Applied_PPrefNbr, BatNbr, BoxNbr, Component, CostType, CostTypeWO, CpnyId,
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
       S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06, S4Future07, S4Future08, S4Future09, S4Future10,
       S4Future11,
       S4Future12,
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
       POUnitPrice, PPV, QtyVar, RcptLineRef, RcptQty,	SiteId, SoLineRef, SOOrdNbr, SOTypeID, WONbr, WOStepNbr)
SELECT t.Acct, 1, @PPREfNbr, @BatNbr, '', '', '', '', t.CpnyId,
       GETDATE(), @ProgID, @UserID,
       d.CuryId, d.CuryMultDiv, d.CuryRate, 0, 0, 0, 0,
       -- CuryTranAmt (follows)
       round(((convert(dec(28,3),t.tranamt)/convert(dec(28,3),pp.origdocamt)) * convert(dec(28,3),j.CuryAdjdAmt)),Currncy.DecPl) + ISNULL(z.offset_curytranamt,0),
       0, 0, 0, 0, 0,
       'C', '', '', 0, d.InvcNbr, SUBSTRING(@PerPost, 1, 4), 0, '',
       0, 'AP', '', 0, 32767,
       '', '',
       GETDATE(), @ProgID, @UserID,
       d.MasterDocNbr, 0, '', '',
       Case
            When t.PC_Status <> '' then '1'
            Else ''
            End,
       d.PerEnt, @PerPost, '', '', t.ProjectID, 0, '',

       d.RefNbr, 1,
       '', '', 0, 0, 0, 0, '', '', 0, 0,
       Case d.s4Future11
            When 'VM'
            Then d.s4Future11
            Else ''
       End,
       Case d.s4Future11
            When 'VM'
            Then d.s4future12
            Else ''
       End,
       '', t.Sub , t.taskID,
       0, 0, 0, 0, '',
       '', '', '', '', '', '',
        -- TranAmt (follows)
       round(((convert(dec(28,3),t.tranamt)/convert(dec(28,3),pp.origdocamt)) * convert(dec(28,3),j.AdjAmt+j.CuryRGOLAmt)),@BaseDecPl) + ISNULL(z.offset_tranamt,0),
       '', d.DocDate, t.TranDesc, 'PP',
       0, 0, 0, 0,
       '', 0,
       '', '', 0, 0, '', '', '', '',
       d.VendId,
       '','',0,0,0,'',0,'',0,0,0,0,'',0,'','','','','',''
FROM AP_PPApplicDet pd
     INNER JOIN APDoc d                                                   -- VO
         ON d.RefNbr=pd.VORefNbr AND d.DocType=pd.AppliedDocType
     INNER JOIN APAdjust jj                                               -- CK to PP
         ON jj.AdjdRefNbr=pd.PPRefNbr AND jj.AdjdDocType='PP'
     INNER JOIN APAdjust j                                                -- CK to VO
         ON j.AdjdRefNbr = d.RefNbr
            AND j.AdjdDocType = d.DocType
            AND j.AdjgRefNbr = jj.AdjgRefNbr
            AND j.AdjgDocType = jj.AdjgDocType
            AND j.s4future11 <> 'V'                                       -- new
     INNER JOIN APDoc pp                                                  -- PP
         ON pp.RefNbr = pd.PPRefNbr AND pp.DocType='PP'
     INNER JOIN APTran t                                                  -- PP APTran
         ON t.RefNbr = pd.PPRefNbr AND t.TranType = 'PP' and t.DrCr = 'D'
     INNER JOIN Currncy (NOLOCK)                                          -- VO Currency
         ON d.CuryID = Currncy.CuryID
     INNER JOIN Vendor v                                                  -- Vendor (new)
          ON d.VendId = v.VendId
     LEFT JOIN #temp_round_adjpp z 
          ON z.rectoadjust = t.recordid
WHERE	pd.BatNbr = @BatNbr
AND	pd.VORefNbr = @VORefNbr
AND pd.pprefnbr = @PPRefNbr
AND	pd.Rlsed = 0

IF @@ERROR < > 0 GOTO ABORT

/*** Insert symmetric APTrans for credit VO APTrans inserted by VO release ***/
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
        POUnitPrice, PPV, QtyVar, RcptLineRef, RcptQty,	SiteId, SoLineRef, SOOrdNbr, SOTypeID, WONbr, WOStepNbr)
SELECT  t.Acct, 1, @PPREfNbr, @BatNbr, '', '', '', '', t.CpnyId, GETDATE(), @ProgID, @UserID,
	d.CuryId, d.CuryMultDiv, d.CuryRate, 0, 0, 0, 0,
	j.CuryAdjdAmt,
	0, 0, 0, 0, 0,
        'D', '', '', 0, d.InvcNbr, SUBSTRING(@PerPost, 1, 4), 0, '',
        0, 'AP', '', 0, 32767, '', '',
        GETDATE(), @ProgID, @UserID,
        d.MasterDocNbr, 0, '', '', '', d.PerEnt, @PerPost, '', '', '', 0, '',
        d.RefNbr, 1,
        '', '', 0, 0, 0, 0,
        '', '', 0, 0, Case d.s4Future11
                           When 'VM' Then d.s4Future11
                           Else ''
                      End,
                      Case d.s4Future11
                           When 'VM' Then d.s4future12
                          Else ''
                      End,
        '', t.Sub , '',
        0, 0, 0, 0, '',
        '', '', '', '', '', '',
	j.AdjAmt,
	'', d.DocDate, t.TranDesc, 'PP',
        0, 0, 0, 0,
        '', 0,
        '', '', 0, 0, '', '', '', '',
        d.VendId,
	'','',0,0,0,'',0,'',0,
        0,0,0,'',0,'','','','','',''
FROM AP_PPApplicDet pd
     INNER JOIN APDoc d
         ON d.RefNbr = pd.VORefNbr AND d.DocType=pd.AppliedDocType
     INNER JOIN APTran t
         ON t.RefNbr = pd.VORefNbr AND t.TranType = pd.AppliedDocType and t.DrCr = 'C'
     INNER JOIN APAdjust jj
         ON jj.AdjdRefNbr = pd.PPRefNbr AND jj.AdjdDocType='PP'
     INNER JOIN APAdjust j
         ON j.AdjdRefNbr = d.RefNbr AND j.AdjdDocType = d.DocType
            AND j.AdjgRefNbr = jj.AdjgRefNbr AND j.AdjgDocType=jj.AdjgDocType
WHERE	pd.BatNbr = @BatNbr
AND	pd.VORefNbr = @VORefNbr
AND pd.pprefnbr = @PPRefNbr
AND	pd.Rlsed = 0

IF @@ERROR < > 0 GOTO ABORT

/*** update VO apdoc to adjust for pre-payment applied ***/
UPDATE d
SET CuryDocBal =  CASE WHEN j.CuryAdjdAmt > d.CuryDocBal
                       THEN 0
                       ELSE round((convert(dec(28,3),d.CuryDocBal) - convert(dec(28,3),j.CuryAdjdAmt)),Currncy.DecPl)
                  END,
    CuryDiscBal = CASE WHEN j.CuryAdjdDiscAmt > d.CuryDiscBal
                       THEN 0
                       ELSE round((convert(dec(28,3),d.CuryDiscBal )- convert(dec(28,3),j.CuryAdjdDiscAmt)),Currncy.DecPl)
                  END,
    DocBal =      CASE WHEN j.AdjAmt > d.DocBal
                       THEN 0
                       ELSE round((convert(dec(28,3),d.DocBal) - convert(dec(28,3),j.AdjAmt)),@BaseDecPl)
                  END,
    DiscBal =     CASE WHEN j.AdjDiscAmt > d.DiscBal
                       THEN 0
                       ELSE round((convert(dec(28,3),d.DiscBal) - convert(dec(28,3),j.AdjDiscAmt)),@BaseDecPl)
                  END,
    PerClosed =   CASE WHEN round((convert(dec(28,3),d.DocBal) - convert(dec(28,3),j.AdjAmt)),@BaseDecPl)<=0
                       THEN j.PerAppl
                       Else PerClosed
                  END,
    OpenDoc =     CASE WHEN round((convert(dec(28,3),d.DocBal) - convert(dec(28,3),j.AdjAmt)),@BaseDecPl)<=0
                       THEN 0
                       Else OpenDoc
                  END,
    LUpd_DateTime = GETDATE(), LUpd_Prog = @ProgID, LUpd_User = @UserID--,
FROM AP_PPApplicDet pd
     INNER JOIN APDoc d                       -- VO
         ON d.RefNbr = pd.VORefNbr
            AND d.DocType = pd.AppliedDocType
     INNER JOIN APAdjust jj                   -- CK to PP
         ON jj.AdjdRefNbr = pd.PPRefNbr
            AND jj.AdjdDocType = 'PP'
     INNER JOIN APAdjust j                    -- CK to VO
         ON d.RefNbr = j.AdjdRefNbr
            AND j.AdjdDocType = d.DocType
            AND j.AdjgRefNbr = jj.AdjgRefNbr
            AND j.AdjgDocType = jj.AdjgDocType
     INNER JOIN Currncy (NOLOCK)
         ON d.CuryID = Currncy.CuryID
WHERE	pd.BatNbr = @BatNbr
AND	pd.VORefNbr = @VORefNbr
AND pd.pprefnbr = @PPRefNbr
AND	pd.Rlsed = 0

IF @@ERROR < > 0 GOTO ABORT

/*** update original prepayment APAdjust record ***/
UPDATE j
SET adjamt =    CASE WHEN j.AdjAmt > j2.CuryAdjgAmt
                     THEN round(convert(dec(28,3),j.AdjAmt) - convert(dec(28,3),j2.CuryAdjgAmt),@BaseDecPl)
                     ELSE 0
                END,
    curyadjdamt=CASE WHEN j.CuryAdjdAmt > j2.CuryAdjdAmt
                     THEN round(convert(dec(28,3),j.CuryAdjdAmt) - convert(dec(28,3), j2.CuryAdjdAmt),Currncy.DecPl)
                     ELSE 0
                END,
    curyadjgamt=CASE WHEN j.CuryAdjgAmt > j2.CuryAdjgAmt
                     THEN round(convert(dec(28,3),j.CuryAdjgAmt) - convert(dec(28,3),j2.CuryAdjgAmt),Currncy.DecPl)
                     ELSE 0
                END,
    LUpd_DateTime = GETDATE(), LUpd_Prog = @ProgID, LUpd_User = @UserID
FROM AP_PPApplicDet pd
     INNER JOIN APDoc d                     -- VO
         ON d.RefNbr=pd.VORefNbr
            AND d.DocType=pd.AppliedDocType
     INNER JOIN APAdjust j                  -- CK to PP
         ON j.AdjdRefNbr=pd.PPRefNbr
            AND j.AdjdDocType = 'PP'
            AND j.s4future11 <> 'V'         -- new
     INNER JOIN APAdjust j2                 -- CK to VO
         ON j2.AdjdRefNbr=pd.VORefNbr
            AND j2.AdjdDocType=pd.AppliedDocType
            AND j2.AdjgRefNbr=j.AdjgRefNbr
            AND j2.AdjgDocType=j.AdjgDocType
     INNER JOIN Currncy (NOLOCK)
	ON j.CuryAdjdCuryID = Currncy.CuryID  -- PP Currency
WHERE	pd.BatNbr = @BatNbr
AND	pd.VORefNbr = @VORefNbr
AND pd.pprefnbr = @PPRefNbr
AND	pd.Rlsed = 0

IF @@ERROR < > 0 GOTO ABORT

/*** RGOL transactions for prepayments applied ***/
INSERT APTran
       (Acct,
       AcctDist, Applied_PPrefNbr, BatNbr, BoxNbr, Component, CostType, CostTypeWO, CpnyId,
       Crtd_DateTime, Crtd_Prog, Crtd_User,
       CuryId, CuryMultDiv, CuryRate,
       CuryTaxAmt00, CuryTaxAmt01, CuryTaxAmt02, CuryTaxAmt03, CuryTranAmt, CuryTxblAmt00,
       CuryTxblAmt01, CuryTxblAmt02, CuryTxblAmt03, CuryUnitPrice,
       DrCr,
       Employee, EmployeeID, Excpt, ExtRefNbr, FiscYr, InstallNbr, InvcTypeId,
       JobRate, JrnlType, Labor_Class_Cd, LineId, LineNbr, LineRef, LineType,
       LUpd_dateTime, LUpd_Prog, LUpd_User,
       MasterDocNbr, NoteID, PC_Flag, PC_ID, PC_Status, PerEnt, PerPost, PmtMethod, POLineRef,
       ProjectID, Qty, Rcptnbr, RefNbr, Rlsed,
       S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
       S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ServiceDate,
       Sub,
       TaskID, TaxAmt00, TaxAmt01, TaxAmt02, TaxAmt03, TaxCalced,
       TaxCat, TaxId00, TaxId01, TaxId02, TaxId03, TaxIdDflt,
       TranAmt,
       TranClass, TranDate,
       TranDesc,
       TranType,
       TxblAmt00, TxblAmt01, TxblAmt02, TxblAmt03, UnitDesc, UnitPrice,
       User1, User2, User3, User4, User5, User6, User7, User8, VendId,
       AlternateID, BOMLineRef, CuryPOExtPrice, CuryPOUnitPrice, CuryPPV, InvtID, POExtPrice,
       PONbr, POQty, POUnitPrice, PPV, QtyVar, RcptLineRef, RcptQty,
       SiteId, SoLineRef, SOOrdNbr, SOTypeID, WONbr, WOStepNbr)
SELECT CASE WHEN j.CuryRGOLAmt > 0
            THEN c.RealLossAcct
            ELSE c.RealGainAcct
       END,                                                                  -- Acct
       1, @PPREfNbr, @BatNbr, '', '', '', '', d.CpnyId,
       GETDATE(), @ProgID, @UserID,
       d.CuryId, d.CuryMultDiv, d.CuryRate,
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
       CASE WHEN j.CuryRGOLAmt > 0
            THEN 'D'
            ELSE 'C'
       END,                                                                  -- DrCr
       '', '', 0, d.InvcNbr, SUBSTRING(@PerPost, 1, 4), d.InstallNbr, '',
       0, 'AP', '', 0, 32767, '', '',
       GETDATE(), @ProgID, @UserID,
       d.MasterDocNbr, 0, '', '', '', d.PerEnt, @PerPost, '', '',
       '', 0, '', d.RefNbr, 1,
       '', '', 0, 0, 0, 0, '', '', 0, 0, '', '', '',
       CASE WHEN j.CuryRGOLAmt > 0
            THEN c.RealLossSub
            ELSE c.RealGainSub
       END,                                    -- Sub
       '', 0, 0, 0, 0, '', '', '', '', '', '', '',
       abs(j.CuryRGOLAmt),                                                   -- TranAmt
       '', d.DocDate,
       CASE WHEN j.CuryRGOLAmt > 0
            THEN 'Realized Loss' + ' ' + p.CuryID
            ELSE 'Realized Gain' + ' ' + p.CuryID
       END,                                                                  -- TranDesc
       CASE WHEN j.CuryRGOLAmt > 0
            THEN 'RL'
            ELSE 'RG'
       END,                                                                  -- TranType
       0, 0, 0, 0, '', 0,
       '', '', 0, 0, '', '', '', '', d.VendId,
       '','',0,0,0,'',0,'',0,0,0,0,'',0,'','','','','',''
FROM AP_PPApplicDet pd
     INNER JOIN APDoc d
         ON d.RefNbr=pd.VORefNbr AND d.DocType=pd.AppliedDocType
     INNER JOIN APAdjust jj
         ON jj.AdjdRefNbr=pd.PPRefNbr AND jj.AdjdDocType='PP'
     INNER JOIN APAdjust j
         ON d.RefNbr = j.AdjdRefNbr AND j.AdjdDocType = pd.AppliedDocType
            AND j.AdjgRefNbr=jj.AdjgRefNbr AND j.AdjgDocType=jj.AdjgDocType
     INNER JOIN APDoc p
         ON p.DocType='PP' AND p.RefNbr=pd.PPRefNbr
     INNER JOIN Currncy c (NOLOCK)
         ON p.CuryID = c.CuryID
WHERE	j.CuryRGOLAmt <> 0
AND	pd.BatNbr = @BatNbr
AND	pd.VORefNbr = @VORefNbr
AND pd.pprefnbr = @PPRefNbr
AND	pd.Rlsed = 0

IF @@ERROR <> 0 GOTO ABORT

/***** Create Vendor AP_Balances Record If Does Not Exist 	*****/
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
         ON d.RefNbr=pd.VORefNbr AND d.DocType=pd.AppliedDocType
     INNER JOIN Vendor v
         ON d.VendID=v.VendID
     INNER JOIN APAdjust jj
         ON jj.AdjdRefNbr=pd.PPRefNbr AND jj.AdjdDocType='PP'
     INNER JOIN APAdjust j
         ON d.RefNbr = j.AdjdRefNbr AND j.AdjdDocType = d.DocType
            AND j.AdjgRefNbr=jj.AdjgRefNbr AND j.AdjgDocType=jj.AdjgDocType AND j.CuryRGOLAmt<>0
     LEFT OUTER JOIN AP_Balances b
        ON d.cpnyid = b.cpnyid and d.vendid = b.vendid
WHERE	b.CpnyId IS NULL
AND	pd.BatNbr = @BatNbr
AND	pd.VORefNbr = @VORefNbr
AND pd.pprefnbr = @PPRefNbr
AND	pd.Rlsed = 0

IF @@ERROR < > 0 GOTO ABORT

/*** update vendor balances with prepayment RGOL ***/
UPDATE	AP_Balances
SET	CurrBal = ROUND(CurrBal+deltaCurr, @BaseDecPl), FutureBal = ROUND(FutureBal+deltaFuture, @BaseDecPl),
	                                 LUpd_DateTime = GETDATE(), LUpd_Prog = @ProgID, LUpd_User = @UserID

FROM (SELECT dVendID = d.VendID, dCpnyID=d.CpnyID,
             deltaCurr = SUM(CASE WHEN d.PerPost <= s.CurrPerNbr THEN convert(dec(28,3), j.CuryRGOLAmt) ELSE 0 END),
             deltaFuture = SUM(CASE WHEN d.PerPost > s.CurrPerNbr THEN convert(dec(28,3), j.CuryRGOLAmt) ELSE 0 END)
      FROM AP_PPApplicDet pd
           INNER JOIN APDoc d
               ON d.RefNbr = pd.VORefNbr AND d.DocType=pd.AppliedDocType
           INNER JOIN APAdjust jj
               ON jj.AdjdRefNbr = pd.PPRefNbr AND jj.AdjdDocType='PP'
           INNER JOIN APAdjust j
               ON d.RefNbr = j.AdjdRefNbr AND j.AdjdDocType = d.DocType
                  AND j.AdjgRefNbr=jj.AdjgRefNbr AND j.AdjgDocType = jj.AdjgDocType AND j.CuryRGOLAmt <> 0
           CROSS JOIN APSetup s (NOLOCK)
      WHERE pd.BatNbr = @BatNbr
      AND   pd.VORefNbr = @VORefNbr
      AND   pd.Rlsed = 0
      GROUP BY d.VendID, d.CpnyID) s
WHERE	VendID = dVendID
AND	CpnyID=dCpnyID

IF @@ERROR <> 0 GOTO ABORT

/***** Add New AP_Hist Record if Vendor Does Not Exist *****/
INSERT APHist (BegBal, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User,
                    CuryID, FiscYr, LUpd_DateTime, LUpd_Prog, LUpd_User,
                    NoteID, PerNbr, PtdBkupWthld00, PtdBkupWthld01,
        PtdBkupWthld02, PtdBkupWthld03, PtdBkupWthld04, PtdBkupWthld05, PtdBkupWthld06, PtdBkupWthld07,
        PtdBkupWthld08, PtdBkupWthld09, PtdBkupWthld10, PtdBkupWthld11, PtdBkupWthld12, PtdCrAdjs00, PtdCrAdjs01, PtdCrAdjs02,
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
                    User7, User8, VendId, YtdBkupWthld, YtdCrAdjs, YtdDiscTkn,
                    YtdDrAdjs, YtdPaymt, YtdPurch)

SELECT 0, dCpnyId, GETDATE(), @ProgID, @UserID, v.CuryID, dFiscYr, GETDATE(), @ProgID, @UserID,
       0, CASE WHEN dFiscYr < SUBSTRING(APSetup.CurrPerNbr , 1, 4)
               THEN dFiscYr + CONVERT(CHAR(2), GLSetup.NbrPer)
               ELSE dPerPost END,
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
       '', '', 0, 0, 0, 0, '', '', 0, 0, '', '',
       '', '', 0, 0, '', '', '', '', v.VendId, 0, 0, 0, 0, 0, 0
FROM APSetup (NOLOCK) CROSS JOIN GLSetup (NOLOCK) CROSS JOIN
     (SELECT dVendID = d.VendID,  dCpnyID = d.CpnyID, dFiscYr = SUBSTRING(d.PerPost,1,4), dPerPost = MAX(d.PerPost)
      FROM AP_PPApplicDet pd
           INNER JOIN APDoc d
               ON d.RefNbr = pd.VORefNbr AND d.DocType=pd.AppliedDocType
           INNER JOIN APAdjust jj
               ON jj.AdjdRefNbr = pd.PPRefNbr AND jj.AdjdDocType='PP'
           INNER JOIN APAdjust j
               ON d.RefNbr = j.AdjdRefNbr AND j.AdjdDocType = d.DocType
                  AND j.AdjgRefNbr = jj.AdjgRefNbr AND j.AdjgDocType = jj.AdjgDocType AND j.CuryRGOLAmt <> 0
      WHERE pd.BatNbr = @BatNbr
      AND   pd.VORefNbr = @VORefNbr
      AND   pd.Rlsed = 0
      GROUP BY d.VendID, d.CpnyID, SUBSTRING(d.PerPost,1,4)) s
      INNER JOIN Vendor v
          ON dVendID = v.VendID
      LEFT JOIN APHist h
          ON h.VendID = dVendID AND h.CpnyID=dCpnyID AND h.FiscYr=dFiscYr
WHERE h.CpnyID IS NULL

IF @@ERROR <> 0 GOTO ABORT

/***** Update AP History *****/
UPDATE APHist SET
	LUpd_DateTime = GETDATE(), LUpd_Prog = @ProgID, LUpd_User = @UserID,
	PtdPaymt00 = ROUND(PtdPaymt00 - deltaPtd00, @BaseDecPl),
	PtdPaymt01 = ROUND(PtdPaymt01 - deltaPtd01, @BaseDecPl),
	PtdPaymt02 = ROUND(PtdPaymt02 - deltaPtd02, @BaseDecPl),
	PtdPaymt03 = ROUND(PtdPaymt03 - deltaPtd03, @BaseDecPl),
	PtdPaymt04 = ROUND(PtdPaymt04 - deltaPtd04, @BaseDecPl),
	PtdPaymt05 = ROUND(PtdPaymt05 - deltaPtd05, @BaseDecPl),
	PtdPaymt06 = ROUND(PtdPaymt06 - deltaPtd06, @BaseDecPl),
	PtdPaymt07 = ROUND(PtdPaymt07 - deltaPtd07, @BaseDecPl),
	PtdPaymt08 = ROUND(PtdPaymt08 - deltaPtd08, @BaseDecPl),
	PtdPaymt09 = ROUND(PtdPaymt09 - deltaPtd09, @BaseDecPl),
	PtdPaymt10 = ROUND(PtdPaymt10 - deltaPtd10, @BaseDecPl),
	PtdPaymt11 = ROUND(PtdPaymt11 - deltaPtd11, @BaseDecPl),
	PtdPaymt12 = ROUND(PtdPaymt12 - deltaPtd12, @BaseDecPl),
	YtdPaymt = ROUND(YtdPaymt - deltaYtd, @BaseDecPl)
FROM (SELECT dVendID=d.VendID, dCpnyID=d.CpnyID, dFiscYr=SUBSTRING(d.PerPost,1,4),
             deltaPtd00=SUM(CASE WHEN SUBSTRING(d.PerPost,5,2)='01' THEN convert(dec(28,3),j.CuryRGOLAmt) ELSE 0 END),
             deltaPtd01=SUM(CASE WHEN SUBSTRING(d.PerPost,5,2)='02' THEN convert(dec(28,3),j.CuryRGOLAmt) ELSE 0 END),
             deltaPtd02=SUM(CASE WHEN SUBSTRING(d.PerPost,5,2)='03' THEN convert(dec(28,3),j.CuryRGOLAmt) ELSE 0 END),
             deltaPtd03=SUM(CASE WHEN SUBSTRING(d.PerPost,5,2)='04' THEN convert(dec(28,3),j.CuryRGOLAmt) ELSE 0 END),
             deltaPtd04=SUM(CASE WHEN SUBSTRING(d.PerPost,5,2)='05' THEN convert(dec(28,3),j.CuryRGOLAmt) ELSE 0 END),
             deltaPtd05=SUM(CASE WHEN SUBSTRING(d.PerPost,5,2)='06' THEN convert(dec(28,3),j.CuryRGOLAmt) ELSE 0 END),
             deltaPtd06=SUM(CASE WHEN SUBSTRING(d.PerPost,5,2)='07' THEN convert(dec(28,3),j.CuryRGOLAmt) ELSE 0 END),
             deltaPtd07=SUM(CASE WHEN SUBSTRING(d.PerPost,5,2)='08' THEN convert(dec(28,3),j.CuryRGOLAmt) ELSE 0 END),
             deltaPtd08=SUM(CASE WHEN SUBSTRING(d.PerPost,5,2)='09' THEN convert(dec(28,3),j.CuryRGOLAmt) ELSE 0 END),
             deltaPtd09=SUM(CASE WHEN SUBSTRING(d.PerPost,5,2)='10' THEN convert(dec(28,3),j.CuryRGOLAmt) ELSE 0 END),
             deltaPtd10=SUM(CASE WHEN SUBSTRING(d.PerPost,5,2)='11' THEN convert(dec(28,3),j.CuryRGOLAmt) ELSE 0 END),
             deltaPtd11=SUM(CASE WHEN SUBSTRING(d.PerPost,5,2)='12' THEN convert(dec(28,3),j.CuryRGOLAmt) ELSE 0 END),
             deltaPtd12=SUM(CASE WHEN SUBSTRING(d.PerPost,5,2)='13' THEN convert(dec(28,3),j.CuryRGOLAmt) ELSE 0 END),
             deltaYtd=SUM(convert(dec(28,3),j.CuryRGOLAmt))
      FROM AP_PPApplicDet pd
           INNER JOIN APDoc d
               ON d.RefNbr = pd.VORefNbr AND d.DocType=pd.AppliedDocType
           INNER JOIN APAdjust jj
               ON jj.AdjdRefNbr = pd.PPRefNbr AND jj.AdjdDocType='PP'
           INNER JOIN APAdjust j
               ON d.RefNbr = j.AdjdRefNbr AND j.AdjdDocType = d.DocType
                  AND j.AdjgRefNbr = jj.AdjgRefNbr AND j.AdjgDocType=jj.AdjgDocType AND j.CuryRGOLAmt<>0
      WHERE pd.BatNbr = @BatNbr
      AND   pd.VORefNbr = @VORefNbr
      AND   pd.Rlsed = 0
      GROUP BY d.VendID, d.CpnyID, SUBSTRING(d.PerPost,1,4)) s
WHERE	VendID = dVendID
AND	CpnyID = dCpnyID
AND	FiscYr = dFiscYr

IF @@ERROR < > 0 GOTO ABORT

/*** update check RGOLAmt field ***/
UPDATE	c
SET	c.LUpd_Prog = @ProgID,
	c.LUpd_User = @UserID,
	c.LUpd_DateTime = getdate(),
	c.RGOLAmt = ROUND(c.RGOLAmt - j.CuryRGOLAmt, @BaseDecPl)
FROM AP_PPApplicDet pd
     INNER JOIN APAdjust jj
         ON jj.AdjdRefNbr=pd.PPRefNbr AND jj.AdjdDocType='PP'
     INNER JOIN APDoc c
         ON c.DocType=jj.AdjgDocType AND c.RefNbr=jj.AdjgRefNbr
     INNER JOIN (SELECT j1.AdjgRefNbr, j1.AdjgDocType, sum(j1.CuryRGOLAmt) AS CuryRGOLAmt
                 FROM AP_PPApplicDet pd1
                      INNER JOIN APAdjust j1
                          ON j1.AdjdRefNbr=pd1.VORefNbr
               WHERE j1.AdjdDocType=pd1.AppliedDocType
                       AND pd1.BatNbr=@BatNbr
                       AND j1.CuryRGOLAmt <> 0
                 GROUP BY j1.AdjgRefNbr, j1.AdjgDocType) j
         ON j.AdjgRefNbr=c.RefNbr AND j.AdjgDocType=c.DocType
WHERE	pd.BatNbr = @BatNbr
AND	pd.VORefNbr = @VORefNbr
AND pd.pprefnbr = @PPRefNbr
AND	pd.Rlsed = 0

IF @@ERROR <> 0 GOTO ABORT

UPDATE	AP_PPApplicDet
SET	LUpd_Prog = @ProgID,
	LUpd_User = @UserID,
	LUpd_DateTime = getdate(),
	Rlsed = 1
WHERE	BatNbr = @BatNbr
AND	VORefNbr = @VORefNbr
AND PPRefNbr = @PPRefNbr
AND	Rlsed = 0

IF @@ERROR <> 0 GOTO ABORT

SELECT	@ErrMess=1

GOTO FINISH

ABORT:

FINISH:
	RETURN @ErrMess




GO
GRANT CONTROL
    ON OBJECT::[dbo].[AP_ApplyPP] TO [MSDSL]
    AS [dbo];

