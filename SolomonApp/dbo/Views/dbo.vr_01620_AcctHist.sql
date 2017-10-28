 

CREATE VIEW vr_01620_AcctHist AS
   SELECT 
      --AcctHist Fields
      AcctHistAcct          = h.Acct, 
      AcctHistBalanceType   = h.BalanceType, 
      AcctHistCuryID        = h.CuryId, 
      AcctHistCpnyID        = h.CpnyID, 
      AcctHistFiscYr        = h.FiscYr,                
      AcctHistLedgerID      = h.LedgerId,                 
      AcctHistSub           = h.Sub,   
      AcctHistUser1         = h.User1,
      AcctHistUser2         = h.User2,
      AcctHistUser3         = h.User3,
      AcctHistUser4         = h.User4,
      AcctHistUser5         = h.User5, 
      AcctHistUser6         = h.User6,
      AcctHistUser7         = h.User7,
      AcctHistUser8         = h.User8,               
      --Account Fields	
      AccountAcctType       = a.AcctType,
      AccountAcctCat        = a.Acct_Cat,          
      AccountActive         = a.Active,
      AccountClassID        = a.ClassID,
      AccountConsolAcct     = a.ConsolAcct,
      AccountDescr          = a.Descr,
      AccountRatioGrp       = a.RatioGrp,
      AccountUser1          = a.User1,
      AccountUser2          = a.User2,
      AccountUser3          = a.User3,
      AccountUser4          = a.User4,
      AccountUser5          = a.User5,
      AccountUser6          = a.User6,
      AccountUser7          = a.User7,
      AccountUser8          = a.User8,       
      -- SubAcct Fields
      SubAcctActive         = u.Active,
      SubAcctConSolSub      = u.ConsolSub,
      SubAcctDescr          = u.Descr,
      SubAcctUser1          = u.User1,
      SubAcctUser2          = u.User2,
      SubAcctUser3          = u.User3,
      SubAcctUser4          = u.User4,
      SubAcctUser5          = u.User5,
      SubAcctUser6          = u.User6,
      SubAcctUser7          = u.User7,
      SubAcctUser8          = u.User8,
      --View Specific Fields
      AcctTypeOrder         = SUBSTRING(a.AcctType, 1, 1), 
      PeriodPost            = (h.FiscYr + v.Mon),
      Mon                   = v.Mon,
      StartingBalance       = CASE v.Mon
                                 WHEN '01' THEN h.BegBal 
                                 WHEN '02' THEN h.YTDBal00 
                                 WHEN '03' THEN h.YTDBal01 
                                 WHEN '04' THEN h.YTDBal02 
                                 WHEN '05' THEN h.YTDBal03 
                                 WHEN '06' THEN h.YTDBal04 
                                 WHEN '07' THEN h.YTDBal05 
                                 WHEN '08' THEN h.YTDBal06 
                                 WHEN '09' THEN h.YTDBal07 
                                 WHEN '10' THEN h.YTDBal08 
                                 WHEN '11' THEN h.YTDBal09 
                                 WHEN '12' THEN h.YTDBal10 
                                 WHEN '13' THEN h.YTDBal11 
	                      END, 
      StartingBalance1       = h.BegBal,
      PeriodActivity        = CASE v.Mon
                                 WHEN '01' THEN h.PTDBal00 
                                 WHEN '02' THEN h.PTDBal01 
                                 WHEN '03' THEN h.PTDBal02 
                                 WHEN '04' THEN h.PTDBal03 
                                 WHEN '05' THEN h.PTDBal04 
                                 WHEN '06' THEN h.PTDBal05 
                                 WHEN '07' THEN h.PTDBal06 
                                 WHEN '08' THEN h.PTDBal07
                                 WHEN '09' THEN h.PTDBal08 
                                 WHEN '10' THEN h.PTDBal09 
                                 WHEN '11' THEN h.PTDBal10 
                                 WHEN '12' THEN h.PTDBal11 
                                 WHEN '13' THEN h.PTDBal12 
	                      END,      
      EndingBalance         = CASE v.Mon 
                                 WHEN '01' THEN h.YTDBal00 
                                 WHEN '02' THEN h.YTDBal01 
                   WHEN '03' THEN h.YTDBal02 
                                 WHEN '04' THEN h.YTDBal03 
                                 WHEN '05' THEN h.YTDBal04 
                                 WHEN '06' THEN h.YTDBal05 
                                 WHEN '07' THEN h.YTDBal06 
                                 WHEN '08' THEN h.YTDBal07 
                                 WHEN '09' THEN h.YTDBal08 
                                 WHEN '10' THEN h.YTDBal09 
                                 WHEN '11' THEN h.YTDBal10 
                                 WHEN '12' THEN h.YTDBal11 
                                 WHEN '13' THEN h.YTDBal12 
	                       END 
FROM AcctHist h INNER JOIN Account           a (NOLOCK)  ON h.Acct = a.Acct 
                INNER JOIN SubAcct           u (NOLOCK)  ON h.Sub  = u.Sub 
                CROSS JOIN vr_ShareMonthList v
                CROSS JOIN GLSetup           s (NOLOCK)
--Only return records for the number of periods configured in GLSetup.
WHERE (CONVERT(INT, v.Mon) <= s.NbrPer)

 
