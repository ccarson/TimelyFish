 

CREATE VIEW vr_01610AB_AcctHist AS
   SELECT 
      --AcctHist Fields        
      AcctHist_Acct         = h.Acct, 
      AcctHist_BalanceType  = h.BalanceType,
      AcctHist_BegBal       = h.BegBal,
      AcctHist_CpnyId       = h.CpnyID, 
      AcctHist_Fiscyr       = h.Fiscyr,
      AcctHist_LedgerId     = h.LedgerId,
      AcctHist_sub          = h.sub,                
      AcctHist_User1        = h.User1,
      AcctHist_User2        = h.User2,
      AcctHist_User3        = h.User3,
      AcctHist_User4        = h.User4,
      AcctHist_User5        = h.User5, 
      AcctHist_User6        = h.User6,
      AcctHist_User7        = h.User7,
      AcctHist_User8        = h.User8,
      --GL Setup  
      GLSetUp_COAOrder      = s.COAOrder,
      GLSetup_RetEarnAcct   = s.RetEarnAcct,
      GLSetup_YtdNetIncAcct = s.YtdNetIncAcct,
      -- RPTCompany Fields
      Rpt_Company_CpnyName  = c.CpnyName,
      Rpt_Company_RI_ID     = c.RI_ID,       
      --Rpt RunTime
      Rpt_RunTime_BegPernbr = r.BegPerNbr,
      --View Specific Fields
      -- Positive and Negative Activity needs to be broken out since the Combined Totals 
      -- format (vr_01610A.sql)prints out a lump sum Debit or Credit per period for multi-period reports.
      PeriodActivityNeg     = CASE WHEN '01' Between SUBSTRING(r.BegPerNbr,5,2) AND SUBSTRING(r.EndPerNbr,5,2)   
                                                 AND '01' <= s.NbrPer AND PTDBAL00 < 0                         THEN
                                         h.PTDBAL00 ELSE 0 END +
                              CASE WHEN '02' Between SUBSTRING(r.BegPerNbr,5,2) AND SUBSTRING(r.EndPerNbr,5,2) 
                                                 AND '02' <= s.NbrPer AND PTDBAL01 < 0                         THEN
                                         h.PTDBAL01 ELSE 0 END +
                              CASE WHEN '03' Between SUBSTRING(r.BegPerNbr,5,2) AND SUBSTRING(r.EndPerNbr,5,2) 
                                                 AND '03' <= s.NbrPer AND PTDBAL02 < 0                         THEN
                                         h.PTDBAL02 ELSE 0 END +
                              CASE WHEN '04' Between SUBSTRING(r.BegPerNbr,5,2) AND SUBSTRING(r.EndPerNbr,5,2) 
                                                 AND '04' <= s.NbrPer AND PTDBAL03 < 0                         THEN
                                         h.PTDBAL03 ELSE 0 END +
                              CASE WHEN '05' Between SUBSTRING(r.BegPerNbr,5,2) AND SUBSTRING(r.EndPerNbr,5,2) 
                                                 AND '05' <= s.NbrPer AND PTDBAL04 < 0                         THEN
                                         h.PTDBAL04 ELSE 0 END +
                              CASE WHEN '06' Between SUBSTRING(r.BegPerNbr,5,2) AND SUBSTRING(r.EndPerNbr,5,2) 
                                                 AND '06' <= s.NbrPer AND PTDBAL05 < 0                         THEN
                                         h.PTDBAL05 ELSE 0 END +
                              CASE WHEN '07' Between SUBSTRING(r.BegPerNbr,5,2) AND SUBSTRING(r.EndPerNbr,5,2) 
                                                 AND '07' <= s.NbrPer AND PTDBAL06 < 0                         THEN
                                         h.PTDBAL06 ELSE 0 END +
                              CASE WHEN '08' Between SUBSTRING(r.BegPerNbr,5,2) AND SUBSTRING(r.EndPerNbr,5,2) 
                                                 AND '08' <= s.NbrPer AND PTDBAL07 < 0                         THEN
                                         h.PTDBAL07 ELSE 0 END +
                              CASE WHEN '09' Between SUBSTRING(r.BegPerNbr,5,2) AND SUBSTRING(r.EndPerNbr,5,2) 
                                                 AND '09' <= s.NbrPer AND PTDBAL08 < 0                         THEN
                                         h.PTDBAL08 ELSE 0 END +
                              CASE WHEN '10' Between SUBSTRING(r.BegPerNbr,5,2) AND SUBSTRING(r.EndPerNbr,5,2) 
                                                 AND '10' <= s.NbrPer AND PTDBAL09 < 0                         THEN
                                         h.PTDBAL09 ELSE 0 END +
                              CASE WHEN '11' Between SUBSTRING(r.BegPerNbr,5,2) AND SUBSTRING(r.EndPerNbr,5,2) 
                                                 AND '11' <= s.NbrPer AND PTDBAL10 < 0                         THEN
                                         h.PTDBAL10 ELSE 0 END +
                              CASE WHEN '12' Between SUBSTRING(r.BegPerNbr,5,2) AND SUBSTRING(r.EndPerNbr,5,2) 
                                                 AND '12' <= s.NbrPer AND PTDBAL11 < 0                         THEN
                                         h.PTDBAL11 ELSE 0 END +
                              CASE WHEN '13' Between SUBSTRING(r.BegPerNbr,5,2) AND SUBSTRING(r.EndPerNbr,5,2) 
                                                 AND '13' <= s.NbrPer AND PTDBAL12 < 0                         THEN
                                         h.PTDBAL12 ELSE 0 END,
      -- Positive and Negative Activity needs to be broken out since the Combined Totals 
      -- format (vr_01610A.sql)prints out a lump sum Debit or Credit per period for multi-period reports.
      PeriodActivityPos     = CASE WHEN '01' Between SUBSTRING(r.BegPerNbr,5,2) AND SUBSTRING(r.EndPerNbr,5,2) 
                                                 AND '01' <= s.NbrPer AND PTDBAL00 > 0                         THEN
                                         h.PTDBAL00 ELSE 0 END +
                              CASE WHEN '02' Between SUBSTRING(r.BegPerNbr,5,2) AND SUBSTRING(r.EndPerNbr,5,2) 
                                                 AND '02' <= s.NbrPer AND PTDBAL01 > 0                         THEN
                                         h.PTDBAL01 ELSE 0 END +
                              CASE WHEN '03' Between SUBSTRING(r.BegPerNbr,5,2) AND SUBSTRING(r.EndPerNbr,5,2)  
                                                 AND '03' <= s.NbrPer AND PTDBAL02 > 0                         THEN
                                         h.PTDBAL02 ELSE 0 END +
                              CASE WHEN '04' Between SUBSTRING(r.BegPerNbr,5,2) AND SUBSTRING(r.EndPerNbr,5,2) 
                                                 AND '04' <= s.NbrPer AND PTDBAL03 > 0                         THEN
                                         h.PTDBAL03 ELSE 0 END +
                              CASE WHEN '05' Between SUBSTRING(r.BegPerNbr,5,2) AND SUBSTRING(r.EndPerNbr,5,2) 
                                                 AND '05' <= s.NbrPer AND PTDBAL04 > 0                         THEN
                                         h.PTDBAL04 ELSE 0 END +
                              CASE WHEN '06' Between SUBSTRING(r.BegPerNbr,5,2) AND SUBSTRING(r.EndPerNbr,5,2) 
                                                 AND '06' <= s.NbrPer AND PTDBAL05 > 0                         THEN
                                         h.PTDBAL05 ELSE 0 END +
                              CASE WHEN '07' Between SUBSTRING(r.BegPerNbr,5,2) AND SUBSTRING(r.EndPerNbr,5,2) 
                                                 AND '07' <= s.NbrPer AND PTDBAL06 > 0                         THEN
                                         h.PTDBAL06 ELSE 0 END +
                              CASE WHEN '08' Between SUBSTRING(r.BegPerNbr,5,2) AND SUBSTRING(r.EndPerNbr,5,2) 
                                                 AND '08' <= s.NbrPer AND PTDBAL07 > 0                         THEN
                                         h.PTDBAL07 ELSE 0 END +
                              CASE WHEN '09' Between SUBSTRING(r.BegPerNbr,5,2) AND SUBSTRING(r.EndPerNbr,5,2) 
                                                 AND '09' <= s.NbrPer AND PTDBAL08 > 0                         THEN
                                         h.PTDBAL08 ELSE 0 END +
                     CASE WHEN '10' Between SUBSTRING(r.BegPerNbr,5,2) AND SUBSTRING(r.EndPerNbr,5,2)  
                                                 AND '10' <= s.NbrPer AND PTDBAL09 > 0                         THEN
                                         h.PTDBAL09 ELSE 0 END +
                              CASE WHEN '11' Between SUBSTRING(r.BegPerNbr,5,2) AND SUBSTRING(r.EndPerNbr,5,2)  
                                                 AND '11' <= s.NbrPer AND PTDBAL10 > 0                         THEN
                                         h.PTDBAL10 ELSE 0 END +
                              CASE WHEN '12' Between SUBSTRING(r.BegPerNbr,5,2) AND SUBSTRING(r.EndPerNbr,5,2)  
                                                 AND '12' <= s.NbrPer AND PTDBAL11 > 0                         THEN
                                         h.PTDBAL11 ELSE 0 END +
                              CASE WHEN '13' Between SUBSTRING(r.BegPerNbr,5,2) AND SUBSTRING(r.EndPerNbr,5,2)  
                                                 AND '13' <= s.NbrPer AND PTDBAL12 > 0                         THEN
                                        h.PTDBAL12 
                                   ELSE 0
                              END,
      StartingBalance       = CASE SUBSTRING(r.BegPerNbr,5,2)  
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
                                   ELSE 0
	                      END,   
      EndingBalance         = CASE SUBSTRING(r.EndPerNbr,5,2) 
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
                                   ELSE 0
	                      END                                 
   FROM RptRuntime r (NOLOCK) INNER JOIN RptCompany   c  (NOLOCK) 
                                         ON r.RI_ID                    = c.RI_ID
                              INNER JOIN AcctHist     h 
                                         ON c.CpnyId                   = h.Cpnyid  AND
                                            SUBSTRING(r.BegPerNbr,1,4) = h.FiscYr
                              CROSS JOIN GLSetup      s (NOLOCK)



 
