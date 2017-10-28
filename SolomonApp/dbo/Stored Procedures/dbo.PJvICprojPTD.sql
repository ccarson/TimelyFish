
CREATE PROC [PJvICprojPTD] @ProjGet   AS VARCHAR(16),
                           @PeriodGet AS VARCHAR(2),
                           @YearGet   AS VARCHAR(4)
AS
    DECLARE @rows AS BIGINT
	declare @GLPeriods as int = (select NbrPer from GLSetup)
	
    SELECT @rows = Count(*)
    FROM   PJvPTDSummary
    WHERE  PJvPTDSummary.fsyear_num = @YearGet
           AND PJvPTDSummary.project = @ProjGet
           AND PJvPTDSummary.Acct IN (SELECT acct
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
                 0.00				'PriorPeriod2Amount',
                 0.00				'PriorPeriod1Amount',
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
                                         case @periodget
           when '01' then isnull(case @GLPeriods
                                     when '01' then 0
                                     when '02' then round(Sum(PriorSummary.amount_01), 2)
                                     when '03' then round(Sum(PriorSummary.amount_02), 2)
                                     when '04' then round(Sum(PriorSummary.amount_03), 2)
                                     when '05' then round(Sum(PriorSummary.amount_04), 2)
                                     when '06' then round(Sum(PriorSummary.amount_05), 2)
                                     when '07' then round(Sum(PriorSummary.amount_06), 2)
                                     when '08' then round(Sum(PriorSummary.amount_07), 2)
                                     when '09' then round(Sum(PriorSummary.amount_08), 2)
                                     when '10' then round(Sum(PriorSummary.amount_09), 2)
                                     when '11' then round(Sum(PriorSummary.amount_10), 2)
                                     when '12' then round(Sum(PriorSummary.amount_11), 2)
                                     when '13' then round(Sum(PriorSummary.amount_12), 2)
                                     when '14' then round(Sum(PriorSummary.amount_13), 2)
                                     when '15' then round(Sum(PriorSummary.amount_14), 2)
                                     else 0
                                  end, 0)
           when '02' then isnull(case @GLPeriods
                                     when '01' then Round(Sum(PriorSummary.amount_01),2)
                                     when '02' then Round(Sum(PriorSummary.amount_01),2)
                                     when '03' then Round(Sum(PriorSummary.amount_03),2)
                                     when '04' then Round(Sum(PriorSummary.amount_04),2)
                                     when '05' then Round(Sum(PriorSummary.amount_05),2)
                                     when '06' then Round(Sum(PriorSummary.amount_06),2)
                                     when '07' then Round(Sum(PriorSummary.amount_07),2)
                                     when '08' then Round(Sum(PriorSummary.amount_08),2)
                                     when '09' then Round(Sum(PriorSummary.amount_09),2)
                                     when '10' then Round(Sum(PriorSummary.amount_10),2)
                                     when '11' then Round(Sum(PriorSummary.amount_11),2)
                                     when '12' then Round(Sum(PriorSummary.amount_12),2)
                                     when '13' then Round(Sum(PriorSummary.amount_13),2)
                                     when '14' then Round(Sum(PriorSummary.amount_14),2)
                                     when '15' then Round(Sum(PriorSummary.amount_15),2)
                                     else 0
                                 end, 0)
           when '03' then round(Sum(PJvPTDSummary.amount_01),2)
           when '04' then round(Sum(PJvPTDSummary.amount_02),2)
           when '05' then round(Sum(PJvPTDSummary.amount_03),2)
           when '06' then round(Sum(PJvPTDSummary.amount_04),2)
           when '07' then round(Sum(PJvPTDSummary.amount_05),2)
           when '08' then round(Sum(PJvPTDSummary.amount_06),2)
           when '09' then round(Sum(PJvPTDSummary.amount_07),2)
           when '10' then round(Sum(PJvPTDSummary.amount_08),2)
           when '11' then round(Sum(PJvPTDSummary.amount_09),2)
           when '12' then round(Sum(PJvPTDSummary.amount_10),2)
           when '13' then round(Sum(PJvPTDSummary.amount_11),2)
           when '14' then round(Sum(PJvPTDSummary.amount_12),2)
           when '15' then round(Sum(PJvPTDSummary.amount_13),2)
           else 0
       end  'PriorPeriod2Amount',
       case @periodget
           when '01' then isnull(case @GLPeriods
                                     when '01' then round(sum(PriorSummary.amount_01),2)
                                     when '02' then round(sum(PriorSummary.amount_01),2)
                                     when '03' then round(sum(PriorSummary.amount_03),2)
                                     when '04' then round(sum(PriorSummary.amount_04),2)
                                     when '05' then round(sum(PriorSummary.amount_05),2)
                                     when '06' then round(sum(PriorSummary.amount_06),2)
                                     when '07' then round(sum(PriorSummary.amount_07),2)
                                     when '08' then round(sum(PriorSummary.amount_08),2)
                                     when '09' then round(sum(PriorSummary.amount_09),2)
                                     when '10' then round(sum(PriorSummary.amount_10),2)
                                     when '11' then round(sum(PriorSummary.amount_11),2)
                                     when '12' then round(sum(PriorSummary.amount_12),2)
                                     when '13' then round(sum(PriorSummary.amount_13),2)
                                     when '14' then round(sum(PriorSummary.amount_14),2)
                                     when '15' then round(sum(PriorSummary.amount_15),2)
                                     else 0
                                 end, 0)
           when '02' then round(sum(PJvPTDSummary.amount_01),2)
           when '03' then round(sum(PJvPTDSummary.amount_02),2)
           when '04' then round(sum(PJvPTDSummary.amount_03),2)
           when '05' then round(sum(PJvPTDSummary.amount_04),2)
           when '06' then round(sum(PJvPTDSummary.amount_05),2)
           when '07' then round(sum(PJvPTDSummary.amount_06),2)
           when '08' then round(sum(PJvPTDSummary.amount_07),2)
           when '09' then round(sum(PJvPTDSummary.amount_08),2)
           when '10' then round(sum(PJvPTDSummary.amount_09),2)
           when '11' then round(sum(PJvPTDSummary.amount_10),2)
           when '12' then round(sum(PJvPTDSummary.amount_11),2)
           when '13' then round(sum(PJvPTDSummary.amount_12),2)
           when '14' then round(sum(PJvPTDSummary.amount_13),2)
           when '15' then round(sum(PJvPTDSummary.amount_14),2)
           else 0
       end  'PriorPeriod1Amount',
                 Round(Sum(PJvPTDSummary.EAC_Amt), 2) 'EAC_Amt'
          FROM   PJvPTDSummary Left Join PJvPTDSummary PriorSummary on @PeriodGet < '03'
    --and PriorSummary.period = CONVERT(char(2), @GLPeriods)
   and PriorSummary.fsyear_num = CONVERT(char(4), CONVERT(int, @YearGet) - 1)
    and PriorSummary.project = PJvPTDSummary.project
    and PriorSummary.pjt_entity = PJvPTDSummary.pjt_entity
    and PriorSummary.acct = PJvPTDSummary.acct
          WHERE  PJvPTDSummary.fsyear_num = @YearGet
                 AND PJvPTDSummary.project = @ProjGet
                 AND PJvPTDSummary.Acct IN (SELECT acct
                                            FROM   PJREPCOL
                                            WHERE  report_code = 'pa3000'
                                                   AND column_nbr = '3')
          GROUP  BY PJvPTDSummary.Acct,
                    PJvPTDSummary.project
      END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJvICprojPTD] TO [MSDSL]
    AS [dbo];

