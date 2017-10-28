
CREATE PROC IC_PJTargetVSActualPTD @ProjGet   AS VARCHAR(16),
                                   @PeriodGet AS VARCHAR(2),
                                   @YearGet   AS VARCHAR(4)
AS
    SELECT IC_PJvPTDSummary.Acct,
           IC_PJvPTDSummary.Project,
           @PeriodGet 'Period',
           IC_PJvPTDSummary.Year,
           IC_PJvPTDSummary.ActualAmt01,
           IC_PJvPTDSummary.ActualAmt02,
           IC_PJvPTDSummary.ActualAmt03,
           IC_PJvPTDSummary.ActualAmt04,
           IC_PJvPTDSummary.ActualAmt05,
           IC_PJvPTDSummary.ActualAmt06,
           IC_PJvPTDSummary.ActualAmt07,
           IC_PJvPTDSummary.ActualAmt08,
           IC_PJvPTDSummary.ActualAmt09,
           IC_PJvPTDSummary.ActualAmt10,
           IC_PJvPTDSummary.ActualAmt11,
           IC_PJvPTDSummary.ActualAmt12,
           IC_PJvPTDSummary.ActualAmt13,
           IC_PJvPTDSummary.ActualAmt14,
           IC_PJvPTDSummary.ActualAmt15,
           IC_PJActSum.TargetAmt01,
           IC_PJActSum.TargetAmt02,
           IC_PJActSum.TargetAmt03,
           IC_PJActSum.TargetAmt04,
           IC_PJActSum.TargetAmt05,
           IC_PJActSum.TargetAmt06,
           IC_PJActSum.TargetAmt07,
           IC_PJActSum.TargetAmt08,
           IC_PJActSum.TargetAmt09,
           IC_PJActSum.TargetAmt10,
           IC_PJActSum.TargetAmt11,
           IC_PJActSum.TargetAmt12,
           IC_PJActSum.TargetAmt13,
           IC_PJActSum.TargetAmt14,
           IC_PJActSum.TargetAmt15,
           IC_PJvPTDSummary.ActualRate01,
           IC_PJvPTDSummary.ActualRate02,
           IC_PJvPTDSummary.ActualRate03,
           IC_PJvPTDSummary.ActualRate04,
           IC_PJvPTDSummary.ActualRate05,
           IC_PJvPTDSummary.ActualRate06,
           IC_PJvPTDSummary.ActualRate07,
           IC_PJvPTDSummary.ActualRate08,
           IC_PJvPTDSummary.ActualRate09,
           IC_PJvPTDSummary.ActualRate10,
           IC_PJvPTDSummary.ActualRate11,
           IC_PJvPTDSummary.ActualRate12,
           IC_PJvPTDSummary.ActualRate13,
           IC_PJvPTDSummary.ActualRate14,
           IC_PJvPTDSummary.ActualRate15,
		   IC_PJvPTDSummary.ProjCury_ActualAmt01,
           IC_PJvPTDSummary.ProjCury_ActualAmt02,
           IC_PJvPTDSummary.ProjCury_ActualAmt03,
           IC_PJvPTDSummary.ProjCury_ActualAmt04,
           IC_PJvPTDSummary.ProjCury_ActualAmt05,
           IC_PJvPTDSummary.ProjCury_ActualAmt06,
           IC_PJvPTDSummary.ProjCury_ActualAmt07,
           IC_PJvPTDSummary.ProjCury_ActualAmt08,
           IC_PJvPTDSummary.ProjCury_ActualAmt09,
           IC_PJvPTDSummary.ProjCury_ActualAmt10,
           IC_PJvPTDSummary.ProjCury_ActualAmt11,
           IC_PJvPTDSummary.ProjCury_ActualAmt12,
           IC_PJvPTDSummary.ProjCury_ActualAmt13,
           IC_PJvPTDSummary.ProjCury_ActualAmt14,
           IC_PJvPTDSummary.ProjCury_ActualAmt15,
           IC_PJActSum.ProjCury_TargetAmt01,
           IC_PJActSum.ProjCury_TargetAmt02,
           IC_PJActSum.ProjCury_TargetAmt03,
           IC_PJActSum.ProjCury_TargetAmt04,
           IC_PJActSum.ProjCury_TargetAmt05,
           IC_PJActSum.ProjCury_TargetAmt06,
           IC_PJActSum.ProjCury_TargetAmt07,
           IC_PJActSum.ProjCury_TargetAmt08,
           IC_PJActSum.ProjCury_TargetAmt09,
           IC_PJActSum.ProjCury_TargetAmt10,
           IC_PJActSum.ProjCury_TargetAmt11,
           IC_PJActSum.ProjCury_TargetAmt12,
           IC_PJActSum.ProjCury_TargetAmt13,
           IC_PJActSum.ProjCury_TargetAmt14,
           IC_PJActSum.ProjCury_TargetAmt15,
           PJACCT.ca_id06 'TargetRate'
    FROM   IC_PJvPTDSummary
           LEFT OUTER JOIN IC_PJActSum
             ON IC_PJvPTDSummary.Acct = IC_PJActSum.acct
                AND IC_PJvPTDSummary.Project = IC_PJActSum.project
                AND IC_PJvPTDSummary.Year = IC_PJActSum.Year
           LEFT OUTER JOIN PJACCT
             ON IC_PJvPTDSummary.acct = PJACCT.acct
    WHERE  IC_PJvPTDSummary.Project = @ProjGet
           AND IC_PJvPTDSummary.Year = @YearGet
           AND IC_PJvPTDSummary.Acct IN (SELECT acct
                                         FROM   PJREPCOL
                                         WHERE  report_code = 'pa3700'
                                                AND column_nbr IN ( '8', '9', '10' ))            


GO
GRANT CONTROL
    ON OBJECT::[dbo].[IC_PJTargetVSActualPTD] TO [MSDSL]
    AS [dbo];

