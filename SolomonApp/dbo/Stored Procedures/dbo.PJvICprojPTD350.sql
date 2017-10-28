
CREATE PROC [PJvICprojPTD350] @ProjGet   AS VARCHAR(16),
                           @PeriodGet AS VARCHAR(2),
                           @YearGet   AS VARCHAR(4)
AS
    DECLARE @rows AS BIGINT

    SELECT @rows = Count(*)
    FROM   PJvPTDSummary
    WHERE  PJvPTDSummary.fsyear_num = @YearGet
           AND PJvPTDSummary.project = @ProjGet
           AND PJvPTDSummary.Acct IN (SELECT acct
                                      FROM   PJREPCOL
                                      WHERE  report_code = 'pa3500'
                                             AND column_nbr in ('8', '9', '10'))

    IF @rows = 0
      BEGIN
          SELECT '------NONE------' 'Acct',
                 0.00               'Rate',
                 0.00               'Beg_Amt',
                 0.00               'PTDAmount',
                 0.00               'YTDAmount',
                 0.00               'EAC_Amt'
      END
    ELSE
      BEGIN
          SELECT PJvPTDSummary.Acct,
                 CASE @PeriodGet
                   WHEN '01' THEN Round(100 * Avg(PJvPTDSummary.rate_01), 2)
                   WHEN '02' THEN Round(100 * Avg(PJvPTDSummary.rate_02), 2)
                   WHEN '03' THEN Round(100 * Avg(PJvPTDSummary.rate_03), 2)
                   WHEN '04' THEN Round(100 * Avg(PJvPTDSummary.rate_04), 2)
                   WHEN '05' THEN Round(100 * Avg(PJvPTDSummary.rate_05), 2)
                   WHEN '06' THEN Round(100 * Avg(PJvPTDSummary.rate_06), 2)
                   WHEN '07' THEN Round(100 * Avg(PJvPTDSummary.rate_07), 2)
                   WHEN '08' THEN Round(100 * Avg(PJvPTDSummary.rate_08), 2)
                   WHEN '09' THEN Round(100 * Avg(PJvPTDSummary.rate_09), 2)
                   WHEN '10' THEN Round(100 * Avg(PJvPTDSummary.rate_10), 2)
                   WHEN '11' THEN Round(100 * Avg(PJvPTDSummary.rate_11), 2)
                   WHEN '12' THEN Round(100 * Avg(PJvPTDSummary.rate_12), 2)
                   WHEN '13' THEN Round(100 * Avg(PJvPTDSummary.rate_13), 2)
                   WHEN '14' THEN Round(100 * Avg(PJvPTDSummary.rate_14), 2)
                   WHEN '15' THEN Round(100 * Avg(PJvPTDSummary.rate_15), 2)
                   ELSE 0
                 END                                  'Rate',
                 Round(Sum(PJvPTDSummary.Beg_Amt), 2) 'Beg_Amt',
                 CASE @PeriodGet
                   WHEN '01' THEN Round(Sum(PJvPTDSummary.amount_01), 2)
                   WHEN '02' THEN Round(Sum(PJvPTDSummary.amount_02), 2)
                   WHEN '03' THEN Round(Sum(PJvPTDSummary.amount_03), 2)
                   WHEN '04' THEN Round(Sum(PJvPTDSummary.amount_04), 2)
                   WHEN '05' THEN Round(Sum(PJvPTDSummary.amount_05), 2)
                   WHEN '06' THEN Round(Sum(PJvPTDSummary.amount_06), 2)
                   WHEN '07' THEN Round(Sum(PJvPTDSummary.amount_07), 2)
                   WHEN '08' THEN Round(Sum(PJvPTDSummary.amount_08), 2)
                   WHEN '09' THEN Round(Sum(PJvPTDSummary.amount_09), 2)
                   WHEN '10' THEN Round(Sum(PJvPTDSummary.amount_10), 2)
                   WHEN '11' THEN Round(Sum(PJvPTDSummary.amount_11), 2)
                   WHEN '12' THEN Round(Sum(PJvPTDSummary.amount_12), 2)
                   WHEN '13' THEN Round(Sum(PJvPTDSummary.amount_13), 2)
                   WHEN '14' THEN Round(Sum(PJvPTDSummary.amount_14), 2)
                   WHEN '15' THEN Round(Sum(PJvPTDSummary.amount_15), 2)
                   ELSE 0
                 END                                  'PTDAmount',
                 CASE @PeriodGet
                   WHEN '01' THEN Round(Sum(PJvPTDSummary.amount_01), 2)
                   WHEN '02' THEN Round(Sum(PJvPTDSummary.amount_01) + Sum(PJvPTDSummary.amount_02), 2)
                   WHEN '03' THEN Round(Sum(PJvPTDSummary.amount_01) + Sum(PJvPTDSummary.amount_02) + Sum(PJvPTDSummary.amount_03), 2)
                   WHEN '04' THEN Round(Sum(PJvPTDSummary.amount_01) + Sum(PJvPTDSummary.amount_02) + Sum(PJvPTDSummary.amount_03) + Sum(PJvPTDSummary.amount_04), 2)
                   WHEN '05' THEN Round(Sum(PJvPTDSummary.amount_01) + Sum(PJvPTDSummary.amount_02) + Sum(PJvPTDSummary.amount_03) + Sum(PJvPTDSummary.amount_04) + Sum(PJvPTDSummary.amount_05), 2)
                   WHEN '06' THEN Round(Sum(PJvPTDSummary.amount_01) + Sum(PJvPTDSummary.amount_02) + Sum(PJvPTDSummary.amount_03) + Sum(PJvPTDSummary.amount_04) + Sum(PJvPTDSummary.amount_05) + Sum(PJvPTDSummary.amount_06), 2)
                   WHEN '07' THEN Round(Sum(PJvPTDSummary.amount_01) + Sum(PJvPTDSummary.amount_02) + Sum(PJvPTDSummary.amount_03) + Sum(PJvPTDSummary.amount_04) + Sum(PJvPTDSummary.amount_05) + Sum(PJvPTDSummary.amount_06) + Sum(PJvPTDSummary.amount_07), 2)
                   WHEN '08' THEN Round(Sum(PJvPTDSummary.amount_01) + Sum(PJvPTDSummary.amount_02) + Sum(PJvPTDSummary.amount_03) + Sum(PJvPTDSummary.amount_04) + Sum(PJvPTDSummary.amount_05) + Sum(PJvPTDSummary.amount_06) + Sum(PJvPTDSummary.amount_07) + Sum(PJvPTDSummary.amount_08), 2)
                   WHEN '09' THEN Round(Sum(PJvPTDSummary.amount_01) + Sum(PJvPTDSummary.amount_02) + Sum(PJvPTDSummary.amount_03) + Sum(PJvPTDSummary.amount_04) + Sum(PJvPTDSummary.amount_05) + Sum(PJvPTDSummary.amount_06) + Sum(PJvPTDSummary.amount_07) + Sum(PJvPTDSummary.amount_08) + Sum(PJvPTDSummary.amount_09), 2)
                   WHEN '10' THEN Round(Sum(PJvPTDSummary.amount_01) + Sum(PJvPTDSummary.amount_02) + Sum(PJvPTDSummary.amount_03) + Sum(PJvPTDSummary.amount_04) + Sum(PJvPTDSummary.amount_05) + Sum(PJvPTDSummary.amount_06) + Sum(PJvPTDSummary.amount_07) + Sum(PJvPTDSummary.amount_08) + Sum(PJvPTDSummary.amount_09) + Sum(PJvPTDSummary.amount_10), 2)
                   WHEN '11' THEN Round(Sum(PJvPTDSummary.amount_01) + Sum(PJvPTDSummary.amount_02) + Sum(PJvPTDSummary.amount_03) + Sum(PJvPTDSummary.amount_04) + Sum(PJvPTDSummary.amount_05) + Sum(PJvPTDSummary.amount_06) + Sum(PJvPTDSummary.amount_07) + Sum(PJvPTDSummary.amount_08) + Sum(PJvPTDSummary.amount_09) + Sum(PJvPTDSummary.amount_10) + Sum(PJvPTDSummary.amount_11), 2)
                   WHEN '12' THEN Round(Sum(PJvPTDSummary.amount_01) + Sum(PJvPTDSummary.amount_02) + Sum(PJvPTDSummary.amount_03) + Sum(PJvPTDSummary.amount_04) + Sum(PJvPTDSummary.amount_05) + Sum(PJvPTDSummary.amount_06) + Sum(PJvPTDSummary.amount_07) + Sum(PJvPTDSummary.amount_08) + Sum(PJvPTDSummary.amount_09) + Sum(PJvPTDSummary.amount_10) + Sum(PJvPTDSummary.amount_11) + Sum(PJvPTDSummary.amount_12), 2)
                   WHEN '13' THEN Round(Sum(PJvPTDSummary.amount_01) + Sum(PJvPTDSummary.amount_02) + Sum(PJvPTDSummary.amount_03) + Sum(PJvPTDSummary.amount_04) + Sum(PJvPTDSummary.amount_05) + Sum(PJvPTDSummary.amount_06) + Sum(PJvPTDSummary.amount_07) + Sum(PJvPTDSummary.amount_08) + Sum(PJvPTDSummary.amount_09) + Sum(PJvPTDSummary.amount_10) + Sum(PJvPTDSummary.amount_11) + Sum(PJvPTDSummary.amount_12) + Sum(PJvPTDSummary.amount_13), 2)
                   WHEN '14' THEN Round(Sum(PJvPTDSummary.amount_01) + Sum(PJvPTDSummary.amount_02) + Sum(PJvPTDSummary.amount_03) + Sum(PJvPTDSummary.amount_04) + Sum(PJvPTDSummary.amount_05) + Sum(PJvPTDSummary.amount_06) + Sum(PJvPTDSummary.amount_07) + Sum(PJvPTDSummary.amount_08) + Sum(PJvPTDSummary.amount_09) + Sum(PJvPTDSummary.amount_10) + Sum(PJvPTDSummary.amount_11) + Sum(PJvPTDSummary.amount_12) + Sum(PJvPTDSummary.amount_13) + Sum(PJvPTDSummary.amount_14), 2)
                   WHEN '15' THEN Round(Sum(PJvPTDSummary.amount_01) + Sum(PJvPTDSummary.amount_02) + Sum(PJvPTDSummary.amount_03) + Sum(PJvPTDSummary.amount_04) + Sum(PJvPTDSummary.amount_05) + Sum(PJvPTDSummary.amount_06) + Sum(PJvPTDSummary.amount_07) + Sum(PJvPTDSummary.amount_08) + Sum(PJvPTDSummary.amount_09) + Sum(PJvPTDSummary.amount_10) + Sum(PJvPTDSummary.amount_11) + Sum(PJvPTDSummary.amount_12) + Sum(PJvPTDSummary.amount_13) + Sum(PJvPTDSummary.amount_14) + Sum(PJvPTDSummary.amount_15), 2)
                   ELSE 0
                 END                                  'YTDAmount',
                 Round(Sum(PJvPTDSummary.EAC_Amt), 2) 'EAC_Amt'
          FROM   PJvPTDSummary
          WHERE  PJvPTDSummary.fsyear_num = @YearGet
                 AND PJvPTDSummary.project = @ProjGet
                 AND PJvPTDSummary.Acct IN (SELECT acct
                                            FROM   PJREPCOL
                                            WHERE  report_code = 'pa3500'
                                                   AND column_nbr in ('8', '9', '10'))
          GROUP  BY PJvPTDSummary.Acct,
                    PJvPTDSummary.project
      END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJvICprojPTD350] TO [MSDSL]
    AS [dbo];

