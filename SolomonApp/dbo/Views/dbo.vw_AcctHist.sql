Create View [dbo].vw_AcctHist
As
	Select
		AcctHist.Acct + AcctHist.Sub AS acct_code, Account.Active as 'AcctActive', Subacct.Active as 'SubActive', vw_acctsub.Active as 'AcctSubActive', 
		0 as per_num, 
		BalanceType, 
		BegBal * Multiplier BegBal, 
		AcctHist.CpnyID, 
		CAST(FiscYr AS smallint) AS fiscal_year, 
		LedgerID, 
		PtdAlloc00 * Multiplier PtdAlloc00,
		PtdAlloc01 * Multiplier PtdAlloc01,
		PtdAlloc02 * Multiplier PtdAlloc02,
		PtdAlloc03 * Multiplier PtdAlloc03,
		PtdAlloc04 * Multiplier PtdAlloc04,
		PtdAlloc05 * Multiplier PtdAlloc05,
		PtdAlloc06 * Multiplier PtdAlloc06,
		PtdAlloc07 * Multiplier PtdAlloc07,
		PtdAlloc08 * Multiplier PtdAlloc08,
		PtdAlloc09 * Multiplier PtdAlloc09,
		PtdAlloc10 * Multiplier PtdAlloc10,
		PtdAlloc11 * Multiplier PtdAlloc11,
		PtdAlloc12 * Multiplier PtdAlloc12,
		PtdBal00 * Multiplier PtdBal00,
		PtdBal01 * Multiplier PtdBal01,
		PtdBal02 * Multiplier PtdBal02,
		PtdBal03 * Multiplier PtdBal03,
		PtdBal04 * Multiplier PtdBal04,
		PtdBal05 * Multiplier PtdBal05,
		PtdBal06 * Multiplier PtdBal06,
		PtdBal07 * Multiplier PtdBal07,
		PtdBal08 * Multiplier PtdBal08,
		PtdBal09 * Multiplier PtdBal09,
		PtdBal10 * Multiplier PtdBal10,
		PtdBal11 * Multiplier PtdBal11,
		PtdBal12 * Multiplier PtdBal12,
		PtdCon00 * Multiplier PtdCon00,
		PtdCon01 * Multiplier PtdCon01,
		PtdCon02 * Multiplier PtdCon02,
		PtdCon03 * Multiplier PtdCon03,
		PtdCon04 * Multiplier PtdCon04,
		PtdCon05 * Multiplier PtdCon05,
		PtdCon06 * Multiplier PtdCon06,
		PtdCon07 * Multiplier PtdCon07,
		PtdCon08 * Multiplier PtdCon08,
		PtdCon09 * Multiplier PtdCon09,
		PtdCon10 * Multiplier PtdCon10,
		PtdCon11 * Multiplier PtdCon11,
		PtdCon12 * Multiplier PtdCon12,
		(begbal + ptdbal00) * Multiplier YtdBal00, 
		(begbal + ptdbal00 + ptdbal01) * Multiplier YtdBal01, 
	    (begbal + ptdbal00 + ptdbal01 + ptdbal02) * Multiplier YtdBal02, 
	    (begbal + ptdbal00 + ptdbal01 + ptdbal02 + ptdbal03) * Multiplier YtdBal03, 
	    (begbal + ptdbal00 + ptdbal01 + ptdbal02 + ptdbal03  + ptdBal04) * Multiplier YtdBal04, 
	    (begbal + ptdbal00 + ptdbal01 + ptdbal02 + ptdbal03  + ptdbal04 + ptdbal05) * Multiplier YtdBal05, 
	    (begbal + ptdbal00 + ptdbal01 + ptdbal02 + ptdbal03  + ptdbal04 + ptdbal05 + ptdbal06) * Multiplier YtdBal06, 
	    (begbal + ptdbal00 + ptdbal01 + ptdbal02 + ptdbal03  + ptdbal04 + ptdbal05 + ptdbal06 + ptdbal07) * Multiplier  YtdBal07, 
	    (begbal + ptdbal00 + ptdbal01 + ptdbal02 + ptdbal03  + ptdbal04 + ptdbal05 + ptdbal06 + PtdBal07 + ptdbal08) * Multiplier  YtdBal08, 
	    (begbal + ptdbal00 + ptdbal01 + ptdbal02 + ptdbal03  + ptdbal04 + ptdbal05 + ptdbal06 + PtdBal07 + ptdbal08 + ptdbal09) * Multiplier YtdBal09, 
	    (begbal + ptdbal00 + ptdbal01 + ptdbal02 + ptdbal03  + ptdbal04 + ptdbal05 + ptdbal06 + PtdBal07 + ptdbal08 + ptdbal09 + ptdbal10) * Multiplier YtdBal10, 
	    (begbal + ptdbal00 + ptdbal01 + ptdbal02 + ptdbal03  + ptdbal04 + ptdbal05 + ptdbal06 + PtdBal07 + ptdbal08 + ptdbal09 + ptdbal10 + ptdbal11) * Multiplier  YtdBal11, 
	    (begbal + ptdbal00 + ptdbal01 + ptdbal02 + ptdbal03  + ptdbal04 + ptdbal05 + ptdbal06 + PtdBal07 + ptdbal08 + ptdbal09 + ptdbal10 + ptdbal11 + ptdbal12) * Multiplier YtdBal12, 
		YTDEstimated, 
     ( select 
     sum(dramt) from GLTran where GLTran.CpnyID  = AcctHist.CpnyID AND GLTran.acct = AcctHist.acct and GLTran.Sub = AcctHist.Sub AND 
     GLTran.LedgerID  = AcctHist.LedgerID AND posted = 'P' AND GLTran.perpost = AcctHist.fiscyr + '01' ) as PtdDRAMT01,
     ( select 
     sum(dramt) from GLTran where GLTran.CpnyID  = AcctHist.CpnyID AND GLTran.acct = AcctHist.acct and GLTran.Sub = AcctHist.Sub AND 
     GLTran.LedgerID  = AcctHist.LedgerID AND posted = 'P' AND GLTran.perpost = AcctHist.fiscyr + '02' ) as PtdDRAMT02,
     ( select 
     sum(dramt) from GLTran where GLTran.CpnyID  = AcctHist.CpnyID AND GLTran.acct = AcctHist.acct and GLTran.Sub = AcctHist.Sub AND 
     GLTran.LedgerID  = AcctHist.LedgerID AND posted = 'P' AND GLTran.perpost = AcctHist.fiscyr + '03' ) as PtdDRAMT03,
     ( select 
     sum(dramt) from GLTran where GLTran.CpnyID  = AcctHist.CpnyID AND GLTran.acct = AcctHist.acct and GLTran.Sub = AcctHist.Sub AND 
     GLTran.LedgerID  = AcctHist.LedgerID AND posted = 'P' AND GLTran.perpost = AcctHist.fiscyr + '04' ) as PtdDRAMT04,
     ( select 
     sum(dramt) from GLTran where GLTran.CpnyID  = AcctHist.CpnyID AND GLTran.acct = AcctHist.acct and GLTran.Sub = AcctHist.Sub AND 
     GLTran.LedgerID  = AcctHist.LedgerID AND posted = 'P' AND GLTran.perpost = AcctHist.fiscyr + '05' ) as PtdDRAMT05,
     ( select 
     sum(dramt) from GLTran where GLTran.CpnyID  = AcctHist.CpnyID AND GLTran.acct = AcctHist.acct and GLTran.Sub = AcctHist.Sub AND 
     GLTran.LedgerID  = AcctHist.LedgerID AND posted = 'P' AND GLTran.perpost = AcctHist.fiscyr + '06' ) as PtdDRAMT06,
     ( select 
     sum(dramt) from GLTran where GLTran.CpnyID  = AcctHist.CpnyID AND GLTran.acct = AcctHist.acct and GLTran.Sub = AcctHist.Sub AND 
     GLTran.LedgerID  = AcctHist.LedgerID AND posted = 'P' AND GLTran.perpost = AcctHist.fiscyr + '07' ) as PtdDRAMT07,
     ( select 
     sum(dramt) from GLTran where GLTran.CpnyID  = AcctHist.CpnyID AND GLTran.acct = AcctHist.acct and GLTran.Sub = AcctHist.Sub AND 
     GLTran.LedgerID  = AcctHist.LedgerID AND posted = 'P' AND GLTran.perpost = AcctHist.fiscyr + '08' ) as PtdDRAMT08,
     ( select 
     sum(dramt) from GLTran where GLTran.CpnyID  = AcctHist.CpnyID AND GLTran.acct = AcctHist.acct and GLTran.Sub = AcctHist.Sub AND 
     GLTran.LedgerID  = AcctHist.LedgerID AND posted = 'P' AND GLTran.perpost = AcctHist.fiscyr + '09' ) as PtdDRAMT09,
     ( select 
     sum(dramt) from GLTran where GLTran.CpnyID  = AcctHist.CpnyID AND GLTran.acct = AcctHist.acct and GLTran.Sub = AcctHist.Sub AND 
     GLTran.LedgerID  = AcctHist.LedgerID AND posted = 'P' AND GLTran.perpost = AcctHist.fiscyr + '10' ) as PtdDRAMT10,
     ( select 
     sum(dramt) from GLTran where GLTran.CpnyID  = AcctHist.CpnyID AND GLTran.acct = AcctHist.acct and GLTran.Sub = AcctHist.Sub AND 
     GLTran.LedgerID  = AcctHist.LedgerID AND posted = 'P' AND GLTran.perpost = AcctHist.fiscyr + '11' ) as PtdDRAMT11,
     ( select 
     sum(dramt) from GLTran where GLTran.CpnyID  = AcctHist.CpnyID AND GLTran.acct = AcctHist.acct and GLTran.Sub = AcctHist.Sub AND 
     GLTran.LedgerID  = AcctHist.LedgerID AND posted = 'P' AND GLTran.perpost = AcctHist.fiscyr + '12' ) as PtdDRAMT12,
     ( select 
     sum(cramt) from GLTran where GLTran.CpnyID  = AcctHist.CpnyID AND GLTran.acct = AcctHist.acct and GLTran.Sub = AcctHist.Sub AND 
     GLTran.LedgerID  = AcctHist.LedgerID AND posted = 'P' AND GLTran.perpost = AcctHist.fiscyr + '01' ) as PtdCRAMT01,
     ( select 
     sum(cramt) from GLTran where GLTran.CpnyID  = AcctHist.CpnyID AND GLTran.acct = AcctHist.acct and GLTran.Sub = AcctHist.Sub AND 
     GLTran.LedgerID  = AcctHist.LedgerID AND posted = 'P' AND GLTran.perpost = AcctHist.fiscyr + '02' ) as PtdCRAMT02,
     ( select 
     sum(cramt) from GLTran where GLTran.CpnyID  = AcctHist.CpnyID AND GLTran.acct = AcctHist.acct and GLTran.Sub = AcctHist.Sub AND 
     GLTran.LedgerID  = AcctHist.LedgerID AND posted = 'P' AND GLTran.perpost = AcctHist.fiscyr + '03' ) as PtdCRAMT03,
     ( select 
     sum(cramt) from GLTran where GLTran.CpnyID  = AcctHist.CpnyID AND GLTran.acct = AcctHist.acct and GLTran.Sub = AcctHist.Sub AND 
     GLTran.LedgerID  = AcctHist.LedgerID AND posted = 'P' AND GLTran.perpost = AcctHist.fiscyr + '04' ) as PtdCRAMT04,
     ( select 
     sum(cramt) from GLTran where GLTran.CpnyID  = AcctHist.CpnyID AND GLTran.acct = AcctHist.acct and GLTran.Sub = AcctHist.Sub AND 
     GLTran.LedgerID  = AcctHist.LedgerID AND posted = 'P' AND GLTran.perpost = AcctHist.fiscyr + '05' ) as PtdCRAMT05,
     ( select 
     sum(cramt) from GLTran where GLTran.CpnyID  = AcctHist.CpnyID AND GLTran.acct = AcctHist.acct and GLTran.Sub = AcctHist.Sub AND 
     GLTran.LedgerID  = AcctHist.LedgerID AND posted = 'P' AND GLTran.perpost = AcctHist.fiscyr + '06' ) as PtdCRAMT06,
     ( select 
     sum(cramt) from GLTran where GLTran.CpnyID  = AcctHist.CpnyID AND GLTran.acct = AcctHist.acct and GLTran.Sub = AcctHist.Sub AND 
     GLTran.LedgerID  = AcctHist.LedgerID AND posted = 'P' AND GLTran.perpost = AcctHist.fiscyr + '07' ) as PtdCRAMT07,
     ( select 
     sum(cramt) from GLTran where GLTran.CpnyID  = AcctHist.CpnyID AND GLTran.acct = AcctHist.acct and GLTran.Sub = AcctHist.Sub AND 
     GLTran.LedgerID  = AcctHist.LedgerID AND posted = 'P' AND GLTran.perpost = AcctHist.fiscyr + '08' ) as PtdCRAMT08,
     ( select 
     sum(cramt) from GLTran where GLTran.CpnyID  = AcctHist.CpnyID AND GLTran.acct = AcctHist.acct and GLTran.Sub = AcctHist.Sub AND 
     GLTran.LedgerID  = AcctHist.LedgerID AND posted = 'P' AND GLTran.perpost = AcctHist.fiscyr + '09' ) as PtdCRAMT09,
     ( select 
     sum(cramt) from GLTran where GLTran.CpnyID  = AcctHist.CpnyID AND GLTran.acct = AcctHist.acct and GLTran.Sub = AcctHist.Sub AND 
     GLTran.LedgerID  = AcctHist.LedgerID AND posted = 'P' AND GLTran.perpost = AcctHist.fiscyr + '10' ) as PtdCRAMT10,
     ( select 
     sum(cramt) from GLTran where GLTran.CpnyID  = AcctHist.CpnyID AND GLTran.acct = AcctHist.acct and GLTran.Sub = AcctHist.Sub AND 
     GLTran.LedgerID  = AcctHist.LedgerID AND posted = 'P' AND GLTran.perpost = AcctHist.fiscyr + '11' ) as PtdCRAMT11,
     ( select 
     sum(cramt) from GLTran where GLTran.CpnyID  = AcctHist.CpnyID AND GLTran.acct = AcctHist.acct and GLTran.Sub = AcctHist.Sub AND 
     GLTran.LedgerID  = AcctHist.LedgerID AND posted = 'P' AND GLTran.perpost = AcctHist.fiscyr + '12' ) as PtdCRAMT12,
     
     ( select 
     sum(cramt) from GLTran where GLTran.CpnyID  = AcctHist.CpnyID AND GLTran.acct = AcctHist.acct and GLTran.Sub = AcctHist.Sub AND 
     GLTran.LedgerID  = AcctHist.LedgerID AND posted = 'P' AND GLTran.fiscyr = AcctHist.fiscyr AND SUBSTRING(GLTran.perpost,5,2) = '01' ) as YtdCRAMT01,
     ( select 
     sum(cramt) from GLTran where GLTran.CpnyID  = AcctHist.CpnyID AND GLTran.acct = AcctHist.acct and GLTran.Sub = AcctHist.Sub AND 
     GLTran.LedgerID  = AcctHist.LedgerID AND posted = 'P' AND GLTran.fiscyr = AcctHist.fiscyr AND SUBSTRING(GLTran.perpost,5,2) <= '02' ) as YtdCRAMT02,
     ( select 
     sum(cramt) from GLTran where GLTran.CpnyID  = AcctHist.CpnyID AND GLTran.acct = AcctHist.acct and GLTran.Sub = AcctHist.Sub AND 
     GLTran.LedgerID  = AcctHist.LedgerID AND posted = 'P' AND GLTran.fiscyr = AcctHist.fiscyr AND SUBSTRING(GLTran.perpost,5,2) <= '03' ) as YtdCRAMT03,
     ( select 
     sum(cramt) from GLTran where GLTran.CpnyID  = AcctHist.CpnyID AND GLTran.acct = AcctHist.acct and GLTran.Sub = AcctHist.Sub AND 
     GLTran.LedgerID  = AcctHist.LedgerID AND posted = 'P' AND GLTran.fiscyr = AcctHist.fiscyr AND SUBSTRING(GLTran.perpost,5,2) <= '04' ) as YtdCRAMT04,
     ( select 
     sum(cramt) from GLTran where GLTran.CpnyID  = AcctHist.CpnyID AND GLTran.acct = AcctHist.acct and GLTran.Sub = AcctHist.Sub AND 
     GLTran.LedgerID  = AcctHist.LedgerID AND posted = 'P' AND GLTran.fiscyr = AcctHist.fiscyr AND SUBSTRING(GLTran.perpost,5,2) <= '05' ) as YtdCRAMT05,
     ( select 
     sum(cramt) from GLTran where GLTran.CpnyID  = AcctHist.CpnyID AND GLTran.acct = AcctHist.acct and GLTran.Sub = AcctHist.Sub AND 
     GLTran.LedgerID  = AcctHist.LedgerID AND posted = 'P' AND GLTran.fiscyr = AcctHist.fiscyr AND SUBSTRING(GLTran.perpost,5,2) <= '06' ) as YtdCRAMT06,
     ( select 
     sum(cramt) from GLTran where GLTran.CpnyID  = AcctHist.CpnyID AND GLTran.acct = AcctHist.acct and GLTran.Sub = AcctHist.Sub AND 
     GLTran.LedgerID  = AcctHist.LedgerID AND posted = 'P' AND GLTran.fiscyr = AcctHist.fiscyr AND SUBSTRING(GLTran.perpost,5,2) <= '07' ) as YtdCRAMT07,
     ( select 
     sum(cramt) from GLTran where GLTran.CpnyID  = AcctHist.CpnyID AND GLTran.acct = AcctHist.acct and GLTran.Sub = AcctHist.Sub AND 
     GLTran.LedgerID  = AcctHist.LedgerID AND posted = 'P' AND GLTran.fiscyr = AcctHist.fiscyr AND SUBSTRING(GLTran.perpost,5,2) <= '08' ) as YtdCRAMT08,
     ( select 
     sum(cramt) from GLTran where GLTran.CpnyID  = AcctHist.CpnyID AND GLTran.acct = AcctHist.acct and GLTran.Sub = AcctHist.Sub AND 
     GLTran.LedgerID  = AcctHist.LedgerID AND posted = 'P' AND GLTran.fiscyr = AcctHist.fiscyr AND SUBSTRING(GLTran.perpost,5,2) <= '09' ) as YtdCRAMT09,
     ( select 
     sum(cramt) from GLTran where GLTran.CpnyID  = AcctHist.CpnyID AND GLTran.acct = AcctHist.acct and GLTran.Sub = AcctHist.Sub AND 
     GLTran.LedgerID  = AcctHist.LedgerID AND posted = 'P' AND GLTran.fiscyr = AcctHist.fiscyr AND SUBSTRING(GLTran.perpost,5,2) <= '10' ) as YtdCRAMT10,
     ( select 
     sum(cramt) from GLTran where GLTran.CpnyID  = AcctHist.CpnyID AND GLTran.acct = AcctHist.acct and GLTran.Sub = AcctHist.Sub AND 
     GLTran.LedgerID  = AcctHist.LedgerID AND posted = 'P' AND GLTran.fiscyr = AcctHist.fiscyr AND SUBSTRING(GLTran.perpost,5,2) <= '11' ) as YtdCRAMT11,
     ( select 
     sum(cramt) from GLTran where GLTran.CpnyID  = AcctHist.CpnyID AND GLTran.acct = AcctHist.acct and GLTran.Sub = AcctHist.Sub AND 
     GLTran.LedgerID  = AcctHist.LedgerID AND posted = 'P' AND GLTran.fiscyr = AcctHist.fiscyr AND SUBSTRING(GLTran.perpost,5,2) <= '12' ) as YtdCRAMT12,
     
     ( select 
     sum(DRamt) from GLTran where GLTran.CpnyID  = AcctHist.CpnyID AND GLTran.acct = AcctHist.acct and GLTran.Sub = AcctHist.Sub AND 
     GLTran.LedgerID  = AcctHist.LedgerID AND posted = 'P' AND GLTran.fiscyr = AcctHist.fiscyr AND SUBSTRING(GLTran.perpost,5,2) = '01' ) as YtdDRAMT01,
     ( select 
     sum(DRamt) from GLTran where GLTran.CpnyID  = AcctHist.CpnyID AND GLTran.acct = AcctHist.acct and GLTran.Sub = AcctHist.Sub AND 
     GLTran.LedgerID  = AcctHist.LedgerID AND posted = 'P' AND GLTran.fiscyr = AcctHist.fiscyr AND SUBSTRING(GLTran.perpost,5,2) <= '02' ) as YtdDRAMT02,
     ( select 
     sum(DRamt) from GLTran where GLTran.CpnyID  = AcctHist.CpnyID AND GLTran.acct = AcctHist.acct and GLTran.Sub = AcctHist.Sub AND 
     GLTran.LedgerID  = AcctHist.LedgerID AND posted = 'P' AND GLTran.fiscyr = AcctHist.fiscyr AND SUBSTRING(GLTran.perpost,5,2) <= '03' ) as YtdDRAMT03,
     ( select 
     sum(DRamt) from GLTran where GLTran.CpnyID  = AcctHist.CpnyID AND GLTran.acct = AcctHist.acct and GLTran.Sub = AcctHist.Sub AND 
     GLTran.LedgerID  = AcctHist.LedgerID AND posted = 'P' AND GLTran.fiscyr = AcctHist.fiscyr AND SUBSTRING(GLTran.perpost,5,2) <= '04' ) as YtdDRAMT04,
     ( select 
     sum(DRamt) from GLTran where GLTran.CpnyID  = AcctHist.CpnyID AND GLTran.acct = AcctHist.acct and GLTran.Sub = AcctHist.Sub AND 
     GLTran.LedgerID  = AcctHist.LedgerID AND posted = 'P' AND GLTran.fiscyr = AcctHist.fiscyr AND SUBSTRING(GLTran.perpost,5,2) <= '05' ) as YtdDRAMT05,
     ( select 
     sum(DRamt) from GLTran where GLTran.CpnyID  = AcctHist.CpnyID AND GLTran.acct = AcctHist.acct and GLTran.Sub = AcctHist.Sub AND 
     GLTran.LedgerID  = AcctHist.LedgerID AND posted = 'P' AND GLTran.fiscyr = AcctHist.fiscyr AND SUBSTRING(GLTran.perpost,5,2) <= '06' ) as YtdDRAMT06,
     ( select 
     sum(DRamt) from GLTran where GLTran.CpnyID  = AcctHist.CpnyID AND GLTran.acct = AcctHist.acct and GLTran.Sub = AcctHist.Sub AND 
     GLTran.LedgerID  = AcctHist.LedgerID AND posted = 'P' AND GLTran.fiscyr = AcctHist.fiscyr AND SUBSTRING(GLTran.perpost,5,2) <= '07' ) as YtdDRAMT07,
     ( select 
     sum(DRamt) from GLTran where GLTran.CpnyID  = AcctHist.CpnyID AND GLTran.acct = AcctHist.acct and GLTran.Sub = AcctHist.Sub AND 
     GLTran.LedgerID  = AcctHist.LedgerID AND posted = 'P' AND GLTran.fiscyr = AcctHist.fiscyr AND SUBSTRING(GLTran.perpost,5,2) <= '08' ) as YtdDRAMT08,
     ( select 
     sum(DRamt) from GLTran where GLTran.CpnyID  = AcctHist.CpnyID AND GLTran.acct = AcctHist.acct and GLTran.Sub = AcctHist.Sub AND 
     GLTran.LedgerID  = AcctHist.LedgerID AND posted = 'P' AND GLTran.fiscyr = AcctHist.fiscyr AND SUBSTRING(GLTran.perpost,5,2) <= '09' ) as YtdDRAMT09,
     ( select 
     sum(DRamt) from GLTran where GLTran.CpnyID  = AcctHist.CpnyID AND GLTran.acct = AcctHist.acct and GLTran.Sub = AcctHist.Sub AND 
     GLTran.LedgerID  = AcctHist.LedgerID AND posted = 'P' AND GLTran.fiscyr = AcctHist.fiscyr AND SUBSTRING(GLTran.perpost,5,2) <= '10' ) as YtdDRAMT10,
     ( select 
     sum(DRamt) from GLTran where GLTran.CpnyID  = AcctHist.CpnyID AND GLTran.acct = AcctHist.acct and GLTran.Sub = AcctHist.Sub AND 
     GLTran.LedgerID  = AcctHist.LedgerID AND posted = 'P' AND GLTran.fiscyr = AcctHist.fiscyr AND SUBSTRING(GLTran.perpost,5,2) <= '11' ) as YtdDRAMT11,
     ( select 
     sum(DRamt) from GLTran where GLTran.CpnyID  = AcctHist.CpnyID AND GLTran.acct = AcctHist.acct and GLTran.Sub = AcctHist.Sub AND 
     GLTran.LedgerID  = AcctHist.LedgerID AND posted = 'P' AND GLTran.fiscyr = AcctHist.fiscyr AND SUBSTRING(GLTran.perpost,5,2) <= '12' ) as YtdDRAMT12
    

	From AcctHist
	LEFT OUTER JOIN (SELECT CASE WHEN CHARINDEX(SUBSTRING(AcctType, 2, 1),'AE') > 0 THEN 1 ELSE -1 END AS Multiplier, * FROM Account) Account on Account.Acct = AcctHist.Acct
	LEFT OUTER JOIN SubAcct on subacct.sub = AcctHist.Sub
	LEFT OUTER JOIN vw_acctsub on (vw_acctsub.Acct = AcctHist.Acct AND vw_acctsub.Sub = AcctHist.Sub AND vw_acctSub.Cpnyid = AcctHist.CpnyID)

