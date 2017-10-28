

CREATE PROC PJvICDeltataskYTD @ProjGet   AS VARCHAR(16),
                         @TaskGet   AS VARCHAR(32),
                         @PeriodGet AS VARCHAR(2),
                         @YearGet   AS VARCHAR(4)
AS
    DECLARE @rows AS BIGINT
	declare @GLPeriods as int = (select NbrPer from GLSetup)
		
    SELECT @rows = Count(*)
    FROM   PJvYTDDeltaSummary
    WHERE  PJvYTDDeltaSummary.Project = @ProjGet
           AND PJvYTDDeltaSummary.pjt_entity = @TaskGet
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
          SELECT PJvYTDDeltaSummary.Acct,
                                   CASE @PeriodGet
                   WHEN '01' THEN Round(100 * (PJvYTDDeltaSummary.rate_01), 2)
                   WHEN '02' THEN Round(100 * (PJvYTDDeltaSummary.rate_02), 2)
                   WHEN '03' THEN Round(100 * (PJvYTDDeltaSummary.rate_03), 2)
                   WHEN '04' THEN Round(100 * (PJvYTDDeltaSummary.rate_04), 2)
                   WHEN '05' THEN Round(100 * (PJvYTDDeltaSummary.rate_05), 2)
                   WHEN '06' THEN Round(100 * (PJvYTDDeltaSummary.rate_06), 2)
                   WHEN '07' THEN Round(100 * (PJvYTDDeltaSummary.rate_07), 2)
                   WHEN '08' THEN Round(100 * (PJvYTDDeltaSummary.rate_08), 2)
                   WHEN '09' THEN Round(100 * (PJvYTDDeltaSummary.rate_09), 2)
                   WHEN '10' THEN Round(100 * (PJvYTDDeltaSummary.rate_10), 2)
                   WHEN '11' THEN Round(100 * (PJvYTDDeltaSummary.rate_11), 2)
                   WHEN '12' THEN Round(100 * (PJvYTDDeltaSummary.rate_12), 2)
                   WHEN '13' THEN Round(100 * (PJvYTDDeltaSummary.rate_13), 2)
                   WHEN '14' THEN Round(100 * (PJvYTDDeltaSummary.rate_14), 2)
                   WHEN '15' THEN Round(100 * (PJvYTDDeltaSummary.rate_15), 2)
                   ELSE 0   
                   end 'rate' ,
                 Round(PJvYTDDeltaSummary.BegAmt, 2)    'Beg_Amt',
                 CASE @PeriodGet
                   WHEN '01' THEN Round(PJvYTDDeltaSummary.amount_01, 2)
                   WHEN '02' THEN Round(PJvYTDDeltaSummary.amount_02, 2)
                   WHEN '03' THEN Round(PJvYTDDeltaSummary.amount_03, 2)
                   WHEN '04' THEN Round(PJvYTDDeltaSummary.amount_04, 2)
                   WHEN '05' THEN Round(PJvYTDDeltaSummary.amount_05, 2)
                   WHEN '06' THEN Round(PJvYTDDeltaSummary.amount_06, 2)
                   WHEN '07' THEN Round(PJvYTDDeltaSummary.amount_07, 2)
                   WHEN '08' THEN Round(PJvYTDDeltaSummary.amount_08, 2)
                   WHEN '09' THEN Round(PJvYTDDeltaSummary.amount_09, 2)
                   WHEN '10' THEN Round(PJvYTDDeltaSummary.amount_10, 2)
                   WHEN '11' THEN Round(PJvYTDDeltaSummary.amount_11, 2)
                   WHEN '12' THEN Round(PJvYTDDeltaSummary.amount_12, 2)
                   WHEN '13' THEN Round(PJvYTDDeltaSummary.amount_13, 2)
                   WHEN '14' THEN Round(PJvYTDDeltaSummary.amount_14, 2)
                   WHEN '15' THEN Round(PJvYTDDeltaSummary.amount_15, 2)
                   ELSE 0
                 END                                'PTDDelta',
                 CASE @PeriodGet
                   WHEN '01' THEN Round(PJvYTDDeltaSummary.amount_01, 2)
                   WHEN '02' THEN Round(PJvYTDDeltaSummary.amount_01 + PJvYTDDeltaSummary.amount_02, 2)
                   WHEN '03' THEN Round(PJvYTDDeltaSummary.amount_01 + PJvYTDDeltaSummary.amount_02 + PJvYTDDeltaSummary.amount_03, 2)
                   WHEN '04' THEN Round(PJvYTDDeltaSummary.amount_01 + PJvYTDDeltaSummary.amount_02 + PJvYTDDeltaSummary.amount_03 + PJvYTDDeltaSummary.amount_04, 2)
                   WHEN '05' THEN Round(PJvYTDDeltaSummary.amount_01 + PJvYTDDeltaSummary.amount_02 + PJvYTDDeltaSummary.amount_03 + PJvYTDDeltaSummary.amount_04 + PJvYTDDeltaSummary.amount_05, 2)
                   WHEN '06' THEN Round(PJvYTDDeltaSummary.amount_01 + PJvYTDDeltaSummary.amount_02 + PJvYTDDeltaSummary.amount_03 + PJvYTDDeltaSummary.amount_04 + PJvYTDDeltaSummary.amount_05 + PJvYTDDeltaSummary.amount_06, 2)
                   WHEN '07' THEN Round(PJvYTDDeltaSummary.amount_01 + PJvYTDDeltaSummary.amount_02 + PJvYTDDeltaSummary.amount_03 + PJvYTDDeltaSummary.amount_04 + PJvYTDDeltaSummary.amount_05 + PJvYTDDeltaSummary.amount_06 + PJvYTDDeltaSummary.amount_07, 2)
                   WHEN '08' THEN Round(PJvYTDDeltaSummary.amount_01 + PJvYTDDeltaSummary.amount_02 + PJvYTDDeltaSummary.amount_03 + PJvYTDDeltaSummary.amount_04 + PJvYTDDeltaSummary.amount_05 + PJvYTDDeltaSummary.amount_06 + PJvYTDDeltaSummary.amount_07 + PJvYTDDeltaSummary.amount_08, 2)
                   WHEN '09' THEN Round(PJvYTDDeltaSummary.amount_01 + PJvYTDDeltaSummary.amount_02 + PJvYTDDeltaSummary.amount_03 + PJvYTDDeltaSummary.amount_04 + PJvYTDDeltaSummary.amount_05 + PJvYTDDeltaSummary.amount_06 + PJvYTDDeltaSummary.amount_07 + PJvYTDDeltaSummary.amount_08 + PJvYTDDeltaSummary.amount_09, 2)
                   WHEN '10' THEN Round(PJvYTDDeltaSummary.amount_01 + PJvYTDDeltaSummary.amount_02 + PJvYTDDeltaSummary.amount_03 + PJvYTDDeltaSummary.amount_04 + PJvYTDDeltaSummary.amount_05 + PJvYTDDeltaSummary.amount_06 + PJvYTDDeltaSummary.amount_07 + PJvYTDDeltaSummary.amount_08 + PJvYTDDeltaSummary.amount_09 + PJvYTDDeltaSummary.amount_10, 2)
                   WHEN '11' THEN Round(PJvYTDDeltaSummary.amount_01 + PJvYTDDeltaSummary.amount_02 + PJvYTDDeltaSummary.amount_03 + PJvYTDDeltaSummary.amount_04 + PJvYTDDeltaSummary.amount_05 + PJvYTDDeltaSummary.amount_06 + PJvYTDDeltaSummary.amount_07 + PJvYTDDeltaSummary.amount_08 + PJvYTDDeltaSummary.amount_09 + PJvYTDDeltaSummary.amount_10 + PJvYTDDeltaSummary.amount_11, 2)
                   WHEN '12' THEN Round(PJvYTDDeltaSummary.amount_01 + PJvYTDDeltaSummary.amount_02 + PJvYTDDeltaSummary.amount_03 + PJvYTDDeltaSummary.amount_04 + PJvYTDDeltaSummary.amount_05 + PJvYTDDeltaSummary.amount_06 + PJvYTDDeltaSummary.amount_07 + PJvYTDDeltaSummary.amount_08 + PJvYTDDeltaSummary.amount_09 + PJvYTDDeltaSummary.amount_10 + PJvYTDDeltaSummary.amount_11 + PJvYTDDeltaSummary.amount_12, 2)
                   WHEN '13' THEN Round(PJvYTDDeltaSummary.amount_01 + PJvYTDDeltaSummary.amount_02 + PJvYTDDeltaSummary.amount_03 + PJvYTDDeltaSummary.amount_04 + PJvYTDDeltaSummary.amount_05 + PJvYTDDeltaSummary.amount_06 + PJvYTDDeltaSummary.amount_07 + PJvYTDDeltaSummary.amount_08 + PJvYTDDeltaSummary.amount_09 + PJvYTDDeltaSummary.amount_10 + PJvYTDDeltaSummary.amount_11 + PJvYTDDeltaSummary.amount_12 + PJvYTDDeltaSummary.amount_13, 2)
                   WHEN '14' THEN Round(PJvYTDDeltaSummary.amount_01 + PJvYTDDeltaSummary.amount_02 + PJvYTDDeltaSummary.amount_03 + PJvYTDDeltaSummary.amount_04 + PJvYTDDeltaSummary.amount_05 + PJvYTDDeltaSummary.amount_06 + PJvYTDDeltaSummary.amount_07 + PJvYTDDeltaSummary.amount_08 + PJvYTDDeltaSummary.amount_09 + PJvYTDDeltaSummary.amount_10 + PJvYTDDeltaSummary.amount_11 + PJvYTDDeltaSummary.amount_12 + PJvYTDDeltaSummary.amount_13 + PJvYTDDeltaSummary.amount_14, 2)
                   WHEN '15' THEN Round(PJvYTDDeltaSummary.amount_01 + PJvYTDDeltaSummary.amount_02 + PJvYTDDeltaSummary.amount_03 + PJvYTDDeltaSummary.amount_04 + PJvYTDDeltaSummary.amount_05 + PJvYTDDeltaSummary.amount_06 + PJvYTDDeltaSummary.amount_07 + PJvYTDDeltaSummary.amount_08 + PJvYTDDeltaSummary.amount_09 + PJvYTDDeltaSummary.amount_10 + PJvYTDDeltaSummary.amount_11 + PJvYTDDeltaSummary.amount_12 + PJvYTDDeltaSummary.amount_13 + PJvYTDDeltaSummary.amount_14 + PJvYTDDeltaSummary.amount_15, 2)
                   ELSE 0
                 END                                'YTDAmount',
                                         case @periodget
           when '01' then isnull(case @GLPeriods
                                     when '01' then 0
                                     when '02' then round(PriorSummary.amount_01, 2)
                                     when '03' then round(PriorSummary.amount_02, 2)
                                     when '04' then round(PriorSummary.amount_03, 2)
                                     when '05' then round(PriorSummary.amount_04, 2)
                                     when '06' then round(PriorSummary.amount_05, 2)
                                     when '07' then round(PriorSummary.amount_06, 2)
                                     when '08' then round(PriorSummary.amount_07, 2)
                                     when '09' then round(PriorSummary.amount_08, 2)
                                     when '10' then round(PriorSummary.amount_09, 2)
                                     when '11' then round(PriorSummary.amount_10, 2)
                                     when '12' then round(PriorSummary.amount_11, 2)
                                     when '13' then round(PriorSummary.amount_12, 2)
                                     when '14' then round(PriorSummary.amount_13, 2)
                                     when '15' then round(PriorSummary.amount_14, 2)
                                     else 0
                                  end, 0)
           when '02' then isnull(case @GLPeriods
                                     when '01' then Round(PriorSummary.amount_01,2)
                                     when '02' then Round(PriorSummary.amount_01,2)
                                     when '03' then Round(PriorSummary.amount_03,2)
                                     when '04' then Round(PriorSummary.amount_04,2)
                                     when '05' then Round(PriorSummary.amount_05,2)
                                     when '06' then Round(PriorSummary.amount_06,2)
                                     when '07' then Round(PriorSummary.amount_07,2)
                                     when '08' then Round(PriorSummary.amount_08,2)
                                     when '09' then Round(PriorSummary.amount_09,2)
                                     when '10' then Round(PriorSummary.amount_10,2)
                                     when '11' then Round(PriorSummary.amount_11,2)
                                     when '12' then Round(PriorSummary.amount_12,2)
                                     when '13' then Round(PriorSummary.amount_13,2)
                                     when '14' then Round(PriorSummary.amount_14,2)
                                     when '15' then Round(PriorSummary.amount_15,2)
                                     else 0
                                 end, 0)
           when '03' then round(PJvYTDDeltaSummary.amount_01,2)
           when '04' then round(PJvYTDDeltaSummary.amount_02,2)
           when '05' then round(PJvYTDDeltaSummary.amount_03,2)
           when '06' then round(PJvYTDDeltaSummary.amount_04,2)
           when '07' then round(PJvYTDDeltaSummary.amount_05,2)
           when '08' then round(PJvYTDDeltaSummary.amount_06,2)
           when '09' then round(PJvYTDDeltaSummary.amount_07,2)
           when '10' then round(PJvYTDDeltaSummary.amount_08,2)
           when '11' then round(PJvYTDDeltaSummary.amount_09,2)
           when '12' then round(PJvYTDDeltaSummary.amount_10,2)
           when '13' then round(PJvYTDDeltaSummary.amount_11,2)
           when '14' then round(PJvYTDDeltaSummary.amount_12,2)
           when '15' then round(PJvYTDDeltaSummary.amount_13,2)
           else 0
       end  'PriorPeriod2Delta',
       case @periodget
           when '01' then isnull(case @GLPeriods
                                     when '01' then round(PriorSummary.amount_01,2)
                                     when '02' then round(PriorSummary.amount_01,2)
                                     when '03' then round(PriorSummary.amount_03,2)
                                     when '04' then round(PriorSummary.amount_04,2)
                                     when '05' then round(PriorSummary.amount_05,2)
                                     when '06' then round(PriorSummary.amount_06,2)
                                     when '07' then round(PriorSummary.amount_07,2)
                                     when '08' then round(PriorSummary.amount_08,2)
                                     when '09' then round(PriorSummary.amount_09,2)
                                     when '10' then round(PriorSummary.amount_10,2)
                                     when '11' then round(PriorSummary.amount_11,2)
                                     when '12' then round(PriorSummary.amount_12,2)
                                     when '13' then round(PriorSummary.amount_13,2)
                                     when '14' then round(PriorSummary.amount_14,2)
                                     when '15' then round(PriorSummary.amount_15,2)
                                     else 0
                                 end, 0)
           when '02' then round(PJvYTDDeltaSummary.amount_01,2)
           when '03' then round(PJvYTDDeltaSummary.amount_02,2)
           when '04' then round(PJvYTDDeltaSummary.amount_03,2)
           when '05' then round(PJvYTDDeltaSummary.amount_04,2)
           when '06' then round(PJvYTDDeltaSummary.amount_05,2)
           when '07' then round(PJvYTDDeltaSummary.amount_06,2)
           when '08' then round(PJvYTDDeltaSummary.amount_07,2)
           when '09' then round(PJvYTDDeltaSummary.amount_08,2)
           when '10' then round(PJvYTDDeltaSummary.amount_09,2)
           when '11' then round(PJvYTDDeltaSummary.amount_10,2)
           when '12' then round(PJvYTDDeltaSummary.amount_11,2)
           when '13' then round(PJvYTDDeltaSummary.amount_12,2)
           when '14' then round(PJvYTDDeltaSummary.amount_13,2)
           when '15' then round(PJvYTDDeltaSummary.amount_14,2)
           else 0
       end  'PriorPeriod1Delta',
                 Round(PJvYTDDeltaSummary.EAC_Amt, 2)    'EAC_Amt'
          FROM   PJvYTDDeltaSummary left join PJvYTDDeltaSummary PriorSummary on 
          @PeriodGet < '03'
   -- and PriorSummary.period = CONVERT(char(2), @GLPeriods)
    and PriorSummary.fsyear_num = CONVERT(char(4), CONVERT(int, @YearGet) - 1)
    and PriorSummary.project = PJvYTDDeltaSummary.project
    and PriorSummary.pjt_entity = PJvYTDDeltaSummary.pjt_entity
    and PriorSummary.acct = PJvYTDDeltaSummary.acct
          WHERE  PJvYTDDeltaSummary.Project = @ProjGet
                 AND PJvYTDDeltaSummary.pjt_entity = @TaskGet
                 --AND PJvYTDDeltaSummary.Period = @PeriodGet
                 AND PJvYTDDeltaSummary.fsyear_num = @YearGet
                 AND PJvYTDDeltaSummary.Acct IN (SELECT acct
                                            FROM   PJREPCOL
                                            WHERE  report_code = 'pa3000'
                                                   AND column_nbr = '3')
      END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJvICDeltataskYTD] TO [MSDSL]
    AS [dbo];

