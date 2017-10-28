 CREATE PROCEDURE pp_08400UpdateARHist @UserAddress VARCHAR(21),
                                      @Sol_User VARCHAR(10),
                                      @Debug INT,
                                      @Result INT OUTPUT
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as

/***** This procedure produces the necessary ARHist for the AR Release process. 	*****/
/***** This procedure is subservant to pp_08400 and uses parameter passing to verify	*****/
/***** successful completion.									*****/

DECLARE @Decpl Int,
        @ProgId CHAR (8),
        @BaseCuryID CHAR(10),
        @CurrPer CHAR (6)
DECLARE @CUSTID CHAR (15)
DECLARE @FISCYR CHAR (4)

SELECT @ProgID =   '08400',
       @Sol_User = 'SOLOMON'

SELECT @BaseCuryID = BaseCuryId, @DecPl = C.DecPl
  FROM GLSetup s (NOLOCK), Currncy c WHERE s.BaseCuryID = c.CuryID

SELECT @CurrPer = PerNbr
  FROM ARSetup (NOLOCK)

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
    PRINT 'Debug...Step 1550:  Create ARHist records If Does Not Exist'
    SELECT 'vp_08400ARReleaseDocs'
    SELECT *
      FROM vp_08400ARReleaseDocs
     WHERE useraddress = @useraddress

  END

INSERT ARHist (AccruedRevBegBal, BegBal, CpnyID, CuryID, Crtd_DateTime, Crtd_Prog, Crtd_User, CustId, FiscYr, LUpd_DateTime,
       LUpd_Prog, LUpd_User, NbrInvcPaid00, NbrInvcPaid01, NbrInvcPaid02, NbrInvcPaid03, NbrInvcPaid04,
       NbrInvcPaid05, NbrInvcPaid06, NbrInvcPaid07, NbrInvcPaid08, NbrInvcPaid09, NbrInvcPaid10,
       NbrInvcPaid11, NbrInvcPaid12, NoteId, PaidInvcDays00, PaidInvcDays01, PaidInvcDays02, PaidInvcDays03,
       PaidInvcDays04, PaidInvcDays05, PaidInvcDays06, PaidInvcDays07, PaidInvcDays08,
       PaidInvcDays09, PaidInvcDays10, PaidInvcDays11, PaidInvcDays12, PerNbr,
       PTDAccruedRev00, PTDAccruedRev01, PTDAccruedRev02, PTDAccruedRev03, PTDAccruedRev04, PTDAccruedRev05, PTDAccruedRev06,
       PTDAccruedRev07, PTDAccruedRev08, PTDAccruedRev09, PTDAccruedRev10, PTDAccruedRev11, PTDAccruedRev12,
       PTDCOGS00, PTDCOGS01, PTDCOGS02, PTDCOGS03, PTDCOGS04, PTDCOGS05, PTDCOGS06, PTDCOGS07, PTDCOGS08,
       PTDCOGS09, PTDCOGS10, PTDCOGS11, PTDCOGS12, PTDCrMemo00, PTDCrMemo01, PTDCrMemo02,
       PTDCrMemo03, PTDCrMemo04, PTDCrMemo05, PTDCrMemo06, PTDCrMemo07, PTDCrMemo08,
       PTDCrMemo09, PTDCrMemo10, PTDCrMemo11, PTDCrMemo12, PTDDisc00, PTDDisc01, PTDDisc02,
       PTDDisc03, PTDDisc04, PTDDisc05, PTDDisc06, PTDDisc07, PTDDisc08, PTDDisc09,
       PTDDisc10, PTDDisc11, PTDDisc12, PTDDrMemo00, PTDDrMemo01, PTDDrMemo02, PTDDrMemo03,
       PTDDrMemo04, PTDDrMemo05, PTDDrMemo06, PTDDrMemo07, PTDDrMemo08, PTDDrMemo09,
       PTDDrMemo10, PTDDrMemo11, PTDDrMemo12, PTDFinChrg00, PTDFinChrg01, PTDFinChrg02,
       PTDFinChrg03, PTDFinChrg04, PTDFinChrg05, PTDFinChrg06, PTDFinChrg07, PTDFinChrg08,
       PTDFinChrg09, PTDFinChrg10, PTDFinChrg11, PTDFinChrg12, PTDRcpt00, PTDRcpt01,
       PTDRcpt02, PTDRcpt03, PTDRcpt04, PTDRcpt05, PTDRcpt06, PTDRcpt07, PTDRcpt08, PTDRcpt09,
       PTDRcpt10, PTDRcpt11, PTDRcpt12, PTDSales00, PTDSales01, PTDSales02, PTDSales03,
       PTDSales04, PTDSales05, PTDSales06, PTDSales07, PTDSales08, PTDSales09, PTDSales10,
       PTDSales11, PTDSales12, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
       S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, User1, User2, User3, User4,
       User5, User6, User7, User8, YTDAccruedRev, YtdCOGS, YtdCrMemo, YtdDisc, YtdDrMemo, YtdFinChrg, YtdRcpt, YtdSales)
SELECT DISTINCT ISNULL((Select top 1 H2.AccruedRevBegBal + H2.YTDAccruedRev
                   FROM ARHIST H2
                  WHERE H2.cpnyid = v.Cpnyid
                    AND H2.CustId = v.CustId
                    AND H2.FiscYr < v.FiscYr
                  ORDER BY FiscYr DESC),0),
       ISNULL((Select top 1 H2.BegBal + (H2.YtdSales + H2.YtdDrMemo + H2.YtdFinChrg) -
                         (H2.YtdRcpt + H2.YtdCrMemo + H2.YtdDisc + H2.YTDAccruedRev)
                   FROM ARHIST H2
                  WHERE H2.cpnyid = v.Cpnyid
                    AND H2.CustId = v.CustId
                    AND H2.FiscYr < v.FiscYr
                  ORDER BY FiscYr DESC),0),
       v.CpnyID, @BaseCuryID, GETDATE(), @ProgID, @Sol_User, v.CustID, r.FiscYr, GETDATE(),
       '', '', 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0,
       0, 0, 0, 0, @CurrPer,
       0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0,
       0, 0,'', '', 0, 0,  0, 0,
       '', '', 0, 0, '', '', '', '', 0, 0,
       '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0
   FROM Wrk_TimeRange r JOIN vp_08400ARBalancesHist v
                         ON v.FiscYr <= r.FiscYr
                        AND v.UserAddress = r.UserAddress
                       LEFT JOIN ARHist h
                              ON h.CustID = v.CustId
                             AND h.CpnyID = v.CpnyID
                             AND h.FiscYr = r.FiscYr
 WHERE  v.UserAddress = @UserAddress
   AND h.custid is null

IF @@ERROR <> 0 GOTO ABORT

/***** Update AR Hist *****/

UPDATE ARHist SET
	LUpd_DateTime = GETDATE(), LUpd_Prog = @ProgID, LUpd_User = @Sol_User,
	PTDAccruedRev00 = Round(h.PTDAccruedRev00 + v.PTDAccruedRev00,@Decpl),
	PTDAccruedRev01 = Round(h.PTDAccruedRev01 + v.PTDAccruedRev01,@Decpl),
	PTDAccruedRev02 = Round(h.PTDAccruedRev02 + v.PTDAccruedRev02,@Decpl),
	PTDAccruedRev03 = Round(h.PTDAccruedRev03 + v.PTDAccruedRev03,@Decpl),
	PTDAccruedRev04 = Round(h.PTDAccruedRev04 + v.PTDAccruedRev04,@Decpl),
	PTDAccruedRev05 = Round(h.PTDAccruedRev05 + v.PTDAccruedRev05,@Decpl),
	PTDAccruedRev06 = Round(h.PTDAccruedRev06 + v.PTDAccruedRev06,@Decpl),
	PTDAccruedRev07 = Round(h.PTDAccruedRev07 + v.PTDAccruedRev07,@Decpl),
	PTDAccruedRev08 = Round(h.PTDAccruedRev08 + v.PTDAccruedRev08,@Decpl),
	PTDAccruedRev09 = Round(h.PTDAccruedRev09 + v.PTDAccruedRev09,@Decpl),
	PTDAccruedRev10 = Round(h.PTDAccruedRev10 + v.PTDAccruedRev10,@Decpl),
	PTDAccruedRev11 = Round(h.PTDAccruedRev11 + v.PTDAccruedRev11,@Decpl),
	PTDAccruedRev12 = Round(h.PTDAccruedRev12 + v.PTDAccruedRev12,@Decpl),

	PTDCrMemo00 = Round(h.PTDCrMemo00 + v.PTDCrMemo00,@Decpl),
	PTDCrMemo01 = Round(h.PTDCrMemo01 + v.PTDCrMemo01,@Decpl),
	PTDCrMemo02 = Round(h.PTDCrMemo02 + v.PTDCrMemo02,@Decpl),
	PTDCrMemo03 = Round(h.PTDCrMemo03 + v.PTDCrMemo03,@Decpl),
	PTDCrMemo04 = Round(h.PTDCrMemo04 + v.PTDCrMemo04,@Decpl),
	PTDCrMemo05 = Round(h.PTDCrMemo05 + v.PTDCrMemo05,@Decpl),
	PTDCrMemo06 = Round(h.PTDCrMemo06 + v.PTDCrMemo06,@Decpl),
	PTDCrMemo07 = Round(h.PTDCrMemo07 + v.PTDCrMemo07,@Decpl),
	PTDCrMemo08 = Round(h.PTDCrMemo08 + v.PTDCrMemo08,@Decpl),
	PTDCrMemo09 = Round(h.PTDCrMemo09 + v.PTDCrMemo09, @Decpl),
	PTDCrMemo10 = Round(h.PTDCrMemo10 + v.PTDCrMemo10, @Decpl),
	PTDCrMemo11 = Round(h.PTDCrMemo11 + v.PTDCrMemo11, @Decpl),
	PTDCrMemo12 = Round(h.PTDCrMemo12 + v.PTDCrMemo12,@Decpl),

	PTDDrMemo00 = Round(h.PTDDrMemo00 + v.PTDDrMemo00, @Decpl),
	PTDDrMemo01 = Round(h.PTDDrMemo01 + v.PTDDrMemo01, @Decpl),
	PTDDrMemo02 = Round(h.PTDDrMemo02 + v.PTDDrMemo02,@Decpl),
	PTDDrMemo03 = Round(h.PTDDrMemo03 + v.PTDDrMemo03, @Decpl),
	PTDDrMemo04 = Round(h.PTDDrMemo04 + v.PTDDrMemo04, @Decpl),
	PTDDrMemo05 = Round(h.PTDDrMemo05 + v.PTDDrMemo05, @Decpl),
	PTDDrMemo06 = Round(h.PTDDrMemo06 + v.PTDDrMemo06, @Decpl),
	PTDDrMemo07 = Round(h.PTDDrMemo07 + v.PTDDrMemo07, @Decpl),
	PTDDrMemo08 = Round(h.PTDDrMemo08 + v.PTDDrMemo08,@Decpl),
	PTDDrMemo09 = Round(h.PTDDrMemo09 + v.PTDDrMemo09, @Decpl),
	PTDDrMemo10 = Round(h.PTDDrMemo10 + v.PTDDrMemo10, @Decpl),
	PTDDrMemo11 = Round(h.PTDDrMemo11 + v.PTDDrMemo11, @Decpl),
	PTDDrMemo12 = Round(h.PTDDrMemo12 + v.PTDDrMemo12,@Decpl),
 	PTDFinChrg00 = Round(h.PTDFinChrg00 + v.PTDFinChrg00, @Decpl),
	PTDFinChrg01 = Round(h.PTDFinChrg01 + v.PTDFinChrg01, @Decpl),
	PTDFinChrg02 = Round(h.PTDFinChrg02 + v.PTDFinChrg02, @Decpl),
	PTDFinChrg03 = Round(h.PTDFinChrg03 + v.PTDFinChrg03, @Decpl),
	PTDFinChrg04 = Round(h.PTDFinChrg04 + v.PTDFinChrg04, @Decpl),
	PTDFinChrg05 = Round(h.PTDFinChrg05 + v.PTDFinChrg05, @Decpl),
	PTDFinChrg06 = Round(h.PTDFinChrg06 + v.PTDFinChrg06, @Decpl),
	PTDFinChrg07 = Round(h.PTDFinChrg07 + v.PTDFinChrg07, @Decpl),
	PTDFinChrg08 = Round(h.PTDFinChrg08 + v.PTDFinChrg08, @Decpl),
	PTDFinChrg09 = Round(h.PTDFinChrg09 + v.PTDFinChrg09, @Decpl),
	PTDFinChrg10 = Round(h.PTDFinChrg10 + v.PTDFinChrg10, @Decpl),
	PTDFinChrg11 = Round(h.PTDFinChrg11 + v.PTDFinChrg11, @Decpl),
	PTDFinChrg12 = Round(h.PTDFinChrg12 + v.PTDFinChrg12,@Decpl),

	PTDDisc00 = Round(h.PTDDisc00 + v.PTDDisc00, @Decpl),
	PTDDisc01 = Round(h.PTDDisc01 + v.PTDDisc01, @Decpl),
	PTDdisc02 = Round(h.PTDDisc02 + v.PTDDisc02, @Decpl),
	PTDDisc03 = Round(h.PTDDisc03 + v.PTDDisc03, @Decpl),
	PTDDisc04 = Round(h.PTDDisc04 + v.PTDDisc04, @Decpl),
	PTDDisc05 = Round(h.PTDDisc05 + v.PTDDisc05, @Decpl),
	PTDDisc06 = Round(h.PTDDisc06 + v.PTDDisc06,@Decpl),
	PTDDisc07 = Round(h.PTDDisc07 + v.PTDDisc07, @Decpl),
	PTDDisc08 = Round(h.PTDDisc08 + v.PTDDisc08, @Decpl),
	PTDDisc09 = Round(h.PTDDisc09 + v.PTDDisc09,@Decpl),
	PTDDisc10 = Round(h.PTDDisc10 + v.PTDDisc10, @Decpl),
	PTDDisc11 = Round(h.PTDDisc11 + v.PTDDisc11, @Decpl),
	PTDDisc12 = Round(h.PTDDisc12 + v.PTDDisc12,@Decpl),

	PTDRcpt00 = Round(h.PTDRcpt00 + v.PTDRcpt00, @Decpl),
	PTDRcpt01 = Round(h.PTDRcpt01 + v.PTDRcpt01, @Decpl),
	PTDRcpt02 = Round(h.PTDRcpt02 + v.PTDRcpt02, @Decpl),
	PTDRcpt03 = Round(h.PTDRcpt03 + v.PTDRcpt03, @Decpl),
	PTDRcpt04 = Round(h.PTDRcpt04 + v.PTDRcpt04,@Decpl),
	PTDRcpt05 = Round(h.PTDRcpt05 + v.PTDRcpt05, @Decpl),
	PTDRcpt06 = Round(h.PTDRcpt06 + v.PTDRcpt06, @Decpl),
	PTDRcpt07 = Round(h.PTDRcpt07 + v.PTDRcpt07, @Decpl),
	PTDRcpt08 = Round(h.PTDRcpt08 + v.PTDRcpt08, @Decpl),
	PTDRcpt09 = Round(h.PTDRcpt09 + v.PTDRcpt09,@Decpl),
	PTDRcpt10 = Round(h.PTDRcpt10 + v.PTDRcpt10, @Decpl),
	PTDRcpt11 = Round(h.PTDRcpt11 + v.PTDRcpt11, @Decpl),
	PTDRcpt12 = Round(h.PTDRcpt12 + v.PTDRcpt12, @Decpl),

	PTDSales00 = Round(h.PTDSales00 + v.PTDSales00,@Decpl),
	PTDSales01 = Round(h.PTDSales01 + v.PTDSales01, @Decpl),
	PTDSales02 = Round(h.PTDSales02 + v.PTDSales02, @Decpl),
	PTDSales03 = Round(h.PTDSales03 + v.PTDSales03,@Decpl),
	PTDSales04 = Round(h.PTDSales04 + v.PTDSales04, @Decpl),
	PTDSales05 = Round(h.PTDSales05 + v.PTDSales05, @Decpl),
	PTDSales06 = Round(h.PTDSales06 + v.PTDSales06, @Decpl),
	PTDSales07 = Round(h.PTDSales07 + v.PTDSales07, @Decpl),
	PTDSales08 = Round(h.PTDSales08 + v.PTDSales08, @Decpl),
	PTDSales09 = Round(h.PTDSales09 + v.PTDSales09, @Decpl),
	PTDSales10 = Round(h.PTDSales10 + v.PTDSales10,@Decpl),
	PTDSales11 = Round(h.PTDSales11 + v.PTDSales11, @Decpl),
	PTDSales12 = Round(h.PTDSales12 + v.PTDSales12,@Decpl),

	YTDAccruedRev = Round(h.YTDAccruedRev + v.YTDAccruedRev, @Decpl),
	YTDCrMemo = Round(h.YTDCrMemo + v.YTDCrMemo, @Decpl),
	YTDDisc = Round(h.YTDDisc + v.YTDDisc,@Decpl),
	YTDDrMemo = Round(h.YTDDrMemo + v.YTDDrMemo,@Decpl),
	YTDFinChrg = Round(h.YTDFinChrg + v.YTDFinChrg, @Decpl),
	YTDRcpt = Round(h.YTDRcpt + v.YTDRcpt, @Decpl),
	YTDSales = Round(h.YTDSales + v.YTDSales, @Decpl)
  FROM ARHist h, vp_08400ARReleaseDocsHist v
 WHERE h.FiscYr = v.FiscYr AND h.CustID = v.CustID
   AND h.CpnyID = v.CpnyID AND v.UserAddress = @UserAddress

IF @@ERROR < > 0 GOTO ABORT

/***** Set Beginning Balance for AR Hist for Customers that have
       History records that are more current than the Fiscal years being
       posted
*****/
DECLARE CSR_Upd_BegBal CURSOR FOR
 SELECT DISTINCT t.CustID, FiscYr = SUBSTRING(t.Perpost,1,4)
   FROM WrkRelease  w JOIN ARTran t
                        ON W.BatNbr = t.BatNbr
  WHERE Module = 'AR'  AND USERADDRESS = @USERADDRESS
    AND EXISTS (SELECT 'Future Years Exist'
                  FROM ARHIST h
                 WHERE t.custid =  h.custid
                   AND h.fiscyr > SUBSTRING(t.Perpost,1,4))

  OPEN CSR_Upd_BegBal
 FETCH CSR_Upd_BegBal
  INTO @Custid, @Fiscyr
 WHILE (@@FETCH_STATUS = 0)
 BEGIN
      /*  Begbal for any future year is the sum of Begbal(for the year the docs are updating) +
                    sum of YTD activity for year updated by docs through year prior to the begbal that is being set */
       /* If records exist for 2001, 2002 and 2003 and 2001 is being updated by this batch, Then
              2003 begbal  = 2001 begbal + 2001 YTD activity + 2002 YTD activity */
       UPDATE A
          SET a.AccruedRevBegBal = ROUND(ISNULL((SELECT  SUM(b.YTDAccruedRev)
	                   FROM ARHist b
                          WHERE a.CustId = b.CustId
                            AND b.FiscYr < a.FiscYr and b.FiscYr >=@FiscYr
                            AND a.CpnyID = b.CpnyID),0)
                         +
	                ISNULL((SELECT r.AccruedRevBegBal
                           FROM ARHist r with(index(arhist0))
                          WHERE a.CustID = r.CustID
                            AND a.CpnyID = r.CpnyID
                            AND r.FiscYr = @FISCYR),0),@Decpl),
             a.BegBal = ROUND(ISNULL((SELECT  SUM((b.YtdSales + b.YtdDrMemo + b.YtdFinChrg) -
                                                         (YtdRcpt + b.YtdCrMemo + b.YtdDisc))
	                   FROM ARHist b
                          WHERE a.CustId = b.CustId
                            AND b.FiscYr < a.FiscYr and b.FiscYr >=@FiscYr
                            AND a.CpnyID = b.CpnyID),0)
                         +
	                ISNULL((SELECT r.BegBal
                           FROM ARHist r with(index(arhist0)) --REH prevent bookmark lookup
                          WHERE a.CustID = r.CustID
                            AND a.CpnyID = r.CpnyID
                            AND r.FiscYr = @FISCYR),0),@Decpl)
         FROM  ArHist a
        WHERE a.Custid = @Custid
          AND a.FiscYr > @FiscYr

       IF @@ERROR <> 0
       BEGIN
         CLOSE CSR_UPD_BegBal
         DEALLOCATE CSR_UPD_BegBal
         GOTO ABORT
       END

       -- Get Next Custid
       FETCH CSR_UPD_BegBal
         INTO @Custid, @Fiscyr

 END -- End while loop
CLOSE CSR_UPD_BegBal
DEALLOCATE CSR_UPD_BegBal

IF @@ERROR <> 0 GOTO ABORT

SELECT @Result = 1
GOTO FINISH

ABORT:
SELECT @Result = 0

FINISH:


