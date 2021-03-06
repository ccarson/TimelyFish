﻿
CREATE PROC PJvICprojPTDCury @ProjGet   AS VARCHAR(16),
                             @PeriodGet AS VARCHAR(2),
                             @YearGet   AS VARCHAR(4)
AS
    DECLARE @rows AS BIGINT
    DECLARE @Decimal_Places AS INT = ( Select decpl from currncy where curyid = (select projcuryid from pjproj where project = @ProjGet ) )
    DECLARE @GLPeriods AS INT = (SELECT NbrPer FROM GLSetup)
    SELECT @rows = Count(*)
    FROM   PJvPTDSummaryCury
    WHERE  PJvPTDSummaryCury.fsyear_num = @YearGet
           AND PJvPTDSummaryCury.project = @ProjGet
           AND PJvPTDSummaryCury.Acct IN (SELECT acct
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
          SELECT PJvPTDSummaryCury.Acct,
                 CASE @PeriodGet
                   WHEN '01' THEN Round(100 * Avg(PJvPTDSummaryCury.rate_01), @Decimal_Places)
                   WHEN '02' THEN Round(100 * Avg(PJvPTDSummaryCury.rate_02), @Decimal_Places)
                   WHEN '03' THEN Round(100 * Avg(PJvPTDSummaryCury.rate_03), @Decimal_Places)
                   WHEN '04' THEN Round(100 * Avg(PJvPTDSummaryCury.rate_04), @Decimal_Places)
                   WHEN '05' THEN Round(100 * Avg(PJvPTDSummaryCury.rate_05), @Decimal_Places)
                   WHEN '06' THEN Round(100 * Avg(PJvPTDSummaryCury.rate_06), @Decimal_Places)
                   WHEN '07' THEN Round(100 * Avg(PJvPTDSummaryCury.rate_07), @Decimal_Places)
                   WHEN '08' THEN Round(100 * Avg(PJvPTDSummaryCury.rate_08), @Decimal_Places)
                   WHEN '09' THEN Round(100 * Avg(PJvPTDSummaryCury.rate_09), @Decimal_Places)
                   WHEN '10' THEN Round(100 * Avg(PJvPTDSummaryCury.rate_10), @Decimal_Places)
                   WHEN '11' THEN Round(100 * Avg(PJvPTDSummaryCury.rate_11), @Decimal_Places)
                   WHEN '12' THEN Round(100 * Avg(PJvPTDSummaryCury.rate_12), @Decimal_Places)
                   WHEN '13' THEN Round(100 * Avg(PJvPTDSummaryCury.rate_13), @Decimal_Places)
                   WHEN '14' THEN Round(100 * Avg(PJvPTDSummaryCury.rate_14), @Decimal_Places)
                   WHEN '15' THEN Round(100 * Avg(PJvPTDSummaryCury.rate_15), @Decimal_Places)
                   ELSE 0
                 END                                      'Rate',
                 Round(Sum(PJvPTDSummaryCury.Beg_Amt), @Decimal_Places) 'Beg_Amt',
                 CASE @PeriodGet
                   WHEN '01' THEN Round(Sum(PJvPTDSummaryCury.amount_01), @Decimal_Places)
                   WHEN '02' THEN Round(Sum(PJvPTDSummaryCury.amount_02), @Decimal_Places)
                   WHEN '03' THEN Round(Sum(PJvPTDSummaryCury.amount_03), @Decimal_Places)
                   WHEN '04' THEN Round(Sum(PJvPTDSummaryCury.amount_04), @Decimal_Places)
                   WHEN '05' THEN Round(Sum(PJvPTDSummaryCury.amount_05), @Decimal_Places)
                   WHEN '06' THEN Round(Sum(PJvPTDSummaryCury.amount_06), @Decimal_Places)
                   WHEN '07' THEN Round(Sum(PJvPTDSummaryCury.amount_07), @Decimal_Places)
                   WHEN '08' THEN Round(Sum(PJvPTDSummaryCury.amount_08), @Decimal_Places)
                   WHEN '09' THEN Round(Sum(PJvPTDSummaryCury.amount_09), @Decimal_Places)
                   WHEN '10' THEN Round(Sum(PJvPTDSummaryCury.amount_10), @Decimal_Places)
                   WHEN '11' THEN Round(Sum(PJvPTDSummaryCury.amount_11), @Decimal_Places)
                   WHEN '12' THEN Round(Sum(PJvPTDSummaryCury.amount_12), @Decimal_Places)
                   WHEN '13' THEN Round(Sum(PJvPTDSummaryCury.amount_13), @Decimal_Places)
                   WHEN '14' THEN Round(Sum(PJvPTDSummaryCury.amount_14), @Decimal_Places)
                   WHEN '15' THEN Round(Sum(PJvPTDSummaryCury.amount_15), @Decimal_Places)
                   ELSE 0
                 END                                      'PTDAmount',
                 CASE @PeriodGet
                   WHEN '01' THEN Round(Sum(PJvPTDSummaryCury.amount_01), @Decimal_Places)
                   WHEN '02' THEN Round(Sum(PJvPTDSummaryCury.amount_01) + Sum(PJvPTDSummaryCury.amount_02), @Decimal_Places)
                   WHEN '03' THEN Round(Sum(PJvPTDSummaryCury.amount_01) + Sum(PJvPTDSummaryCury.amount_02) + Sum(PJvPTDSummaryCury.amount_03), @Decimal_Places)
                   WHEN '04' THEN Round(Sum(PJvPTDSummaryCury.amount_01) + Sum(PJvPTDSummaryCury.amount_02) + Sum(PJvPTDSummaryCury.amount_03) + Sum(PJvPTDSummaryCury.amount_04), @Decimal_Places)
                   WHEN '05' THEN Round(Sum(PJvPTDSummaryCury.amount_01) + Sum(PJvPTDSummaryCury.amount_02) + Sum(PJvPTDSummaryCury.amount_03) + Sum(PJvPTDSummaryCury.amount_04) + Sum(PJvPTDSummaryCury.amount_05), @Decimal_Places)
                   WHEN '06' THEN Round(Sum(PJvPTDSummaryCury.amount_01) + Sum(PJvPTDSummaryCury.amount_02) + Sum(PJvPTDSummaryCury.amount_03) + Sum(PJvPTDSummaryCury.amount_04) + Sum(PJvPTDSummaryCury.amount_05) + Sum(PJvPTDSummaryCury.amount_06), @Decimal_Places)
                   WHEN '07' THEN Round(Sum(PJvPTDSummaryCury.amount_01) + Sum(PJvPTDSummaryCury.amount_02) + Sum(PJvPTDSummaryCury.amount_03) + Sum(PJvPTDSummaryCury.amount_04) + Sum(PJvPTDSummaryCury.amount_05) + Sum(PJvPTDSummaryCury.amount_06) + Sum(PJvPTDSummaryCury.amount_07), @Decimal_Places)
                   WHEN '08' THEN Round(Sum(PJvPTDSummaryCury.amount_01) + Sum(PJvPTDSummaryCury.amount_02) + Sum(PJvPTDSummaryCury.amount_03) + Sum(PJvPTDSummaryCury.amount_04) + Sum(PJvPTDSummaryCury.amount_05) + Sum(PJvPTDSummaryCury.amount_06) + Sum(PJvPTDSummaryCury.amount_07) + Sum(PJvPTDSummaryCury.amount_08), @Decimal_Places)
                   WHEN '09' THEN Round(Sum(PJvPTDSummaryCury.amount_01) + Sum(PJvPTDSummaryCury.amount_02) + Sum(PJvPTDSummaryCury.amount_03) + Sum(PJvPTDSummaryCury.amount_04) + Sum(PJvPTDSummaryCury.amount_05) + Sum(PJvPTDSummaryCury.amount_06) + Sum(PJvPTDSummaryCury.amount_07) + Sum(PJvPTDSummaryCury.amount_08) + Sum(PJvPTDSummaryCury.amount_09), @Decimal_Places)
                   WHEN '10' THEN Round(Sum(PJvPTDSummaryCury.amount_01) + Sum(PJvPTDSummaryCury.amount_02) + Sum(PJvPTDSummaryCury.amount_03) + Sum(PJvPTDSummaryCury.amount_04) + Sum(PJvPTDSummaryCury.amount_05) + Sum(PJvPTDSummaryCury.amount_06) + Sum(PJvPTDSummaryCury.amount_07) + Sum(PJvPTDSummaryCury.amount_08) + Sum(PJvPTDSummaryCury.amount_09) + Sum(PJvPTDSummaryCury.amount_10), @Decimal_Places)
                   WHEN '11' THEN Round(Sum(PJvPTDSummaryCury.amount_01) + Sum(PJvPTDSummaryCury.amount_02) + Sum(PJvPTDSummaryCury.amount_03) + Sum(PJvPTDSummaryCury.amount_04) + Sum(PJvPTDSummaryCury.amount_05) + Sum(PJvPTDSummaryCury.amount_06) + Sum(PJvPTDSummaryCury.amount_07) + Sum(PJvPTDSummaryCury.amount_08) + Sum(PJvPTDSummaryCury.amount_09) + Sum(PJvPTDSummaryCury.amount_10) + Sum(PJvPTDSummaryCury.amount_11), @Decimal_Places)
                   WHEN '12' THEN Round(Sum(PJvPTDSummaryCury.amount_01) + Sum(PJvPTDSummaryCury.amount_02) + Sum(PJvPTDSummaryCury.amount_03) + Sum(PJvPTDSummaryCury.amount_04) + Sum(PJvPTDSummaryCury.amount_05) + Sum(PJvPTDSummaryCury.amount_06) + Sum(PJvPTDSummaryCury.amount_07) + Sum(PJvPTDSummaryCury.amount_08) + Sum(PJvPTDSummaryCury.amount_09) + Sum(PJvPTDSummaryCury.amount_10) + Sum(PJvPTDSummaryCury.amount_11) + Sum(PJvPTDSummaryCury.amount_12), @Decimal_Places)
                   WHEN '13' THEN Round(Sum(PJvPTDSummaryCury.amount_01) + Sum(PJvPTDSummaryCury.amount_02) + Sum(PJvPTDSummaryCury.amount_03) + Sum(PJvPTDSummaryCury.amount_04) + Sum(PJvPTDSummaryCury.amount_05) + Sum(PJvPTDSummaryCury.amount_06) + Sum(PJvPTDSummaryCury.amount_07) + Sum(PJvPTDSummaryCury.amount_08) + Sum(PJvPTDSummaryCury.amount_09) + Sum(PJvPTDSummaryCury.amount_10) + Sum(PJvPTDSummaryCury.amount_11) + Sum(PJvPTDSummaryCury.amount_12) + Sum(PJvPTDSummaryCury.amount_13), @Decimal_Places)
                   WHEN '14' THEN Round(Sum(PJvPTDSummaryCury.amount_01) + Sum(PJvPTDSummaryCury.amount_02) + Sum(PJvPTDSummaryCury.amount_03) + Sum(PJvPTDSummaryCury.amount_04) + Sum(PJvPTDSummaryCury.amount_05) + Sum(PJvPTDSummaryCury.amount_06) + Sum(PJvPTDSummaryCury.amount_07) + Sum(PJvPTDSummaryCury.amount_08) + Sum(PJvPTDSummaryCury.amount_09) + Sum(PJvPTDSummaryCury.amount_10) + Sum(PJvPTDSummaryCury.amount_11) + Sum(PJvPTDSummaryCury.amount_12) + Sum(PJvPTDSummaryCury.amount_13) + Sum(PJvPTDSummaryCury.amount_14), @Decimal_Places)
                   WHEN '15' THEN Round(Sum(PJvPTDSummaryCury.amount_01) + Sum(PJvPTDSummaryCury.amount_02) + Sum(PJvPTDSummaryCury.amount_03) + Sum(PJvPTDSummaryCury.amount_04) + Sum(PJvPTDSummaryCury.amount_05) + Sum(PJvPTDSummaryCury.amount_06) + Sum(PJvPTDSummaryCury.amount_07) + Sum(PJvPTDSummaryCury.amount_08) + Sum(PJvPTDSummaryCury.amount_09) + Sum(PJvPTDSummaryCury.amount_10) + Sum(PJvPTDSummaryCury.amount_11) + Sum(PJvPTDSummaryCury.amount_12) + Sum(PJvPTDSummaryCury.amount_13) + Sum(PJvPTDSummaryCury.amount_14) + Sum(PJvPTDSummaryCury.amount_15), @Decimal_Places)
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
                   WHEN '03' THEN Round(Sum(PJvPTDSummaryCury.amount_01), @Decimal_Places)
                   WHEN '04' THEN Round(Sum(PJvPTDSummaryCury.amount_02), @Decimal_Places)
                   WHEN '05' THEN Round(Sum(PJvPTDSummaryCury.amount_03), @Decimal_Places)
                   WHEN '06' THEN Round(Sum(PJvPTDSummaryCury.amount_04), @Decimal_Places)
                   WHEN '07' THEN Round(Sum(PJvPTDSummaryCury.amount_05), @Decimal_Places)
                   WHEN '08' THEN Round(Sum(PJvPTDSummaryCury.amount_06), @Decimal_Places)
                   WHEN '09' THEN Round(Sum(PJvPTDSummaryCury.amount_07), @Decimal_Places)
                   WHEN '10' THEN Round(Sum(PJvPTDSummaryCury.amount_08), @Decimal_Places)
                   WHEN '11' THEN Round(Sum(PJvPTDSummaryCury.amount_09), @Decimal_Places)
                   WHEN '12' THEN Round(Sum(PJvPTDSummaryCury.amount_10), @Decimal_Places)
                   WHEN '13' THEN Round(Sum(PJvPTDSummaryCury.amount_11), @Decimal_Places)
                   WHEN '14' THEN Round(Sum(PJvPTDSummaryCury.amount_12), @Decimal_Places)
                   WHEN '15' THEN Round(Sum(PJvPTDSummaryCury.amount_13), @Decimal_Places)
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
                   WHEN '02' THEN Round(Sum(PJvPTDSummaryCury.amount_01), @Decimal_Places)
                   WHEN '03' THEN Round(Sum(PJvPTDSummaryCury.amount_02), @Decimal_Places)
                   WHEN '04' THEN Round(Sum(PJvPTDSummaryCury.amount_03), @Decimal_Places)
                   WHEN '05' THEN Round(Sum(PJvPTDSummaryCury.amount_04), @Decimal_Places)
                   WHEN '06' THEN Round(Sum(PJvPTDSummaryCury.amount_05), @Decimal_Places)
                   WHEN '07' THEN Round(Sum(PJvPTDSummaryCury.amount_06), @Decimal_Places)
                   WHEN '08' THEN Round(Sum(PJvPTDSummaryCury.amount_07), @Decimal_Places)
                   WHEN '09' THEN Round(Sum(PJvPTDSummaryCury.amount_08), @Decimal_Places)
                   WHEN '10' THEN Round(Sum(PJvPTDSummaryCury.amount_09), @Decimal_Places)
                   WHEN '11' THEN Round(Sum(PJvPTDSummaryCury.amount_10), @Decimal_Places)
                   WHEN '12' THEN Round(Sum(PJvPTDSummaryCury.amount_11), @Decimal_Places)
                   WHEN '13' THEN Round(Sum(PJvPTDSummaryCury.amount_12), @Decimal_Places)
                   WHEN '14' THEN Round(Sum(PJvPTDSummaryCury.amount_13), @Decimal_Places)
                   WHEN '15' THEN Round(Sum(PJvPTDSummaryCury.amount_14), @Decimal_Places)
                   ELSE 0
                 END                                      'PriorPeriod1Amount',
                 Round(Sum(PJvPTDSummaryCury.EAC_Amt), @Decimal_Places) 'EAC_Amt',
                 @Decimal_Places AS DecPL
          FROM   PJvPTDSummaryCury
                 LEFT JOIN PJvPTDSummaryCury PriorSummary
                   ON @PeriodGet < '03'
                      --and PriorSummary.period = CONVERT(char(2), @GLPeriods)  
                      AND PriorSummary.fsyear_num = CONVERT(CHAR(4), CONVERT(INT, @YearGet) - 1)
                      AND PriorSummary.project = PJvPTDSummaryCury.project
                      AND PriorSummary.pjt_entity = PJvPTDSummaryCury.pjt_entity
                      AND PriorSummary.acct = PJvPTDSummaryCury.acct
          WHERE  PJvPTDSummaryCury.fsyear_num = @YearGet
                 AND PJvPTDSummaryCury.project = @ProjGet
                 AND PJvPTDSummaryCury.Acct IN (SELECT acct
                                                FROM   PJREPCOL
                                                WHERE  report_code = 'pa3000'
                                                       AND column_nbr = '3')
          GROUP  BY PJvPTDSummaryCury.Acct,
                    PJvPTDSummaryCury.project
      END 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJvICprojPTDCury] TO [MSDSL]
    AS [dbo];

