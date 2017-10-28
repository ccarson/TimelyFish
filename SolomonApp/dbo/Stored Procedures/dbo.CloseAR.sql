 CREATE PROCEDURE CloseAR @ClosePeriod as varchar (6), @NextPeriod  as varchar (6), @userID as varchar (10) as

--@ClosePeriod = Current Period Number
--@NextPeriod = Next Period Number
BEGIN TRAN

DECLARE @nextPerNbr AS smallint
SET NOCOUNT ON
SELECT @nextPerNbr = CONVERT (smallint, right (@NextPeriod,2))

UPDATE b
   SET b.pernbr = @NextPeriod,
       b.CurrBal = b.CurrBal +
         CASE @nextPerNbr
           WHEN 1  THEN PTDSales00 + PTDDrMemo00 + PTDFinChrg00 - PtdRcpt00 - PTDCrMemo00 - PTDDisc00
           WHEN 2  THEN PTDSales01 + PTDDrMemo01 + PTDFinChrg01 - PtdRcpt01 - PTDCrMemo01 - PTDDisc01
           WHEN 3  THEN PTDSales02 + PTDDrMemo02 + PTDFinChrg02 - PtdRcpt02 - PTDCrMemo02 - PTDDisc02
           WHEN 4  THEN PTDSales03 + PTDDrMemo03 + PTDFinChrg03 - PtdRcpt03 - PTDCrMemo03 - PTDDisc03
           WHEN 5  THEN PTDSales04 + PTDDrMemo04 + PTDFinChrg04 - PtdRcpt04 - PTDCrMemo04 - PTDDisc04
           WHEN 6  THEN PTDSales05 + PTDDrMemo05 + PTDFinChrg05 - PtdRcpt05 - PTDCrMemo05 - PTDDisc05
           WHEN 7  THEN PTDSales06 + PTDDrMemo06 + PTDFinChrg06 - PtdRcpt06 - PTDCrMemo06 - PTDDisc06
           WHEN 8  THEN PTDSales07 + PTDDrMemo07 + PTDFinChrg07 - PtdRcpt07 - PTDCrMemo07 - PTDDisc07
           WHEN 9  THEN PTDSales08 + PTDDrMemo08 + PTDFinChrg08 - PtdRcpt08 - PTDCrMemo08 - PTDDisc08
           WHEN 10 THEN PTDSales09 + PTDDrMemo09 + PTDFinChrg09 - PtdRcpt09 - PTDCrMemo09 - PTDDisc09
           WHEN 11 THEN PTDSales10 + PTDDrMemo10 + PTDFinChrg10 - PtdRcpt10 - PTDCrMemo10 - PTDDisc10
           WHEN 12 THEN PTDSales11 + PTDDrMemo11 + PTDFinChrg11 - PtdRcpt11 - PTDCrMemo11 - PTDDisc11
           WHEN 13 THEN PTDSales12 + PTDDrMemo12 + PTDFinChrg12 - PtdRcpt12 - PTDCrMemo12 - PTDDisc12
         END,
       b.FutureBal = b.Futurebal -
         CASE @nextPerNbr
           WHEN 1  THEN PTDSales00+ PTDDrMemo00 + PTDFinChrg00 - PtdRcpt00 - PTDCrMemo00 - PTDDisc00
           WHEN 2  THEN PTDSales01+ PTDDrMemo01 + PTDFinChrg01 - PtdRcpt01 - PTDCrMemo01 - PTDDisc01
           WHEN 3  THEN PTDSales02+ PTDDrMemo02 + PTDFinChrg02 - PtdRcpt02 - PTDCrMemo02 - PTDDisc02
           WHEN 4  THEN PTDSales03+ PTDDrMemo03 + PTDFinChrg03 - PtdRcpt03 - PTDCrMemo03 - PTDDisc03
           WHEN 5  THEN PTDSales04+ PTDDrMemo04 + PTDFinChrg04 - PtdRcpt04 - PTDCrMemo04 - PTDDisc04
           WHEN 6  THEN PTDSales05+ PTDDrMemo05 + PTDFinChrg05 - PtdRcpt05 - PTDCrMemo05 - PTDDisc05
           WHEN 7  THEN PTDSales06+ PTDDrMemo06 + PTDFinChrg06 - PtdRcpt06 - PTDCrMemo06 - PTDDisc06
           WHEN 8  THEN PTDSales07+ PTDDrMemo07 + PTDFinChrg07 - PtdRcpt07 - PTDCrMemo07 - PTDDisc07
           WHEN 9  THEN PTDSales08+ PTDDrMemo08 + PTDFinChrg08 - PtdRcpt08 - PTDCrMemo08 - PTDDisc08
           WHEN 10 THEN PTDSales09+ PTDDrMemo09 + PTDFinChrg09 - PtdRcpt09 - PTDCrMemo09 - PTDDisc09
           WHEN 11 THEN PTDSales10+ PTDDrMemo10 + PTDFinChrg10 - PtdRcpt10 - PTDCrMemo10 - PTDDisc10
           WHEN 12 THEN PTDSales11+ PTDDrMemo11 + PTDFinChrg11 - PtdRcpt11 - PTDCrMemo11 - PTDDisc11
           WHEN 13 THEN PTDSales12+ PTDDrMemo12 + PTDFinChrg12 - PtdRcpt12 - PTDCrMemo12 - PTDDisc12
         END,
       lupd_datetime = GETDATE(), lupd_prog = '01560', lupd_user = @userid
  FROM AR_Balances b INNER JOIN ARHist h
                             ON h.cpnyid = b.cpnyid AND
                                h.custid = b.custid
 WHERE b.pernbr <= @ClosePeriod AND h.fiscyr = LEFT (@NextPeriod,4)
IF @@ERROR <> 0 GOTO abort

UPDATE h
   SET pernbr = @NextPeriod, lupd_datetime = GETDATE(), lupd_prog = '01560', lupd_user = @userid
  FROM arhist h
 WHERE h.pernbr <= @ClosePeriod AND h.fiscyr = LEFT (@NextPeriod,4)
IF @@ERROR <> 0 GOTO abort

UPDATE customer
   SET pernbr = @NextPeriod, lupd_datetime = GETDATE(), lupd_prog = '01560', lupd_user = @userid
 WHERE pernbr <= @ClosePeriod
IF @@ERROR <> 0 GOTO abort

UPDATE sph
   SET pernbr = @NextPeriod,
       lupd_datetime = GETDATE(), lupd_prog = '01560', lupd_user = @userid
  FROM slsperhist sph
 WHERE sph.pernbr <= @ClosePeriod AND fiscyr = LEFT (@NextPeriod, 4)
IF @@ERROR <> 0 GOTO abort

UPDATE salesperson
   SET pernbr = @NextPeriod, lupd_datetime = GETDATE(), lupd_prog = '01560', lupd_user = @userid
 WHERE pernbr <= @ClosePeriod
IF @@ERROR <> 0 GOTO abort

IF (LEFT(@NextPeriod, 4) <> LEFT(@ClosePeriod,4))
  BEGIN
    INSERT ARHist (AccruedRevBegBal, BegBal,
                   CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User, CuryID,
                   CustId, FiscYr, LUpd_DateTime, LUpd_Prog, LUpd_User,
                   NbrInvcPaid00, NbrInvcPaid01, NbrInvcPaid02, NbrInvcPaid03,
                   NbrInvcPaid04, NbrInvcPaid05, NbrInvcPaid06, NbrInvcPaid07, NbrInvcPaid08,
                   NbrInvcPaid09, NbrInvcPaid10, NbrInvcPaid11, NbrInvcPaid12, NoteId,
                   PaidInvcDays00, PaidInvcDays01, PaidInvcDays02, PaidInvcDays03, PaidInvcDays04,
                   PaidInvcDays05, PaidInvcDays06, PaidInvcDays07, PaidInvcDays08, PaidInvcDays09,
                   PaidInvcDays10, PaidInvcDays11, PaidInvcDays12, PerNbr,
       		   PTDAccruedRev00, PTDAccruedRev01, PTDAccruedRev02, PTDAccruedRev03, PTDAccruedRev04, PTDAccruedRev05, PTDAccruedRev06,
       		   PTDAccruedRev07, PTDAccruedRev08, PTDAccruedRev09, PTDAccruedRev10, PTDAccruedRev11, PTDAccruedRev12,
                   PTDCOGS00, PTDCOGS01, PTDCOGS02, PTDCOGS03, PTDCOGS04, PTDCOGS05, PTDCOGS06, PTDCOGS07,
                   PTDCOGS08, PTDCOGS09, PTDCOGS10, PTDCOGS11, PTDCOGS12, PTDCrMemo00, PTDCrMemo01,
                   PTDCrMemo02, PTDCrMemo03, PTDCrMemo04, PTDCrMemo05, PTDCrMemo06, PTDCrMemo07,
                   PTDCrMemo08, PTDCrMemo09, PTDCrMemo10, PTDCrMemo11, PTDCrMemo12, PTDDisc00,
                   PTDDisc01, PTDDisc02, PTDDisc03, PTDDisc04, PTDDisc05, PTDDisc06, PTDDisc07,
                   PTDDisc08, PTDDisc09, PTDDisc10, PTDDisc11, PTDDisc12, PTDDrMemo00, PTDDrMemo01,
                   PTDDrMemo02, PTDDrMemo03, PTDDrMemo04, PTDDrMemo05, PTDDrMemo06, PTDDrMemo07,
                   PTDDrMemo08, PTDDrMemo09, PTDDrMemo10, PTDDrMemo11, PTDDrMemo12, PTDFinChrg00,
                   PTDFinChrg01, PTDFinChrg02, PTDFinChrg03, PTDFinChrg04, PTDFinChrg05,
                   PTDFinChrg06, PTDFinChrg07, PTDFinChrg08, PTDFinChrg09, PTDFinChrg10,
                   PTDFinChrg11, PTDFinChrg12, PTDRcpt00, PTDRcpt01, PTDRcpt02, PTDRcpt03,
                   PTDRcpt04, PTDRcpt05, PTDRcpt06, PTDRcpt07, PTDRcpt08, PTDRcpt09, PTDRcpt10,
                   PTDRcpt11, PTDRcpt12, PTDSales00, PTDSales01, PTDSales02, PTDSales03,
                   PTDSales04, PTDSales05, PTDSales06, PTDSales07, PTDSales08, PTDSales09,
                   PTDSales10, PTDSales11, PTDSales12, S4Future01, S4Future02, S4Future03,
                   S4Future04, S4Future05, S4Future06,
                   S4Future07, S4Future08, S4Future09,
                   S4Future10, S4Future11, S4Future12, User1, User2, User3,
                   User4, User5, User6, User7, User8,
                   YTDAccruedRev, YtdCOGS, YtdCrMemo, YtdDisc, YtdDrMemo, YtdFinChrg, YtdRcpt, YtdSales)
     SELECT ROUND(inclusive.AccruedRevBegBal + inclusive.YTDAccruedRev, c.decpl), ROUND(inclusive.BegBal + inclusive.YtdSales + inclusive.YtdDrMemo + inclusive.YtdFinChrg -
                    inclusive.YtdRcpt - inclusive.YtdCrMemo - inclusive.YtdDisc - inclusive.YTDAccruedRev, c.decpl),
           inclusive.CpnyID, GETDATE(), '01560', @UserID, inclusive.CuryID,
           inclusive.CustId, LEFT (@NextPeriod, 4), GETDATE(), '01560', @userid,
           0, 0, 0, 0,
           0, 0, 0, 0, 0,
           0, 0, 0, 0, 0,
           0, 0, 0, 0, 0,
           0, 0, 0, 0, 0,
           0, 0, 0, @NextPeriod,
       	   0, 0, 0, 0, 0, 0, 0,
       	   0, 0, 0, 0, 0, 0,
           0, 0, 0, 0, 0, 0, 0, 0,
           0, 0, 0, 0, 0, 0, 0,
           0, 0, 0, 0, 0, 0,
           0, 0, 0, 0, 0, 0,
           0, 0, 0, 0, 0, 0, 0,
           0, 0, 0, 0, 0, 0, 0,
           0, 0, 0, 0, 0, 0,
           0, 0, 0, 0, 0, 0,
           0, 0, 0, 0, 0,
           0, 0, 0, 0, 0,
           0, 0, 0, 0, 0, 0,
           0, 0, 0, 0, 0, 0, 0,
           0, 0, 0, 0, 0, 0,
           0, 0, 0, 0, 0, 0,
           0, 0, 0, '', '', 0,
           0, 0, 0,
           CONVERT (SMALLDATETIME, '19000101', 112), CONVERT (SMALLDATETIME, '19000101', 112), 0,
           0, '', '', '', '', 0,
           0, '', '', CONVERT (SMALLDATETIME, '19000101', 112), CONVERT (SMALLDATETIME, '19000101', 112),
           0, 0, 0, 0, 0, 0, 0, 0

    FROM ARHist inclusive INNER JOIN currncy c
                                  ON c.curyid = inclusive.curyid
   WHERE inclusive.FiscYr = LEFT (@ClosePeriod, 4) AND
         NOT EXISTS (SELECT 1
                       FROM ARHist exclusive
                      WHERE exclusive.FiscYr = LEFT (@NextPeriod, 4) AND
                            inclusive.CpnyId = exclusive.CpnyID AND
                            exclusive.custid = inclusive.custid)
   ORDER BY CustID
  IF @@ERROR <> 0 GOTO abort
END

UPDATE ARDoc
   SET CurrentNbr = 0, lupd_datetime = GETDATE(), lupd_prog = '01560', lupd_user = @userid
 WHERE ARDoc.DocBal = 0 AND
       PerClosed <= @NextPeriod AND
       CurrentNbr = 1 AND
       Rlsed = 1
IF @@ERROR <> 0 GOTO abort

UPDATE ARSetup
   SET ARSetup.PerNbr = @NextPeriod, lupd_datetime = GETDATE(), lupd_prog = '01560', lupd_user = @userid
IF @@ERROR <> 0 GOTO abort

accept:
COMMIT TRAN
GOTO finish
abort:
ROLLBACK TRAN
finish:


