
CREATE PROC PJvICprojYTD350 @ProjGet   AS VARCHAR(16),
                         @PeriodGet AS VARCHAR(2),
                         @YearGet   AS VARCHAR(4)
AS
    DECLARE @rows AS BIGINT

    SELECT @rows = Count(*)
    FROM   PJvYTDSummary
    WHERE  PJvYTDSummary.Project = @ProjGet
           AND PJvYTDSummary.Period = @PeriodGet
           AND PJvYTDSummary.Year = @YearGet
           AND PJvYTDSummary.Acct IN (SELECT acct
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
          SELECT PJvYTDSummary.Acct                      'Acct',
                 Round(Avg(PJvYTDSummary.rate) * 100, 2) 'Rate',
                 Round(Sum(PJvYTDSummary.Beg_Amt), 2)    'Beg_Amt',
                 CASE @PeriodGet
                   WHEN '01' THEN Round(Sum(PJvYTDSummary.amount_01), 2)
                   WHEN '02' THEN Round(Sum(PJvYTDSummary.amount_02), 2)
                   WHEN '03' THEN Round(Sum(PJvYTDSummary.amount_03), 2)
                   WHEN '04' THEN Round(Sum(PJvYTDSummary.amount_04), 2)
                   WHEN '05' THEN Round(Sum(PJvYTDSummary.amount_05), 2)
                   WHEN '06' THEN Round(Sum(PJvYTDSummary.amount_06), 2)
                   WHEN '07' THEN Round(Sum(PJvYTDSummary.amount_07), 2)
                   WHEN '08' THEN Round(Sum(PJvYTDSummary.amount_08), 2)
                   WHEN '09' THEN Round(Sum(PJvYTDSummary.amount_09), 2)
                   WHEN '10' THEN Round(Sum(PJvYTDSummary.amount_10), 2)
                   WHEN '11' THEN Round(Sum(PJvYTDSummary.amount_11), 2)
                   WHEN '12' THEN Round(Sum(PJvYTDSummary.amount_12), 2)
                   WHEN '13' THEN Round(Sum(PJvYTDSummary.amount_13), 2)
                   WHEN '14' THEN Round(Sum(PJvYTDSummary.amount_14), 2)
                   WHEN '15' THEN Round(Sum(PJvYTDSummary.amount_15), 2)
                   ELSE 0
                 END                                     'PTDAmount',
                 CASE @PeriodGet
                   WHEN '01' THEN Round(Sum(PJvYTDSummary.amount_01), 2)
                   WHEN '02' THEN Round(Sum(PJvYTDSummary.amount_01) + Sum(PJvYTDSummary.amount_02), 2)
                   WHEN '03' THEN Round(Sum(PJvYTDSummary.amount_01) + Sum(PJvYTDSummary.amount_02) + Sum(PJvYTDSummary.amount_03), 2)
                   WHEN '04' THEN Round(Sum(PJvYTDSummary.amount_01) + Sum(PJvYTDSummary.amount_02) + Sum(PJvYTDSummary.amount_03) + Sum(PJvYTDSummary.amount_04), 2)
                   WHEN '05' THEN Round(Sum(PJvYTDSummary.amount_01) + Sum(PJvYTDSummary.amount_02) + Sum(PJvYTDSummary.amount_03) + Sum(PJvYTDSummary.amount_04) + Sum(PJvYTDSummary.amount_05), 2)
                   WHEN '06' THEN Round(Sum(PJvYTDSummary.amount_01) + Sum(PJvYTDSummary.amount_02) + Sum(PJvYTDSummary.amount_03) + Sum(PJvYTDSummary.amount_04) + Sum(PJvYTDSummary.amount_05) + Sum(PJvYTDSummary.amount_06), 2)
                   WHEN '07' THEN Round(Sum(PJvYTDSummary.amount_01) + Sum(PJvYTDSummary.amount_02) + Sum(PJvYTDSummary.amount_03) + Sum(PJvYTDSummary.amount_04) + Sum(PJvYTDSummary.amount_05) + Sum(PJvYTDSummary.amount_06) + Sum(PJvYTDSummary.amount_07), 2)
                   WHEN '08' THEN Round(Sum(PJvYTDSummary.amount_01) + Sum(PJvYTDSummary.amount_02) + Sum(PJvYTDSummary.amount_03) + Sum(PJvYTDSummary.amount_04) + Sum(PJvYTDSummary.amount_05) + Sum(PJvYTDSummary.amount_06) + Sum(PJvYTDSummary.amount_07) + Sum(PJvYTDSummary.amount_08), 2)
                   WHEN '09' THEN Round(Sum(PJvYTDSummary.amount_01) + Sum(PJvYTDSummary.amount_02) + Sum(PJvYTDSummary.amount_03) + Sum(PJvYTDSummary.amount_04) + Sum(PJvYTDSummary.amount_05) + Sum(PJvYTDSummary.amount_06) + Sum(PJvYTDSummary.amount_07) + Sum(PJvYTDSummary.amount_08) + Sum(PJvYTDSummary.amount_09), 2)
                   WHEN '10' THEN Round(Sum(PJvYTDSummary.amount_01) + Sum(PJvYTDSummary.amount_02) + Sum(PJvYTDSummary.amount_03) + Sum(PJvYTDSummary.amount_04) + Sum(PJvYTDSummary.amount_05) + Sum(PJvYTDSummary.amount_06) + Sum(PJvYTDSummary.amount_07) + Sum(PJvYTDSummary.amount_08) + Sum(PJvYTDSummary.amount_09) + Sum(PJvYTDSummary.amount_10), 2)
                   WHEN '11' THEN Round(Sum(PJvYTDSummary.amount_01) + Sum(PJvYTDSummary.amount_02) + Sum(PJvYTDSummary.amount_03) + Sum(PJvYTDSummary.amount_04) + Sum(PJvYTDSummary.amount_05) + Sum(PJvYTDSummary.amount_06) + Sum(PJvYTDSummary.amount_07) + Sum(PJvYTDSummary.amount_08) + Sum(PJvYTDSummary.amount_09) + Sum(PJvYTDSummary.amount_10) + Sum(PJvYTDSummary.amount_11), 2)
                   WHEN '12' THEN Round(Sum(PJvYTDSummary.amount_01) + Sum(PJvYTDSummary.amount_02) + Sum(PJvYTDSummary.amount_03) + Sum(PJvYTDSummary.amount_04) + Sum(PJvYTDSummary.amount_05) + Sum(PJvYTDSummary.amount_06) + Sum(PJvYTDSummary.amount_07) + Sum(PJvYTDSummary.amount_08) + Sum(PJvYTDSummary.amount_09) + Sum(PJvYTDSummary.amount_10) + Sum(PJvYTDSummary.amount_11) + Sum(PJvYTDSummary.amount_12), 2)
                   WHEN '13' THEN Round(Sum(PJvYTDSummary.amount_01) + Sum(PJvYTDSummary.amount_02) + Sum(PJvYTDSummary.amount_03) + Sum(PJvYTDSummary.amount_04) + Sum(PJvYTDSummary.amount_05) + Sum(PJvYTDSummary.amount_06) + Sum(PJvYTDSummary.amount_07) + Sum(PJvYTDSummary.amount_08) + Sum(PJvYTDSummary.amount_09) + Sum(PJvYTDSummary.amount_10) + Sum(PJvYTDSummary.amount_11) + Sum(PJvYTDSummary.amount_12) + Sum(PJvYTDSummary.amount_13), 2)
                   WHEN '14' THEN Round(Sum(PJvYTDSummary.amount_01) + Sum(PJvYTDSummary.amount_02) + Sum(PJvYTDSummary.amount_03) + Sum(PJvYTDSummary.amount_04) + Sum(PJvYTDSummary.amount_05) + Sum(PJvYTDSummary.amount_06) + Sum(PJvYTDSummary.amount_07) + Sum(PJvYTDSummary.amount_08) + Sum(PJvYTDSummary.amount_09) + Sum(PJvYTDSummary.amount_10) + Sum(PJvYTDSummary.amount_11) + Sum(PJvYTDSummary.amount_12) + Sum(PJvYTDSummary.amount_13) + Sum(PJvYTDSummary.amount_14), 2)
                   WHEN '15' THEN Round(Sum(PJvYTDSummary.amount_01) + Sum(PJvYTDSummary.amount_02) + Sum(PJvYTDSummary.amount_03) + Sum(PJvYTDSummary.amount_04) + Sum(PJvYTDSummary.amount_05) + Sum(PJvYTDSummary.amount_06) + Sum(PJvYTDSummary.amount_07) + Sum(PJvYTDSummary.amount_08) + Sum(PJvYTDSummary.amount_09) + Sum(PJvYTDSummary.amount_10) + Sum(PJvYTDSummary.amount_11) + Sum(PJvYTDSummary.amount_12) + Sum(PJvYTDSummary.amount_13) + Sum(PJvYTDSummary.amount_14) + Sum(PJvYTDSummary.amount_15), 2)
                   ELSE 0
                 END                                     'YTDAmount',
                 Round(Sum(PJvYTDSummary.EAC_Amt), 2)    'EAC_Amt'
          FROM   PJvYTDSummary
          WHERE  PJvYTDSummary.Project = @ProjGet
                 AND PJvYTDSummary.Period = @PeriodGet
                 AND PJvYTDSummary.Year = @YearGet
                 AND PJvYTDSummary.Acct IN (SELECT acct
                                            FROM   PJREPCOL
                                            WHERE  report_code = 'pa3500'
                                                   AND column_nbr in ('8', '9', '10'))
          GROUP  BY PJvYTDSummary.Acct,
                    PJvYTDSummary.Project
      END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJvICprojYTD350] TO [MSDSL]
    AS [dbo];

