

CREATE PROC PJvICtaskYTD @ProjGet   AS VARCHAR(16),
                         @TaskGet   AS VARCHAR(32),
                         @PeriodGet AS VARCHAR(2),
                         @YearGet   AS VARCHAR(4)
AS
    DECLARE @rows AS BIGINT
	declare @GLPeriods as int = (select NbrPer from GLSetup)
		
    SELECT @rows = Count(*)
    FROM   PJvYTDSummary
    WHERE  PJvYTDSummary.Project = @ProjGet
           AND PJvYTDSummary.pjt_entity = @TaskGet
           AND PJvYTDSummary.Period = @PeriodGet
           AND PJvYTDSummary.Year = @YearGet
           AND PJvYTDSummary.Acct IN (SELECT acct
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
          SELECT PJvYTDSummary.Acct,
                 Round(PJvYTDSummary.rate * 100, 2) 'Rate',
                 Round(PJvYTDSummary.Beg_Amt, 2)    'Beg_Amt',
                 CASE @PeriodGet
                   WHEN '01' THEN Round(PJvYTDSummary.amount_01, 2)
                   WHEN '02' THEN Round(PJvYTDSummary.amount_02, 2)
                   WHEN '03' THEN Round(PJvYTDSummary.amount_03, 2)
                   WHEN '04' THEN Round(PJvYTDSummary.amount_04, 2)
                   WHEN '05' THEN Round(PJvYTDSummary.amount_05, 2)
                   WHEN '06' THEN Round(PJvYTDSummary.amount_06, 2)
                   WHEN '07' THEN Round(PJvYTDSummary.amount_07, 2)
                   WHEN '08' THEN Round(PJvYTDSummary.amount_08, 2)
                   WHEN '09' THEN Round(PJvYTDSummary.amount_09, 2)
                   WHEN '10' THEN Round(PJvYTDSummary.amount_10, 2)
                   WHEN '11' THEN Round(PJvYTDSummary.amount_11, 2)
                   WHEN '12' THEN Round(PJvYTDSummary.amount_12, 2)
                   WHEN '13' THEN Round(PJvYTDSummary.amount_13, 2)
                   WHEN '14' THEN Round(PJvYTDSummary.amount_14, 2)
                   WHEN '15' THEN Round(PJvYTDSummary.amount_15, 2)
                   ELSE 0
                 END                                'PTDAmount',
                 CASE @PeriodGet
                   WHEN '01' THEN Round(PJvYTDSummary.amount_01, 2)
                   WHEN '02' THEN Round(PJvYTDSummary.amount_01 + PJvYTDSummary.amount_02, 2)
                   WHEN '03' THEN Round(PJvYTDSummary.amount_01 + PJvYTDSummary.amount_02 + PJvYTDSummary.amount_03, 2)
                   WHEN '04' THEN Round(PJvYTDSummary.amount_01 + PJvYTDSummary.amount_02 + PJvYTDSummary.amount_03 + PJvYTDSummary.amount_04, 2)
                   WHEN '05' THEN Round(PJvYTDSummary.amount_01 + PJvYTDSummary.amount_02 + PJvYTDSummary.amount_03 + PJvYTDSummary.amount_04 + PJvYTDSummary.amount_05, 2)
                   WHEN '06' THEN Round(PJvYTDSummary.amount_01 + PJvYTDSummary.amount_02 + PJvYTDSummary.amount_03 + PJvYTDSummary.amount_04 + PJvYTDSummary.amount_05 + PJvYTDSummary.amount_06, 2)
                   WHEN '07' THEN Round(PJvYTDSummary.amount_01 + PJvYTDSummary.amount_02 + PJvYTDSummary.amount_03 + PJvYTDSummary.amount_04 + PJvYTDSummary.amount_05 + PJvYTDSummary.amount_06 + PJvYTDSummary.amount_07, 2)
                   WHEN '08' THEN Round(PJvYTDSummary.amount_01 + PJvYTDSummary.amount_02 + PJvYTDSummary.amount_03 + PJvYTDSummary.amount_04 + PJvYTDSummary.amount_05 + PJvYTDSummary.amount_06 + PJvYTDSummary.amount_07 + PJvYTDSummary.amount_08, 2)
                   WHEN '09' THEN Round(PJvYTDSummary.amount_01 + PJvYTDSummary.amount_02 + PJvYTDSummary.amount_03 + PJvYTDSummary.amount_04 + PJvYTDSummary.amount_05 + PJvYTDSummary.amount_06 + PJvYTDSummary.amount_07 + PJvYTDSummary.amount_08 + PJvYTDSummary.amount_09, 2)
                   WHEN '10' THEN Round(PJvYTDSummary.amount_01 + PJvYTDSummary.amount_02 + PJvYTDSummary.amount_03 + PJvYTDSummary.amount_04 + PJvYTDSummary.amount_05 + PJvYTDSummary.amount_06 + PJvYTDSummary.amount_07 + PJvYTDSummary.amount_08 + PJvYTDSummary.amount_09 + PJvYTDSummary.amount_10, 2)
                   WHEN '11' THEN Round(PJvYTDSummary.amount_01 + PJvYTDSummary.amount_02 + PJvYTDSummary.amount_03 + PJvYTDSummary.amount_04 + PJvYTDSummary.amount_05 + PJvYTDSummary.amount_06 + PJvYTDSummary.amount_07 + PJvYTDSummary.amount_08 + PJvYTDSummary.amount_09 + PJvYTDSummary.amount_10 + PJvYTDSummary.amount_11, 2)
                   WHEN '12' THEN Round(PJvYTDSummary.amount_01 + PJvYTDSummary.amount_02 + PJvYTDSummary.amount_03 + PJvYTDSummary.amount_04 + PJvYTDSummary.amount_05 + PJvYTDSummary.amount_06 + PJvYTDSummary.amount_07 + PJvYTDSummary.amount_08 + PJvYTDSummary.amount_09 + PJvYTDSummary.amount_10 + PJvYTDSummary.amount_11 + PJvYTDSummary.amount_12, 2)
                   WHEN '13' THEN Round(PJvYTDSummary.amount_01 + PJvYTDSummary.amount_02 + PJvYTDSummary.amount_03 + PJvYTDSummary.amount_04 + PJvYTDSummary.amount_05 + PJvYTDSummary.amount_06 + PJvYTDSummary.amount_07 + PJvYTDSummary.amount_08 + PJvYTDSummary.amount_09 + PJvYTDSummary.amount_10 + PJvYTDSummary.amount_11 + PJvYTDSummary.amount_12 + PJvYTDSummary.amount_13, 2)
                   WHEN '14' THEN Round(PJvYTDSummary.amount_01 + PJvYTDSummary.amount_02 + PJvYTDSummary.amount_03 + PJvYTDSummary.amount_04 + PJvYTDSummary.amount_05 + PJvYTDSummary.amount_06 + PJvYTDSummary.amount_07 + PJvYTDSummary.amount_08 + PJvYTDSummary.amount_09 + PJvYTDSummary.amount_10 + PJvYTDSummary.amount_11 + PJvYTDSummary.amount_12 + PJvYTDSummary.amount_13 + PJvYTDSummary.amount_14, 2)
                   WHEN '15' THEN Round(PJvYTDSummary.amount_01 + PJvYTDSummary.amount_02 + PJvYTDSummary.amount_03 + PJvYTDSummary.amount_04 + PJvYTDSummary.amount_05 + PJvYTDSummary.amount_06 + PJvYTDSummary.amount_07 + PJvYTDSummary.amount_08 + PJvYTDSummary.amount_09 + PJvYTDSummary.amount_10 + PJvYTDSummary.amount_11 + PJvYTDSummary.amount_12 + PJvYTDSummary.amount_13 + PJvYTDSummary.amount_14 + PJvYTDSummary.amount_15, 2)
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
           when '03' then round(PJvYTDSummary.amount_01,2)
           when '04' then round(PJvYTDSummary.amount_02,2)
           when '05' then round(PJvYTDSummary.amount_03,2)
           when '06' then round(PJvYTDSummary.amount_04,2)
           when '07' then round(PJvYTDSummary.amount_05,2)
           when '08' then round(PJvYTDSummary.amount_06,2)
           when '09' then round(PJvYTDSummary.amount_07,2)
           when '10' then round(PJvYTDSummary.amount_08,2)
           when '11' then round(PJvYTDSummary.amount_09,2)
           when '12' then round(PJvYTDSummary.amount_10,2)
           when '13' then round(PJvYTDSummary.amount_11,2)
           when '14' then round(PJvYTDSummary.amount_12,2)
           when '15' then round(PJvYTDSummary.amount_13,2)
           else 0
       end  'PriorPeriod2Amount',
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
           when '02' then round(PJvYTDSummary.amount_01,2)
           when '03' then round(PJvYTDSummary.amount_02,2)
           when '04' then round(PJvYTDSummary.amount_03,2)
           when '05' then round(PJvYTDSummary.amount_04,2)
           when '06' then round(PJvYTDSummary.amount_05,2)
           when '07' then round(PJvYTDSummary.amount_06,2)
           when '08' then round(PJvYTDSummary.amount_07,2)
           when '09' then round(PJvYTDSummary.amount_08,2)
           when '10' then round(PJvYTDSummary.amount_09,2)
           when '11' then round(PJvYTDSummary.amount_10,2)
           when '12' then round(PJvYTDSummary.amount_11,2)
           when '13' then round(PJvYTDSummary.amount_12,2)
           when '14' then round(PJvYTDSummary.amount_13,2)
           when '15' then round(PJvYTDSummary.amount_14,2)
           else 0
       end  'PriorPeriod1Amount',
                 Round(PJvYTDSummary.EAC_Amt, 2)    'EAC_Amt'
          FROM   PJvYTDSummary left join PJvYTDSummary PriorSummary on 
          @PeriodGet < '03'
    and PriorSummary.period = CONVERT(char(2), @GLPeriods)
    and PriorSummary.Year = CONVERT(char(4), CONVERT(int, @YearGet) - 1)
    and PriorSummary.project = PJvYTDSummary.project
    and PriorSummary.pjt_entity = PJvYTDSummary.pjt_entity
    and PriorSummary.acct = PJvYTDSummary.acct
          WHERE  PJvYTDSummary.Project = @ProjGet
                 AND PJvYTDSummary.pjt_entity = @TaskGet
                 AND PJvYTDSummary.Period = @PeriodGet
                 AND PJvYTDSummary.Year = @YearGet
                 AND PJvYTDSummary.Acct IN (SELECT acct
                                            FROM   PJREPCOL
                                            WHERE  report_code = 'pa3000'
                                                   AND column_nbr = '3')
      END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJvICtaskYTD] TO [MSDSL]
    AS [dbo];

