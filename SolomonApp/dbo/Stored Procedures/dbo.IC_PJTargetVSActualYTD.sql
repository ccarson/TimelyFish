
CREATE PROC IC_PJTargetVSActualYTD @ProjGet   AS VARCHAR(16),
                                   @PeriodGet AS VARCHAR(2),
                                   @YearGet   AS VARCHAR(4)
AS
        SELECT IC_PJvYTDSummary.Acct,
           IC_PJvYTDSummary.Project,
           IC_PJvYTDSummary.Period,
           IC_PJvYTDSummary.Year,
           IC_PJvYTDSummary.ActualAmt01,
           IC_PJvYTDSummary.ActualAmt02,
           IC_PJvYTDSummary.ActualAmt03,
           IC_PJvYTDSummary.ActualAmt04,
           IC_PJvYTDSummary.ActualAmt05,
           IC_PJvYTDSummary.ActualAmt06,
           IC_PJvYTDSummary.ActualAmt07,
           IC_PJvYTDSummary.ActualAmt08,
           IC_PJvYTDSummary.ActualAmt09,
           IC_PJvYTDSummary.ActualAmt10,
           IC_PJvYTDSummary.ActualAmt11,
           IC_PJvYTDSummary.ActualAmt12,
           IC_PJvYTDSummary.ActualAmt13,
           IC_PJvYTDSummary.ActualAmt14,
           IC_PJvYTDSummary.ActualAmt15,
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
           IC_PJvYTDSummary.ActualRate,
		   IC_PJvYTDSummary.ProjCury_ActualAmt01,
           IC_PJvYTDSummary.ProjCury_ActualAmt02,
           IC_PJvYTDSummary.ProjCury_ActualAmt03,
           IC_PJvYTDSummary.ProjCury_ActualAmt04,
           IC_PJvYTDSummary.ProjCury_ActualAmt05,
           IC_PJvYTDSummary.ProjCury_ActualAmt06,
           IC_PJvYTDSummary.ProjCury_ActualAmt07,
           IC_PJvYTDSummary.ProjCury_ActualAmt08,
           IC_PJvYTDSummary.ProjCury_ActualAmt09,
           IC_PJvYTDSummary.ProjCury_ActualAmt10,
           IC_PJvYTDSummary.ProjCury_ActualAmt11,
           IC_PJvYTDSummary.ProjCury_ActualAmt12,
           IC_PJvYTDSummary.ProjCury_ActualAmt13,
           IC_PJvYTDSummary.ProjCury_ActualAmt14,
           IC_PJvYTDSummary.ProjCury_ActualAmt15,
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
    FROM   IC_PJvYTDSummary
           LEFT OUTER JOIN IC_PJActSum
             ON IC_PJvYTDSummary.Acct = IC_PJActSum.acct
                AND IC_PJvYTDSummary.Project = IC_PJActSum.project
                AND IC_PJvYTDSummary.Year = IC_PJActSum.Year
           LEFT OUTER JOIN PJACCT
             ON IC_PJvYTDSummary.acct = PJACCT.acct
    WHERE  IC_PJvYTDSummary.Project = @ProjGet
           AND IC_PJvYTDSummary.Period = @PeriodGet
           AND IC_PJvYTDSummary.Year = @YearGet
           AND IC_PJvYTDSummary.Acct IN (SELECT acct
                                         FROM   PJREPCOL
                                         WHERE  report_code = 'pa3700'
                                                AND column_nbr IN ( '8', '9', '10' )) 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[IC_PJTargetVSActualYTD] TO [MSDSL]
    AS [dbo];

