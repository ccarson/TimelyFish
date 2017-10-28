

CREATE PROC PJvICDeltaprojYTD @ProjGet   AS VARCHAR(16),
                         @PeriodGet AS VARCHAR(2),
                         @YearGet   AS VARCHAR(4)
AS
    DECLARE @rows AS BIGINT
	declare @GLPeriods as int = (select NbrPer from GLSetup)    
    
    SELECT @rows = Count(*)
    FROM   PJvYTDDeltaSummary
    WHERE  PJvYTDDeltaSummary.Project = @ProjGet
           --AND PJvYTDDeltaSummary.Period = @PeriodGet
           AND PJvYTDDeltaSummary.fsyear_num = @YearGet
           AND PJvYTDDeltaSummary.Acct IN (SELECT acct
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
                 0.00				'PriorPeriod2Delta',
                 0.00				'PriorPeriod1Delta',
                 0.00               'EAC_Amt'
      END
    ELSE
      BEGIN
          SELECT PJvYTDDeltaSummary.Acct                      'Acct',
                  CASE @PeriodGet
                   WHEN '01' THEN Round(100 * Avg(PJvYTDDeltaSummary.rate_01), 2)
                   WHEN '02' THEN Round(100 * Avg(PJvYTDDeltaSummary.rate_02), 2)
                   WHEN '03' THEN Round(100 * Avg(PJvYTDDeltaSummary.rate_03), 2)
                   WHEN '04' THEN Round(100 * Avg(PJvYTDDeltaSummary.rate_04), 2)
                   WHEN '05' THEN Round(100 * Avg(PJvYTDDeltaSummary.rate_05), 2)
                   WHEN '06' THEN Round(100 * Avg(PJvYTDDeltaSummary.rate_06), 2)
                   WHEN '07' THEN Round(100 * Avg(PJvYTDDeltaSummary.rate_07), 2)
                   WHEN '08' THEN Round(100 * Avg(PJvYTDDeltaSummary.rate_08), 2)
                   WHEN '09' THEN Round(100 * Avg(PJvYTDDeltaSummary.rate_09), 2)
                   WHEN '10' THEN Round(100 * Avg(PJvYTDDeltaSummary.rate_10), 2)
                   WHEN '11' THEN Round(100 * Avg(PJvYTDDeltaSummary.rate_11), 2)
                   WHEN '12' THEN Round(100 * Avg(PJvYTDDeltaSummary.rate_12), 2)
                   WHEN '13' THEN Round(100 * Avg(PJvYTDDeltaSummary.rate_13), 2)
                   WHEN '14' THEN Round(100 * Avg(PJvYTDDeltaSummary.rate_14), 2)
                   WHEN '15' THEN Round(100 * Avg(PJvYTDDeltaSummary.rate_15), 2)
                   ELSE 0   
                   end 'rate' ,
                 Round(Sum(PJvYTDDeltaSummary.BegAmt), 2)    'Beg_Amt',
                 CASE @PeriodGet
                   WHEN '01' THEN Round(Sum(PJvYTDDeltaSummary.amount_01), 2)
                   WHEN '02' THEN Round(Sum(PJvYTDDeltaSummary.amount_02), 2)
                   WHEN '03' THEN Round(Sum(PJvYTDDeltaSummary.amount_03), 2)
                   WHEN '04' THEN Round(Sum(PJvYTDDeltaSummary.amount_04), 2)
                   WHEN '05' THEN Round(Sum(PJvYTDDeltaSummary.amount_05), 2)
                   WHEN '06' THEN Round(Sum(PJvYTDDeltaSummary.amount_06), 2)
                   WHEN '07' THEN Round(Sum(PJvYTDDeltaSummary.amount_07), 2)
                   WHEN '08' THEN Round(Sum(PJvYTDDeltaSummary.amount_08), 2)
                   WHEN '09' THEN Round(Sum(PJvYTDDeltaSummary.amount_09), 2)
                   WHEN '10' THEN Round(Sum(PJvYTDDeltaSummary.amount_10), 2)
                   WHEN '11' THEN Round(Sum(PJvYTDDeltaSummary.amount_11), 2)
                   WHEN '12' THEN Round(Sum(PJvYTDDeltaSummary.amount_12), 2)
                   WHEN '13' THEN Round(Sum(PJvYTDDeltaSummary.amount_13), 2)
                   WHEN '14' THEN Round(Sum(PJvYTDDeltaSummary.amount_14), 2)
                   WHEN '15' THEN Round(Sum(PJvYTDDeltaSummary.amount_15), 2)
                   ELSE 0
                 END                                     'PTDDelta',
                 CASE @PeriodGet
                   WHEN '01' THEN Round(Sum(PJvYTDDeltaSummary.amount_01), 2)
                   WHEN '02' THEN Round(Sum(PJvYTDDeltaSummary.amount_01) + Sum(PJvYTDDeltaSummary.amount_02), 2)
                   WHEN '03' THEN Round(Sum(PJvYTDDeltaSummary.amount_01) + Sum(PJvYTDDeltaSummary.amount_02) + Sum(PJvYTDDeltaSummary.amount_03), 2)
                   WHEN '04' THEN Round(Sum(PJvYTDDeltaSummary.amount_01) + Sum(PJvYTDDeltaSummary.amount_02) + Sum(PJvYTDDeltaSummary.amount_03) + Sum(PJvYTDDeltaSummary.amount_04), 2)
                   WHEN '05' THEN Round(Sum(PJvYTDDeltaSummary.amount_01) + Sum(PJvYTDDeltaSummary.amount_02) + Sum(PJvYTDDeltaSummary.amount_03) + Sum(PJvYTDDeltaSummary.amount_04) + Sum(PJvYTDDeltaSummary.amount_05), 2)
                   WHEN '06' THEN Round(Sum(PJvYTDDeltaSummary.amount_01) + Sum(PJvYTDDeltaSummary.amount_02) + Sum(PJvYTDDeltaSummary.amount_03) + Sum(PJvYTDDeltaSummary.amount_04) + Sum(PJvYTDDeltaSummary.amount_05) + Sum(PJvYTDDeltaSummary.amount_06), 2)
                   WHEN '07' THEN Round(Sum(PJvYTDDeltaSummary.amount_01) + Sum(PJvYTDDeltaSummary.amount_02) + Sum(PJvYTDDeltaSummary.amount_03) + Sum(PJvYTDDeltaSummary.amount_04) + Sum(PJvYTDDeltaSummary.amount_05) + Sum(PJvYTDDeltaSummary.amount_06) + Sum(PJvYTDDeltaSummary.amount_07), 2)
                   WHEN '08' THEN Round(Sum(PJvYTDDeltaSummary.amount_01) + Sum(PJvYTDDeltaSummary.amount_02) + Sum(PJvYTDDeltaSummary.amount_03) + Sum(PJvYTDDeltaSummary.amount_04) + Sum(PJvYTDDeltaSummary.amount_05) + Sum(PJvYTDDeltaSummary.amount_06) + Sum(PJvYTDDeltaSummary.amount_07) + Sum(PJvYTDDeltaSummary.amount_08), 2)
                   WHEN '09' THEN Round(Sum(PJvYTDDeltaSummary.amount_01) + Sum(PJvYTDDeltaSummary.amount_02) + Sum(PJvYTDDeltaSummary.amount_03) + Sum(PJvYTDDeltaSummary.amount_04) + Sum(PJvYTDDeltaSummary.amount_05) + Sum(PJvYTDDeltaSummary.amount_06) + Sum(PJvYTDDeltaSummary.amount_07) + Sum(PJvYTDDeltaSummary.amount_08) + Sum(PJvYTDDeltaSummary.amount_09), 2)
                   WHEN '10' THEN Round(Sum(PJvYTDDeltaSummary.amount_01) + Sum(PJvYTDDeltaSummary.amount_02) + Sum(PJvYTDDeltaSummary.amount_03) + Sum(PJvYTDDeltaSummary.amount_04) + Sum(PJvYTDDeltaSummary.amount_05) + Sum(PJvYTDDeltaSummary.amount_06) + Sum(PJvYTDDeltaSummary.amount_07) + Sum(PJvYTDDeltaSummary.amount_08) + Sum(PJvYTDDeltaSummary.amount_09) + Sum(PJvYTDDeltaSummary.amount_10), 2)
                   WHEN '11' THEN Round(Sum(PJvYTDDeltaSummary.amount_01) + Sum(PJvYTDDeltaSummary.amount_02) + Sum(PJvYTDDeltaSummary.amount_03) + Sum(PJvYTDDeltaSummary.amount_04) + Sum(PJvYTDDeltaSummary.amount_05) + Sum(PJvYTDDeltaSummary.amount_06) + Sum(PJvYTDDeltaSummary.amount_07) + Sum(PJvYTDDeltaSummary.amount_08) + Sum(PJvYTDDeltaSummary.amount_09) + Sum(PJvYTDDeltaSummary.amount_10) + Sum(PJvYTDDeltaSummary.amount_11), 2)
                   WHEN '12' THEN Round(Sum(PJvYTDDeltaSummary.amount_01) + Sum(PJvYTDDeltaSummary.amount_02) + Sum(PJvYTDDeltaSummary.amount_03) + Sum(PJvYTDDeltaSummary.amount_04) + Sum(PJvYTDDeltaSummary.amount_05) + Sum(PJvYTDDeltaSummary.amount_06) + Sum(PJvYTDDeltaSummary.amount_07) + Sum(PJvYTDDeltaSummary.amount_08) + Sum(PJvYTDDeltaSummary.amount_09) + Sum(PJvYTDDeltaSummary.amount_10) + Sum(PJvYTDDeltaSummary.amount_11) + Sum(PJvYTDDeltaSummary.amount_12), 2)
                   WHEN '13' THEN Round(Sum(PJvYTDDeltaSummary.amount_01) + Sum(PJvYTDDeltaSummary.amount_02) + Sum(PJvYTDDeltaSummary.amount_03) + Sum(PJvYTDDeltaSummary.amount_04) + Sum(PJvYTDDeltaSummary.amount_05) + Sum(PJvYTDDeltaSummary.amount_06) + Sum(PJvYTDDeltaSummary.amount_07) + Sum(PJvYTDDeltaSummary.amount_08) + Sum(PJvYTDDeltaSummary.amount_09) + Sum(PJvYTDDeltaSummary.amount_10) + Sum(PJvYTDDeltaSummary.amount_11) + Sum(PJvYTDDeltaSummary.amount_12) + Sum(PJvYTDDeltaSummary.amount_13), 2)
                   WHEN '14' THEN Round(Sum(PJvYTDDeltaSummary.amount_01) + Sum(PJvYTDDeltaSummary.amount_02) + Sum(PJvYTDDeltaSummary.amount_03) + Sum(PJvYTDDeltaSummary.amount_04) + Sum(PJvYTDDeltaSummary.amount_05) + Sum(PJvYTDDeltaSummary.amount_06) + Sum(PJvYTDDeltaSummary.amount_07) + Sum(PJvYTDDeltaSummary.amount_08) + Sum(PJvYTDDeltaSummary.amount_09) + Sum(PJvYTDDeltaSummary.amount_10) + Sum(PJvYTDDeltaSummary.amount_11) + Sum(PJvYTDDeltaSummary.amount_12) + Sum(PJvYTDDeltaSummary.amount_13) + Sum(PJvYTDDeltaSummary.amount_14), 2)
                   WHEN '15' THEN Round(Sum(PJvYTDDeltaSummary.amount_01) + Sum(PJvYTDDeltaSummary.amount_02) + Sum(PJvYTDDeltaSummary.amount_03) + Sum(PJvYTDDeltaSummary.amount_04) + Sum(PJvYTDDeltaSummary.amount_05) + Sum(PJvYTDDeltaSummary.amount_06) + Sum(PJvYTDDeltaSummary.amount_07) + Sum(PJvYTDDeltaSummary.amount_08) + Sum(PJvYTDDeltaSummary.amount_09) + Sum(PJvYTDDeltaSummary.amount_10) + Sum(PJvYTDDeltaSummary.amount_11) + Sum(PJvYTDDeltaSummary.amount_12) + Sum(PJvYTDDeltaSummary.amount_13) + Sum(PJvYTDDeltaSummary.amount_14) + Sum(PJvYTDDeltaSummary.amount_15), 2)
                   ELSE 0
                 END                                     'YTDAmount',
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
           when '03' then round(Sum(PJvYTDDeltaSummary.amount_01),2)
           when '04' then round(Sum(PJvYTDDeltaSummary.amount_02),2)
           when '05' then round(Sum(PJvYTDDeltaSummary.amount_03),2)
           when '06' then round(Sum(PJvYTDDeltaSummary.amount_04),2)
           when '07' then round(Sum(PJvYTDDeltaSummary.amount_05),2)
           when '08' then round(Sum(PJvYTDDeltaSummary.amount_06),2)
           when '09' then round(Sum(PJvYTDDeltaSummary.amount_07),2)
           when '10' then round(Sum(PJvYTDDeltaSummary.amount_08),2)
           when '11' then round(Sum(PJvYTDDeltaSummary.amount_09),2)
           when '12' then round(Sum(PJvYTDDeltaSummary.amount_10),2)
           when '13' then round(Sum(PJvYTDDeltaSummary.amount_11),2)
           when '14' then round(Sum(PJvYTDDeltaSummary.amount_12),2)
           when '15' then round(Sum(PJvYTDDeltaSummary.amount_13),2)
           else 0
       end  'PriorPeriod2Delta',
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
           when '02' then round(sum(PJvYTDDeltaSummary.amount_01),2)
           when '03' then round(sum(PJvYTDDeltaSummary.amount_02),2)
           when '04' then round(sum(PJvYTDDeltaSummary.amount_03),2)
           when '05' then round(sum(PJvYTDDeltaSummary.amount_04),2)
           when '06' then round(sum(PJvYTDDeltaSummary.amount_05),2)
           when '07' then round(sum(PJvYTDDeltaSummary.amount_06),2)
           when '08' then round(sum(PJvYTDDeltaSummary.amount_07),2)
           when '09' then round(sum(PJvYTDDeltaSummary.amount_08),2)
           when '10' then round(sum(PJvYTDDeltaSummary.amount_09),2)
           when '11' then round(sum(PJvYTDDeltaSummary.amount_10),2)
           when '12' then round(sum(PJvYTDDeltaSummary.amount_11),2)
           when '13' then round(sum(PJvYTDDeltaSummary.amount_12),2)
           when '14' then round(sum(PJvYTDDeltaSummary.amount_13),2)
           when '15' then round(sum(PJvYTDDeltaSummary.amount_14),2)
           else 0
       end  'PriorPeriod1Delta',

                 Round(Sum(PJvYTDDeltaSummary.EAC_Amt), 2)    'EAC_Amt'
          FROM   PJvYTDDeltaSummary Left Join PJvYTDDeltaSummary PriorSummary on @PeriodGet < '03'
    --and PriorSummary.period = CONVERT(char(2), @GLPeriods)
    and PriorSummary.fsyear_num = CONVERT(char(4), CONVERT(int, @YearGet) - 1)
    and PriorSummary.project = PJvYTDDeltaSummary.project
    and PriorSummary.pjt_entity = PJvYTDDeltaSummary.pjt_entity
    and PriorSummary.acct = PJvYTDDeltaSummary.acct

          WHERE  PJvYTDDeltaSummary.Project = @ProjGet
				--and PJvYTDDeltaSummary.pjt_entity = 'T01'
                -- AND PJvYTDDeltaSummary.Period = @PeriodGet
                 AND PJvYTDDeltaSummary.fsyear_num = @YearGet
                 AND PJvYTDDeltaSummary.Acct IN (SELECT acct
                                            FROM   PJREPCOL
                                            WHERE  report_code = 'pa3000'
                                                   AND column_nbr = '3')
          GROUP  BY PJvYTDDeltaSummary.Acct,
                    PJvYTDDeltaSummary.Project
      END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJvICDeltaprojYTD] TO [MSDSL]
    AS [dbo];

