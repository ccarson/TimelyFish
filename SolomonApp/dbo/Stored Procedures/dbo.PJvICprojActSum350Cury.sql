
CREATE PROC PJvICprojActSum350Cury @ProjGet   AS VARCHAR(16),
                           @PeriodGet AS VARCHAR(2),
                           @YearGet   AS VARCHAR(4)
AS
    DECLARE @rows AS BIGINT
    DECLARE @Decimal_Places AS INT = ( Select decpl from currncy where curyid = (select projcuryid from pjproj where project = @ProjGet ) )
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
                 0.00               'YTDAmount',
                 0.00               'DecPL'
      END
    ELSE
      BEGIN
          SELECT PJActSum.Acct,
                 CASE @PeriodGet
                   WHEN '01' THEN Round(Sum(PJActSum.projcury_amount_01), @Decimal_Places)
                   WHEN '02' THEN Round(Sum(PJActSum.projcury_amount_01) + Sum(PJActSum.projcury_amount_02), @Decimal_Places)
                   WHEN '03' THEN Round(Sum(PJActSum.projcury_amount_01) + Sum(PJActSum.projcury_amount_02) + Sum(PJActSum.projcury_amount_03), @Decimal_Places)
                   WHEN '04' THEN Round(Sum(PJActSum.projcury_amount_01) + Sum(PJActSum.projcury_amount_02) + Sum(PJActSum.projcury_amount_03) + Sum(PJActSum.projcury_amount_04), @Decimal_Places)
                   WHEN '05' THEN Round(Sum(PJActSum.projcury_amount_01) + Sum(PJActSum.projcury_amount_02) + Sum(PJActSum.projcury_amount_03) + Sum(PJActSum.projcury_amount_04) + Sum(PJActSum.projcury_amount_05), @Decimal_Places)
                   WHEN '06' THEN Round(Sum(PJActSum.projcury_amount_01) + Sum(PJActSum.projcury_amount_02) + Sum(PJActSum.projcury_amount_03) + Sum(PJActSum.projcury_amount_04) + Sum(PJActSum.projcury_amount_05) + Sum(PJActSum.projcury_amount_06), @Decimal_Places)
                   WHEN '07' THEN Round(Sum(PJActSum.projcury_amount_01) + Sum(PJActSum.projcury_amount_02) + Sum(PJActSum.projcury_amount_03) + Sum(PJActSum.projcury_amount_04) + Sum(PJActSum.projcury_amount_05) + Sum(PJActSum.projcury_amount_06) + Sum(PJActSum.projcury_amount_07), @Decimal_Places)
                   WHEN '08' THEN Round(Sum(PJActSum.projcury_amount_01) + Sum(PJActSum.projcury_amount_02) + Sum(PJActSum.projcury_amount_03) + Sum(PJActSum.projcury_amount_04) + Sum(PJActSum.projcury_amount_05) + Sum(PJActSum.projcury_amount_06) + Sum(PJActSum.projcury_amount_07) + Sum(PJActSum.projcury_amount_08), @Decimal_Places)
                   WHEN '09' THEN Round(Sum(PJActSum.projcury_amount_01) + Sum(PJActSum.projcury_amount_02) + Sum(PJActSum.projcury_amount_03) + Sum(PJActSum.projcury_amount_04) + Sum(PJActSum.projcury_amount_05) + Sum(PJActSum.projcury_amount_06) + Sum(PJActSum.projcury_amount_07) + Sum(PJActSum.projcury_amount_08) + Sum(PJActSum.projcury_amount_09), @Decimal_Places)
                   WHEN '10' THEN Round(Sum(PJActSum.projcury_amount_01) + Sum(PJActSum.projcury_amount_02) + Sum(PJActSum.projcury_amount_03) + Sum(PJActSum.projcury_amount_04) + Sum(PJActSum.projcury_amount_05) + Sum(PJActSum.projcury_amount_06) + Sum(PJActSum.projcury_amount_07) + Sum(PJActSum.projcury_amount_08) + Sum(PJActSum.projcury_amount_09) + Sum(PJActSum.projcury_amount_10), @Decimal_Places)
                   WHEN '11' THEN Round(Sum(PJActSum.projcury_amount_01) + Sum(PJActSum.projcury_amount_02) + Sum(PJActSum.projcury_amount_03) + Sum(PJActSum.projcury_amount_04) + Sum(PJActSum.projcury_amount_05) + Sum(PJActSum.projcury_amount_06) + Sum(PJActSum.projcury_amount_07) + Sum(PJActSum.projcury_amount_08) + Sum(PJActSum.projcury_amount_09) + Sum(PJActSum.projcury_amount_10) + Sum(PJActSum.projcury_amount_11), @Decimal_Places)
                   WHEN '12' THEN Round(Sum(PJActSum.projcury_amount_01) + Sum(PJActSum.projcury_amount_02) + Sum(PJActSum.projcury_amount_03) + Sum(PJActSum.projcury_amount_04) + Sum(PJActSum.projcury_amount_05) + Sum(PJActSum.projcury_amount_06) + Sum(PJActSum.projcury_amount_07) + Sum(PJActSum.projcury_amount_08) + Sum(PJActSum.projcury_amount_09) + Sum(PJActSum.projcury_amount_10) + Sum(PJActSum.projcury_amount_11) + Sum(PJActSum.projcury_amount_12), @Decimal_Places)
                   WHEN '13' THEN Round(Sum(PJActSum.projcury_amount_01) + Sum(PJActSum.projcury_amount_02) + Sum(PJActSum.projcury_amount_03) + Sum(PJActSum.projcury_amount_04) + Sum(PJActSum.projcury_amount_05) + Sum(PJActSum.projcury_amount_06) + Sum(PJActSum.projcury_amount_07) + Sum(PJActSum.projcury_amount_08) + Sum(PJActSum.projcury_amount_09) + Sum(PJActSum.projcury_amount_10) + Sum(PJActSum.projcury_amount_11) + Sum(PJActSum.projcury_amount_12) + Sum(PJActSum.projcury_amount_13), @Decimal_Places)
                   WHEN '14' THEN Round(Sum(PJActSum.projcury_amount_01) + Sum(PJActSum.projcury_amount_02) + Sum(PJActSum.projcury_amount_03) + Sum(PJActSum.projcury_amount_04) + Sum(PJActSum.projcury_amount_05) + Sum(PJActSum.projcury_amount_06) + Sum(PJActSum.projcury_amount_07) + Sum(PJActSum.projcury_amount_08) + Sum(PJActSum.projcury_amount_09) + Sum(PJActSum.projcury_amount_10) + Sum(PJActSum.projcury_amount_11) + Sum(PJActSum.projcury_amount_12) + Sum(PJActSum.projcury_amount_13) + Sum(PJActSum.projcury_amount_14), @Decimal_Places)
                   WHEN '15' THEN Round(Sum(PJActSum.projcury_amount_01) + Sum(PJActSum.projcury_amount_02) + Sum(PJActSum.projcury_amount_03) + Sum(PJActSum.projcury_amount_04) + Sum(PJActSum.projcury_amount_05) + Sum(PJActSum.projcury_amount_06) + Sum(PJActSum.projcury_amount_07) + Sum(PJActSum.projcury_amount_08) + Sum(PJActSum.projcury_amount_09) + Sum(PJActSum.projcury_amount_10) + Sum(PJActSum.projcury_amount_11) + Sum(PJActSum.projcury_amount_12) + Sum(PJActSum.projcury_amount_13) + Sum(PJActSum.projcury_amount_14) + Sum(PJActSum.projcury_amount_15), @Decimal_Places)
                   ELSE 0
                 END                                  'YTDAmount',
                 @Decimal_Places as DecPL
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
    ON OBJECT::[dbo].[PJvICprojActSum350Cury] TO [MSDSL]
    AS [dbo];

