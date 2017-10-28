
CREATE PROC [PJvICprojTotalPTD] @ProjGet   AS VARCHAR(16),
                                @PeriodGet AS VARCHAR(2),
                                @YearGet   AS VARCHAR(4)
AS
    DECLARE @rows AS BIGINT

    SELECT @rows = Count(*)
    FROM   PJvPTDSummary
    WHERE  PJvPTDSummary.fsyear_num = @YearGet
           AND PJvPTDSummary.project = @ProjGet

    IF @rows = 0
      BEGIN
          SELECT 0.00 'PTDCost',
                 0.00 'YTDCost',
                 0.00 'Beg_Amt'
      END
    ELSE
      BEGIN
          SELECT CASE @PeriodGet
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
                 END 'PTDCost',
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
                 END 'YTDCost',
                 Round(Sum(PJvPTDSummary.Beg_Amt), 2) 'Beg_Amt'
          FROM   PJvPTDSummary
          WHERE  PJvPTDSummary.fsyear_num = @YearGet
                 AND PJvPTDSummary.project = @ProjGet
          GROUP  BY PJvPTDSummary.project
      END 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJvICprojTotalPTD] TO [MSDSL]
    AS [dbo];

