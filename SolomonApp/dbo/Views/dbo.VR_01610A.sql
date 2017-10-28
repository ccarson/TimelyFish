 

CREATE VIEW VR_01610A AS
   SELECT          
      -- Account
      Account_AcctType        = a.AcctType,
      Account_Acct_Cat        = a.Acct_Cat,         
      Account_Active          = a.Active,
      Account_ClassID         = a.ClassID,
      Account_ConsolAcct      = a.ConsolAcct,
      Account_CuryID          = a.CuryID,	
      Account_Descr           = a.Descr,
      Account_RatioGrp        = a.RatioGrp,
      Account_User1           = a.User1,
      Account_User2           = a.User2,
      Account_User3           = a.User3,
      Account_User4           = a.User4,
      Account_User5           = a.User5,
      Account_User6           = a.User6,
      Account_User7           = a.User7,
      Account_User8           = a.User8,
      -- AcctHist Fields
      AcctHist_Acct,           
      AcctHist_BalanceType,    
      AcctHist_BegBal,         
      AcctHist_CpnyID,      
      -- Due to performance in the Stored procedure, FiscYr and AcctHist_FiscYr need 
      -- to be retrieved from this view.   
      AcctHist_Fiscyr,         
      AcctHist_LedgerID,       
      AcctHist_Sub,   
      AcctHist_User1, 
      AcctHist_User2, 
      AcctHist_User3, 
      AcctHist_User4, 
      AcctHist_User5, 
      AcctHist_User6, 
      AcctHist_User7, 
      AcctHist_User8, 
      --GL Setup  
      GLSetup_RetEarnAcct,
      GLSetup_YtdNetIncAcct,
      GLSetUp_COAOrder,
      -- RPTCompany Fields
      Rpt_Company_CpnyName,
      Rpt_Company_RI_ID,  
      --View Specific Fields
      AcctType_Order          = SUBSTRING(a.AcctType, 1, 1),     
      -- Due to performance in the Stored procedure, FiscYr and AcctHist_FiscYr need 
      -- to be retrieved from this view.
      Fiscyr                  = v.AcctHist_Fiscyr,
      Period_Post             = Rpt_RunTime_BegPernbr,
      Starting_Balance        = v.StartingBalance, 	 
      Ending_Balance          = v.EndingBalance, 
      AcctType_Desc           = CASE v.GLSetUp_COAOrder 
                                   WHEN  'A' THEN
                                      CASE SUBSTRING(a.AcctType, 1, 1)        
                                         WHEN '1' THEN  '1 - Assets'
                                         WHEN '2' THEN  '2 - Liabilities'
                                         ELSE           '3 - Income & Expense'
                                      END
                                   WHEN  'B' THEN
                                      CASE SUBSTRING(a.AcctType, 1, 1) 
                                         WHEN '1' THEN  '1 - Assets'
                                         WHEN '2' THEN  '2 - Liabilities'
                                         WHEN '3' THEN  '3 - Income'
                                         ELSE           '4 - Expense'
                                      END
                                   WHEN  'C' THEN
                                      CASE SUBSTRING(a.AcctType, 1, 1) 
                                         WHEN '1' THEN  '1 - Income'
                                         WHEN '2' THEN  '2 - Expense'
                                         WHEN '3' THEN  '3 - Assets'
                                         ELSE           '4 - Liabilities'
                                      END
                                   WHEN  'D' THEN
                                      CASE SUBSTRING(a.AcctType, 1, 1) 
                                         WHEN '1' THEN  '1 - Income & Expense'
                                         WHEN '2' THEN  '2 - Assets'
                                         ELSE           '3 - Liabilities'
                                      END
                                END,   
      DrAmtTot                = CASE WHEN (SUBSTRING(a.AcctType,2,1) = 'A' ) THEN
                                          (v.PeriodActivityPos)
                                     WHEN (SUBSTRING(a.AcctType,2,1) = 'L')  THEN
                                 (v.PeriodActivityNeg * -1)
                                     WHEN (SUBSTRING(a.AcctType,2,1) = 'I')  THEN
                                          (v.PeriodActivityNeg * -1)
                                     WHEN (SUBSTRING(a.AcctType,2,1) = 'E')  THEN
                                          (v.PeriodActivityPos)
                                     ELSE 0.00                                                                                                      
                                     
                                END, 
      CrAmtTot                = CASE WHEN (SUBSTRING(a.AcctType,2,1) = 'A')  THEN
                                          (v.PeriodActivityNeg * -1)
                                     WHEN (SUBSTRING(a.AcctType,2,1) = 'L')  THEN
                                          (v.PeriodActivityPos)
                                     WHEN (SUBSTRING(a.AcctType,2,1) = 'I')  THEN
                                          (v.PeriodActivityPos)
                                     WHEN (SUBSTRING(a.AcctType,2,1) = 'E')  THEN
                                          (v.PeriodActivityNeg * -1)
                                     ELSE 0.00                                                                                                           
                                END 
   FROM  vr_01610AB_AcctHist v INNER JOIN Account a    ON v.AcctHist_Acct = a.acct   
   WHERE  
     (v.AcctHist_Acct         = v.GLSetup_YtdNetIncAcct) OR   -- Include YTDNet Income Accounts 
     (v.AcctHist_Acct         = v.GLSetup_RetEarnAcct)   OR   -- Include Retained Earnings Accounts 
     (v.StartingBalance       <> 0.000)                  OR   -- Include accounts with a starting balance 
                                                              -- regardless of period activity.           
     (v.EndingBalance         = 0.00)                    OR   -- Include account with a ending balance of zero
                                                              -- regardless of period activity.       
     ((v.PeriodActivityPos <> 0.00 OR v.PeriodActivityNeg <> 0.00) AND v.StartingBalance = 0.000)  OR
     ((v.PeriodActivityPos <> 0.00 OR v.PeriodActivityNeg <> 0.00) AND v.EndingBalance <> 0.00)     
                                            


 
