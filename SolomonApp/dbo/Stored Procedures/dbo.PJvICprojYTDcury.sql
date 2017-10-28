
CREATE PROC PJvICprojYTDcury @ProjGet   AS VARCHAR(16),
                             @PeriodGet AS VARCHAR(2),
                             @YearGet   AS VARCHAR(4)
AS
    DECLARE @rows AS BIGINT
    DECLARE @Decimal_Places AS INT = ( Select decpl from currncy where curyid = (select projcuryid from pjproj where project = @ProjGet ) )
    DECLARE @GLPeriods AS INT = (SELECT NbrPer FROM GLSetup)
    SELECT @rows = Count(*)
    FROM   PJvYTDSummaryCury
    WHERE  PJvYTDSummaryCury.Project = @ProjGet
           AND PJvYTDSummaryCury.Period = @PeriodGet
           AND PJvYTDSummaryCury.Year = @YearGet
           AND PJvYTDSummaryCury.Acct IN (SELECT acct
                                       FROM   PJREPCOL
                                       WHERE  report_code = 'pa3000'
                                              AND column_nbr = '3')

    IF @rows = 0
      BEGIN
          SELECT '------NONE------' 'Acct',
                 0.00               'Rate',
                 0.00               'Beg_Amt',
                 0.00               'PTDAmount',
                 0.00               'YTDAmount',
                 0.00               'PriorPeriod2Amount',
                 0.00               'PriorPeriod1Amount',
                 0.00               'EAC_Amt',
                 0.00               'DecPL'
      END
    ELSE
      BEGIN
          SELECT PJvYTDSummaryCury.Acct                      'Acct',
                 Round(Avg(PJvYTDSummaryCury.rate) * 100, @Decimal_Places) 'Rate',
                 Round(Sum(PJvYTDSummaryCury.Beg_Amt), @Decimal_Places)    'Beg_Amt',
                 CASE @PeriodGet
                   WHEN '01' THEN Round(Sum(PJvYTDSummaryCury.amount_01), @Decimal_Places)
                   WHEN '02' THEN Round(Sum(PJvYTDSummaryCury.amount_02), @Decimal_Places)
                   WHEN '03' THEN Round(Sum(PJvYTDSummaryCury.amount_03), @Decimal_Places)
                   WHEN '04' THEN Round(Sum(PJvYTDSummaryCury.amount_04), @Decimal_Places)
                   WHEN '05' THEN Round(Sum(PJvYTDSummaryCury.amount_05), @Decimal_Places)
                   WHEN '06' THEN Round(Sum(PJvYTDSummaryCury.amount_06), @Decimal_Places)
                   WHEN '07' THEN Round(Sum(PJvYTDSummaryCury.amount_07), @Decimal_Places)
                   WHEN '08' THEN Round(Sum(PJvYTDSummaryCury.amount_08), @Decimal_Places)
                   WHEN '09' THEN Round(Sum(PJvYTDSummaryCury.amount_09), @Decimal_Places)
                   WHEN '10' THEN Round(Sum(PJvYTDSummaryCury.amount_10), @Decimal_Places)
                   WHEN '11' THEN Round(Sum(PJvYTDSummaryCury.amount_11), @Decimal_Places)
                   WHEN '12' THEN Round(Sum(PJvYTDSummaryCury.amount_12), @Decimal_Places)
                   WHEN '13' THEN Round(Sum(PJvYTDSummaryCury.amount_13), @Decimal_Places)
                   WHEN '14' THEN Round(Sum(PJvYTDSummaryCury.amount_14), @Decimal_Places)
                   WHEN '15' THEN Round(Sum(PJvYTDSummaryCury.amount_15), @Decimal_Places)
                   ELSE 0
                 END                                      'PTDAmount',
                 CASE @PeriodGet
                   WHEN '01' THEN Round(Sum(PJvYTDSummaryCury.amount_01), @Decimal_Places)
                   WHEN '02' THEN Round(Sum(PJvYTDSummaryCury.amount_01) + Sum(PJvYTDSummaryCury.amount_02), @Decimal_Places)
                   WHEN '03' THEN Round(Sum(PJvYTDSummaryCury.amount_01) + Sum(PJvYTDSummaryCury.amount_02) + Sum(PJvYTDSummaryCury.amount_03), @Decimal_Places)
                   WHEN '04' THEN Round(Sum(PJvYTDSummaryCury.amount_01) + Sum(PJvYTDSummaryCury.amount_02) + Sum(PJvYTDSummaryCury.amount_03) + Sum(PJvYTDSummaryCury.amount_04), @Decimal_Places)
                   WHEN '05' THEN Round(Sum(PJvYTDSummaryCury.amount_01) + Sum(PJvYTDSummaryCury.amount_02) + Sum(PJvYTDSummaryCury.amount_03) + Sum(PJvYTDSummaryCury.amount_04) + Sum(PJvYTDSummaryCury.amount_05), @Decimal_Places)
                   WHEN '06' THEN Round(Sum(PJvYTDSummaryCury.amount_01) + Sum(PJvYTDSummaryCury.amount_02) + Sum(PJvYTDSummaryCury.amount_03) + Sum(PJvYTDSummaryCury.amount_04) + Sum(PJvYTDSummaryCury.amount_05) + Sum(PJvYTDSummaryCury.amount_06), @Decimal_Places)
                   WHEN '07' THEN Round(Sum(PJvYTDSummaryCury.amount_01) + Sum(PJvYTDSummaryCury.amount_02) + Sum(PJvYTDSummaryCury.amount_03) + Sum(PJvYTDSummaryCury.amount_04) + Sum(PJvYTDSummaryCury.amount_05) + Sum(PJvYTDSummaryCury.amount_06) + Sum(PJvYTDSummaryCury.amount_07), @Decimal_Places)
                   WHEN '08' THEN Round(Sum(PJvYTDSummaryCury.amount_01) + Sum(PJvYTDSummaryCury.amount_02) + Sum(PJvYTDSummaryCury.amount_03) + Sum(PJvYTDSummaryCury.amount_04) + Sum(PJvYTDSummaryCury.amount_05) + Sum(PJvYTDSummaryCury.amount_06) + Sum(PJvYTDSummaryCury.amount_07) + Sum(PJvYTDSummaryCury.amount_08), @Decimal_Places)
                   WHEN '09' THEN Round(Sum(PJvYTDSummaryCury.amount_01) + Sum(PJvYTDSummaryCury.amount_02) + Sum(PJvYTDSummaryCury.amount_03) + Sum(PJvYTDSummaryCury.amount_04) + Sum(PJvYTDSummaryCury.amount_05) + Sum(PJvYTDSummaryCury.amount_06) + Sum(PJvYTDSummaryCury.amount_07) + Sum(PJvYTDSummaryCury.amount_08) + Sum(PJvYTDSummaryCury.amount_09), @Decimal_Places)
                   WHEN '10' THEN Round(Sum(PJvYTDSummaryCury.amount_01) + Sum(PJvYTDSummaryCury.amount_02) + Sum(PJvYTDSummaryCury.amount_03) + Sum(PJvYTDSummaryCury.amount_04) + Sum(PJvYTDSummaryCury.amount_05) + Sum(PJvYTDSummaryCury.amount_06) + Sum(PJvYTDSummaryCury.amount_07) + Sum(PJvYTDSummaryCury.amount_08) + Sum(PJvYTDSummaryCury.amount_09) + Sum(PJvYTDSummaryCury.amount_10), @Decimal_Places)
                   WHEN '11' THEN Round(Sum(PJvYTDSummaryCury.amount_01) + Sum(PJvYTDSummaryCury.amount_02) + Sum(PJvYTDSummaryCury.amount_03) + Sum(PJvYTDSummaryCury.amount_04) + Sum(PJvYTDSummaryCury.amount_05) + Sum(PJvYTDSummaryCury.amount_06) + Sum(PJvYTDSummaryCury.amount_07) + Sum(PJvYTDSummaryCury.amount_08) + Sum(PJvYTDSummaryCury.amount_09) + Sum(PJvYTDSummaryCury.amount_10) + Sum(PJvYTDSummaryCury.amount_11), @Decimal_Places)
                   WHEN '12' THEN Round(Sum(PJvYTDSummaryCury.amount_01) + Sum(PJvYTDSummaryCury.amount_02) + Sum(PJvYTDSummaryCury.amount_03) + Sum(PJvYTDSummaryCury.amount_04) + Sum(PJvYTDSummaryCury.amount_05) + Sum(PJvYTDSummaryCury.amount_06) + Sum(PJvYTDSummaryCury.amount_07) + Sum(PJvYTDSummaryCury.amount_08) + Sum(PJvYTDSummaryCury.amount_09) + Sum(PJvYTDSummaryCury.amount_10) + Sum(PJvYTDSummaryCury.amount_11) + Sum(PJvYTDSummaryCury.amount_12), @Decimal_Places)
                   WHEN '13' THEN Round(Sum(PJvYTDSummaryCury.amount_01) + Sum(PJvYTDSummaryCury.amount_02) + Sum(PJvYTDSummaryCury.amount_03) + Sum(PJvYTDSummaryCury.amount_04) + Sum(PJvYTDSummaryCury.amount_05) + Sum(PJvYTDSummaryCury.amount_06) + Sum(PJvYTDSummaryCury.amount_07) + Sum(PJvYTDSummaryCury.amount_08) + Sum(PJvYTDSummaryCury.amount_09) + Sum(PJvYTDSummaryCury.amount_10) + Sum(PJvYTDSummaryCury.amount_11) + Sum(PJvYTDSummaryCury.amount_12) + Sum(PJvYTDSummaryCury.amount_13), @Decimal_Places)
                   WHEN '14' THEN Round(Sum(PJvYTDSummaryCury.amount_01) + Sum(PJvYTDSummaryCury.amount_02) + Sum(PJvYTDSummaryCury.amount_03) + Sum(PJvYTDSummaryCury.amount_04) + Sum(PJvYTDSummaryCury.amount_05) + Sum(PJvYTDSummaryCury.amount_06) + Sum(PJvYTDSummaryCury.amount_07) + Sum(PJvYTDSummaryCury.amount_08) + Sum(PJvYTDSummaryCury.amount_09) + Sum(PJvYTDSummaryCury.amount_10) + Sum(PJvYTDSummaryCury.amount_11) + Sum(PJvYTDSummaryCury.amount_12) + Sum(PJvYTDSummaryCury.amount_13) + Sum(PJvYTDSummaryCury.amount_14), @Decimal_Places)
                   WHEN '15' THEN Round(Sum(PJvYTDSummaryCury.amount_01) + Sum(PJvYTDSummaryCury.amount_02) + Sum(PJvYTDSummaryCury.amount_03) + Sum(PJvYTDSummaryCury.amount_04) + Sum(PJvYTDSummaryCury.amount_05) + Sum(PJvYTDSummaryCury.amount_06) + Sum(PJvYTDSummaryCury.amount_07) + Sum(PJvYTDSummaryCury.amount_08) + Sum(PJvYTDSummaryCury.amount_09) + Sum(PJvYTDSummaryCury.amount_10) + Sum(PJvYTDSummaryCury.amount_11) + Sum(PJvYTDSummaryCury.amount_12) + Sum(PJvYTDSummaryCury.amount_13) + Sum(PJvYTDSummaryCury.amount_14) + Sum(PJvYTDSummaryCury.amount_15), @Decimal_Places)
                   ELSE 0
                 END                                      'YTDAmount',
                 CASE @periodget
                   WHEN '01' THEN Isnull(CASE @GLPeriods
                                           WHEN '01' THEN 0
                                           WHEN '02' THEN Round(Sum(PriorSummary.amount_01), @Decimal_Places)
                                           WHEN '03' THEN Round(Sum(PriorSummary.amount_02), @Decimal_Places)
                                           WHEN '04' THEN Round(Sum(PriorSummary.amount_03), @Decimal_Places)
                                           WHEN '05' THEN Round(Sum(PriorSummary.amount_04), @Decimal_Places)
                                           WHEN '06' THEN Round(Sum(PriorSummary.amount_05), @Decimal_Places)
                                           WHEN '07' THEN Round(Sum(PriorSummary.amount_06), @Decimal_Places)
                                           WHEN '08' THEN Round(Sum(PriorSummary.amount_07), @Decimal_Places)
                                           WHEN '09' THEN Round(Sum(PriorSummary.amount_08), @Decimal_Places)
                                           WHEN '10' THEN Round(Sum(PriorSummary.amount_09), @Decimal_Places)
                                           WHEN '11' THEN Round(Sum(PriorSummary.amount_10), @Decimal_Places)
                                           WHEN '12' THEN Round(Sum(PriorSummary.amount_11), @Decimal_Places)
                                           WHEN '13' THEN Round(Sum(PriorSummary.amount_12), @Decimal_Places)
                                           WHEN '14' THEN Round(Sum(PriorSummary.amount_13), @Decimal_Places)
                                           WHEN '15' THEN Round(Sum(PriorSummary.amount_14), @Decimal_Places)
                                           ELSE 0
                                         END, 0)
                   WHEN '02' THEN Isnull(CASE @GLPeriods
                                           WHEN '01' THEN Round(Sum(PriorSummary.amount_01), @Decimal_Places)
                                           WHEN '02' THEN Round(Sum(PriorSummary.amount_01), @Decimal_Places)
                                           WHEN '03' THEN Round(Sum(PriorSummary.amount_03), @Decimal_Places)
                                           WHEN '04' THEN Round(Sum(PriorSummary.amount_04), @Decimal_Places)
                                           WHEN '05' THEN Round(Sum(PriorSummary.amount_05), @Decimal_Places)
                                           WHEN '06' THEN Round(Sum(PriorSummary.amount_06), @Decimal_Places)
                                           WHEN '07' THEN Round(Sum(PriorSummary.amount_07), @Decimal_Places)
                                           WHEN '08' THEN Round(Sum(PriorSummary.amount_08), @Decimal_Places)
                                           WHEN '09' THEN Round(Sum(PriorSummary.amount_09), @Decimal_Places)
                                           WHEN '10' THEN Round(Sum(PriorSummary.amount_10), @Decimal_Places)
                                           WHEN '11' THEN Round(Sum(PriorSummary.amount_11), @Decimal_Places)
                                           WHEN '12' THEN Round(Sum(PriorSummary.amount_12), @Decimal_Places)
                                           WHEN '13' THEN Round(Sum(PriorSummary.amount_13), @Decimal_Places)
                                           WHEN '14' THEN Round(Sum(PriorSummary.amount_14), @Decimal_Places)
                                           WHEN '15' THEN Round(Sum(PriorSummary.amount_15), @Decimal_Places)
                                           ELSE 0
                                         END, 0)
                   WHEN '03' THEN Round(Sum(PJvYTDSummaryCury.amount_01), @Decimal_Places)
                   WHEN '04' THEN Round(Sum(PJvYTDSummaryCury.amount_02), @Decimal_Places)
                   WHEN '05' THEN Round(Sum(PJvYTDSummaryCury.amount_03), @Decimal_Places)
                   WHEN '06' THEN Round(Sum(PJvYTDSummaryCury.amount_04), @Decimal_Places)
                   WHEN '07' THEN Round(Sum(PJvYTDSummaryCury.amount_05), @Decimal_Places)
                   WHEN '08' THEN Round(Sum(PJvYTDSummaryCury.amount_06), @Decimal_Places)
                   WHEN '09' THEN Round(Sum(PJvYTDSummaryCury.amount_07), @Decimal_Places)
                   WHEN '10' THEN Round(Sum(PJvYTDSummaryCury.amount_08), @Decimal_Places)
                   WHEN '11' THEN Round(Sum(PJvYTDSummaryCury.amount_09), @Decimal_Places)
                   WHEN '12' THEN Round(Sum(PJvYTDSummaryCury.amount_10), @Decimal_Places)
                   WHEN '13' THEN Round(Sum(PJvYTDSummaryCury.amount_11), @Decimal_Places)
                   WHEN '14' THEN Round(Sum(PJvYTDSummaryCury.amount_12), @Decimal_Places)
                   WHEN '15' THEN Round(Sum(PJvYTDSummaryCury.amount_13), @Decimal_Places)
                   ELSE 0
                 END                                      'PriorPeriod2Amount',
                 CASE @periodget
                   WHEN '01' THEN Isnull(CASE @GLPeriods
                                           WHEN '01' THEN Round(Sum(PriorSummary.amount_01), @Decimal_Places)
                                           WHEN '02' THEN Round(Sum(PriorSummary.amount_01), @Decimal_Places)
                                           WHEN '03' THEN Round(Sum(PriorSummary.amount_03), @Decimal_Places)
                                           WHEN '04' THEN Round(Sum(PriorSummary.amount_04), @Decimal_Places)
                                           WHEN '05' THEN Round(Sum(PriorSummary.amount_05), @Decimal_Places)
                                           WHEN '06' THEN Round(Sum(PriorSummary.amount_06), @Decimal_Places)
                                           WHEN '07' THEN Round(Sum(PriorSummary.amount_07), @Decimal_Places)
                                           WHEN '08' THEN Round(Sum(PriorSummary.amount_08), @Decimal_Places)
                                           WHEN '09' THEN Round(Sum(PriorSummary.amount_09), @Decimal_Places)
                                           WHEN '10' THEN Round(Sum(PriorSummary.amount_10), @Decimal_Places)
                                           WHEN '11' THEN Round(Sum(PriorSummary.amount_11), @Decimal_Places)
                                           WHEN '12' THEN Round(Sum(PriorSummary.amount_12), @Decimal_Places)
                                           WHEN '13' THEN Round(Sum(PriorSummary.amount_13), @Decimal_Places)
                                           WHEN '14' THEN Round(Sum(PriorSummary.amount_14), @Decimal_Places)
                                           WHEN '15' THEN Round(Sum(PriorSummary.amount_15), @Decimal_Places)
                                           ELSE 0
                                         END, 0)
                   WHEN '02' THEN Round(Sum(PJvYTDSummaryCury.amount_01), @Decimal_Places)
                   WHEN '03' THEN Round(Sum(PJvYTDSummaryCury.amount_02), @Decimal_Places)
                   WHEN '04' THEN Round(Sum(PJvYTDSummaryCury.amount_03), @Decimal_Places)
                   WHEN '05' THEN Round(Sum(PJvYTDSummaryCury.amount_04), @Decimal_Places)
                   WHEN '06' THEN Round(Sum(PJvYTDSummaryCury.amount_05), @Decimal_Places)
                   WHEN '07' THEN Round(Sum(PJvYTDSummaryCury.amount_06), @Decimal_Places)
                   WHEN '08' THEN Round(Sum(PJvYTDSummaryCury.amount_07), @Decimal_Places)
                   WHEN '09' THEN Round(Sum(PJvYTDSummaryCury.amount_08), @Decimal_Places)
                   WHEN '10' THEN Round(Sum(PJvYTDSummaryCury.amount_09), @Decimal_Places)
                   WHEN '11' THEN Round(Sum(PJvYTDSummaryCury.amount_10), @Decimal_Places)
                   WHEN '12' THEN Round(Sum(PJvYTDSummaryCury.amount_11), @Decimal_Places)
                   WHEN '13' THEN Round(Sum(PJvYTDSummaryCury.amount_12), @Decimal_Places)
                   WHEN '14' THEN Round(Sum(PJvYTDSummaryCury.amount_13), @Decimal_Places)
                   WHEN '15' THEN Round(Sum(PJvYTDSummaryCury.amount_14), @Decimal_Places)
                   ELSE 0
                 END                                      'PriorPeriod1Amount',
                 Round(Sum(PJvYTDSummaryCury.EAC_Amt), @Decimal_Places)    'EAC_Amt',
                 @Decimal_Places AS DecPL
          FROM   PJvYTDSummaryCury 
                 LEFT JOIN PJvYTDSummaryCury PriorSummary
                   ON @PeriodGet < '03'
                      AND PriorSummary.period = CONVERT(CHAR(2), @GLPeriods)
                      AND PriorSummary.Year = CONVERT(CHAR(4), CONVERT(INT, @YearGet) - 1)
                      AND PriorSummary.project = PJvYTDSummaryCury.project
                      AND PriorSummary.pjt_entity = PJvYTDSummaryCury.pjt_entity
                      AND PriorSummary.acct = PJvYTDSummaryCury.acct
          WHERE  PJvYTDSummaryCury.Project = @ProjGet
                 AND PJvYTDSummaryCury.Period = @PeriodGet
                 AND PJvYTDSummaryCury.Year = @YearGet
                 AND PJvYTDSummaryCury.Acct IN (SELECT acct
                                             FROM   PJREPCOL
                                             WHERE  report_code = 'pa3000'
                                                    AND column_nbr = '3')
          GROUP  BY PJvYTDSummaryCury.Acct,
                    PJvYTDSummaryCury.Project
      END 
      

GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJvICprojYTDcury] TO [MSDSL]
    AS [dbo];

