

Create View [dbo].[vw_CuryAcct]
As
	Select
		CuryAcct.Acct + CuryAcct.Sub AS acct_code, Account.Active as 'AcctActive', Subacct.Active as 'SubActive', vw_acctsub.Active as 'AcctSubActive',
		0 as per_num, 
		BalanceType, 
		BaseCuryID,
		BegBal * Multiplier BegBal, 
		CuryAcct.CpnyID, 
		CuryBegBal,
		CuryAcct.CuryId as curr_code,
		CuryPtdBal00 * Multiplier CuryPtdBal00, 
		CuryPtdBal01 * Multiplier CuryPtdBal01, 
		CuryPtdBal02 * Multiplier CuryPtdBal02, 
		CuryPtdBal03 * Multiplier CuryPtdBal03, 
		CuryPtdBal04 * Multiplier CuryPtdBal04, 
		CuryPtdBal05 * Multiplier CuryPtdBal05, 
		CuryPtdBal06 * Multiplier CuryPtdBal06, 
		CuryPtdBal07 * Multiplier CuryPtdBal07, 
		CuryPtdBal08 * Multiplier CuryPtdBal08, 
		CuryPtdBal09 * Multiplier CuryPtdBal09, 
		CuryPtdBal10 * Multiplier CuryPtdBal10, 
		CuryPtdBal11 * Multiplier CuryPtdBal11, 
		CuryPtdBal12 * Multiplier CuryPtdBal12, 
		(curybegbal + curyptdbal00) * Multiplier CuryYtdBal00, 
		(curybegbal + curyptdbal00 + curyptdbal01) * Multiplier CuryYtdBal01, 
	    (curybegbal + curyptdbal00 + curyptdbal01 + curyptdbal02) * Multiplier CuryYtdBal02, 
	    (curybegbal + curyptdbal00 + curyptdbal01 + curyptdbal02 + curyptdbal03) * Multiplier CuryYtdBal03, 
	    (curybegbal + curyptdbal00 + curyptdbal01 + curyptdbal02 + curyptdbal03  + curyptdBal04) * Multiplier CuryYtdBal04, 
	    (curybegbal + curyptdbal00 + curyptdbal01 + curyptdbal02 + curyptdbal03  + curyptdbal04 + curyptdbal05) * Multiplier CuryYtdBal05, 
	    (curybegbal + curyptdbal00 + curyptdbal01 + curyptdbal02 + curyptdbal03  + curyptdbal04 + curyptdbal05 + curyptdbal06) * Multiplier CuryYtdBal06, 
	    (curybegbal + curyptdbal00 + curyptdbal01 + curyptdbal02 + curyptdbal03  + curyptdbal04 + curyptdbal05 + curyptdbal06 + curyptdbal07) * Multiplier  CuryYtdBal07, 
	    (curybegbal + curyptdbal00 + curyptdbal01 + curyptdbal02 + curyptdbal03  + curyptdbal04 + curyptdbal05 + curyptdbal06 + curyPtdBal07 + curyptdbal08) * Multiplier  CuryYtdBal08, 
	    (curybegbal + curyptdbal00 + curyptdbal01 + curyptdbal02 + curyptdbal03  + curyptdbal04 + curyptdbal05 + curyptdbal06 + curyPtdBal07 + curyptdbal08 + curyptdbal09) * Multiplier CuryYtdBal09, 
	    (curybegbal + curyptdbal00 + curyptdbal01 + curyptdbal02 + curyptdbal03  + curyptdbal04 + curyptdbal05 + curyptdbal06 + curyPtdBal07 + curyptdbal08 + curyptdbal09 + curyptdbal10) * Multiplier CuryYtdBal10, 
	    (curybegbal + curyptdbal00 + curyptdbal01 + curyptdbal02 + curyptdbal03  + curyptdbal04 + curyptdbal05 + curyptdbal06 + curyPtdBal07 + curyptdbal08 + curyptdbal09 + curyptdbal10 + curyptdbal11) * Multiplier  CuryYtdBal11, 
	    (curybegbal + curyptdbal00 + curyptdbal01 + curyptdbal02 + curyptdbal03  + curyptdbal04 + curyptdbal05 + curyptdbal06 + curyPtdBal07 + curyptdbal08 + curyptdbal09 + curyptdbal10 + curyptdbal11 + curyptdbal12) * Multiplier CuryYtdBal12,
		CAST(FiscYr AS smallint) AS fiscal_year,
		LedgerID, 
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
		(begbal + ptdbal00) * Multiplier YtdBal00, 
		(begbal + ptdbal00 + ptdbal01) * Multiplier YtdBal01, 
	    (begbal + ptdbal00 + ptdbal01 + ptdbal02) * Multiplier YtdBal02, 
	    (begbal + ptdbal00 + ptdbal01 + ptdbal02 + ptdbal03) * Multiplier YtdBal03, 
	    (begbal + ptdbal00 + ptdbal01 + ptdbal02 + ptdbal03  + ptdBal04) * Multiplier YtdBal04, 
	    (begbal + ptdbal00 + ptdbal01 + ptdbal02 + ptdbal03  + ptdbal04 + ptdbal05) * Multiplier YtdBal05, 
	    (begbal + ptdbal00 + ptdbal01 + ptdbal02 + ptdbal03  + ptdbal04 + ptdbal05 + ptdbal06) * Multiplier YtdBal06, 
	    (begbal + ptdbal00 + ptdbal01 + ptdbal02 + ptdbal03  + ptdbal04 + ptdbal05 + ptdbal06 + ptdbal07) * Multiplier YtdBal07, 
	    (begbal + ptdbal00 + ptdbal01 + ptdbal02 + ptdbal03  + ptdbal04 + ptdbal05 + ptdbal06 + PtdBal07 + ptdbal08) * Multiplier YtdBal08, 
	    (begbal + ptdbal00 + ptdbal01 + ptdbal02 + ptdbal03  + ptdbal04 + ptdbal05 + ptdbal06 + PtdBal07 + ptdbal08 + ptdbal09) * Multiplier YtdBal09, 
	    (begbal + ptdbal00 + ptdbal01 + ptdbal02 + ptdbal03  + ptdbal04 + ptdbal05 + ptdbal06 + PtdBal07 + ptdbal08 + ptdbal09 + ptdbal10) * Multiplier YtdBal10, 
	    (begbal + ptdbal00 + ptdbal01 + ptdbal02 + ptdbal03  + ptdbal04 + ptdbal05 + ptdbal06 + PtdBal07 + ptdbal08 + ptdbal09 + ptdbal10 + ptdbal11) * Multiplier YtdBal11, 
	    (begbal + ptdbal00 + ptdbal01 + ptdbal02 + ptdbal03  + ptdbal04 + ptdbal05 + ptdbal06 + PtdBal07 + ptdbal08 + ptdbal09 + ptdbal10 + ptdbal11 + ptdbal12) * Multiplier YtdBal12, 
     ( select 
     sum(dramt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.perpost = CuryAcct.fiscyr + '01' ) as PtdDRAMT01,
     ( select 
     sum(dramt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.perpost = CuryAcct.fiscyr + '02' ) as PtdDRAMT02,
     ( select 
     sum(dramt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.perpost = CuryAcct.fiscyr + '03' ) as PtdDRAMT03,
     ( select 
     sum(dramt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.perpost = CuryAcct.fiscyr + '04' ) as PtdDRAMT04,
     ( select 
     sum(dramt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.perpost = CuryAcct.fiscyr + '05' ) as PtdDRAMT05,
     ( select 
     sum(dramt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.perpost = CuryAcct.fiscyr + '06' ) as PtdDRAMT06,
     ( select 
     sum(dramt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.perpost = CuryAcct.fiscyr + '07' ) as PtdDRAMT07,
     ( select 
     sum(dramt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.perpost = CuryAcct.fiscyr + '08' ) as PtdDRAMT08,
     ( select 
     sum(dramt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.perpost = CuryAcct.fiscyr + '09' ) as PtdDRAMT09,
     ( select 
     sum(dramt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.perpost = CuryAcct.fiscyr + '10' ) as PtdDRAMT10,
     ( select 
     sum(dramt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.perpost = CuryAcct.fiscyr + '11' ) as PtdDRAMT11,
     ( select 
     sum(dramt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.perpost = CuryAcct.fiscyr + '12' ) as PtdDRAMT12,
     ( select 
     sum(cramt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.perpost = CuryAcct.fiscyr + '01' ) as PtdCRAMT01,
     ( select 
     sum(cramt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.perpost = CuryAcct.fiscyr + '02' ) as PtdCRAMT02,
     ( select 
     sum(cramt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.perpost = CuryAcct.fiscyr + '03' ) as PtdCRAMT03,
     ( select 
     sum(cramt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.perpost = CuryAcct.fiscyr + '04' ) as PtdCRAMT04,
     ( select 
     sum(cramt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.perpost = CuryAcct.fiscyr + '05' ) as PtdCRAMT05,
     ( select 
     sum(cramt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.perpost = CuryAcct.fiscyr + '06' ) as PtdCRAMT06,
     ( select 
     sum(cramt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.perpost = CuryAcct.fiscyr + '07' ) as PtdCRAMT07,
     ( select 
     sum(cramt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.perpost = CuryAcct.fiscyr + '08' ) as PtdCRAMT08,
     ( select 
     sum(cramt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.perpost = CuryAcct.fiscyr + '09' ) as PtdCRAMT09,
     ( select 
     sum(cramt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.perpost = CuryAcct.fiscyr + '10' ) as PtdCRAMT10,
     ( select 
     sum(cramt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.perpost = CuryAcct.fiscyr + '11' ) as PtdCRAMT11,
     ( select 
     sum(cramt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.perpost = CuryAcct.fiscyr + '12' ) as PtdCRAMT12,



	 ( select 
     sum(curydramt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.perpost = CuryAcct.fiscyr + '01' ) as curyPtdDRAMT01,
     ( select 
     sum(curydramt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.perpost = CuryAcct.fiscyr + '02' ) as curyPtdDRAMT02,
     ( select 
     sum(curydramt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.perpost = CuryAcct.fiscyr + '03' ) as curyPtdDRAMT03,
     ( select 
     sum(curydramt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.perpost = CuryAcct.fiscyr + '04' ) as curyPtdDRAMT04,
     ( select 
     sum(curydramt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.perpost = CuryAcct.fiscyr + '05' ) as curyPtdDRAMT05,
     ( select 
     sum(curydramt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.perpost = CuryAcct.fiscyr + '06' ) as curyPtdDRAMT06,
     ( select 
     sum(curydramt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.perpost = CuryAcct.fiscyr + '07' ) as curyPtdDRAMT07,
     ( select 
     sum(curydramt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.perpost = CuryAcct.fiscyr + '08' ) as curyPtdDRAMT08,
     ( select 
     sum(curydramt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.perpost = CuryAcct.fiscyr + '09' ) as curyPtdDRAMT09,
     ( select 
     sum(curydramt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.perpost = CuryAcct.fiscyr + '10' ) as curyPtdDRAMT10,
     ( select 
     sum(curydramt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.perpost = CuryAcct.fiscyr + '11' ) as curyPtdDRAMT11,
     ( select 
     sum(curydramt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.perpost = CuryAcct.fiscyr + '12' ) as curyPtdDRAMT12,
     ( select 
     sum(curycramt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.perpost = CuryAcct.fiscyr + '01' ) as curyPtdCRAMT01,
     ( select 
     sum(curycramt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.perpost = CuryAcct.fiscyr + '02' ) as curyPtdCRAMT02,
     ( select 
     sum(curycramt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.perpost = CuryAcct.fiscyr + '03' ) as curyPtdCRAMT03,
     ( select 
     sum(curycramt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.perpost = CuryAcct.fiscyr + '04' ) as curyPtdCRAMT04,
     ( select 
     sum(curycramt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.perpost = CuryAcct.fiscyr + '05' ) as curyPtdCRAMT05,
     ( select 
     sum(curycramt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.perpost = CuryAcct.fiscyr + '06' ) as curyPtdCRAMT06,
     ( select 
     sum(curycramt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.perpost = CuryAcct.fiscyr + '07' ) as curyPtdCRAMT07,
     ( select 
     sum(curycramt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.perpost = CuryAcct.fiscyr + '08' ) as curyPtdCRAMT08,
     ( select 
     sum(curycramt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.perpost = CuryAcct.fiscyr + '09' ) as curyPtdCRAMT09,
     ( select 
     sum(curycramt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.perpost = CuryAcct.fiscyr + '10' ) as curyPtdCRAMT10,
     ( select 
     sum(curycramt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.perpost = CuryAcct.fiscyr + '11' ) as curyPtdCRAMT11,
     ( select 
     sum(curycramt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.perpost = CuryAcct.fiscyr + '12' ) as curyPtdCRAMT12,

     ( select 
     sum(curycramt) from GLTran where GLTran.CpnyID  = curyAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.fiscyr = CuryAcct.fiscyr AND SUBSTRING( GLTran.perpost,5,2) = '01' ) as CuryYtdCRAMT01,
     ( select 
     sum(curycramt) from GLTran where GLTran.CpnyID  = curyAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.fiscyr = CuryAcct.fiscyr AND SUBSTRING( GLTran.perpost,5,2) <= '02' ) as CuryYtdCRAMT02,
     ( select 
     sum(curycramt) from GLTran where GLTran.CpnyID  = curyAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.fiscyr = CuryAcct.fiscyr AND SUBSTRING( GLTran.perpost,5,2) <= '03' ) as CuryYtdCRAMT03,
     ( select 
     sum(curycramt) from GLTran where GLTran.CpnyID  = curyAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.fiscyr = CuryAcct.fiscyr AND SUBSTRING( GLTran.perpost,5,2) <= '04' ) as CuryYtdCRAMT04,
     ( select 
     sum(curycramt) from GLTran where GLTran.CpnyID  = curyAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.fiscyr = CuryAcct.fiscyr AND SUBSTRING( GLTran.perpost,5,2) <= '05' ) as CuryYtdCRAMT05,
     ( select 
     sum(curycramt) from GLTran where GLTran.CpnyID  = curyAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.fiscyr = CuryAcct.fiscyr AND SUBSTRING( GLTran.perpost,5,2) <= '06' ) as CuryYtdCRAMT06,
     ( select 
     sum(curycramt) from GLTran where GLTran.CpnyID  = curyAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.fiscyr = CuryAcct.fiscyr AND SUBSTRING( GLTran.perpost,5,2) <= '07' ) as CuryYtdCRAMT07,
     ( select 
     sum(curycramt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.fiscyr = CuryAcct.fiscyr AND SUBSTRING( GLTran.perpost,5,2) <= '08' ) as CuryYtdCRAMT08,
     ( select 
     sum(curycramt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.fiscyr = CuryAcct.fiscyr AND SUBSTRING( GLTran.perpost,5,2) <= '09' ) as CuryYtdCRAMT09,
     ( select 
     sum(curycramt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.fiscyr = CuryAcct.fiscyr AND SUBSTRING( GLTran.perpost,5,2) <= '10' ) as CuryYtdCRAMT10,
     ( select 
     sum(curycramt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.fiscyr = CuryAcct.fiscyr AND SUBSTRING( GLTran.perpost,5,2) <= '11' ) as CuryYtdCRAMT11,
     ( select 
     sum(curycramt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.fiscyr = CuryAcct.fiscyr AND SUBSTRING( GLTran.perpost,5,2) <= '12' ) as CuryYtdCRAMT12,
     
     ( select 
     sum(curyDRamt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.fiscyr = CuryAcct.fiscyr AND SUBSTRING( GLTran.perpost,5,2) <= '01' ) as CuryYtdDRAMT01,
     ( select 
     sum(curyDRamt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.fiscyr = CuryAcct.fiscyr AND SUBSTRING( GLTran.perpost,5,2) <= '02' ) as CuryYtdDRAMT02,
     ( select 
     sum(curyDRamt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.fiscyr = CuryAcct.fiscyr AND SUBSTRING( GLTran.perpost,5,2) <= '03' ) as CuryYtdDRAMT03,
     ( select 
     sum(curyDRamt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.fiscyr = CuryAcct.fiscyr AND SUBSTRING( GLTran.perpost,5,2) <= '04' ) as CuryYtdDRAMT04,
     ( select 
     sum(curyDRamt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.fiscyr = CuryAcct.fiscyr AND SUBSTRING( GLTran.perpost,5,2) <= '05' ) as CuryYtdDRAMT05,
     ( select 
     sum(curyDRamt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.fiscyr = CuryAcct.fiscyr AND SUBSTRING( GLTran.perpost,5,2) <= '06' ) as CuryYtdDRAMT06,
     ( select 
     sum(curyDRamt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.fiscyr = CuryAcct.fiscyr AND SUBSTRING( GLTran.perpost,5,2) <= '07' ) as CuryYtdDRAMT07,
     ( select 
     sum(curyDRamt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.fiscyr = CuryAcct.fiscyr AND SUBSTRING( GLTran.perpost,5,2) <= '08' ) as CuryYtdDRAMT08,
     ( select 
     sum(curyDRamt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.fiscyr = CuryAcct.fiscyr AND SUBSTRING( GLTran.perpost,5,2) <= '09' ) as CuryYtdDRAMT09,
     ( select 
     sum(curyDRamt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.fiscyr = CuryAcct.fiscyr AND SUBSTRING( GLTran.perpost,5,2) <= '10' ) as CuryYtdDRAMT10,
     ( select 
     sum(curyDRamt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.fiscyr = CuryAcct.fiscyr AND SUBSTRING( GLTran.perpost,5,2) <= '11' ) as CuryYtdDRAMT11,
     ( select 
     sum(curyDRamt) from GLTran where GLTran.CpnyID  = CuryAcct.CpnyID AND GLTran.acct = CuryAcct.acct and GLTran.Sub = CuryAcct.Sub AND 
     GLTran.LedgerID  = CuryAcct.LedgerID AND posted = 'P' AND GLTran.fiscyr = CuryAcct.fiscyr AND SUBSTRING( GLTran.perpost,5,2) <= '12' ) as CuryYtdDRAMT12

	From CuryAcct 
	LEFT OUTER JOIN (SELECT CASE WHEN CHARINDEX(SUBSTRING(AcctType, 2, 1),'AE') > 0 THEN 1 ELSE -1 END AS Multiplier, * FROM Account) Account on Account.Acct = dbo.CuryAcct.Acct
	LEFT OUTER JOIN SubAcct on subacct.sub = CuryAcct.Sub
	LEFT OUTER JOIN vw_acctsub on (vw_acctsub.Acct = CuryAcct.Acct AND vw_acctsub.Sub = CuryAcct.Sub AND vw_acctsub.CpnyID = CuryAcct.CpnyID)

