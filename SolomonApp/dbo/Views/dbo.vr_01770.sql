 


CREATE VIEW vr_01770 As

SELECT 
    V.BudgetLedgerID, V.BudgetYear, V.CpnyID AS BudgetCpnyID,   
    Budget.ShortDescr AS BdgtDescr, Budget.BdgtSegment, Account.Descr AS AcctDescr,
    V.SrcCpnyID As BasisActualCpnyID, V.Source As BasisActualLedger, LEFT(V.S4Future12, 5) As BasisActualYear,
    V.S4Future02 As BasisBdgtCpnyID, V.S4Future11 AS BasisBdgtLedger, LEFT(V.S4Future01, 5) AS BasisBdgtYear,
    R.CpnyName, R.RI_ID,
    BasisActualAH.Acct As ActualAcct, BasisActualAH.Sub As ActualSub, 
    BasisActualAH.PtdBal00 AS ActualPTDBal00, BasisActualAH.PtdBal01 AS ActualPTDBal01, BasisActualAH.PtdBal02 AS ActualPTDBal02, 
    BasisActualAH.PtdBal03 AS ActualPTDBal03, BasisActualAH.PtdBal04 AS ActualPTDBal04, BasisActualAH.PtdBal05 AS ActualPTDBal05, 
    BasisActualAH.PtdBal06 AS ActualPTDBal06, BasisActualAH.PtdBal07 AS ActualPTDBal07, BasisActualAH.PtdBal08 AS ActualPTDBal08, 
    BasisActualAH.PtdBal09 AS ActualPTDBal09, BasisActualAH.PtdBal10 AS ActualPTDBal10, BasisActualAH.PtdBal11 AS ActualPTDBal11, 
    BasisActualAH.PtdBal12 AS ActualPTDBal12, 
    BasisActualAH.YTDBal00 AS ActualYTDBal00, BasisActualAH.YTDBal01 AS ActualYTDBal01, BasisActualAH.YTDBal02 AS ActualYTDBal02, 
    BasisActualAH.YTDBal03 AS ActualYTDBal03, BasisActualAH.YTDBal04 AS ActualYTDBal04, BasisActualAH.YTDBal05 AS ActualYTDBal05, 
    BasisActualAH.YTDBal06 AS ActualYTDBal06, BasisActualAH.YTDBal07 AS ActualYTDBal07, BasisActualAH.YTDBal08 AS ActualYTDBal08, 
    BasisActualAH.YTDBal09 AS ActualYTDBal09, BasisActualAH.YTDBal10 AS ActualYTDBal10, BasisActualAH.YTDBal11 AS ActualYTDBal11, 
    BasisActualAH.YTDBal12 AS ActualYTDBal12, 
    BasisBudgetAH.AnnBdgt AS BasisBdgtAnnBdgt, 
    BasisBudgetAH.PtdBal00 AS BasisBdgtPTDBal00, BasisBudgetAH.PtdBal01 AS BasisBdgtPTDBal01, BasisBudgetAH.PtdBal02 AS BasisBdgtPTDBal02, 
    BasisBudgetAH.PtdBal03 AS BasisBdgtPTDBal03, BasisBudgetAH.PtdBal04 AS BasisBdgtPTDBal04, BasisBudgetAH.PtdBal05 AS BasisBdgtPTDBal05, 
    BasisBudgetAH.PtdBal06 AS BasisBdgtPTDBal06, BasisBudgetAH.PtdBal07 AS BasisBdgtPTDBal07, BasisBudgetAH.PtdBal08 AS BasisBdgtPTDBal08, 
    BasisBudgetAH.PtdBal09 AS BasisBdgtPTDBal09, BasisBudgetAH.PtdBal10 AS BasisBdgtPTDBal10, BasisBudgetAH.PTDBal11 AS BasisBdgtPTDBal11, 
    BasisBudgetAH.PtdBal12 AS BasisBdgtPTDBal12, 
    BasisBudgetAH.YTDBal00 AS BasisBdgtYTDBal00, BasisBudgetAH.YTDBal01 AS BasisBdgtYTDBal01, BasisBudgetAH.YTDBal02 AS BasisBdgtYTDBal02, 
    BasisBudgetAH.YTDBal03 AS BasisBdgtYTDBal03, BasisBudgetAH.YTDBal04 AS BasisBdgtYTDBal04, BasisBudgetAH.YTDBal05 AS BasisBdgtYTDBal05, 
    BasisBudgetAH.YTDBal06 AS BasisBdgtYTDBal06, BasisBudgetAH.YTDBal07 AS BasisBdgtYTDBal07, BasisBudgetAH.YTDBal08 AS BasisBdgtYTDBal08, 
    BasisBudgetAH.YTDBal09 AS BasisBdgtYTDBal09, BasisBudgetAH.YTDBal10 AS BasisBdgtYTDBal10, BasisBudgetAH.YTDBal11 AS BasisBdgtYTDBal11, 
    BasisBudgetAH.YTDBal12 AS BasisBdgtYTDBal12, BasisBudgetAH.YTDEstimated AS BasisBdgtYTDEstimated, 
    BudgetAH.Acct AS BudgetAcct, BudgetAH.Sub AS BudgetSub, BudgetAH.AnnBdgt AS BudgetAnnBdgt, 
    BudgetAH.PtdBal00 AS BudgetPTDBal00, BudgetAH.PtdBal01 AS BudgetPTDBal01, BudgetAH.PtdBal02 AS BudgetPTDBal02, 
    BudgetAH.PtdBal03 AS BudgetPTDBal03, BudgetAH.PtdBal04 AS BudgetPTDBal04, BudgetAH.PtdBal05 AS BudgetPTDBal05, 
    BudgetAH.PtdBal06 AS BudgetPTDBal06, BudgetAH.PtdBal07 AS BudgetPTDBal07, BudgetAH.PtdBal08 AS BudgetPTDBal08, 
    BudgetAH.PtdBal09 AS BudgetPTDBal09, BudgetAH.PtdBal10 AS BudgetPTDBal10, BudgetAH.PTDBal11 AS BudgetPTDBal11, 
    BudgetAH.PtdBal12 AS BudgetPTDBal12, 
    BudgetAH.YTDBal00 AS BudgetYTDBal00, BudgetAH.YTDBal01 AS BudgetYTDBal01, BudgetAH.YTDBal02 AS BudgetYTDBal02, 
    BudgetAH.YTDBal03 AS BudgetYTDBal03, BudgetAH.YTDBal04 AS BudgetYTDBal04, BudgetAH.YTDBal05 AS BudgetYTDBal05, 
    BudgetAH.YTDBal06 AS BudgetYTDBal06, BudgetAH.YTDBal07 AS BudgetYTDBal07, BudgetAH.YTDBal08 AS BudgetYTDBal08, 
    BudgetAH.YTDBal09 AS BudgetYTDBal09, BudgetAH.YTDBal10 AS BudgetYTDBal10, BudgetAH.YTDBal11 AS BudgetYTDBal11, 
    BudgetAH.YTDBal12 AS BudgetYTDBal12, BudgetAH.YTDEstimated AS BudgetYTDEstimated,
    Budget.User1 as BudgetUser1, Budget.User2 as BudgetUser2, Budget.User3 as BudgetUser3, Budget.User4 as BudgetUser4,
    Budget.User5 as BudgetUser5, Budget.User6 as BudgetUser6, Budget.User7 as BudgetUser7, Budget.User8 as BudgetUser8,
    v.User1 as VersionUser1, v.User2 as VersionUser2, v.User3 as VersionUser3, v.User4 as VersionUser4,
    v.User5 as VersionUser5, v.User6 as VersionUser6, v.User7 as VersionUser7, v.User8 as VersionUser8
    --F.NumberSegments, F.SegLength00, F.SegLength01, F.SegLength02, F.SegLength03, F.SegLength04, F.SegLength05, 
    --F.SegLength06, F.SegLength07, GLSetup.BudgetSubSeg00, GLSetup.BudgetSubSeg01, GLSetup.BudgetSubSeg02, GLSetup.BudgetSubSeg03,
    --GLSetup.BudgetSubSeg04, GLSetup.BudgetSubSeg05, GLSetup.BudgetSubSeg06, GLSetup.BudgetSubSeg07
FROM Budget_Version V INNER JOIN Budget ON V.BudgetLedgerID = Budget.BudgetLedgerID
    AND V.BudgetYear = Budget.BudgetYear And V.CpnyID = Budget.CpnyID
    --Inner Join proposed budget ledger accthist (current budget)
    INNER JOIN AcctHist BudgetAH ON V.BudgetLedgerID = BudgetAH.LedgerID 
    AND V.BudgetYear = BudgetAH.FiscYr AND V.CpnyID = BudgetAH.CpnyID AND
    BudgetAH.Sub LIKE RTRIM(REPLACE(Budget.BdgtSegment, '?', '_'))

    --Outer Join basis budget ledger AcctHist data (previous year's or basis year's budget)
    --  Budget_Version.S4Future02 = Basis Budget Company ID
    --  Budget_Version.S4Future11 = Basis Budget Ledger ID
    --  Budget_Version.S4Future01 = Basis Budget Year
    LEFT OUTER JOIN AcctHist BasisBudgetAH ON V.S4Future02 = BasisBudgetAH.CpnyID 
    AND V.S4Future11 = BasisBudgetAH.LedgerID AND V.S4Future01 = BasisBudgetAH.FiscYr
    AND BudgetAH.Acct = BasisBudgetAH.Acct
    AND BudgetAH.Sub = BasisBudgetAH.Sub --LIKE REPLACE(Budget.BdgtSegment, '?', '_')

    --Join Account and RptCompany
    INNER JOIN RptCompany R ON V.CpnyID = R.CpnyID
    INNER JOIN Account ON BudgetAH.Acct = Account.Acct

    --Join GLSetup for Budget Segment indicators (GLSetup.BudgetSubSeg00 - 07)
    LEFT OUTER JOIN GLSetup (NOLOCK) ON GLSetup.CpnyID = GLSetup.CpnyID

    --Join BUSetup table for Budget Fill Segments
    INNER JOIN BUSetup (NOLOCK) ON V.CpnyID = BUSetup.CpnyID

    --Join FlexDef table for Subaccount segment lengths
    INNER JOIN FlexDef F ON F.FieldClassName = 'SUBACCOUNT'

    --Outer Join actual ledger accthist (basis actual ledger data)
    --  Budget_Version.S4Future12 = Basis Actual Year
    LEFT OUTER JOIN AcctHist BasisActualAH ON V.SrcCpnyID = BasisActualAH.CpnyID 
    AND V.Source = BasisActualAH.LedgerID AND V.S4Future12 = BasisActualAH.FiscYr
    AND BudgetAH.Acct = BasisActualAH.Acct AND
    --Actual Subaccounts must have fill characters masked out
    BasisActualAH.Sub LIKE RTRIM(           --REPLACE(
	 CASE F.NumberSegments     
	   WHEN 8 THEN
	    CASE GLSetup.BudgetSubSeg00 
    	    WHEN '1' THEN RTRIM(LEFT(BudgetAH.Sub, F.SegLength00))
       	    WHEN '0' THEN RTRIM(REPLICATE('_', F.SegLength00)) END 
	    +
	    CASE GLSetup.BudgetSubSeg01 
    	    WHEN '1' THEN RTRIM(SUBSTRING(BudgetAH.Sub, F.SegLength00 + 1, F.SegLength01))
       	    WHEN '0' THEN RTRIM(REPLICATE('_', F.SegLength01)) END 
	    +
	    CASE GLSetup.BudgetSubSeg02 
    	    WHEN '1' THEN RTRIM(SUBSTRING(BudgetAH.Sub, F.SegLength00 + F.SegLength01 + 1, F.SegLength02))
       	    WHEN '0' THEN RTRIM(REPLICATE('_', F.SegLength02)) END 
	    +
	    CASE GLSetup.BudgetSubSeg03 
    	    WHEN '1' THEN RTRIM(SUBSTRING(BudgetAH.Sub, F.SegLength00 + F.SegLength01 + F.SegLength02 + 1, F.SegLength03))
       	    WHEN '0' THEN RTRIM(REPLICATE('_', F.SegLength03)) END 
	    +
	    CASE GLSetup.BudgetSubSeg04 
    	    WHEN '1' THEN RTRIM(SUBSTRING(BudgetAH.Sub, F.SegLength00 + F.SegLength01 + F.SegLength02 + F.SegLength03 + 1, F.SegLength04))
       	    WHEN '0' THEN RTRIM(REPLICATE('_', F.SegLength04)) END 
	    +
	    CASE GLSetup.BudgetSubSeg05 
    	    WHEN '1' THEN RTRIM(SUBSTRING(BudgetAH.Sub, F.SegLength00 + F.SegLength01 + F.SegLength02 + F.SegLength03 + F.SegLength04 + 1, F.SegLength05))
       	    WHEN '0' THEN RTRIM(REPLICATE('_', F.SegLength05)) END 
	    +
   	    CASE GLSetup.BudgetSubSeg06 
    	    WHEN '1' THEN RTRIM(SUBSTRING(BudgetAH.Sub, F.SegLength00 + F.SegLength01 + F.SegLength02 + F.SegLength03 + F.SegLength04 + F.SegLength05 + 1, F.SegLength06))
       	    WHEN '0' THEN RTRIM(REPLICATE('_', F.SegLength06)) END 
	    +
	    CASE GLSetup.BudgetSubSeg07 
    	    WHEN '1' THEN RTRIM(SUBSTRING(BudgetAH.Sub, F.SegLength00 + F.SegLength01 + F.SegLength02 + F.SegLength03 + F.SegLength04 + F.SegLength05 + F.SegLength06 + 1, F.SegLength07))
       	    WHEN '0' THEN RTRIM(REPLICATE('_', F.SegLength07)) END
	   WHEN 7 THEN
	    CASE GLSetup.BudgetSubSeg00 
    	    WHEN '1' THEN RTRIM(LEFT(BudgetAH.Sub, F.SegLength00))
       	    WHEN '0' THEN RTRIM(REPLICATE('_', F.SegLength00)) END 
	    +
	    CASE GLSetup.BudgetSubSeg01 
    	    WHEN '1' THEN RTRIM(SUBSTRING(BudgetAH.Sub, F.SegLength00 + 1, F.SegLength01))
       	    WHEN '0' THEN RTRIM(REPLICATE('_', F.SegLength01)) END 
	    +
	    CASE GLSetup.BudgetSubSeg02 
    	    WHEN '1' THEN RTRIM(SUBSTRING(BudgetAH.Sub, F.SegLength00 + F.SegLength01 + 1, F.SegLength02))
       	    WHEN '0' THEN RTRIM(REPLICATE('_', F.SegLength02)) END 
	    +
	    CASE GLSetup.BudgetSubSeg03 
    	    WHEN '1' THEN RTRIM(SUBSTRING(BudgetAH.Sub, F.SegLength00 + F.SegLength01 + F.SegLength02 + 1, F.SegLength03))
       	    WHEN '0' THEN RTRIM(REPLICATE('_', F.SegLength03)) END 
	    +
	    CASE GLSetup.BudgetSubSeg04 
    	    WHEN '1' THEN RTRIM(SUBSTRING(BudgetAH.Sub, F.SegLength00 + F.SegLength01 + F.SegLength02 + F.SegLength03 + 1, F.SegLength04))
       	    WHEN '0' THEN RTRIM(REPLICATE('_', F.SegLength04)) END 
	    +
	    CASE GLSetup.BudgetSubSeg05 
    	    WHEN '1' THEN RTRIM(SUBSTRING(BudgetAH.Sub, F.SegLength00 + F.SegLength01 + F.SegLength02 + F.SegLength03 + F.SegLength04 + 1, F.SegLength05))
       	    WHEN '0' THEN RTRIM(REPLICATE('_', F.SegLength05)) END 
	    +
   	    CASE GLSetup.BudgetSubSeg06 
    	    WHEN '1' THEN RTRIM(SUBSTRING(BudgetAH.Sub, F.SegLength00 + F.SegLength01 + F.SegLength02 + F.SegLength03 + F.SegLength04 + F.SegLength05 + 1, F.SegLength06))
       	    WHEN '0' THEN RTRIM(REPLICATE('_', F.SegLength06)) END
	   WHEN 6 THEN
	    CASE GLSetup.BudgetSubSeg00 
    	    WHEN '1' THEN RTRIM(LEFT(BudgetAH.Sub, F.SegLength00))
       	    WHEN '0' THEN RTRIM(REPLICATE('_', F.SegLength00)) END 
	    +
	    CASE GLSetup.BudgetSubSeg01 
    	    WHEN '1' THEN RTRIM(SUBSTRING(BudgetAH.Sub, F.SegLength00 + 1, F.SegLength01))
       	    WHEN '0' THEN RTRIM(REPLICATE('_', F.SegLength01)) END 
	    +
	    CASE GLSetup.BudgetSubSeg02 
    	    WHEN '1' THEN RTRIM(SUBSTRING(BudgetAH.Sub, F.SegLength00 + F.SegLength01 + 1, F.SegLength02))
       	    WHEN '0' THEN RTRIM(REPLICATE('_', F.SegLength02)) END 
	    +
	    CASE GLSetup.BudgetSubSeg03 
    	    WHEN '1' THEN RTRIM(SUBSTRING(BudgetAH.Sub, F.SegLength00 + F.SegLength01 + F.SegLength02 + 1, F.SegLength03))
       	    WHEN '0' THEN RTRIM(REPLICATE('_', F.SegLength03)) END 
	    +
	    CASE GLSetup.BudgetSubSeg04 
    	    WHEN '1' THEN RTRIM(SUBSTRING(BudgetAH.Sub, F.SegLength00 + F.SegLength01 + F.SegLength02 + F.SegLength03 + 1, F.SegLength04))
       	    WHEN '0' THEN RTRIM(REPLICATE('_', F.SegLength04)) END 
	    +
	    CASE GLSetup.BudgetSubSeg05 
    	    WHEN '1' THEN RTRIM(SUBSTRING(BudgetAH.Sub, F.SegLength00 + F.SegLength01 + F.SegLength02 + F.SegLength03 + F.SegLength04 + 1, F.SegLength05))
       	    WHEN '0' THEN RTRIM(REPLICATE('_', F.SegLength05)) END
	   WHEN 5 THEN
	    CASE GLSetup.BudgetSubSeg00 
    	    WHEN '1' THEN RTRIM(LEFT(BudgetAH.Sub, F.SegLength00))
       	    WHEN '0' THEN RTRIM(REPLICATE('_', F.SegLength00)) END 
	    +
	    CASE GLSetup.BudgetSubSeg01 
    	    WHEN '1' THEN RTRIM(SUBSTRING(BudgetAH.Sub, F.SegLength00 + 1, F.SegLength01))
       	    WHEN '0' THEN RTRIM(REPLICATE('_', F.SegLength01)) END 
	    +
	    CASE GLSetup.BudgetSubSeg02 
    	    WHEN '1' THEN RTRIM(SUBSTRING(BudgetAH.Sub, F.SegLength00 + F.SegLength01 + 1, F.SegLength02))
       	    WHEN '0' THEN RTRIM(REPLICATE('_', F.SegLength02)) END 
	    +
	    CASE GLSetup.BudgetSubSeg03 
    	    WHEN '1' THEN RTRIM(SUBSTRING(BudgetAH.Sub, F.SegLength00 + F.SegLength01 + F.SegLength02 + 1, F.SegLength03))
       	    WHEN '0' THEN RTRIM(REPLICATE('_', F.SegLength03)) END 
	    +
	    CASE GLSetup.BudgetSubSeg04 
    	    WHEN '1' THEN RTRIM(SUBSTRING(BudgetAH.Sub, F.SegLength00 + F.SegLength01 + F.SegLength02 + F.SegLength03 + 1, F.SegLength04))
       	    WHEN '0' THEN RTRIM(REPLICATE('_', F.SegLength04)) END 
	   WHEN 4 THEN
	    CASE GLSetup.BudgetSubSeg00 
    	    WHEN '1' THEN RTRIM(LEFT(BudgetAH.Sub, F.SegLength00))
       	    WHEN '0' THEN RTRIM(REPLICATE('_', F.SegLength00)) END 
	    +
	    CASE GLSetup.BudgetSubSeg01 
    	    WHEN '1' THEN RTRIM(SUBSTRING(BudgetAH.Sub, F.SegLength00 + 1, F.SegLength01))
       	    WHEN '0' THEN RTRIM(REPLICATE('_', F.SegLength01)) END 
	    +
	    CASE GLSetup.BudgetSubSeg02 
    	    WHEN '1' THEN RTRIM(SUBSTRING(BudgetAH.Sub, F.SegLength00 + F.SegLength01 + 1, F.SegLength02))
       	    WHEN '0' THEN RTRIM(REPLICATE('_', F.SegLength02)) END 
 	    +
	    CASE GLSetup.BudgetSubSeg03 
    	    WHEN '1' THEN RTRIM(SUBSTRING(BudgetAH.Sub, F.SegLength00 + F.SegLength01 + F.SegLength02 + 1, F.SegLength03))
       	    WHEN '0' THEN RTRIM(REPLICATE('_', F.SegLength03)) END
	   WHEN 3 THEN
	    CASE GLSetup.BudgetSubSeg00 
    	    WHEN '1' THEN RTRIM(LEFT(BudgetAH.Sub, F.SegLength00))
       	    WHEN '0' THEN RTRIM(REPLICATE('_', F.SegLength00)) END 
	    +
	    CASE GLSetup.BudgetSubSeg01 
    	    WHEN '1' THEN RTRIM(SUBSTRING(BudgetAH.Sub, F.SegLength00 + 1, F.SegLength01))
       	    WHEN '0' THEN RTRIM(REPLICATE('_', F.SegLength01)) END 
	    +
	    CASE GLSetup.BudgetSubSeg02 
    	    WHEN '1' THEN RTRIM(SUBSTRING(BudgetAH.Sub, F.SegLength00 + F.SegLength01 + 1, F.SegLength02))
       	    WHEN '0' THEN RTRIM(REPLICATE('_', F.SegLength02)) END
	   WHEN 2 THEN
	    CASE GLSetup.BudgetSubSeg00 
    	    WHEN '1' THEN RTRIM(LEFT(BudgetAH.Sub, F.SegLength00))
       	    WHEN '0' THEN RTRIM(REPLICATE('_', F.SegLength00)) END 
	    +
	    CASE GLSetup.BudgetSubSeg01 
    	    WHEN '1' THEN RTRIM(SUBSTRING(BudgetAH.Sub, F.SegLength00 + 1, F.SegLength01))
       	    WHEN '0' THEN RTRIM(REPLICATE('_', F.SegLength01)) END
	   ELSE --One segment, no unused segments possible
    	    RTRIM(BudgetAH.Sub) END) --, '?', '_')) --Replace '?' with SQL wild char


 
