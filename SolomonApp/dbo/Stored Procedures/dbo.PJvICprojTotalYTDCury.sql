
CREATE PROC [PJvICprojTotalYTDCury] @ProjGet   AS VARCHAR(16),
                                @PeriodGet AS VARCHAR(2),
                                @YearGet   AS VARCHAR(4)
AS
    DECLARE @rows AS BIGINT

    SELECT @rows = Count(*)
    FROM   PJvYTDSummaryCury
    WHERE  PJvYTDSummaryCury.Project = @ProjGet
           AND PJvYTDSummaryCury.Period = @PeriodGet
           AND PJvYTDSummaryCury.Year = @YearGet

    IF @rows = 0
      BEGIN
          SELECT 0.00 'PTDCost',
                 0.00 'YTDCost',
                 0.00 'Beg_Amt'
      END
    ELSE
      BEGIN
          SELECT CASE @PeriodGet
                   WHEN '01' THEN Round(Sum(PJvYTDSummaryCury.amount_01), 2)
                   WHEN '02' THEN Round(Sum(PJvYTDSummaryCury.amount_02), 2)
                   WHEN '03' THEN Round(Sum(PJvYTDSummaryCury.amount_03), 2)
                   WHEN '04' THEN Round(Sum(PJvYTDSummaryCury.amount_04), 2)
                   WHEN '05' THEN Round(Sum(PJvYTDSummaryCury.amount_05), 2)
                   WHEN '06' THEN Round(Sum(PJvYTDSummaryCury.amount_06), 2)
                   WHEN '07' THEN Round(Sum(PJvYTDSummaryCury.amount_07), 2)
                   WHEN '08' THEN Round(Sum(PJvYTDSummaryCury.amount_08), 2)
                   WHEN '09' THEN Round(Sum(PJvYTDSummaryCury.amount_09), 2)
                   WHEN '10' THEN Round(Sum(PJvYTDSummaryCury.amount_10), 2)
                   WHEN '11' THEN Round(Sum(PJvYTDSummaryCury.amount_11), 2)
                   WHEN '12' THEN Round(Sum(PJvYTDSummaryCury.amount_12), 2)
                   WHEN '13' THEN Round(Sum(PJvYTDSummaryCury.amount_13), 2)
                   WHEN '14' THEN Round(Sum(PJvYTDSummaryCury.amount_14), 2)
                   WHEN '15' THEN Round(Sum(PJvYTDSummaryCury.amount_15), 2)
                   ELSE 0
                 END 'PTDCost',
                 CASE @PeriodGet
                   WHEN '01' THEN Round(Sum(PJvYTDSummaryCury.amount_01), 2)
                   WHEN '02' THEN Round(Sum(PJvYTDSummaryCury.amount_01) + Sum(PJvYTDSummaryCury.amount_02), 2)
                   WHEN '03' THEN Round(Sum(PJvYTDSummaryCury.amount_01) + Sum(PJvYTDSummaryCury.amount_02) + Sum(PJvYTDSummaryCury.amount_03), 2)
                   WHEN '04' THEN Round(Sum(PJvYTDSummaryCury.amount_01) + Sum(PJvYTDSummaryCury.amount_02) + Sum(PJvYTDSummaryCury.amount_03) + Sum(PJvYTDSummaryCury.amount_04), 2)
                   WHEN '05' THEN Round(Sum(PJvYTDSummaryCury.amount_01) + Sum(PJvYTDSummaryCury.amount_02) + Sum(PJvYTDSummaryCury.amount_03) + Sum(PJvYTDSummaryCury.amount_04) + Sum(PJvYTDSummaryCury.amount_05), 2)
                   WHEN '06' THEN Round(Sum(PJvYTDSummaryCury.amount_01) + Sum(PJvYTDSummaryCury.amount_02) + Sum(PJvYTDSummaryCury.amount_03) + Sum(PJvYTDSummaryCury.amount_04) + Sum(PJvYTDSummaryCury.amount_05) + Sum(PJvYTDSummaryCury.amount_06), 2)
                   WHEN '07' THEN Round(Sum(PJvYTDSummaryCury.amount_01) + Sum(PJvYTDSummaryCury.amount_02) + Sum(PJvYTDSummaryCury.amount_03) + Sum(PJvYTDSummaryCury.amount_04) + Sum(PJvYTDSummaryCury.amount_05) + Sum(PJvYTDSummaryCury.amount_06) + Sum(PJvYTDSummaryCury.amount_07), 2)
                   WHEN '08' THEN Round(Sum(PJvYTDSummaryCury.amount_01) + Sum(PJvYTDSummaryCury.amount_02) + Sum(PJvYTDSummaryCury.amount_03) + Sum(PJvYTDSummaryCury.amount_04) + Sum(PJvYTDSummaryCury.amount_05) + Sum(PJvYTDSummaryCury.amount_06) + Sum(PJvYTDSummaryCury.amount_07) + Sum(PJvYTDSummaryCury.amount_08), 2)
                   WHEN '09' THEN Round(Sum(PJvYTDSummaryCury.amount_01) + Sum(PJvYTDSummaryCury.amount_02) + Sum(PJvYTDSummaryCury.amount_03) + Sum(PJvYTDSummaryCury.amount_04) + Sum(PJvYTDSummaryCury.amount_05) + Sum(PJvYTDSummaryCury.amount_06) + Sum(PJvYTDSummaryCury.amount_07) + Sum(PJvYTDSummaryCury.amount_08) + Sum(PJvYTDSummaryCury.amount_09), 2)
                   WHEN '10' THEN Round(Sum(PJvYTDSummaryCury.amount_01) + Sum(PJvYTDSummaryCury.amount_02) + Sum(PJvYTDSummaryCury.amount_03) + Sum(PJvYTDSummaryCury.amount_04) + Sum(PJvYTDSummaryCury.amount_05) + Sum(PJvYTDSummaryCury.amount_06) + Sum(PJvYTDSummaryCury.amount_07) + Sum(PJvYTDSummaryCury.amount_08) + Sum(PJvYTDSummaryCury.amount_09) + Sum(PJvYTDSummaryCury.amount_10), 2)
                   WHEN '11' THEN Round(Sum(PJvYTDSummaryCury.amount_01) + Sum(PJvYTDSummaryCury.amount_02) + Sum(PJvYTDSummaryCury.amount_03) + Sum(PJvYTDSummaryCury.amount_04) + Sum(PJvYTDSummaryCury.amount_05) + Sum(PJvYTDSummaryCury.amount_06) + Sum(PJvYTDSummaryCury.amount_07) + Sum(PJvYTDSummaryCury.amount_08) + Sum(PJvYTDSummaryCury.amount_09) + Sum(PJvYTDSummaryCury.amount_10) + Sum(PJvYTDSummaryCury.amount_11), 2)
                   WHEN '12' THEN Round(Sum(PJvYTDSummaryCury.amount_01) + Sum(PJvYTDSummaryCury.amount_02) + Sum(PJvYTDSummaryCury.amount_03) + Sum(PJvYTDSummaryCury.amount_04) + Sum(PJvYTDSummaryCury.amount_05) + Sum(PJvYTDSummaryCury.amount_06) + Sum(PJvYTDSummaryCury.amount_07) + Sum(PJvYTDSummaryCury.amount_08) + Sum(PJvYTDSummaryCury.amount_09) + Sum(PJvYTDSummaryCury.amount_10) + Sum(PJvYTDSummaryCury.amount_11) + Sum(PJvYTDSummaryCury.amount_12), 2)
                   WHEN '13' THEN Round(Sum(PJvYTDSummaryCury.amount_01) + Sum(PJvYTDSummaryCury.amount_02) + Sum(PJvYTDSummaryCury.amount_03) + Sum(PJvYTDSummaryCury.amount_04) + Sum(PJvYTDSummaryCury.amount_05) + Sum(PJvYTDSummaryCury.amount_06) + Sum(PJvYTDSummaryCury.amount_07) + Sum(PJvYTDSummaryCury.amount_08) + Sum(PJvYTDSummaryCury.amount_09) + Sum(PJvYTDSummaryCury.amount_10) + Sum(PJvYTDSummaryCury.amount_11) + Sum(PJvYTDSummaryCury.amount_12) + Sum(PJvYTDSummaryCury.amount_13), 2)
                   WHEN '14' THEN Round(Sum(PJvYTDSummaryCury.amount_01) + Sum(PJvYTDSummaryCury.amount_02) + Sum(PJvYTDSummaryCury.amount_03) + Sum(PJvYTDSummaryCury.amount_04) + Sum(PJvYTDSummaryCury.amount_05) + Sum(PJvYTDSummaryCury.amount_06) + Sum(PJvYTDSummaryCury.amount_07) + Sum(PJvYTDSummaryCury.amount_08) + Sum(PJvYTDSummaryCury.amount_09) + Sum(PJvYTDSummaryCury.amount_10) + Sum(PJvYTDSummaryCury.amount_11) + Sum(PJvYTDSummaryCury.amount_12) + Sum(PJvYTDSummaryCury.amount_13) + Sum(PJvYTDSummaryCury.amount_14), 2)
                   WHEN '15' THEN Round(Sum(PJvYTDSummaryCury.amount_01) + Sum(PJvYTDSummaryCury.amount_02) + Sum(PJvYTDSummaryCury.amount_03) + Sum(PJvYTDSummaryCury.amount_04) + Sum(PJvYTDSummaryCury.amount_05) + Sum(PJvYTDSummaryCury.amount_06) + Sum(PJvYTDSummaryCury.amount_07) + Sum(PJvYTDSummaryCury.amount_08) + Sum(PJvYTDSummaryCury.amount_09) + Sum(PJvYTDSummaryCury.amount_10) + Sum(PJvYTDSummaryCury.amount_11) + Sum(PJvYTDSummaryCury.amount_12) + Sum(PJvYTDSummaryCury.amount_13) + Sum(PJvYTDSummaryCury.amount_14) + Sum(PJvYTDSummaryCury.amount_15), 2)
                   ELSE 0
                 END 'YTDCost',
                 Round(Sum(PJvYTDSummaryCury.Beg_Amt), 2) 'Beg_Amt'
          FROM   PJvYTDSummaryCury
          WHERE  PJvYTDSummaryCury.Project = @ProjGet
                 AND PJvYTDSummaryCury.Period = @PeriodGet
                 AND PJvYTDSummaryCury.Year = @YearGet
          GROUP  BY PJvYTDSummaryCury.Project
      END 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJvICprojTotalYTDCury] TO [MSDSL]
    AS [dbo];

