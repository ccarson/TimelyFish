
CREATE PROC [PJvICprojTotalPTDCury] @ProjGet   AS VARCHAR(16),
                                @PeriodGet AS VARCHAR(2),
                                @YearGet   AS VARCHAR(4)
AS
    DECLARE @rows AS BIGINT

    SELECT @rows = Count(*)
    FROM   PJvPTDSummaryCury
    WHERE  PJvPTDSummaryCury.fsyear_num = @YearGet
           AND PJvPTDSummaryCury.project = @ProjGet

    IF @rows = 0
      BEGIN
          SELECT 0.00 'PTDCost',
                 0.00 'YTDCost',
                 0.00 'Beg_Amt'
      END
    ELSE
      BEGIN
          SELECT CASE @PeriodGet
                   WHEN '01' THEN Round(Sum(PJvPTDSummaryCury.amount_01), 2)
                   WHEN '02' THEN Round(Sum(PJvPTDSummaryCury.amount_02), 2)
                   WHEN '03' THEN Round(Sum(PJvPTDSummaryCury.amount_03), 2)
                   WHEN '04' THEN Round(Sum(PJvPTDSummaryCury.amount_04), 2)
                   WHEN '05' THEN Round(Sum(PJvPTDSummaryCury.amount_05), 2)
                   WHEN '06' THEN Round(Sum(PJvPTDSummaryCury.amount_06), 2)
                   WHEN '07' THEN Round(Sum(PJvPTDSummaryCury.amount_07), 2)
                   WHEN '08' THEN Round(Sum(PJvPTDSummaryCury.amount_08), 2)
                   WHEN '09' THEN Round(Sum(PJvPTDSummaryCury.amount_09), 2)
                   WHEN '10' THEN Round(Sum(PJvPTDSummaryCury.amount_10), 2)
                   WHEN '11' THEN Round(Sum(PJvPTDSummaryCury.amount_11), 2)
                   WHEN '12' THEN Round(Sum(PJvPTDSummaryCury.amount_12), 2)
                   WHEN '13' THEN Round(Sum(PJvPTDSummaryCury.amount_13), 2)
                   WHEN '14' THEN Round(Sum(PJvPTDSummaryCury.amount_14), 2)
                   WHEN '15' THEN Round(Sum(PJvPTDSummaryCury.amount_15), 2)
                   ELSE 0
                 END 'PTDCost',
                 CASE @PeriodGet
                   WHEN '01' THEN Round(Sum(PJvPTDSummaryCury.amount_01), 2)
                   WHEN '02' THEN Round(Sum(PJvPTDSummaryCury.amount_01) + Sum(PJvPTDSummaryCury.amount_02), 2)
                   WHEN '03' THEN Round(Sum(PJvPTDSummaryCury.amount_01) + Sum(PJvPTDSummaryCury.amount_02) + Sum(PJvPTDSummaryCury.amount_03), 2)
                   WHEN '04' THEN Round(Sum(PJvPTDSummaryCury.amount_01) + Sum(PJvPTDSummaryCury.amount_02) + Sum(PJvPTDSummaryCury.amount_03) + Sum(PJvPTDSummaryCury.amount_04), 2)
                   WHEN '05' THEN Round(Sum(PJvPTDSummaryCury.amount_01) + Sum(PJvPTDSummaryCury.amount_02) + Sum(PJvPTDSummaryCury.amount_03) + Sum(PJvPTDSummaryCury.amount_04) + Sum(PJvPTDSummaryCury.amount_05), 2)
                   WHEN '06' THEN Round(Sum(PJvPTDSummaryCury.amount_01) + Sum(PJvPTDSummaryCury.amount_02) + Sum(PJvPTDSummaryCury.amount_03) + Sum(PJvPTDSummaryCury.amount_04) + Sum(PJvPTDSummaryCury.amount_05) + Sum(PJvPTDSummaryCury.amount_06), 2)
                   WHEN '07' THEN Round(Sum(PJvPTDSummaryCury.amount_01) + Sum(PJvPTDSummaryCury.amount_02) + Sum(PJvPTDSummaryCury.amount_03) + Sum(PJvPTDSummaryCury.amount_04) + Sum(PJvPTDSummaryCury.amount_05) + Sum(PJvPTDSummaryCury.amount_06) + Sum(PJvPTDSummaryCury.amount_07), 2)
                   WHEN '08' THEN Round(Sum(PJvPTDSummaryCury.amount_01) + Sum(PJvPTDSummaryCury.amount_02) + Sum(PJvPTDSummaryCury.amount_03) + Sum(PJvPTDSummaryCury.amount_04) + Sum(PJvPTDSummaryCury.amount_05) + Sum(PJvPTDSummaryCury.amount_06) + Sum(PJvPTDSummaryCury.amount_07) + Sum(PJvPTDSummaryCury.amount_08), 2)
                   WHEN '09' THEN Round(Sum(PJvPTDSummaryCury.amount_01) + Sum(PJvPTDSummaryCury.amount_02) + Sum(PJvPTDSummaryCury.amount_03) + Sum(PJvPTDSummaryCury.amount_04) + Sum(PJvPTDSummaryCury.amount_05) + Sum(PJvPTDSummaryCury.amount_06) + Sum(PJvPTDSummaryCury.amount_07) + Sum(PJvPTDSummaryCury.amount_08) + Sum(PJvPTDSummaryCury.amount_09), 2)
                   WHEN '10' THEN Round(Sum(PJvPTDSummaryCury.amount_01) + Sum(PJvPTDSummaryCury.amount_02) + Sum(PJvPTDSummaryCury.amount_03) + Sum(PJvPTDSummaryCury.amount_04) + Sum(PJvPTDSummaryCury.amount_05) + Sum(PJvPTDSummaryCury.amount_06) + Sum(PJvPTDSummaryCury.amount_07) + Sum(PJvPTDSummaryCury.amount_08) + Sum(PJvPTDSummaryCury.amount_09) + Sum(PJvPTDSummaryCury.amount_10), 2)
                   WHEN '11' THEN Round(Sum(PJvPTDSummaryCury.amount_01) + Sum(PJvPTDSummaryCury.amount_02) + Sum(PJvPTDSummaryCury.amount_03) + Sum(PJvPTDSummaryCury.amount_04) + Sum(PJvPTDSummaryCury.amount_05) + Sum(PJvPTDSummaryCury.amount_06) + Sum(PJvPTDSummaryCury.amount_07) + Sum(PJvPTDSummaryCury.amount_08) + Sum(PJvPTDSummaryCury.amount_09) + Sum(PJvPTDSummaryCury.amount_10) + Sum(PJvPTDSummaryCury.amount_11), 2)
                   WHEN '12' THEN Round(Sum(PJvPTDSummaryCury.amount_01) + Sum(PJvPTDSummaryCury.amount_02) + Sum(PJvPTDSummaryCury.amount_03) + Sum(PJvPTDSummaryCury.amount_04) + Sum(PJvPTDSummaryCury.amount_05) + Sum(PJvPTDSummaryCury.amount_06) + Sum(PJvPTDSummaryCury.amount_07) + Sum(PJvPTDSummaryCury.amount_08) + Sum(PJvPTDSummaryCury.amount_09) + Sum(PJvPTDSummaryCury.amount_10) + Sum(PJvPTDSummaryCury.amount_11) + Sum(PJvPTDSummaryCury.amount_12), 2)
                   WHEN '13' THEN Round(Sum(PJvPTDSummaryCury.amount_01) + Sum(PJvPTDSummaryCury.amount_02) + Sum(PJvPTDSummaryCury.amount_03) + Sum(PJvPTDSummaryCury.amount_04) + Sum(PJvPTDSummaryCury.amount_05) + Sum(PJvPTDSummaryCury.amount_06) + Sum(PJvPTDSummaryCury.amount_07) + Sum(PJvPTDSummaryCury.amount_08) + Sum(PJvPTDSummaryCury.amount_09) + Sum(PJvPTDSummaryCury.amount_10) + Sum(PJvPTDSummaryCury.amount_11) + Sum(PJvPTDSummaryCury.amount_12) + Sum(PJvPTDSummaryCury.amount_13), 2)
                   WHEN '14' THEN Round(Sum(PJvPTDSummaryCury.amount_01) + Sum(PJvPTDSummaryCury.amount_02) + Sum(PJvPTDSummaryCury.amount_03) + Sum(PJvPTDSummaryCury.amount_04) + Sum(PJvPTDSummaryCury.amount_05) + Sum(PJvPTDSummaryCury.amount_06) + Sum(PJvPTDSummaryCury.amount_07) + Sum(PJvPTDSummaryCury.amount_08) + Sum(PJvPTDSummaryCury.amount_09) + Sum(PJvPTDSummaryCury.amount_10) + Sum(PJvPTDSummaryCury.amount_11) + Sum(PJvPTDSummaryCury.amount_12) + Sum(PJvPTDSummaryCury.amount_13) + Sum(PJvPTDSummaryCury.amount_14), 2)
                   WHEN '15' THEN Round(Sum(PJvPTDSummaryCury.amount_01) + Sum(PJvPTDSummaryCury.amount_02) + Sum(PJvPTDSummaryCury.amount_03) + Sum(PJvPTDSummaryCury.amount_04) + Sum(PJvPTDSummaryCury.amount_05) + Sum(PJvPTDSummaryCury.amount_06) + Sum(PJvPTDSummaryCury.amount_07) + Sum(PJvPTDSummaryCury.amount_08) + Sum(PJvPTDSummaryCury.amount_09) + Sum(PJvPTDSummaryCury.amount_10) + Sum(PJvPTDSummaryCury.amount_11) + Sum(PJvPTDSummaryCury.amount_12) + Sum(PJvPTDSummaryCury.amount_13) + Sum(PJvPTDSummaryCury.amount_14) + Sum(PJvPTDSummaryCury.amount_15), 2)
                   ELSE 0
                 END 'YTDCost',
                 Round(Sum(PJvPTDSummaryCury.Beg_Amt), 2) 'Beg_Amt'
          FROM   PJvPTDSummaryCury
          WHERE  PJvPTDSummaryCury.fsyear_num = @YearGet
                 AND PJvPTDSummaryCury.project = @ProjGet
          GROUP  BY PJvPTDSummaryCury.project
      END 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJvICprojTotalPTDCury] TO [MSDSL]
    AS [dbo];

