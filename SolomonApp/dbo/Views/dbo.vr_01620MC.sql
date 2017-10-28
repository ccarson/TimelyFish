 

CREATE VIEW vr_01620MC AS
   SELECT          
      -- Account
      Account_AcctType        = v.AccountAcctType,
      Account_Acct_Cat        = v.AccountAcctCat,         
      Account_Active          = v.AccountActive,
      Account_ClassID         = v.AccountClassID,
      Account_ConsolAcct      = v.AccountConsolAcct,
      Account_CuryID          = v.AccountCuryID,
      Account_Descr           = v.AccountDescr,
      Account_RatioGrp        = v.AccountRatioGrp,
      Account_User1           = v.AccountUser1,
      Account_User2           = v.AccountUser2,
      Account_User3           = v.AccountUser3,
      Account_User4           = v.AccountUser4,
      Account_User5           = v.AccountUser5,
      Account_User6           = v.AccountUser6,
      Account_User7           = v.AccountUser7,
      Account_User8           = v.AccountUser8,
      -- CuryAcct Fields
      CuryAcct_Acct           = v.CuryAcctAcct, 
      CuryAcct_BalanceType    = v.CuryAcctBalanceType,
      CuryAcct_BaseCuryID     = v.CuryAcctBaseCuryID,
      CuryAcct_CpnyID         = v.CuryAcctCpnyID, 
      CuryAcct_CuryID         = v.CuryAcctCuryID,
      CuryAcct_Fiscyr         = v.CuryAcctFiscyr,
      CuryAcct_LedgerID       = v.CuryAcctLedgerID, 
      CuryAcct_Sub            = v.CuryAcctSub,           
      CuryAcct_User1          = v.CuryAcctUser1,
      CuryAcct_User2          = v.CuryAcctUser2,
      CuryAcct_User3          = v.CuryAcctUser3,
      CuryAcct_User4          = v.CuryAcctUser4,
      CuryAcct_User5          = v.CuryAcctUser5, 
      CuryAcct_User6          = v.CuryAcctUser6,
      CuryAcct_User7          = v.CuryAcctUser7,
      CuryAcct_User8          = v.CuryAcctUser8,
      -- GLTran Fields
      GLTran_BaseCuryId       = t.BaseCuryId,
      GLTran_Batnbr           = t.Batnbr,
      GLTran_CrAmt            = t.CrAmt,
      GLTran_Crtd_DateTime    = t.Crtd_DateTime,
      GLTran_Crtd_Prog        = t.Crtd_Prog,
      GLTran_Crtd_User        = t.Crtd_User,
      GLTran_CuryCrAmt        = t.CuryCrAmt,
      GLTran_CuryDrAmt        = t.CuryDrAmt,
      GLTran_CuryID           = t.CuryID,
      GLTran_DrAmt            = t.DrAmt,    
      GLTran_EmployeeID       = t.EmployeeID,
      GLTran_ExtRefNbr        = t.ExtRefNbr,   
      GLTran_IC_Distribution  = t.IC_Distribution,  
      GLTran_JrnlType         = t.JrnlType,
      GLTran_Labor_Class_Cd   = t.Labor_Class_CD,
      GLTran_LineNbr          = t.LineNbr,
      GLTran_LineRef          = t.LineRef,
      GLTran_LUpd_DateTime    = t.LUpd_DateTime,
      GLTran_LUpd_Prog        = t.LUpd_Prog,
      GLTran_LUpd_User        = t.Lupd_User,
      GLTran_Module           = t.Module,
      GLTran_OrigAcct         = t.OrigAcct,
      GLTran_OrigBatNbr       = t.OrigBatNbr,
      GLTran_OrigCpnyID       = t.OrigCpnyID,
      GLTran_OrigSub          = t.OrigSub,
      GLTran_PC_Flag          = t.PC_Flag,
      GLTran_PC_Status        = t.PC_Status,
      GLTran_PerEnt           = t.PerEnt,
      GLTran_Posted           = t.Posted,
      GLTran_ProjectID        = t.ProjectID,
      GLTran_Qty              = t.Qty,
      GLTran_Refnbr           = t.RefNbr,
      GLTran_TaskID           = t.TaskID,
      GLTran_TranDate         = t.TranDate,
      GLTran_TranDesc         = t.TranDesc,
      GLTran_TranType         = t.TranType,	
      GLTran_Units            = t.Units,
      GLTran_User1            = t.User1,
      GLTran_User2            = t.User2,
      GLTran_User3            = t.User3,
      GLTran_User4            = t.User4,
      GLTran_User5            = t.User5, 
      GLTran_User6            = t.User6,
      GLTran_User7            = t.User7,
      GLTran_User8            = t.User8, 
      --GL Setup  
      GLSetup_RetEarnAcct     = s.RetEarnAcct,
      GLSetup_YtdNetIncAcct   = s.YtdNetIncAcct,
      GLSetUp_COAOrder        = s.COAOrder,
      -- RPTCompany Fields
      Rpt_Company_CpnyName    = c.CpnyName,
      Rpt_Company_RI_ID       = c.RI_ID,
      -- SubAcct Fields
      SubAcct_Active          = v.SubAcctActive,
      SubAcct_ConSolSub       = v.SubAcctConsolSub,
      SubAcct_Descr           = v.SubAcctDescr,
      SubAcct_User1           = v.SubAcctUser1,
      SubAcct_User2           = v.SubAcctUser2,
      SubAcct_User3           = v.SubAcctUser3,
      SubAcct_User4           = v.SubAcctUser4,
      SubAcct_User5           = v.SubAcctUser5,
      SubAcct_User6           = v.SubAcctUser6,
      SubAcct_User7           = v.SubAcctUser7,
      SubAcct_User8           = v.SubAcctUser8,
      --View Specific Fields
      AcctType_Order          = v.AcctTypeOrder,
      AcctType_Desc           = 
        CASE s.COAOrder 
             WHEN  'A' THEN
                       CASE v.AcctTypeOrder 
                          WHEN '1' THEN  '1 - Assets'
                          WHEN '2' THEN  '2 - Liabilities'
                          ELSE           '3 - Income & Expense'
                       END
             WHEN  'B' THEN
                       CASE v.AcctTypeOrder 
                          WHEN '1' THEN  '1 - Assets'
                          WHEN '2' THEN  '2 - Liabilities'
                          WHEN '3' THEN  '3 - Income'
                          ELSE           '4 - Expense'
                       END
             WHEN  'C' THEN
                       CASE v.AcctTypeOrder 
                          WHEN '1' THEN  '1 - Income'
                          WHEN '2' THEN  '2 - Expense'
                          WHEN '3' THEN  '3 - Assets'
                          ELSE           '4 - Liabilities'
                       END
             WHEN  'D' THEN
                       CASE v.AcctTypeOrder 
                          WHEN '1' THEN  '1 - Income & Expense'
                          WHEN '2' THEN  '2 - Assets'
                          ELSE           '3 - Liabilities'
                       END
        END,
      Fiscyr                  = v.CuryAcctFiscyr,
      Month                   = v.Mon,
      Cury_Starting_Balance   = v.CuryStartingBalance,
      Starting_Balance        = v.StartingBalance,
      Starting_Balance1       = v.StartingBalance1, 	
      CuryStarting_Balance1   = v.CuryStartingBalance1, 	
      Cury_Period_Activity    = v.CuryPeriodActivity, 
      Period_Activity         = v.PeriodActivity, 
      Period_Post             = v.PeriodPost,
      Cury_Ending_Balance     = v.CuryEndingBalance, 
      Ending_Balance          = v.EndingBalance, 
      Trans_Flag              = 'G',
      r.BegPerNbr, r.EndPerNbr 
   FROM  vr_01620MC_CuryAcct v 
                    INNER JOIN RptCompany   c (NOLOCK)        ON v.CuryAcctCpnyID      = c.CpnyID                             
                    INNER JOIN RptRuntime   r (NOLOCK)        ON r.RI_ID               = c.RI_ID       AND
                                                                 v.CuryAcctFiscyr      BETWEEN
                                                                 LEFT(r.BegPerNbr,4)   AND LEFT(r.EndPerNbr,4)
                    INNER LOOP JOIN GLTran  t With (INDEX(GLTRAN6)) ON v.CuryAcctAcct        = t.Acct        AND
                                                                 v.CuryAcctSub         = t.Sub         AND 
                                                                 v.CuryAcctLedgerID    = t.LedgerID    AND
                                                                 v.CuryAcctFiscyr      = t.FiscYr      AND
                                                                 v.PeriodPost          = t.PerPost     AND 
                                                                 v.CuryAcctCuryID      = t.CuryID      AND
                                                                 v.CuryAcctCpnyID      = t.CpnyID                                                                       
                    CROSS JOIN GLSetUp      s (NOLOCK)  
   WHERE (t.Posted = 'P' AND t.Acct  <> s.YtdNetIncAcct)     --  Posted Batch information only.  Since GL does not
                                                             --  allow direct postings to the YTDNetIncome Account 
                                                             --  (4.21 SP2 and beyond)these will be excluded from the 
                                                             --  the first part of the UNION. YTDNetIncome accounts will be 
                                                             --  placed on the GL Detail Report as summarized accounts.        
   -- *****************************************************************************************************************
   -- This UNION ALL sets the Tran_Flag equal to 'A' and includes CuryAcct activity for YTD Net Income
   -- Accounts, Initalized Accounts and Accounts where the Batch Period to Post is not equal to GLTran Period to Post.
   -- *****************************************************************************************************************
   UNION ALL


   SELECT          
      -- Account
      Account_AcctType        = v.AccountAcctType,
      Account_Acct_Cat        = v.AccountAcctCat,         
      Account_Active          = v.AccountActive,
      Account_ClassID         = v.AccountClassID,
      Account_ConsolAcct      = v.AccountConsolAcct,
      Account_CuryID          = v.AccountCuryID,
      Account_Descr           = v.AccountDescr,
      Account_RatioGrp        = v.AccountRatioGrp,
      Account_User1           = v.AccountUser1,
      Account_User2           = v.AccountUser2,
      Account_User3           = v.AccountUser3,
      Account_User4           = v.AccountUser4,
      Account_User5           = v.AccountUser5,
      Account_User6           = v.AccountUser6,
      Account_User7           = v.AccountUser7,
      Account_User8           = v.AccountUser8,
      -- CuryAcct Fields
      CuryAcct_Acct           = v.CuryAcctAcct, 
      CuryAcct_BalanceType    = v.CuryAcctBalanceType,
      CuryAcct_BaseCuryID     = v.CuryAcctBaseCuryID,
      CuryAcct_CpnyID         = v.CuryAcctCpnyID, 
      CuryAcct_CuryID         = v.CuryAcctCuryID,
      CuryAcct_Fiscyr         = v.CuryAcctFiscyr,
      CuryAcct_LedgerID       = v.CuryAcctLedgerID, 
      CuryAcct_Sub            = v.CuryAcctSub,           
      CuryAcct_User1          = v.CuryAcctUser1,
      CuryAcct_User2          = v.CuryAcctUser2,
      CuryAcct_User3          = v.CuryAcctUser3,
      CuryAcct_User4          = v.CuryAcctUser4,
      CuryAcct_User5          = v.CuryAcctUser5, 
      CuryAcct_User6          = v.CuryAcctUser6,
      CuryAcct_User7          = v.CuryAcctUser7,
      CuryAcct_User8          = v.CuryAcctUser8,
      -- GLTran Fields
      GLTran_BaseCuryId       = s.BaseCuryId,
      GLTran_Batnbr           = '',
      GLTran_CrAmt            = CASE WHEN (SUBSTRING(v.AccountAcctType,2,1) = 'A' AND v.PeriodActivity < 0.00) THEN
                                          (v.PeriodActivity * -1)
                                     WHEN (SUBSTRING(v.AccountAcctType,2,1) = 'L' AND v.PeriodActivity >= 0.00)THEN
                                          (v.PeriodActivity)
                                     WHEN (SUBSTRING(v.AccountAcctType,2,1) = 'I' AND v.PeriodActivity >= 0.00)THEN
                                          (v.PeriodActivity)
                                     WHEN (SUBSTRING(v.AccountAcctType,2,1) = 'E' AND v.PeriodActivity < 0.00)THEN
                                          (v.PeriodActivity * -1)
                                     ELSE 0.00                                                                                                      
                                END,       
      GLTran_Crtd_DateTime    = '',
      GLTran_Crtd_Prog        = '',
      GLTran_Crtd_User        = '',
      GLTran_CuryCrAmt        = CASE WHEN (SUBSTRING(v.AccountAcctType,2,1) = 'A' AND v.CuryPeriodActivity < 0.00)  THEN
                                          (v.CuryPeriodActivity * -1)
                                     WHEN (SUBSTRING(v.AccountAcctType,2,1) = 'L' AND v.CuryPeriodActivity >= 0.00) THEN 
                                          (v.CuryPeriodActivity)
                                     WHEN (SUBSTRING(v.AccountAcctType,2,1) = 'I' AND v.CuryPeriodActivity >= 0.00) THEN
                                          (v.CuryPeriodActivity)
                                     WHEN (SUBSTRING(v.AccountAcctType,2,1) = 'E' AND v.CuryPeriodActivity < 0.00)  THEN
                                          (v.CuryPeriodActivity * -1)
                                     ELSE 0.00                                                                                                      
                                END,       
      GLTran_CuryDrAmt        = CASE WHEN (SUBSTRING(v.AccountAcctType,2,1) = 'A' AND v.CuryPeriodActivity >= 0.00) THEN
                                          (v.CuryPeriodActivity)
                                     WHEN (SUBSTRING(v.AccountAcctType,2,1) = 'L' AND v.CuryPeriodActivity < 0.00)  THEN
                                          (v.CuryPeriodActivity * -1)
                                     WHEN (SUBSTRING(v.AccountAcctType,2,1) = 'I' AND v.CuryPeriodActivity < 0.00)  THEN
                                          (v.CuryPeriodActivity * -1)
                                     WHEN (SUBSTRING(v.AccountAcctType,2,1) = 'E' AND v.CuryPeriodActivity >= 0.00) THEN
                                          (v.CuryPeriodActivity)
                                     ELSE 0.00                                                                                                      
                                END,  
      GLTran_CuryID           = v.CuryAcctCuryID,
      GLTran_DrAmt            = CASE WHEN (SUBSTRING(v.AccountAcctType,2,1) = 'A' AND v.PeriodActivity >= 0.00)     THEN
                                          (v.PeriodActivity)
                                     WHEN (SUBSTRING(v.AccountAcctType,2,1) = 'L' AND v.PeriodActivity < 0.00)      THEN
                                          (v.PeriodActivity * -1)
                                     WHEN (SUBSTRING(v.AccountAcctType,2,1) = 'I' AND v.PeriodActivity < 0.00)      THEN
                                          (v.PeriodActivity * -1)
                                     WHEN (SUBSTRING(v.AccountAcctType,2,1) = 'E' AND v.PeriodActivity >= 0.00)     THEN
                                          (v.PeriodActivity)
                                     ELSE 0.00                                                                                                      
                                END,    
      GLTran_EmployeeID       = '',
      GLTran_ExtRefNbr        = '',  
      GLTran_IC_Distribution  = '',  
      GLTran_JrnlType         = '',
      GLTran_Labor_Class_Cd   = '',
      GLTran_LineNbr          = '',
      GLTran_LineRef          = '',
      GLTran_LUpd_DateTime    = '',
      GLTran_LUpd_Prog        = '',
      GLTran_LUpd_User        = '',
      GLTran_Module           = '',
      GLTran_OrigAcct         = '',
      GLTran_OrigBatNbr       = '',
      GLTran_OrigCpnyID       = '',
      GLTran_OrigSub          = '',
      GLTran_PC_Flag          = '',
      GLTran_PC_Status        = '',
      GLTran_PerEnt           = v.PeriodPost,
      GLTran_Posted           = '',
      GLTran_ProjectID        = '',
      GLTran_Qty              = '',
      GLTran_Refnbr           = '',
      GLTran_TaskID           = '',
      GLTran_TranDate         = '1900-01-01',
      GLTran_TranDesc         = '',
      GLTran_TranType         = '',	
      GLTran_Units            = '',
      GLTran_User1            = '',
      GLTran_User2            = '',
      GLTran_User3            = '',
      GLTran_User4         = '',
      GLTran_User5            = '', 
      GLTran_User6            = '',
      GLTran_User7            = '',
      GLTran_User8            = '', 
      --GL Setup  
      GLSetup_RetEarnAcct     = s.RetEarnAcct,
      GLSetup_YtdNetIncAcct   = s.YtdNetIncAcct,
      GLSetUp_COAOrder        = s.COAOrder,
      -- RPTCompany Fields
      Rpt_Company_CpnyName    = c.CpnyName,
      Rpt_Company_RI_ID       = c.RI_ID,
      -- SubAcct Fields
      SubAcct_Active          = v.SubAcctActive,
      SubAcct_ConSolSub       = v.SubAcctConsolSub,
      SubAcct_Descr           = v.SubAcctDescr,
      SubAcct_User1           = v.SubAcctUser1,
      SubAcct_User2         = v.SubAcctUser2,
      SubAcct_User3           = v.SubAcctUser3,
      SubAcct_User4           = v.SubAcctUser4,
      SubAcct_User5           = v.SubAcctUser5,
      SubAcct_User6           = v.SubAcctUser6,
      SubAcct_User7           = v.SubAcctUser7,
      SubAcct_User8           = v.SubAcctUser8,
      --View Specific Fields
      AcctType_Order          = v.AcctTypeOrder,
      AcctType_Desc           =
        CASE s.COAOrder 
             WHEN  'A' THEN
                       CASE v.AcctTypeOrder 
                          WHEN '1' THEN  '1 - Assets'
                          WHEN '2' THEN  '2 - Liabilities'
                          ELSE           '3 - Income & Expense'
                       END
             WHEN  'B' THEN
                       CASE v.AcctTypeOrder 
                          WHEN '1' THEN  '1 - Assets'
                          WHEN '2' THEN  '2 - Liabilities'
                          WHEN '3' THEN  '3 - Income'
                          ELSE           '4 - Expense'
                       END
             WHEN  'C' THEN
                       CASE v.AcctTypeOrder 
                          WHEN '1' THEN  '1 - Income'
                          WHEN '2' THEN  '2 - Expense'
                          WHEN '3' THEN  '3 - Assets'
                          ELSE           '4 - Liabilities'
                       END
             WHEN  'D' THEN
                       CASE v.AcctTypeOrder 
                          WHEN '1' THEN  '1 - Income & Expense'
                          WHEN '2' THEN  '2 - Assets'
                          ELSE           '3 - Liabilities'
                       END
        END,
      Fiscyr                  = v.CuryAcctFiscyr,
      Month                   = v.Mon,
      Cury_Starting_Balance   = v.CuryStartingBalance,
      Starting_Balance        = v.StartingBalance,
      Starting_Balance1       = v.StartingBalance1, 	
      CuryStarting_Balance1   = v.CuryStartingBalance1, 
      Cury_Period_Activity    = v.CuryPeriodActivity, 
      Period_Activity         = v.PeriodActivity, 
      Period_Post             = v.PeriodPost,
      Cury_Ending_Balance     = v.CuryEndingBalance, 
      Ending_Balance          = v.EndingBalance, 
      Trans_Flag              = 'A',
      r.BegPerNbr, r.EndPerNbr 
   FROM  vr_01620MC_CuryAcct v 
                    CROSS JOIN GLSetUp          s (NOLOCK)    
                    INNER JOIN RPTCompany       c (NOLOCK)        ON v.CuryAcctCpnyID      = c.CpnyID                             
                    INNER JOIN RptRuntime       r (NOLOCK)        ON r.RI_ID               = c.RI_ID       AND
                                                                     v.CuryAcctFiscyr      BETWEEN
                                                                     LEFT(r.BegPerNbr,4)   AND LEFT(r.EndPerNbr,4)
                    LEFT OUTER LOOP JOIN GLTran t With (INDEX(GLTRAN6)) ON v.CuryAcctAcct        = t.Acct        AND
                                                                     v.CuryAcctSub         = t.Sub         AND 
                                                                     v.CuryAcctLedgerID    = t.LedgerID    AND
v.CuryAcctFiscyr      = t.FiscYr      AND
                                                                     v.PeriodPost          = t.PerPost     AND 
                                                                     v.CuryAcctCpnyID      = t.CpnyId      AND  
                                                                     t.Posted              = 'P'           AND
                                                                     v.CuryAcctCuryID      = t.CuryID      AND 
                                                                     v.CuryAcctAcct        <> s.YtdNetIncAcct                                                                                             
WHERE ((v.CuryAcctAcct = s.YtdNetIncAcct)                     OR   -- Include YTD Net Income Accounts
          t.Acct IS NULL )         -- Accounts with no activity, no beginning balance, but has summary activity.


 
