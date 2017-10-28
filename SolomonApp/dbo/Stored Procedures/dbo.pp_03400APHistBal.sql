 --USETHISSYNTAX

CREATE PROCEDURE pp_03400APHistBal @UserAddress VARCHAR(21), @ProgID CHAR(8), @Sol_User Char(10), @Pernbr CHAR(6), @DecPl INT, @Result INT OUTPUT AS

/***** File Name: 0375pp_03400APHistBal.Sql				*****/
/***** Last Modified by Tawnya James on 7/09/99 at 11:45am   	*****/
/***** 12/2/98  DCM  Split apart 1099 boxes for current & future years for AP_Balances Table.  *****/
/***** 12/10/98 CSS  "Close Zeros Documents" - Joined Update to WrkRelease/Batnbr so only those batches being released get updated. *****/
/***** 1/14/98  DCM  Replaced 2 for rounding with @DecPl since not rounding AP_Balances.Currbal correctly.  *****/

---DECLARE @Progid CHAR (8)
---DECLARE @Sol_User CHAR (10)

---SELECT @ProgID =   '03400',
---       @Sol_User = 'SOLOMON'


/***** Update AP History *****/

UPDATE APHist SET
	LUpd_DateTime = GETDATE(), LUpd_Prog = @ProgID, LUpd_User = @Sol_User,
	PtdCrAdjs00 = ROUND(h.PtdCrAdjs00 + v.PtdCrAdjs00, @DecPl),
	PtdCrAdjs01 = ROUND(h.PtdCrAdjs01 + v.PtdCrAdjs01, @DecPl),
	PtdCrAdjs02 = ROUND(h.PtdCrAdjs02 + v.PtdCrAdjs02, @DecPl),
	PtdCrAdjs03 = ROUND(h.PtdCrAdjs03 + v.PtdCrAdjs03, @DecPl),
	PtdCrAdjs04 = ROUND(h.PtdCrAdjs04 + v.PtdCrAdjs04, @DecPl),
	PtdCrAdjs05 = ROUND(h.PtdCrAdjs05 + v.PtdCrAdjs05, @DecPl),
	PtdCrAdjs06 = ROUND(h.PtdCrAdjs06 + v.PtdCrAdjs06, @DecPl),
	PtdCrAdjs07 = ROUND(h.PtdCrAdjs07 + v.PtdCrAdjs07, @DecPl),
	PtdCrAdjs08 = ROUND(h.PtdCrAdjs08 + v.PtdCrAdjs08, @DecPl),
	PtdCrAdjs09 = ROUND(h.PtdCrAdjs09 + v.PtdCrAdjs09, @DecPl),
	PtdCrAdjs10 = ROUND(h.PtdCrAdjs10 + v.PtdCrAdjs10, @DecPl),
	PtdCrAdjs11 = ROUND(h.PtdCrAdjs11 + v.PtdCrAdjs11, @DecPl),
	PtdCrAdjs12 = ROUND(h.PtdCrAdjs12 + v.PtdCrAdjs12, @DecPl),
	PtdDiscTkn00 = ROUND(h.PtdDiscTkn00 + v.PtdDiscTkn00, @DecPl),
	PtdDiscTkn01 = ROUND(h.PtdDiscTkn01 + v.PtdDiscTkn01, @DecPl),
	PtdDiscTkn02 = ROUND(h.PtdDiscTkn02 + v.PtdDiscTkn02, @DecPl),
	PtdDiscTkn03 = ROUND(h.PtdDiscTkn03 + v.PtdDiscTkn03, @DecPl),
	PtdDiscTkn04 = ROUND(h.PtdDiscTkn04 + v.PtdDiscTkn04, @DecPl),
	PtdDiscTkn05 = ROUND(h.PtdDiscTkn05 + v.PtdDiscTkn05, @DecPl),
	PtdDiscTkn06 = ROUND(h.PtdDiscTkn06 + v.PtdDiscTkn06, @DecPl),
	PtdDiscTkn07 = ROUND(h.PtdDiscTkn07 + v.PtdDiscTkn07, @DecPl),
	PtdDiscTkn08 = ROUND(h.PtdDiscTkn08 + v.PtdDiscTkn08, @DecPl),
	PtdDiscTkn09 = ROUND(h.PtdDiscTkn09 + v.PtdDiscTkn09, @DecPl),
	PtdDiscTkn10 = ROUND(h.PtdDiscTkn10 + v.PtdDiscTkn10, @DecPl),
	PtdDiscTkn11 = ROUND(h.PtdDiscTkn11 + v.PtdDiscTkn11, @DecPl),
	PtdDiscTkn12 = ROUND(h.PtdDiscTkn12 + v.PtdDiscTkn12, @DecPl),
	PtdDrAdjs00 = ROUND(h.PtdDrAdjs00 + v.PtdDrAdjs00, @DecPl),
	PtdDrAdjs01 = ROUND(h.PtdDrAdjs01 + v.PtdDrAdjs01, @DecPl),
	PtdDrAdjs02 = ROUND(h.PtdDrAdjs02 + v.PtdDrAdjs02, @DecPl),
	PtdDrAdjs03 = ROUND(h.PtdDrAdjs03 + v.PtdDrAdjs03, @DecPl),
	PtdDrAdjs04 = ROUND(h.PtdDrAdjs04 + v.PtdDrAdjs04, @DecPl),
	PtdDrAdjs05 = ROUND(h.PtdDrAdjs05 + v.PtdDrAdjs05, @DecPl),
	PtdDrAdjs06 = ROUND(h.PtdDrAdjs06 + v.PtdDrAdjs06, @DecPl),
	PtdDrAdjs07 = ROUND(h.PtdDrAdjs07 + v.PtdDrAdjs07, @DecPl),
	PtdDrAdjs08 = ROUND(h.PtdDrAdjs08 + v.PtdDrAdjs08, @DecPl),
	PtdDrAdjs09 = ROUND(h.PtdDrAdjs09 + v.PtdDrAdjs09, @DecPl),
	PtdDrAdjs10 = ROUND(h.PtdDrAdjs10 + v.PtdDrAdjs10, @DecPl),
	PtdDrAdjs11 = ROUND(h.PtdDrAdjs11 + v.PtdDrAdjs11, @DecPl),
	PtdDrAdjs12 = ROUND(h.PtdDrAdjs12 + v.PtdDrAdjs12, @DecPl),
	PtdPaymt00 = ROUND(h.PtdPaymt00 + v.PtdPaymt00, @DecPl),
	PtdPaymt01 = ROUND(h.PtdPaymt01 + v.PtdPaymt01, @DecPl),
	PtdPaymt02 = ROUND(h.PtdPaymt02 + v.PtdPaymt02, @DecPl),
	PtdPaymt03 = ROUND(h.PtdPaymt03 + v.PtdPaymt03, @DecPl),
	PtdPaymt04 = ROUND(h.PtdPaymt04 + v.PtdPaymt04, @DecPl),
	PtdPaymt05 = ROUND(h.PtdPaymt05 + v.PtdPaymt05, @DecPl),
	PtdPaymt06 = ROUND(h.PtdPaymt06 + v.PtdPaymt06, @DecPl),
	PtdPaymt07 = ROUND(h.PtdPaymt07 + v.PtdPaymt07, @DecPl),
	PtdPaymt08 = ROUND(h.PtdPaymt08 + v.PtdPaymt08, @DecPl),
	PtdPaymt09 = ROUND(h.PtdPaymt09 + v.PtdPaymt09, @DecPl),
	PtdPaymt10 = ROUND(h.PtdPaymt10 + v.PtdPaymt10, @DecPl),
	PtdPaymt11 = ROUND(h.PtdPaymt11 + v.PtdPaymt11, @DecPl),
	PtdPaymt12 = ROUND(h.PtdPaymt12 + v.PtdPaymt12, @DecPl),
	PtdPurch00 = ROUND(h.PtdPurch00 + v.PtdPurch00, @DecPl),
	PtdPurch01 = ROUND(h.PtdPurch01 + v.PtdPurch01, @DecPl),
	PtdPurch02 = ROUND(h.PtdPurch02 + v.PtdPurch02, @DecPl),
	PtdPurch03 = ROUND(h.PtdPurch03 + v.PtdPurch03, @DecPl),
	PtdPurch04 = ROUND(h.PtdPurch04 + v.PtdPurch04, @DecPl),
	PtdPurch05 = ROUND(h.PtdPurch05 + v.PtdPurch05, @DecPl),
	PtdPurch06 = ROUND(h.PtdPurch06 + v.PtdPurch06, @DecPl),
	PtdPurch07 = ROUND(h.PtdPurch07 + v.PtdPurch07, @DecPl),
	PtdPurch08 = ROUND(h.PtdPurch08 + v.PtdPurch08, @DecPl),
	PtdPurch09 = ROUND(h.PtdPurch09 + v.PtdPurch09, @DecPl),
	PtdPurch10 = ROUND(h.PtdPurch10 + v.PtdPurch10, @DecPl),
	PtdPurch11 = ROUND(h.PtdPurch11 + v.PtdPurch11, @DecPl),
	PtdPurch12 = ROUND(h.PtdPurch12 + v.PtdPurch12, @DecPl),
	PtdBkupWthld00 = ROUND(h.PtdBkupWthld00 + v.PtdBkupWthld00, @DecPl),
	PtdBkupWthld01 = ROUND(h.PtdBkupWthld01 + v.PtdBkupWthld01, @DecPl),
	PtdBkupWthld02 = ROUND(h.PtdBkupWthld02 + v.PtdBkupWthld02, @DecPl),
	PtdBkupWthld03 = ROUND(h.PtdBkupWthld03 + v.PtdBkupWthld03, @DecPl),
	PtdBkupWthld04 = ROUND(h.PtdBkupWthld04 + v.PtdBkupWthld04, @DecPl),
	PtdBkupWthld05 = ROUND(h.PtdBkupWthld05 + v.PtdBkupWthld05, @DecPl),
	PtdBkupWthld06 = ROUND(h.PtdBkupWthld06 + v.PtdBkupWthld06, @DecPl),
	PtdBkupWthld07 = ROUND(h.PtdBkupWthld07 + v.PtdBkupWthld07, @DecPl),
	PtdBkupWthld08 = ROUND(h.PtdBkupWthld08 + v.PtdBkupWthld08, @DecPl),
	PtdBkupWthld09 = ROUND(h.PtdBkupWthld09 + v.PtdBkupWthld09, @DecPl),
	PtdBkupWthld10 = ROUND(h.PtdBkupWthld10 + v.PtdBkupWthld10, @DecPl),
	PtdBkupWthld11 = ROUND(h.PtdBkupWthld11 + v.PtdBkupWthld11, @DecPl),
	PtdBkupWthld12 = ROUND(h.PtdBkupWthld12 + v.PtdBkupWthld12, @DecPl),
	YtdBkupWthld = ROUND(h.YtdBkupWthld + v.YtdBkupWthld, @DecPl),
	YtdCrAdjs = ROUND(h.YtdCrAdjs + v.YtdCrAdjs, @DecPl),
	YtdDiscTkn = ROUND(h.YtdDiscTkn + v.YtdDiscTkn, @DecPl),
	YtdDrAdjs = ROUND(h.YtdDrAdjs + v.YtdDrAdjs, @DecPl),
	YtdPaymt = ROUND(h.YtdPaymt + v.YtdPaymt, @DecPl),
	YtdPurch = ROUND(h.YtdPurch + v.YtdPurch, @DecPl)
FROM APHist h, vp_03400ReleaseDocsHist v
WHERE h.FiscYr = v.FiscYr AND h.VendId = v.VendId AND v.CpnyId = h.CpnyId AND
	v.UserAddress = @UserAddress
IF @@ERROR < > 0 GOTO ABORT

/***** Set Beginning Balance for AP Hist *****/

UPDATE a SET a.BegBal = ROUND((SELECT SUM(b.YtdPurch + b.YtdCrAdjs - b.YtdDiscTkn - b.YtdDrAdjs - b.YtdPaymt)
	FROM APHist b WHERE a.VendId = b.VendId AND b.FiscYr < a.FiscYr AND b.CpnyId = a.CpnyId) +
	(SELECT c.BegBal FROM APHist c WHERE a.VendId = c.VendId AND a.CpnyId = c.CpnyId AND c.FiscYr =
	(SELECT MIN(FiscYr) FROM APHist d WHERE d.VendId = a.VendId AND a.CpnyId = d.CpnyId)), @DecPl),
      LUpd_DateTime = GETDATE(), LUpd_Prog = @ProgID, LUpd_User = @Sol_User
FROM APHist a
WHERE a.FiscYr > (SELECT MIN(FiscYr) FROM APHist d WHERE d.VendId = a.VendId AND d.CpnyId = a.CpnyId) AND
	exists (select 'select vendid' from wrkrelease w
                           INNER JOIN apdoc d ON w.batnbr = d.batnbr
                   where w.useraddress = @useraddress and w.module = 'AP'
                     and d.vendid  = a.vendid )

IF @@ERROR < > 0 GOTO ABORT

/***** Update Vendor Balances 					*****/
/***** Create Vendor AP_Balances Record If Does Not Exist 	*****/

INSERT AP_Balances (CpnyId, Crtd_DateTime, Crtd_Prog, Crtd_User,
	CurrBal, CuryID, CYBox00, CYBox01, CYBox02, CYBox03, CYBox04, CYBox05, CYBox06,
	CYBox07, CYBox08, CYBox09, 
    CYBox10,CYBox11,CYBox12, CYBox13, CYBox14, CYBox15, CYFor01, CYInterest, FutureBal, LastChkDate, LastVoDate,
	LUpd_dateTime, LUpd_prog, LUpd_User, NoteId, NYBox00, 
    NYBox01, NYBox02, NYBox03,
	NYBox04, NYBox05, NYBox06, NYBox07, NYBox08, NYBox09, NYBox10, NYBox11,NYBox12,NYBox13, NYBox14, NYBox15, NYFor01, NYInterest, PerNbr,
	S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
	S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12,
	User1, User2, User3, User4, User5, User6, User7, User8, Vendid)
SELECT DISTINCT v.CpnyId, GETDATE(), @ProgID, @Sol_User,
        0, v.CuryID, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, '', '', '',
        GETDATE(), @ProgID, @Sol_User, '', 0,
		0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, '',
		'', '', 0, 0, 0, 0,
        '', '', 0, 0, '', '',
		'', '', 0, 0, '', '', '', '', v.VendID
  FROM vp_03400ReleaseDocsVendor v
  LEFT OUTER JOIN AP_Balances b
    on v.cpnyid = b.cpnyid and v.vendid = b.vendid
WHERE v.UserAddress = @UserAddress AND b.cpnyid is null
	IF @@ERROR < > 0 GOTO ABORT

/***** Update AP_Balance for Vendor *****/

UPDATE AP_Balances SET CurrBal = ROUND(ROUND(CurrBal, @DecPl) + Round(CurrentAmt, @DecPl), @DecPl),
		FutureBal = ROUND(ROUND (FutureBal, @DecPl) + Round(FutureAmt, @DecPl), @DecPl),
		LastChkDate = CASE WHEN v.LastChkDate > b.LastChkDate THEN v.LastChkDate ELSE b.LastChkDate END,
		LastVoDate = CASE WHEN v.LastVoDate > b.LastVoDate THEN v.LastVoDate ELSE b.LastVoDate END,
		LUpd_DateTime = GETDATE(), LUpd_Prog = @ProgID, LUpd_User = @Sol_User
FROM AP_Balances b, vp_03400ReleaseDocsVendor v
WHERE v.UserAddress = @UserAddress AND b.VendID = v.VendID AND b.CpnyID = v.CpnyID

IF @@ERROR < > 0 GOTO ABORT

/***** Close Zero Documents ******/
UPDATE d set d.rlsed=1, d.opendoc=0, d.perclosed=@pernbr, d.LUpd_DateTime = GETDATE(), d.LUpd_Prog = @ProgID, d.LUpd_User = @Sol_User
    FROM APDoc d, WrkRelease w
    where d.curyorigdocamt=0 and d.doctype in  ('VO','AC','AD') AND
          w.UserAddress = @USERADDRESS AND
          w.Module = "AP" AND
          d.Batnbr = w.batnbr

IF @@ERROR < > 0 GOTO ABORT
/***** Update APDoc Balances *****/

UPDATE APDoc SET
	ApplyRefNbr =
	Case when d.DocType = 'AD' then
		''
	else
		ApplyRefNbr
	end,
	LUpd_DateTime = GETDATE(), LUpd_Prog = @ProgID, LUpd_User = @Sol_User,
	CuryDiscBal =
		CASE WHEN ROUND(convert(dec(16,3),d.CuryDiscBal) - convert(dec(16,3),v.CuryDiscAmt), c.DecPl) <= 0
			then 0
		ELSE
			ROUND(convert(dec(16,3),d.CuryDiscBal) - convert(dec(16,3),v.CuryDiscAmt), c.DecPl)
		END,
		BWAmt = CASE WHEN v.adjtype = 'VC' THEN d.BWAmt + v.BWAmt ELSE v.BWAmt END,
		CuryBWAmt = CASE WHEN v.adjtype = 'VC' THEN d.CuryBWAmt + v.CuryBWAmt ELSE v.CuryBWAmt END,
	CuryDocBal =
		CASE WHEN v.DrCr = "R"
			THEN 	d.CuryDocBal
		ELSE
		/*  For voiding a check for a prepayment, the prepayment amount should be reset to the original amount. */
		    CASE WHEN (v.AdjdDocType = "PP" and v.adjtype = "VC") THEN
			d.CuryOrigDocAmt
		    ELSE
			CASE WHEN ROUND(Convert(dec(16,3),d.CuryDocBal) - Convert(dec(16,3),v.CuryDiscAmt) - Convert(dec(16,3),v.CuryBWAmt) - Convert(dec(16,3),v.CuryAdjAmt), c.DecPl) <=0
			    THEN 0
		 	ELSE
			    ROUND(Convert(dec(16,3),d.CuryDocBal) - Convert(dec(16,3),v.CuryDiscAmt) - Convert(dec(16,3),v.CuryBWAmt) - Convert(dec(16,3),v.CuryAdjAmt), c.DecPl)
			END
		    END
		END,
	DiscTkn = CASE WHEN v.adjtype in ("CK", "ZC") THEN DiscTkn * -1 ELSE ROUND(convert(dec(16,3),d.DiscTkn) - convert(dec(16,3),v.AdjDiscAmt), @DecPl) END,
	CuryDiscTkn = CASE WHEN v.adjtype in ("CK", "ZC") THEN CuryDiscTkn * -1 ELSE ROUND(convert(dec(16,3),d.CuryDiscTkn) - convert(dec(16,3),v.CuryDiscAmt), c.DecPl) END,
	DiscBal = CASE WHEN
			ROUND(convert(dec(16,3),d.DiscBal) - convert(dec(16,3),v.AdjDiscAmt), @DecPl) <= 0
			OR
			ROUND(convert(dec(16,3),d.CuryDiscBal) - convert(dec(16,3),v.CuryDiscAmt), c.DecPl) <= 0
			then 0
		    ELSE
			ROUND(convert(dec(16,3),d.DiscBal) - convert(dec(16,3),v.AdjDiscAmt), @DecPl)
		    END,
	DocBal = CASE WHEN  ROUND(Convert(dec(16,3),d.CuryDocBal) - Convert(dec(16,3),v.CuryDiscAmt) - Convert(dec(16,3),v.CuryAdjAmt), c.DecPl) <=0 THEN 0 ELSE
		CASE WHEN v.DrCr = "R"
			THEN 	d.DocBal
		ELSE
		/* When voiding a check for a prepayment, the prepayment amount should be reset to the original amount. */
		    CASE WHEN (v.AdjdDocType = "PP" and v.adjtype = "VC") THEN
			d.OrigDocAmt
		    ELSE
			CASE WHEN ROUND(Convert(dec(16,3),d.DocBal), @DecPl) - (round(Convert(dec(16,3),v.AdjDiscAmt), @DecPl) - round(Convert(dec(16,3),v.BWAmt), @DecPl) + round(Convert(dec(16,3),v.AdjAmt), @DecPl))<= 0
		 	    THEN 0
			ELSE
			    ROUND(Convert(dec(16,3),d.DocBal), @DecPl) - round(Convert(dec(16,3),v.BWAmt), @DecPl) - (round(Convert(dec(16,3),v.AdjDiscAmt), @DecPl) + round(Convert(dec(16,3),v.AdjAmt), @DecPl))
			    
			END
		    END
			END
		END,
	OpenDoc =
	CASE WHEN v.DrCr = "R"
	THEN d.OpenDoc
	ELSE
		CASE
		WHEN ROUND(Convert(dec(16,3),d.DocBal), @DecPl) - round(Convert(dec(16,3),v.BWAmt), @DecPl) - (round(Convert(dec(16,3),v.AdjDiscAmt), @DecPl) + round(Convert(dec(16,3),v.AdjAmt), @DecPl)) <= 0 THEN 0
		ELSE 1 END
	END,
	PerClosed = CASE
		WHEN ROUND(Convert(dec(16,3),d.DocBal), @DecPl) - round(Convert(dec(16,3),v.BWAmt), @DecPl) - (round(Convert(dec(16,3),v.AdjDiscAmt), @DecPl) + round(Convert(dec(16,3),v.AdjAmt), @DecPl)) > 0 THEN ""
		ELSE v.PerPost END,
	Selected = 0,
	CuryPmtAmt =
	CASE WHEN v.DrCr = "R"
	THEN	v.CuryAdjAmt

---	ELSE	(CASE WHEN d.DocType = "VO" AND ROUND(convert(dec(16,3),d.DocBal) - round(convert(dec(16,3),v.AdjDiscAmt) + convert(dec(16,3),v.AdjAmt), @DecPl), @DecPl) <= 0
---		THEN 0
---		ELSE CuryPmtAmt END)
	ELSE
	0
	END,
	PmtAmt =
	CASE WHEN v.DrCr = "R"
	THEN	v.AdjAmt
---	ELSE	(CASE WHEN d.DocType = "VO" AND ROUND(convert(dec(16,3),d.DocBal) - round(convert(dec(16,3),v.AdjDiscAmt) + convert(dec(16,3),v.AdjAmt), @DecPl), @DecPl) <= 0
---		THEN 0
---		ELSE PmtAmt END)
	ELSE
	0
	END,
	Status = CASE v.DrCr WHEN "R" THEN "C" WHEN "V" THEN "V" ELSE d.Status END,
	ClearDate = CASE WHEN v.DrCr = "R" THEN GETDATE() ELSE ClearDate END
FROM APDoc d, vp_03400APDocAdjust v, Currncy c
WHERE v.AdjdRefNbr = d.RefNbr AND v.AdjdDocType = d.DocType AND
	d.Acct = v.Acct and d.Sub = v.Sub AND v.UserAddress = @UserAddress AND
	v.VendID = d.VendID AND v.CpnyID = d.CpnyID AND
	c.curyid = d.curyid

IF @@ERROR < > 0 GOTO ABORT

/***** Update Voucher Master doc (VM) with check amounts *****/
UPDATE vm
	SET vm.CuryDocBal = round(convert(dec(16,3),vm.CuryDocBal) - (convert(dec(16,3),j.CuryAdjAmt) + convert(dec(16,3),j.CuryDiscAmt)), @DecPl),
          vm.CuryDiscBal = round(convert(dec(16,3),vm.CuryDiscBal) - convert(dec(16,3),j.CuryDiscAmt), @DecPl),
	    vm.DocBal = round(convert(dec(16,3),vm.DocBal) - (convert(dec(16,3),j.AdjAmt) + convert(dec(16,3),j.AdjDiscAmt)),@DecPl),
          vm.DiscBal = round(vm.DiscBal - j.AdjDiscAmt, @DecPl),
	    vm.LUpd_DateTime = GETDATE(), vm.LUpd_Prog = @ProgID, vm.LUpd_User = @Sol_User,
	    vm.opendoc = CASE WHEN (round(vm.CuryDocBal - (j.CuryAdjAmt + j.CuryDiscAmt), @DecPl) <= 0 AND round(vm.CuryDiscBal- j.CuryDiscAmt, @DecPl) <= 0) THEN 0 ELSE 1 END
	FROM vp_03400APDocAdjustVM j, apdoc vm,  wrkrelease w
      WHERE w.UserAddress =  @UserAddress AND  w.batnbr = j.adjbatnbr AND
	     vm.refnbr = j.MasterDocNbr and vm.doctype = 'VM'
IF @@ERROR < > 0 GOTO ABORT

/***** Clear "V" Records *****/

DELETE APTran
FROM APTran t, WrkRelease w
WHERE t.BatNbr = w.BatNbr AND w.Module = "AP" AND w.UserAddress = @UserAddress AND t.DRCR = "V"
IF @@ERROR < > 0 GOTO ABORT

/***** Update APTran *****/

UPDATE t SET t.Rlsed = 1, t.JrnlType = b.JrnlType, t.PerPost = b.PerPost, t.PerEnt = b.PerEnt,
	t.LUpd_DateTime = GETDATE(), t.LUpd_Prog = @ProgID, t.LUpd_User = @Sol_User
FROM APTran t, Batch b, Vendor v, WrkRelease w
WHERE t.BatNbr = w.BatNbr AND t.BatNbr = b.BatNbr  AND b.Module = "AP" AND w.Module = "AP"
	AND t.VendID = v.VendID AND w.UserAddress = @UserAddress

IF @@ERROR < > 0 GOTO ABORT

/***** Update 1099 Vendor Information *****/
INSERT AP_Balances
        (CpnyId, Crtd_DateTime, Crtd_prog, Crtd_User, CurrBal, CuryID,
         CYBox00, CYBox01, CYBox02, CYBox03, CYBox04, CYBox05, CYBox06, CYBox07, CYBox08, CYBox09, CYBox10,
         CYBox11, CYBox12, CYBox13, CYBox14, CYBox15, CYFor01, CYInterest, futureBal, LastChkDate, LastVODate, LUpd_DateTime, LUpd_prog, LUpd_User,
         Noteid, NYBox00, NYBox01, NYBox02, NYBox03, NYBox04, NYBox05, NYBox06,
         NYBox07, NYBox08, NYBox09, NYBox10,NYBox11, NYBox12, NYBox13, NYBox14, NYBox15, NYFor01, NYInterest, Pernbr,
         S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
         S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12,
         User1, User2, User3, User4, User5, User6, User7, User8, VendID)
SELECT   distinct z.CpnyId, GETDATE(), @ProgID, @Sol_User, 0, z.CuryID,
         0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
         0, 0, 0, 0, 0, '', 0, 0, '', '', GETDATE(), @ProgID, @Sol_user,
         0, 0, 0, 0, 0, 0, 0, 0,
         0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, '',
         '', '', 0, 0, 0, 0, 
         '', '', 0, 0, '', '',
         '', '', 0, 0, '', '', '', '', z.VendID

FROM	vp_034001099Docs z
WHERE   z.UserAddress = @UserAddress
	AND NOT EXISTS (SELECT VendID FROM AP_Balances apb WHERE apb.VendID = z.VendID AND apb.CpnyId = z.CpnyId)

IF @@ERROR < > 0 GOTO ABORT

UPDATE AP_Balances SET 	LUpd_DateTime = GETDATE(), LUpd_Prog = @ProgID, LUpd_User = @Sol_User,
	NYBox00 = ROUND(b.NYBox00 + z.Box00, CASE WHEN c.DecPl IS NULL THEN @DecPl ELSE c.DecPl END),
	NYBox01 = ROUND(b.NYBox01 + z.Box01, CASE WHEN c.DecPl IS NULL THEN @DecPl ELSE c.DecPl END),
	NYBox02 = ROUND(b.NYBox02 + z.Box02, CASE WHEN c.DecPl IS NULL THEN @DecPl ELSE c.DecPl END),
	NYBox03 = ROUND(b.NYBox03 + z.Box03, CASE WHEN c.DecPl IS NULL THEN @DecPl ELSE c.DecPl END),
	NYBox04 = ROUND(b.NYBox04 + z.Box04, CASE WHEN c.DecPl IS NULL THEN @DecPl ELSE c.DecPl END),
	NYBox05 = ROUND(b.NYBox05 + z.Box05, CASE WHEN c.DecPl IS NULL THEN @DecPl ELSE c.DecPl END),
	NYBox06 = ROUND(b.NYBox06 + z.Box06, CASE WHEN c.DecPl IS NULL THEN @DecPl ELSE c.DecPl END),
	NYBox07 = ROUND(b.NYBox07 + z.Box07, CASE WHEN c.DecPl IS NULL THEN @DecPl ELSE c.DecPl END),
	NYBox08 = ROUND(b.NYBox08 + z.Box08, CASE WHEN c.DecPl IS NULL THEN @DecPl ELSE c.DecPl END),
	NYBox09 = ROUND(b.NYBox09 + z.Box09, CASE WHEN c.DecPl IS NULL THEN @DecPl ELSE c.DecPl END),
	NYBox11 = ROUND(b.NYBox11 + z.Box15a, CASE WHEN c.DecPl IS NULL THEN @DecPl ELSE c.DecPl END),
	NYBox12 = ROUND(b.NYBox12 + z.Box15b, CASE WHEN c.DecPl IS NULL THEN @DecPl ELSE c.DecPl END),
	NYBox13 = ROUND(b.NYBox13 + z.Box12, CASE WHEN c.DecPl IS NULL THEN @DecPl ELSE c.DecPl END),
	NYBox14 = ROUND(b.NYBox14 + z.Box13, CASE WHEN c.DecPl IS NULL THEN @DecPl ELSE c.DecPl END)
FROM    AP_Balances b, vp_034001099Docs z, Currncy c
		right outer join Vendor v
			on c.CuryID = v.CuryID
WHERE v.VendId = z.VendId AND v.Next1099Yr = z.CalendarYr AND
        z.vendid = b.vendid AND b.CpnyId = z.CpnyId AND	z.UserAddress = @UserAddress

IF @@ERROR < > 0 GOTO ABORT

UPDATE AP_Balances SET 	LUpd_DateTime = GETDATE(), LUpd_Prog = @ProgID, LUpd_User = @Sol_User,
	CYBox00 = ROUND(b.CYBox00 + z.Box00, CASE WHEN c.DecPl IS NULL THEN @DecPl ELSE c.DecPl END),
	CYBox01 = ROUND(b.CYBox01 + z.Box01, CASE WHEN c.DecPl IS NULL THEN @DecPl ELSE c.DecPl END),
	CYBox02 = ROUND(b.CYBox02 + z.Box02, CASE WHEN c.DecPl IS NULL THEN @DecPl ELSE c.DecPl END),
	CYBox03 = ROUND(b.CYBox03 + z.Box03, CASE WHEN c.DecPl IS NULL THEN @DecPl ELSE c.DecPl END),
	CYBox04 = ROUND(b.CYBox04 + z.Box04, CASE WHEN c.DecPl IS NULL THEN @DecPl ELSE c.DecPl END),
	CYBox05 = ROUND(b.CYBox05 + z.Box05, CASE WHEN c.DecPl IS NULL THEN @DecPl ELSE c.DecPl END),
	CYBox06 = ROUND(b.CYBox06 + z.Box06, CASE WHEN c.DecPl IS NULL THEN @DecPl ELSE c.DecPl END),
	CYBox07 = ROUND(b.CYBox07 + z.Box07, CASE WHEN c.DecPl IS NULL THEN @DecPl ELSE c.DecPl END),
	CYBox08 = ROUND(b.CYBox08 + z.Box08, CASE WHEN c.DecPl IS NULL THEN @DecPl ELSE c.DecPl END),
	CYBox09 = ROUND(b.CYBox09 + z.Box09, CASE WHEN c.DecPl IS NULL THEN @DecPl ELSE c.DecPl END),
	CYBox11 = ROUND(b.CYBox11 + z.Box15a, CASE WHEN c.DecPl IS NULL THEN @DecPl ELSE c.DecPl END),
	CYBox12 = ROUND(b.CYBox12 + z.Box15b, CASE WHEN c.DecPl IS NULL THEN @DecPl ELSE c.DecPl END),
	CYBox13 = ROUND(b.CYBox13 + z.Box12, CASE WHEN c.DecPl IS NULL THEN @DecPl ELSE c.DecPl END),
	CYBox14 = ROUND(b.CYBox14 + z.Box13, CASE WHEN c.DecPl IS NULL THEN @DecPl ELSE c.DecPl END)
FROM    AP_Balances b, vp_034001099Docs z, Currncy c
		right outer join Vendor v
			on c.CuryID = v.CuryID
WHERE v.VendId = z.VendId AND v.Curr1099Yr = z.CalendarYr AND
        z.vendid = b.vendid AND b.CpnyId = z.CpnyId AND	z.UserAddress = @UserAddress

IF @@ERROR < > 0 GOTO ABORT

SELECT @Result = 1
GOTO FINISH

ABORT:
SELECT @Result = 0
FINISH:


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_03400APHistBal] TO [MSDSL]
    AS [dbo];

