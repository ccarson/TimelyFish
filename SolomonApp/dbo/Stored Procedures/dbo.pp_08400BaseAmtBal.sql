 CREATE PROCEDURE pp_08400BaseAmtBal @Useraddress VARCHAR(21), @Sol_User VARCHAR(10),
                                      @EditScrnNbr VARCHAR(5), @BaseDecPl INT, @ProcResult INT OUTPUT

WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
/********************************************************************************
*             Copyright Solomon Software, Inc. 1994-1999 All Rights Reserved
**    Proc Name: pp_08400BaseAmtBal
**++* Narrative: Foreign currency docs can have inconsistencies between line and document totals due to
*               rounding of individual amounts vs. totals
*/

DECLARE @Debug INT
SELECT @Debug = CASE WHEN @UserAddress = 'ARDebug' THEN 1
                     ELSE 0
                END

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(varchar(30), GETDATE(), 113)
    PRINT 'Debug...Step 400-100:  BaseAmtBal - Declarations and variables are set'

  END

DECLARE @ProgID CHAR (8)
SET @ProgID = '08400'

-- IF base trans do not total to doc total because of currency rounding, adjust the tran
-- Cury Diff view returns 08010 only so this will only balance IN, CM, DM and CS docs --REH added inner loop join to avoid scan on ARTRAN

UPDATE t
SET t.tranamt = ROUND(t.tranamt + v.RoundDiff, @BaseDecpl),
	t.LUpd_DateTime= getdate(),
	t.LUpd_Prog = @ProgID,
	t.LUpd_User = @Sol_User
FROM  vp_08400CuryDiff v
	inner loop join ARTran t on  v.batnbr = t.batnbr
			AND v.CustID = t.CustID
			AND v.refnbr = t.refnbr
			AND v.doctype = t.trantype
			AND v.RecordID = t.RecordID
WHERE v.UserAddress = @UserAddress

IF @@ERROR <> 0 GOTO ABORT

-- Makes sure that the unapplied total + applied total is equal to Origdocamt.
-- If not adjust the unapplied total which is stored in CuryApplAmt
UPDATE d SET  CuryApplAmt = CONVERT(dec(28,3),d.curydocbal) -
        ISNULL((SELECT   SumCuryTranAmt = SUM(CONVERT(dec(28,3),curytranamt))
                  FROM ARTran t with(INDEX(ARTRAN8))
                 WHERE drcr = 'U'
                   AND d.applbatnbr = t.batnbr
                   AND d.Custid = t.custid
                   AND d.doctype = t.trantype
                   AND d.refnbr = t.refnbr),0)
  FROM WrkRelease w (NOLOCK) INNER LOOP JOIN ARDoc d
                                ON w.Batnbr = d.applbatnbr
WHERE w.module = 'AR' AND d.doctype IN ('PA','PP','CM')
   AND w.useraddress = @UserAddress

IF @@ERROR <> 0 GOTO ABORT

UPDATE d SET ApplAmt = CASE WHEN d.CuryMultDiv = 'D'
                            THEN ROUND((Convert(dec(28,3),d.curyapplamt) /
                                         Convert(DEC(19,9),d.curyrate)), @BaseDecPl)
                            ELSE ROUND((Convert(dec(28,3),d.curyapplamt) *
                                          Convert(DEC(19,9),d.curyrate)), @BaseDecPl)
                        END
  FROM WrkRelease w (NOLOCK) INNER LOOP JOIN ARDoc d
                                ON w.Batnbr = d.applbatnbr
                               AND w.Batnbr = d.batnbr
 WHERE w.module = 'AR' AND d.doctype IN ('PA','PP','CM')
  AND w.UserAddress = @Useraddress
IF @@ERROR <> 0 GOTO ABORT

--08030 company/account/sub correction since OM-sourced U-trans may not have correct account/sub
UPDATE t
   SET CpnyID = d.CpnyID,
       Acct = d.BankAcct,
       Sub = d.BankSub
  FROM WrkRelease w INNER JOIN Batch b
                       ON b.BatNbr = w.BatNbr AND b.Module = w.Module
                    INNER JOIN ARTran t
                       ON t.BatNbr = w.BatNbr AND t.DrCr = 'U'
                    INNER JOIN ARDoc d
                       ON d.CustID = t.CustID AND d.DocType = t.CostType AND d.RefNbr = t.SiteID
WHERE	w.Module = 'AR' AND w.UserAddress = @UserAddress AND b.EditScrnNbr = '08030' AND b.JrnlType = 'OM'
IF @@ERROR <> 0 GOTO ABORT

SELECT @ProcResult = 1
GOTO FINISH

ABORT:
SELECT @ProcResult = 0

FINISH:



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_08400BaseAmtBal] TO [MSDSL]
    AS [dbo];

