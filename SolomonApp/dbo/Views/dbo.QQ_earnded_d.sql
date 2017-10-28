
CREATE VIEW [QQ_earnded_d]
AS
SELECT	ED.EmpId AS [Employee ID], CASE WHEN CHARINDEX('~' , E.Name) > 0 THEN CONVERT (CHAR(60) , LTRIM(SUBSTRING(E.Name, 1 , CHARINDEX('~' , E.Name) - 1)) 
		+ ', ' + LTRIM(RTRIM(SUBSTRING(E.Name, CHARINDEX('~' , E.Name) + 1 , 60)))) ELSE E.Name END AS [Employee Name], ED.CalYr AS [Calendar Year], 
		ED.EarnDedId AS [Deduction ID], ED.EDType, ED.CalYtdEarnDed AS [YTD Deductions], ED.YtdPerTkn AS [YTD Period Taken], 
        ED.YtdRptEarnSubjDed AS [YTD Earnings Subj Ded], D.EmpleeDed AS [Reduces Net Pay], ED.ArrgYTD AS [YTD Arrearage], ED.QtdEarnDed00 AS [QTD Deductions 1], 
        ED.QtdRptEarnSubjDed00 AS [QTD Earnings Subj Ded 1], ED.QtdEarnDed01 AS [QTD Deductions 2], ED.QtdRptEarnSubjDed01 AS [QTD Earnings Subj Ded 2], 
        ED.QtdEarnDed02 AS [QTD Deductions 3], ED.QtdRptEarnSubjDed02 AS [QTD Earnings Subj Ded 3], ED.QtdEarnDed03 AS [QTD Deductions 4], 
        ED.QtdRptEarnSubjDed03 AS [QTD Earnings Subj Ded 4], ED.AddlExmptAmt AS [Additional Exemption Amount], ED.CalMaxYtdDed AS [Max Deduction Amount], 
        ED.AddlCrAmt AS [Additional Credit Amount], ED.ArrgCurr AS [Current Arrearage], ED.ArrgEmpAllow AS [Allow Arrearages Y/N], ED.CpnyID AS [Company ID], 
        CONVERT(DATE,ED.Crtd_DateTime) AS [Create Date], ED.Crtd_Prog AS [Create Program], ED.Crtd_User AS [Create User], 
        ED.CurrEarnDedAmt AS [Current Deduction Amount], ED.CurrRptEarnSubjDed AS [Current Earnings Subj Ded], ED.DedSequence AS [Garnishment Sequence], 
        ED.EarnDedType AS [Deduction Type], ED.Exmpt AS Exempt, ED.FxdPctRate AS [Fixed Amount Rate/Percent], CONVERT(DATE,ED.LUpd_DateTime) AS [Last Update Date], 
        ED.LUpd_Prog AS [Last Update Program], ED.LUpd_User AS [Last Update User], ED.MtdEarnDed00 AS [MTD Deduction 01], ED.MtdEarnDed01 AS [MTD Deduction 02], 
        ED.MtdEarnDed02 AS [MTD Deduction 03], ED.MtdEarnDed03 AS [MTD Deduction 04], ED.MtdEarnDed04 AS [MTD Deduction 05], ED.MtdEarnDed05 AS [MTD Deduction 06], 
        ED.MtdEarnDed06 AS [MTD Deduction 07], ED.MtdEarnDed07 AS [MTD Deduction 08], ED.MtdEarnDed08 AS [MTD Deduction 09], ED.MtdEarnDed09 AS [MTD Deduction 10], 
        ED.MtdEarnDed10 AS [MTD Deduction 11], ED.MtdEarnDed11 AS [MTD Deduction 12], ED.MtdRptEarnSubjDed00 AS [MTD Earnings Subj Ded 01], 
        ED.MtdRptEarnSubjDed01 AS [MTD Earnings Subj Ded 02], ED.MtdRptEarnSubjDed02 AS [MTD Earnings Subj Ded 03], 
        ED.MtdRptEarnSubjDed03 AS [MTD Earnings Subj Ded 04], ED.MtdRptEarnSubjDed04 AS [MTD Earnings Subj Ded 05], 
        ED.MtdRptEarnSubjDed05 AS [MTD Earnings Subj Ded 06], ED.MtdRptEarnSubjDed06 AS [MTD Earnings Subj Ded 07], 
        ED.MtdRptEarnSubjDed07 AS [MTD Earnings Subj Ded 08], ED.MtdRptEarnSubjDed08 AS [MTD Earnings Subj Ded 09], 
        ED.MtdRptEarnSubjDed09 AS [MTD Earnings Subj Ded 10], ED.MtdRptEarnSubjDed10 AS [MTD Earnings Subj Ded 11], 
        ED.MtdRptEarnSubjDed11 AS [MTD Earnings Subj Ded 12], ED.NbrOthrExmpt AS [Nbr Other Exemptions], ED.NbrPersExmpt AS [Nbr Personal Exemptions], ED.NoteId, 
        ED.S4Future01, ED.S4Future02, ED.S4Future03, ED.S4Future04, ED.S4Future05, ED.S4Future06, CONVERT(DATE,ED.S4Future07) AS [S4Future07], 
        CONVERT(DATE,ED.S4Future08) AS [S4Future08], ED.S4Future09, ED.S4Future10, ED.S4Future11, ED.S4Future12, ED.User1, ED.User2, ED.User3, ED.User4, ED.User5, 
        ED.User6, CONVERT(DATE,ED.User7) AS [User7], CONVERT(DATE,ED.User8) AS [User8]
FROM	EarnDed ED with (nolock) 
			INNER JOIN Employee E with (nolock) ON ED.EmpId = E.EmpId AND ED.CalYr = E.CalYr 
			INNER JOIN Deduction D with (nolock) ON ED.CalYr = D.CalYr AND ED.EarnDedId = D.DedId
WHERE     (ED.EDType = 'D')

