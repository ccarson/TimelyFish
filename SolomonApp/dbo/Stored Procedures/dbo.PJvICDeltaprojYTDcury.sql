
CREATE PROC PJvICDeltaprojYTDcury @ProjGet   AS VARCHAR(16),
                                  @PeriodGet AS VARCHAR(2),
                                  @YearGet   AS VARCHAR(4)
AS
    DECLARE @rows AS BIGINT
    DECLARE @Decimal_Places AS INT = ( Select decpl from currncy where curyid = (select projcuryid from pjproj where project = @ProjGet ) )
    DECLARE @GLPeriods AS INT = (SELECT NbrPer FROM GLSetup)
    SELECT @rows = Count(*)
    FROM   PJvYTDDeltaSummaryCury
    WHERE  PJvYTDDeltaSummaryCury.Project = @ProjGet
           --AND PJvYTDDeltaSummaryCury.Period = @PeriodGet  
           AND PJvYTDDeltaSummaryCury.fsyear_num = @YearGet
           AND PJvYTDDeltaSummaryCury.Acct IN (SELECT acct
                                               FROM   PJREPCOL
                                               WHERE  report_code = 'pa3000'
                                                      AND column_nbr = '3')

    IF @rows = 0
      BEGIN
          SELECT '------NONE------' 'Acct',
                 0.00               'Rate',
                 0.00               'Beg_Amt',
                 0.00               'PTDDelta',
                 0.00               'YTDAmount',
                 0.00               'PriorPeriod2Delta',
                 0.00               'PriorPeriod1Delta',
                 0.00               'EAC_Amt',
                 0.00               'DecPL'
      END
    ELSE
      BEGIN
          SELECT PJvYTDDeltaSummaryCury.Acct                   'Acct',
                 CASE @PeriodGet
                   WHEN '01' THEN Round(100 * Avg(PJvYTDDeltaSummaryCury.rate_01), @Decimal_Places)
                   WHEN '02' THEN Round(100 * Avg(PJvYTDDeltaSummaryCury.rate_02), @Decimal_Places)
                   WHEN '03' THEN Round(100 * Avg(PJvYTDDeltaSummaryCury.rate_03), @Decimal_Places)
                   WHEN '04' THEN Round(100 * Avg(PJvYTDDeltaSummaryCury.rate_04), @Decimal_Places)
                   WHEN '05' THEN Round(100 * Avg(PJvYTDDeltaSummaryCury.rate_05), @Decimal_Places)
                   WHEN '06' THEN Round(100 * Avg(PJvYTDDeltaSummaryCury.rate_06), @Decimal_Places)
                   WHEN '07' THEN Round(100 * Avg(PJvYTDDeltaSummaryCury.rate_07), @Decimal_Places)
                   WHEN '08' THEN Round(100 * Avg(PJvYTDDeltaSummaryCury.rate_08), @Decimal_Places)
                   WHEN '09' THEN Round(100 * Avg(PJvYTDDeltaSummaryCury.rate_09), @Decimal_Places)
                   WHEN '10' THEN Round(100 * Avg(PJvYTDDeltaSummaryCury.rate_10), @Decimal_Places)
                   WHEN '11' THEN Round(100 * Avg(PJvYTDDeltaSummaryCury.rate_11), @Decimal_Places)
                   WHEN '12' THEN Round(100 * Avg(PJvYTDDeltaSummaryCury.rate_12), @Decimal_Places)
                   WHEN '13' THEN Round(100 * Avg(PJvYTDDeltaSummaryCury.rate_13), @Decimal_Places)
                   WHEN '14' THEN Round(100 * Avg(PJvYTDDeltaSummaryCury.rate_14), @Decimal_Places)
                   WHEN '15' THEN Round(100 * Avg(PJvYTDDeltaSummaryCury.rate_15), @Decimal_Places)
                   ELSE 0
                 END                                           'rate',
                 Round(Sum(PJvYTDDeltaSummaryCury.BegAmt), @Decimal_Places)  'Beg_Amt',
                 CASE @PeriodGet
                   WHEN '01' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_01), @Decimal_Places)
                   WHEN '02' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_02), @Decimal_Places)
                   WHEN '03' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_03), @Decimal_Places)
                   WHEN '04' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_04), @Decimal_Places)
                   WHEN '05' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_05), @Decimal_Places)
                   WHEN '06' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_06), @Decimal_Places)
                   WHEN '07' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_07), @Decimal_Places)
                   WHEN '08' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_08), @Decimal_Places)
                   WHEN '09' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_09), @Decimal_Places)
                   WHEN '10' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_10), @Decimal_Places)
                   WHEN '11' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_11), @Decimal_Places)
                   WHEN '12' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_12), @Decimal_Places)
                   WHEN '13' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_13), @Decimal_Places)
                   WHEN '14' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_14), @Decimal_Places)
                   WHEN '15' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_15), @Decimal_Places)
                   ELSE 0
                 END                                           'PTDDelta',
                 CASE @PeriodGet
                   WHEN '01' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_01), @Decimal_Places)
                   WHEN '02' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_01) + Sum(PJvYTDDeltaSummaryCury.amount_02), @Decimal_Places)
                   WHEN '03' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_01) + Sum(PJvYTDDeltaSummaryCury.amount_02) + Sum(PJvYTDDeltaSummaryCury.amount_03), @Decimal_Places)
                   WHEN '04' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_01) + Sum(PJvYTDDeltaSummaryCury.amount_02) + Sum(PJvYTDDeltaSummaryCury.amount_03) + Sum(PJvYTDDeltaSummaryCury.amount_04), @Decimal_Places)
                   WHEN '05' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_01) + Sum(PJvYTDDeltaSummaryCury.amount_02) + Sum(PJvYTDDeltaSummaryCury.amount_03) + Sum(PJvYTDDeltaSummaryCury.amount_04) + Sum(PJvYTDDeltaSummaryCury.amount_05), @Decimal_Places)
                   WHEN '06' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_01) + Sum(PJvYTDDeltaSummaryCury.amount_02) + Sum(PJvYTDDeltaSummaryCury.amount_03) + Sum(PJvYTDDeltaSummaryCury.amount_04) + Sum(PJvYTDDeltaSummaryCury.amount_05) + Sum(PJvYTDDeltaSummaryCury.amount_06), @Decimal_Places)
                   WHEN '07' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_01) + Sum(PJvYTDDeltaSummaryCury.amount_02) + Sum(PJvYTDDeltaSummaryCury.amount_03) + Sum(PJvYTDDeltaSummaryCury.amount_04) + Sum(PJvYTDDeltaSummaryCury.amount_05) + Sum(PJvYTDDeltaSummaryCury.amount_06) + Sum(PJvYTDDeltaSummaryCury.amount_07), @Decimal_Places)
                   WHEN '08' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_01) + Sum(PJvYTDDeltaSummaryCury.amount_02) + Sum(PJvYTDDeltaSummaryCury.amount_03) + Sum(PJvYTDDeltaSummaryCury.amount_04) + Sum(PJvYTDDeltaSummaryCury.amount_05) + Sum(PJvYTDDeltaSummaryCury.amount_06) + Sum(PJvYTDDeltaSummaryCury.amount_07) + Sum(PJvYTDDeltaSummaryCury.amount_08), @Decimal_Places)
                   WHEN '09' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_01) + Sum(PJvYTDDeltaSummaryCury.amount_02) + Sum(PJvYTDDeltaSummaryCury.amount_03) + Sum(PJvYTDDeltaSummaryCury.amount_04) + Sum(PJvYTDDeltaSummaryCury.amount_05) + Sum(PJvYTDDeltaSummaryCury.amount_06) + Sum(PJvYTDDeltaSummaryCury.amount_07) + Sum(PJvYTDDeltaSummaryCury.amount_08) + Sum(PJvYTDDeltaSummaryCury.amount_09), @Decimal_Places)
                   WHEN '10' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_01) + Sum(PJvYTDDeltaSummaryCury.amount_02) + Sum(PJvYTDDeltaSummaryCury.amount_03) + Sum(PJvYTDDeltaSummaryCury.amount_04) + Sum(PJvYTDDeltaSummaryCury.amount_05) + Sum(PJvYTDDeltaSummaryCury.amount_06) + Sum(PJvYTDDeltaSummaryCury.amount_07) + Sum(PJvYTDDeltaSummaryCury.amount_08) + Sum(PJvYTDDeltaSummaryCury.amount_09) + Sum(PJvYTDDeltaSummaryCury.amount_10), @Decimal_Places)
                   WHEN '11' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_01) + Sum(PJvYTDDeltaSummaryCury.amount_02) + Sum(PJvYTDDeltaSummaryCury.amount_03) + Sum(PJvYTDDeltaSummaryCury.amount_04) + Sum(PJvYTDDeltaSummaryCury.amount_05) + Sum(PJvYTDDeltaSummaryCury.amount_06) + Sum(PJvYTDDeltaSummaryCury.amount_07) + Sum(PJvYTDDeltaSummaryCury.amount_08) + Sum(PJvYTDDeltaSummaryCury.amount_09) + Sum(PJvYTDDeltaSummaryCury.amount_10) + Sum(PJvYTDDeltaSummaryCury.amount_11), @Decimal_Places)
                   WHEN '12' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_01) + Sum(PJvYTDDeltaSummaryCury.amount_02) + Sum(PJvYTDDeltaSummaryCury.amount_03) + Sum(PJvYTDDeltaSummaryCury.amount_04) + Sum(PJvYTDDeltaSummaryCury.amount_05) + Sum(PJvYTDDeltaSummaryCury.amount_06) + Sum(PJvYTDDeltaSummaryCury.amount_07) + Sum(PJvYTDDeltaSummaryCury.amount_08) + Sum(PJvYTDDeltaSummaryCury.amount_09) + Sum(PJvYTDDeltaSummaryCury.amount_10) + Sum(PJvYTDDeltaSummaryCury.amount_11) + Sum(PJvYTDDeltaSummaryCury.amount_12), @Decimal_Places)
                   WHEN '13' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_01) + Sum(PJvYTDDeltaSummaryCury.amount_02) + Sum(PJvYTDDeltaSummaryCury.amount_03) + Sum(PJvYTDDeltaSummaryCury.amount_04) + Sum(PJvYTDDeltaSummaryCury.amount_05) + Sum(PJvYTDDeltaSummaryCury.amount_06) + Sum(PJvYTDDeltaSummaryCury.amount_07) + Sum(PJvYTDDeltaSummaryCury.amount_08) + Sum(PJvYTDDeltaSummaryCury.amount_09) + Sum(PJvYTDDeltaSummaryCury.amount_10) + Sum(PJvYTDDeltaSummaryCury.amount_11) + Sum(PJvYTDDeltaSummaryCury.amount_12) + Sum(PJvYTDDeltaSummaryCury.amount_13), @Decimal_Places)
                   WHEN '14' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_01) + Sum(PJvYTDDeltaSummaryCury.amount_02) + Sum(PJvYTDDeltaSummaryCury.amount_03) + Sum(PJvYTDDeltaSummaryCury.amount_04) + Sum(PJvYTDDeltaSummaryCury.amount_05) + Sum(PJvYTDDeltaSummaryCury.amount_06) + Sum(PJvYTDDeltaSummaryCury.amount_07) + Sum(PJvYTDDeltaSummaryCury.amount_08) + Sum(PJvYTDDeltaSummaryCury.amount_09) + Sum(PJvYTDDeltaSummaryCury.amount_10) + Sum(PJvYTDDeltaSummaryCury.amount_11) + Sum(PJvYTDDeltaSummaryCury.amount_12) + Sum(PJvYTDDeltaSummaryCury.amount_13) + Sum(PJvYTDDeltaSummaryCury.amount_14), @Decimal_Places)
                   WHEN '15' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_01) + Sum(PJvYTDDeltaSummaryCury.amount_02) + Sum(PJvYTDDeltaSummaryCury.amount_03) + Sum(PJvYTDDeltaSummaryCury.amount_04) + Sum(PJvYTDDeltaSummaryCury.amount_05) + Sum(PJvYTDDeltaSummaryCury.amount_06) + Sum(PJvYTDDeltaSummaryCury.amount_07) + Sum(PJvYTDDeltaSummaryCury.amount_08) + Sum(PJvYTDDeltaSummaryCury.amount_09) + Sum(PJvYTDDeltaSummaryCury.amount_10) + Sum(PJvYTDDeltaSummaryCury.amount_11) + Sum(PJvYTDDeltaSummaryCury.amount_12) + Sum(PJvYTDDeltaSummaryCury.amount_13) + Sum(PJvYTDDeltaSummaryCury.amount_14) + Sum(PJvYTDDeltaSummaryCury.amount_15), @Decimal_Places)
                   ELSE 0
                 END                                           'YTDAmount',
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
                   WHEN '03' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_01), @Decimal_Places)
                   WHEN '04' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_02), @Decimal_Places)
                   WHEN '05' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_03), @Decimal_Places)
                   WHEN '06' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_04), @Decimal_Places)
                   WHEN '07' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_05), @Decimal_Places)
                   WHEN '08' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_06), @Decimal_Places)
                   WHEN '09' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_07), @Decimal_Places)
                   WHEN '10' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_08), @Decimal_Places)
                   WHEN '11' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_09), @Decimal_Places)
                   WHEN '12' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_10), @Decimal_Places)
                   WHEN '13' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_11), @Decimal_Places)
                   WHEN '14' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_12), @Decimal_Places)
                   WHEN '15' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_13), @Decimal_Places)
                   ELSE 0
                 END                                           'PriorPeriod2Delta',
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
                   WHEN '02' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_01), @Decimal_Places)
                   WHEN '03' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_02), @Decimal_Places)
                   WHEN '04' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_03), @Decimal_Places)
                   WHEN '05' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_04), @Decimal_Places)
                   WHEN '06' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_05), @Decimal_Places)
                   WHEN '07' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_06), @Decimal_Places)
                   WHEN '08' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_07), @Decimal_Places)
                   WHEN '09' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_08), @Decimal_Places)
                   WHEN '10' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_09), @Decimal_Places)
                   WHEN '11' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_10), @Decimal_Places)
                   WHEN '12' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_11), @Decimal_Places)
                   WHEN '13' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_12), @Decimal_Places)
                   WHEN '14' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_13), @Decimal_Places)
                   WHEN '15' THEN Round(Sum(PJvYTDDeltaSummaryCury.amount_14), @Decimal_Places)
                   ELSE 0
                 END                                           'PriorPeriod1Delta',
                 Round(Sum(PJvYTDDeltaSummaryCury.EAC_Amt), @Decimal_Places) 'EAC_Amt',
                 @Decimal_Places AS DecPL
          FROM   PJvYTDDeltaSummaryCury
                 LEFT JOIN PJvYTDDeltaSummaryCury PriorSummary
                   ON @PeriodGet < '03'
                      --and PriorSummary.period = CONVERT(char(2), @GLPeriods)  
                      AND PriorSummary.fsyear_num = CONVERT(CHAR(4), CONVERT(INT, @YearGet) - 1)
                      AND PriorSummary.project = PJvYTDDeltaSummaryCury.project
                      AND PriorSummary.pjt_entity = PJvYTDDeltaSummaryCury.pjt_entity
                      AND PriorSummary.acct = PJvYTDDeltaSummaryCury.acct
          WHERE  PJvYTDDeltaSummaryCury.Project = @ProjGet
                 --and PJvYTDDeltaSummaryCury.pjt_entity = 'T01'  
                 -- AND PJvYTDDeltaSummaryCury.Period = @PeriodGet  
                 AND PJvYTDDeltaSummaryCury.fsyear_num = @YearGet
                 AND PJvYTDDeltaSummaryCury.Acct IN (SELECT acct
                                                     FROM   PJREPCOL
                                                     WHERE  report_code = 'pa3000'
                                                            AND column_nbr = '3')
          GROUP  BY PJvYTDDeltaSummaryCury.Acct,
                    PJvYTDDeltaSummaryCury.Project
      END 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJvICDeltaprojYTDcury] TO [MSDSL]
    AS [dbo];

