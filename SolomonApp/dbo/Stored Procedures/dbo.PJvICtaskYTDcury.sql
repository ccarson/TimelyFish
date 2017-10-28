
CREATE PROC PJvICtaskYTDcury @ProjGet   AS VARCHAR(16),
                             @TaskGet   AS VARCHAR(32),
                             @PeriodGet AS VARCHAR(2),
                             @YearGet   AS VARCHAR(4)
AS
    DECLARE @rows AS BIGINT
    DECLARE @GLPeriods AS INT = (SELECT NbrPer FROM GLSetup)
    DECLARE @Decimal_Places AS INT = ( Select decpl from currncy where curyid = (select projcuryid from pjproj where project = @ProjGet ) )
    SELECT @rows = Count(*)
    FROM   PJvYTDSummaryCury
    WHERE  PJvYTDSummaryCury.Project = @ProjGet
           AND PJvYTDSummaryCury.pjt_entity = @TaskGet
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
          SELECT PJvYTDSummaryCury.Acct,
                 Round(PJvYTDSummaryCury.rate * 100, @Decimal_Places) 'Rate',
                 Round(PJvYTDSummaryCury.Beg_Amt, @Decimal_Places)    'Beg_Amt',
                 CASE @PeriodGet
                   WHEN '01' THEN Round(PJvYTDSummaryCury.amount_01, @Decimal_Places)
                   WHEN '02' THEN Round(PJvYTDSummaryCury.amount_02, @Decimal_Places)
                   WHEN '03' THEN Round(PJvYTDSummaryCury.amount_03, @Decimal_Places)
                   WHEN '04' THEN Round(PJvYTDSummaryCury.amount_04, @Decimal_Places)
                   WHEN '05' THEN Round(PJvYTDSummaryCury.amount_05, @Decimal_Places)
                   WHEN '06' THEN Round(PJvYTDSummaryCury.amount_06, @Decimal_Places)
                   WHEN '07' THEN Round(PJvYTDSummaryCury.amount_07, @Decimal_Places)
                   WHEN '08' THEN Round(PJvYTDSummaryCury.amount_08, @Decimal_Places)
                   WHEN '09' THEN Round(PJvYTDSummaryCury.amount_09, @Decimal_Places)
                   WHEN '10' THEN Round(PJvYTDSummaryCury.amount_10, @Decimal_Places)
                   WHEN '11' THEN Round(PJvYTDSummaryCury.amount_11, @Decimal_Places)
                   WHEN '12' THEN Round(PJvYTDSummaryCury.amount_12, @Decimal_Places)
                   WHEN '13' THEN Round(PJvYTDSummaryCury.amount_13, @Decimal_Places)
                   WHEN '14' THEN Round(PJvYTDSummaryCury.amount_14, @Decimal_Places)
                   WHEN '15' THEN Round(PJvYTDSummaryCury.amount_15, @Decimal_Places)
                   ELSE 0
                 END                                    'PTDAmount',
                 CASE @PeriodGet
                   WHEN '01' THEN Round(PJvYTDSummaryCury.amount_01, @Decimal_Places)
                   WHEN '02' THEN Round(PJvYTDSummaryCury.amount_01 + PJvYTDSummaryCury.amount_02, @Decimal_Places)
                   WHEN '03' THEN Round(PJvYTDSummaryCury.amount_01 + PJvYTDSummaryCury.amount_02 + PJvYTDSummaryCury.amount_03, @Decimal_Places)
                   WHEN '04' THEN Round(PJvYTDSummaryCury.amount_01 + PJvYTDSummaryCury.amount_02 + PJvYTDSummaryCury.amount_03 + PJvYTDSummaryCury.amount_04, @Decimal_Places)
                   WHEN '05' THEN Round(PJvYTDSummaryCury.amount_01 + PJvYTDSummaryCury.amount_02 + PJvYTDSummaryCury.amount_03 + PJvYTDSummaryCury.amount_04 + PJvYTDSummaryCury.amount_05, @Decimal_Places)
                   WHEN '06' THEN Round(PJvYTDSummaryCury.amount_01 + PJvYTDSummaryCury.amount_02 + PJvYTDSummaryCury.amount_03 + PJvYTDSummaryCury.amount_04 + PJvYTDSummaryCury.amount_05 + PJvYTDSummaryCury.amount_06, @Decimal_Places)
                   WHEN '07' THEN Round(PJvYTDSummaryCury.amount_01 + PJvYTDSummaryCury.amount_02 + PJvYTDSummaryCury.amount_03 + PJvYTDSummaryCury.amount_04 + PJvYTDSummaryCury.amount_05 + PJvYTDSummaryCury.amount_06 + PJvYTDSummaryCury.amount_07, @Decimal_Places)
                   WHEN '08' THEN Round(PJvYTDSummaryCury.amount_01 + PJvYTDSummaryCury.amount_02 + PJvYTDSummaryCury.amount_03 + PJvYTDSummaryCury.amount_04 + PJvYTDSummaryCury.amount_05 + PJvYTDSummaryCury.amount_06 + PJvYTDSummaryCury.amount_07 + PJvYTDSummaryCury.amount_08, @Decimal_Places)
                   WHEN '09' THEN Round(PJvYTDSummaryCury.amount_01 + PJvYTDSummaryCury.amount_02 + PJvYTDSummaryCury.amount_03 + PJvYTDSummaryCury.amount_04 + PJvYTDSummaryCury.amount_05 + PJvYTDSummaryCury.amount_06 + PJvYTDSummaryCury.amount_07 + PJvYTDSummaryCury.amount_08 + PJvYTDSummaryCury.amount_09, @Decimal_Places)
                   WHEN '10' THEN Round(PJvYTDSummaryCury.amount_01 + PJvYTDSummaryCury.amount_02 + PJvYTDSummaryCury.amount_03 + PJvYTDSummaryCury.amount_04 + PJvYTDSummaryCury.amount_05 + PJvYTDSummaryCury.amount_06 + PJvYTDSummaryCury.amount_07 + PJvYTDSummaryCury.amount_08 + PJvYTDSummaryCury.amount_09 + PJvYTDSummaryCury.amount_10, @Decimal_Places)
                   WHEN '11' THEN Round(PJvYTDSummaryCury.amount_01 + PJvYTDSummaryCury.amount_02 + PJvYTDSummaryCury.amount_03 + PJvYTDSummaryCury.amount_04 + PJvYTDSummaryCury.amount_05 + PJvYTDSummaryCury.amount_06 + PJvYTDSummaryCury.amount_07 + PJvYTDSummaryCury.amount_08 + PJvYTDSummaryCury.amount_09 + PJvYTDSummaryCury.amount_10 + PJvYTDSummaryCury.amount_11, @Decimal_Places)
                   WHEN '12' THEN Round(PJvYTDSummaryCury.amount_01 + PJvYTDSummaryCury.amount_02 + PJvYTDSummaryCury.amount_03 + PJvYTDSummaryCury.amount_04 + PJvYTDSummaryCury.amount_05 + PJvYTDSummaryCury.amount_06 + PJvYTDSummaryCury.amount_07 + PJvYTDSummaryCury.amount_08 + PJvYTDSummaryCury.amount_09 + PJvYTDSummaryCury.amount_10 + PJvYTDSummaryCury.amount_11 + PJvYTDSummaryCury.amount_12, @Decimal_Places)
                   WHEN '13' THEN Round(PJvYTDSummaryCury.amount_01 + PJvYTDSummaryCury.amount_02 + PJvYTDSummaryCury.amount_03 + PJvYTDSummaryCury.amount_04 + PJvYTDSummaryCury.amount_05 + PJvYTDSummaryCury.amount_06 + PJvYTDSummaryCury.amount_07 + PJvYTDSummaryCury.amount_08 + PJvYTDSummaryCury.amount_09 + PJvYTDSummaryCury.amount_10 + PJvYTDSummaryCury.amount_11 + PJvYTDSummaryCury.amount_12 + PJvYTDSummaryCury.amount_13, @Decimal_Places)
                   WHEN '14' THEN Round(PJvYTDSummaryCury.amount_01 + PJvYTDSummaryCury.amount_02 + PJvYTDSummaryCury.amount_03 + PJvYTDSummaryCury.amount_04 + PJvYTDSummaryCury.amount_05 + PJvYTDSummaryCury.amount_06 + PJvYTDSummaryCury.amount_07 + PJvYTDSummaryCury.amount_08 + PJvYTDSummaryCury.amount_09 + PJvYTDSummaryCury.amount_10 + PJvYTDSummaryCury.amount_11 + PJvYTDSummaryCury.amount_12 + PJvYTDSummaryCury.amount_13 + PJvYTDSummaryCury.amount_14, @Decimal_Places)
                   WHEN '15' THEN Round(PJvYTDSummaryCury.amount_01 + PJvYTDSummaryCury.amount_02 + PJvYTDSummaryCury.amount_03 + PJvYTDSummaryCury.amount_04 + PJvYTDSummaryCury.amount_05 + PJvYTDSummaryCury.amount_06 + PJvYTDSummaryCury.amount_07 + PJvYTDSummaryCury.amount_08 + PJvYTDSummaryCury.amount_09 + PJvYTDSummaryCury.amount_10 + PJvYTDSummaryCury.amount_11 + PJvYTDSummaryCury.amount_12 + PJvYTDSummaryCury.amount_13 + PJvYTDSummaryCury.amount_14 + PJvYTDSummaryCury.amount_15, @Decimal_Places)
                   ELSE 0
                 END                                    'YTDAmount',
                 CASE @periodget
                   WHEN '01' THEN Isnull(CASE @GLPeriods
                                           WHEN '01' THEN 0
                                           WHEN '02' THEN Round(PriorSummary.amount_01, @Decimal_Places)
                                           WHEN '03' THEN Round(PriorSummary.amount_02, @Decimal_Places)
                                           WHEN '04' THEN Round(PriorSummary.amount_03, @Decimal_Places)
                                           WHEN '05' THEN Round(PriorSummary.amount_04, @Decimal_Places)
                                           WHEN '06' THEN Round(PriorSummary.amount_05, @Decimal_Places)
                                           WHEN '07' THEN Round(PriorSummary.amount_06, @Decimal_Places)
                                           WHEN '08' THEN Round(PriorSummary.amount_07, @Decimal_Places)
                                           WHEN '09' THEN Round(PriorSummary.amount_08, @Decimal_Places)
                                           WHEN '10' THEN Round(PriorSummary.amount_09, @Decimal_Places)
                                           WHEN '11' THEN Round(PriorSummary.amount_10, @Decimal_Places)
                                           WHEN '12' THEN Round(PriorSummary.amount_11, @Decimal_Places)
                                           WHEN '13' THEN Round(PriorSummary.amount_12, @Decimal_Places)
                                           WHEN '14' THEN Round(PriorSummary.amount_13, @Decimal_Places)
                                           WHEN '15' THEN Round(PriorSummary.amount_14, @Decimal_Places)
                                           ELSE 0
                                         END, 0)
                   WHEN '02' THEN Isnull(CASE @GLPeriods
                                           WHEN '01' THEN Round(PriorSummary.amount_01, @Decimal_Places)
                                           WHEN '02' THEN Round(PriorSummary.amount_01, @Decimal_Places)
                                           WHEN '03' THEN Round(PriorSummary.amount_03, @Decimal_Places)
                                           WHEN '04' THEN Round(PriorSummary.amount_04, @Decimal_Places)
                                           WHEN '05' THEN Round(PriorSummary.amount_05, @Decimal_Places)
                                           WHEN '06' THEN Round(PriorSummary.amount_06, @Decimal_Places)
                                           WHEN '07' THEN Round(PriorSummary.amount_07, @Decimal_Places)
                                           WHEN '08' THEN Round(PriorSummary.amount_08, @Decimal_Places)
                                           WHEN '09' THEN Round(PriorSummary.amount_09, @Decimal_Places)
                                           WHEN '10' THEN Round(PriorSummary.amount_10, @Decimal_Places)
                                           WHEN '11' THEN Round(PriorSummary.amount_11, @Decimal_Places)
                                           WHEN '12' THEN Round(PriorSummary.amount_12, @Decimal_Places)
                                           WHEN '13' THEN Round(PriorSummary.amount_13, @Decimal_Places)
                                           WHEN '14' THEN Round(PriorSummary.amount_14, @Decimal_Places)
                                           WHEN '15' THEN Round(PriorSummary.amount_15, @Decimal_Places)
                                           ELSE 0
                                         END, 0)
                   WHEN '03' THEN Round(PJvYTDSummaryCury.amount_01, @Decimal_Places)
                   WHEN '04' THEN Round(PJvYTDSummaryCury.amount_02, @Decimal_Places)
                   WHEN '05' THEN Round(PJvYTDSummaryCury.amount_03, @Decimal_Places)
                   WHEN '06' THEN Round(PJvYTDSummaryCury.amount_04, @Decimal_Places)
                   WHEN '07' THEN Round(PJvYTDSummaryCury.amount_05, @Decimal_Places)
                   WHEN '08' THEN Round(PJvYTDSummaryCury.amount_06, @Decimal_Places)
                   WHEN '09' THEN Round(PJvYTDSummaryCury.amount_07, @Decimal_Places)
                   WHEN '10' THEN Round(PJvYTDSummaryCury.amount_08, @Decimal_Places)
                   WHEN '11' THEN Round(PJvYTDSummaryCury.amount_09, @Decimal_Places)
                   WHEN '12' THEN Round(PJvYTDSummaryCury.amount_10, @Decimal_Places)
                   WHEN '13' THEN Round(PJvYTDSummaryCury.amount_11, @Decimal_Places)
                   WHEN '14' THEN Round(PJvYTDSummaryCury.amount_12, @Decimal_Places)
                   WHEN '15' THEN Round(PJvYTDSummaryCury.amount_13, @Decimal_Places)
                   ELSE 0
                 END                                    'PriorPeriod2Amount',
                 CASE @periodget
                   WHEN '01' THEN Isnull(CASE @GLPeriods
                                           WHEN '01' THEN Round(PriorSummary.amount_01, @Decimal_Places)
                                           WHEN '02' THEN Round(PriorSummary.amount_01, @Decimal_Places)
                                           WHEN '03' THEN Round(PriorSummary.amount_03, @Decimal_Places)
                                           WHEN '04' THEN Round(PriorSummary.amount_04, @Decimal_Places)
                                           WHEN '05' THEN Round(PriorSummary.amount_05, @Decimal_Places)
                                           WHEN '06' THEN Round(PriorSummary.amount_06, @Decimal_Places)
                                           WHEN '07' THEN Round(PriorSummary.amount_07, @Decimal_Places)
                                           WHEN '08' THEN Round(PriorSummary.amount_08, @Decimal_Places)
                                           WHEN '09' THEN Round(PriorSummary.amount_09, @Decimal_Places)
                                           WHEN '10' THEN Round(PriorSummary.amount_10, @Decimal_Places)
                                           WHEN '11' THEN Round(PriorSummary.amount_11, @Decimal_Places)
                                           WHEN '12' THEN Round(PriorSummary.amount_12, @Decimal_Places)
                                           WHEN '13' THEN Round(PriorSummary.amount_13, @Decimal_Places)
                                           WHEN '14' THEN Round(PriorSummary.amount_14, @Decimal_Places)
                                           WHEN '15' THEN Round(PriorSummary.amount_15, @Decimal_Places)
                                           ELSE 0
                                         END, 0)
                   WHEN '02' THEN Round(PJvYTDSummaryCury.amount_01, @Decimal_Places)
                   WHEN '03' THEN Round(PJvYTDSummaryCury.amount_02, @Decimal_Places)
                   WHEN '04' THEN Round(PJvYTDSummaryCury.amount_03, @Decimal_Places)
                   WHEN '05' THEN Round(PJvYTDSummaryCury.amount_04, @Decimal_Places)
                   WHEN '06' THEN Round(PJvYTDSummaryCury.amount_05, @Decimal_Places)
                   WHEN '07' THEN Round(PJvYTDSummaryCury.amount_06, @Decimal_Places)
                   WHEN '08' THEN Round(PJvYTDSummaryCury.amount_07, @Decimal_Places)
                   WHEN '09' THEN Round(PJvYTDSummaryCury.amount_08, @Decimal_Places)
                   WHEN '10' THEN Round(PJvYTDSummaryCury.amount_09, @Decimal_Places)
                   WHEN '11' THEN Round(PJvYTDSummaryCury.amount_10, @Decimal_Places)
                   WHEN '12' THEN Round(PJvYTDSummaryCury.amount_11, @Decimal_Places)
                   WHEN '13' THEN Round(PJvYTDSummaryCury.amount_12, @Decimal_Places)
                   WHEN '14' THEN Round(PJvYTDSummaryCury.amount_13, @Decimal_Places)
                   WHEN '15' THEN Round(PJvYTDSummaryCury.amount_14, @Decimal_Places)
                   ELSE 0
                 END                                    'PriorPeriod1Amount',
                 Round(PJvYTDSummaryCury.EAC_Amt, @Decimal_Places)    'EAC_Amt',
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
                 AND PJvYTDSummaryCury.pjt_entity = @TaskGet
                 AND PJvYTDSummaryCury.Period = @PeriodGet
                 AND PJvYTDSummaryCury.Year = @YearGet
                 AND PJvYTDSummaryCury.Acct IN (SELECT acct
                                                FROM   PJREPCOL
                                                WHERE  report_code = 'pa3000'
                                                       AND column_nbr = '3')
      END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJvICtaskYTDcury] TO [MSDSL]
    AS [dbo];

