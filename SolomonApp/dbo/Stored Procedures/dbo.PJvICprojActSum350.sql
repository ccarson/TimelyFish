
CREATE PROC PJvICprojActSum350 @ProjGet   AS VARCHAR(16),
                           @PeriodGet AS VARCHAR(2),
                           @YearGet   AS VARCHAR(4)
AS
    DECLARE @rows AS BIGINT

    SELECT @rows = Count(*)
    FROM   PJActSum
    WHERE  PJActSum.fsyear_num = @YearGet
           AND PJActSum.project = @ProjGet
           AND PJActSum.Acct IN (SELECT acct
                                      FROM   PJREPCOL
                                      WHERE  report_code = 'pa3500'
                                             AND column_nbr in ('8', '9', '10'))

    IF @rows = 0
      BEGIN
          SELECT '------NONE------' 'Acct',
                 0.00               'YTDAmount'
      END
    ELSE
      BEGIN
          SELECT PJActSum.Acct,
                 CASE @PeriodGet
                   WHEN '01' THEN Round(Sum(PJActSum.amount_01), 2)
                   WHEN '02' THEN Round(Sum(PJActSum.amount_01) + Sum(PJActSum.amount_02), 2)
                   WHEN '03' THEN Round(Sum(PJActSum.amount_01) + Sum(PJActSum.amount_02) + Sum(PJActSum.amount_03), 2)
                   WHEN '04' THEN Round(Sum(PJActSum.amount_01) + Sum(PJActSum.amount_02) + Sum(PJActSum.amount_03) + Sum(PJActSum.amount_04), 2)
                   WHEN '05' THEN Round(Sum(PJActSum.amount_01) + Sum(PJActSum.amount_02) + Sum(PJActSum.amount_03) + Sum(PJActSum.amount_04) + Sum(PJActSum.amount_05), 2)
                   WHEN '06' THEN Round(Sum(PJActSum.amount_01) + Sum(PJActSum.amount_02) + Sum(PJActSum.amount_03) + Sum(PJActSum.amount_04) + Sum(PJActSum.amount_05) + Sum(PJActSum.amount_06), 2)
                   WHEN '07' THEN Round(Sum(PJActSum.amount_01) + Sum(PJActSum.amount_02) + Sum(PJActSum.amount_03) + Sum(PJActSum.amount_04) + Sum(PJActSum.amount_05) + Sum(PJActSum.amount_06) + Sum(PJActSum.amount_07), 2)
                   WHEN '08' THEN Round(Sum(PJActSum.amount_01) + Sum(PJActSum.amount_02) + Sum(PJActSum.amount_03) + Sum(PJActSum.amount_04) + Sum(PJActSum.amount_05) + Sum(PJActSum.amount_06) + Sum(PJActSum.amount_07) + Sum(PJActSum.amount_08), 2)
                   WHEN '09' THEN Round(Sum(PJActSum.amount_01) + Sum(PJActSum.amount_02) + Sum(PJActSum.amount_03) + Sum(PJActSum.amount_04) + Sum(PJActSum.amount_05) + Sum(PJActSum.amount_06) + Sum(PJActSum.amount_07) + Sum(PJActSum.amount_08) + Sum(PJActSum.amount_09), 2)
                   WHEN '10' THEN Round(Sum(PJActSum.amount_01) + Sum(PJActSum.amount_02) + Sum(PJActSum.amount_03) + Sum(PJActSum.amount_04) + Sum(PJActSum.amount_05) + Sum(PJActSum.amount_06) + Sum(PJActSum.amount_07) + Sum(PJActSum.amount_08) + Sum(PJActSum.amount_09) + Sum(PJActSum.amount_10), 2)
                   WHEN '11' THEN Round(Sum(PJActSum.amount_01) + Sum(PJActSum.amount_02) + Sum(PJActSum.amount_03) + Sum(PJActSum.amount_04) + Sum(PJActSum.amount_05) + Sum(PJActSum.amount_06) + Sum(PJActSum.amount_07) + Sum(PJActSum.amount_08) + Sum(PJActSum.amount_09) + Sum(PJActSum.amount_10) + Sum(PJActSum.amount_11), 2)
                   WHEN '12' THEN Round(Sum(PJActSum.amount_01) + Sum(PJActSum.amount_02) + Sum(PJActSum.amount_03) + Sum(PJActSum.amount_04) + Sum(PJActSum.amount_05) + Sum(PJActSum.amount_06) + Sum(PJActSum.amount_07) + Sum(PJActSum.amount_08) + Sum(PJActSum.amount_09) + Sum(PJActSum.amount_10) + Sum(PJActSum.amount_11) + Sum(PJActSum.amount_12), 2)
                   WHEN '13' THEN Round(Sum(PJActSum.amount_01) + Sum(PJActSum.amount_02) + Sum(PJActSum.amount_03) + Sum(PJActSum.amount_04) + Sum(PJActSum.amount_05) + Sum(PJActSum.amount_06) + Sum(PJActSum.amount_07) + Sum(PJActSum.amount_08) + Sum(PJActSum.amount_09) + Sum(PJActSum.amount_10) + Sum(PJActSum.amount_11) + Sum(PJActSum.amount_12) + Sum(PJActSum.amount_13), 2)
                   WHEN '14' THEN Round(Sum(PJActSum.amount_01) + Sum(PJActSum.amount_02) + Sum(PJActSum.amount_03) + Sum(PJActSum.amount_04) + Sum(PJActSum.amount_05) + Sum(PJActSum.amount_06) + Sum(PJActSum.amount_07) + Sum(PJActSum.amount_08) + Sum(PJActSum.amount_09) + Sum(PJActSum.amount_10) + Sum(PJActSum.amount_11) + Sum(PJActSum.amount_12) + Sum(PJActSum.amount_13) + Sum(PJActSum.amount_14), 2)
                   WHEN '15' THEN Round(Sum(PJActSum.amount_01) + Sum(PJActSum.amount_02) + Sum(PJActSum.amount_03) + Sum(PJActSum.amount_04) + Sum(PJActSum.amount_05) + Sum(PJActSum.amount_06) + Sum(PJActSum.amount_07) + Sum(PJActSum.amount_08) + Sum(PJActSum.amount_09) + Sum(PJActSum.amount_10) + Sum(PJActSum.amount_11) + Sum(PJActSum.amount_12) + Sum(PJActSum.amount_13) + Sum(PJActSum.amount_14) + Sum(PJActSum.amount_15), 2)
                   ELSE 0
                 END                                  'YTDAmount'
          FROM   PJActSum
          WHERE  PJActSum.fsyear_num = @YearGet
                 AND PJActSum.project = @ProjGet
                 AND PJActSum.Acct IN (SELECT acct
                                            FROM   PJREPCOL
                                            WHERE  report_code = 'pa3500'
                                                   AND column_nbr in ('8', '9', '10'))
          GROUP  BY PJActSum.Acct,
                    PJActSum.project
      END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJvICprojActSum350] TO [MSDSL]
    AS [dbo];

