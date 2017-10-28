
CREATE VIEW PJvYTDDeltaSummaryCury
AS
  SELECT PJYTDAIC_delta.acct,
         PJYTDAIC_delta.project,
         PJYTDAIC_delta.pjt_entity,
         PJYTDAIC_delta.fsyear_num,
         PJYTDAIC_delta.rate_01,
         PJYTDAIC_delta.rate_02,
         PJYTDAIC_delta.rate_03,
         PJYTDAIC_delta.rate_04,
         PJYTDAIC_delta.rate_05,
         PJYTDAIC_delta.rate_06,
         PJYTDAIC_delta.rate_07,
         PJYTDAIC_delta.rate_08,
         PJYTDAIC_delta.rate_09,
         PJYTDAIC_delta.rate_10,
         PJYTDAIC_delta.rate_11,
         PJYTDAIC_delta.rate_12,
         PJYTDAIC_delta.rate_13,
         PJYTDAIC_delta.rate_14,
         PJYTDAIC_delta.rate_15,
         PJYTDAIC_delta.BegAmt,
         ytd_01,
         ytd_02,
         ytd_03,
         ytd_04,
         ytd_05,
         ytd_06,
         ytd_07,
         ytd_08,
         ytd_09,
         ytd_10,
         ytd_11,
         ytd_12,
         PJYTDAIC_delta.ytd_01                   'amount_01',
         -- using max_period prevents a large negative for the delta of the period after the last one processed  
         CASE
           WHEN PJYTDAIC_delta.max_period >= '02' THEN PJYTDAIC_delta.ytd_02 - PJYTDAIC_delta.ytd_01
           ELSE 0
         END                                     'amount_02',
         CASE
           WHEN PJYTDAIC_delta.max_period >= '03' THEN PJYTDAIC_delta.ytd_03 - PJYTDAIC_delta.ytd_02
           ELSE 0
         END                                     'amount_03',
         CASE
           WHEN PJYTDAIC_delta.max_period >= '04' THEN PJYTDAIC_delta.ytd_04 - PJYTDAIC_delta.ytd_03
           ELSE 0
         END                                     'amount_04',
         CASE
           WHEN PJYTDAIC_delta.max_period >= '05' THEN PJYTDAIC_delta.ytd_05 - PJYTDAIC_delta.ytd_04
           ELSE 0
         END                                     'amount_05',
         CASE
           WHEN PJYTDAIC_delta.max_period >= '06' THEN PJYTDAIC_delta.ytd_06 - PJYTDAIC_delta.ytd_05
           ELSE 0
         END                                     'amount_06',
         CASE
           WHEN PJYTDAIC_delta.max_period >= '07' THEN PJYTDAIC_delta.ytd_07 - PJYTDAIC_delta.ytd_06
           ELSE 0
         END                                     'amount_07',
         CASE
           WHEN PJYTDAIC_delta.max_period >= '08' THEN PJYTDAIC_delta.ytd_08 - PJYTDAIC_delta.ytd_07
           ELSE 0
         END                                     'amount_08',
         CASE
           WHEN PJYTDAIC_delta.max_period >= '09' THEN PJYTDAIC_delta.ytd_09 - PJYTDAIC_delta.ytd_08
           ELSE 0
         END                                     'amount_09',
         CASE
           WHEN PJYTDAIC_delta.max_period >= '10' THEN PJYTDAIC_delta.ytd_10 - PJYTDAIC_delta.ytd_09
           ELSE 0
         END                                     'amount_10',
         CASE
           WHEN PJYTDAIC_delta.max_period >= '11' THEN PJYTDAIC_delta.ytd_11 - PJYTDAIC_delta.ytd_10
           ELSE 0
         END                                     'amount_11',
         CASE
           WHEN PJYTDAIC_delta.max_period >= '12' THEN PJYTDAIC_delta.ytd_12 - PJYTDAIC_delta.ytd_11
           ELSE 0
         END                                     'amount_12',
         CASE
           WHEN PJYTDAIC_delta.max_period >= '13' THEN PJYTDAIC_delta.ytd_13 - PJYTDAIC_delta.ytd_12
           ELSE 0
         END                                     'amount_13',
         CASE
           WHEN PJYTDAIC_delta.max_period >= '14' THEN PJYTDAIC_delta.ytd_14 - PJYTDAIC_delta.ytd_13
           ELSE 0
         END                                     'amount_14',
         CASE
           WHEN PJYTDAIC_delta.max_period = '15' THEN PJYTDAIC_delta.ytd_15 - PJYTDAIC_delta.ytd_14
           ELSE 0
         END                                     'amount_15',
         Isnull(PJPTDSUM.ProjCury_eac_amount, 0) 'EAC_Amt'
  FROM   (SELECT LEFT(period, 4)         'fsyear_num',
                 acct,
                 project,
                 pjt_entity,
                 Max(RIGHT(period, 2))   'max_period',
                 Max(ProjCury_amount_bf) AS 'BegAmt',
                 Sum(CASE RIGHT(period, 2)
                       WHEN '01' THEN ProjCury_amount_01
                       ELSE 0
                     END)                'ytd_01',
                 Sum(CASE RIGHT(period, 2)
                       WHEN '02' THEN ProjCury_amount_01 + ProjCury_amount_02
                       ELSE 0
                     END)                'ytd_02',
                 Sum(CASE RIGHT(period, 2)
                       WHEN '03' THEN ProjCury_amount_01 + ProjCury_amount_02 + ProjCury_amount_03
                       ELSE 0
                     END)                'ytd_03',
                 Sum(CASE RIGHT(period, 2)
                       WHEN '04' THEN ProjCury_amount_01 + ProjCury_amount_02 + ProjCury_amount_03 + ProjCury_amount_04
                       ELSE 0
                     END)                'ytd_04',
                 Sum(CASE RIGHT(period, 2)
                       WHEN '05' THEN ProjCury_amount_01 + ProjCury_amount_02 + ProjCury_amount_03 + ProjCury_amount_04 + ProjCury_amount_05
                       ELSE 0
                     END)                'ytd_05',
                 Sum(CASE RIGHT(period, 2)
                       WHEN '06' THEN ProjCury_amount_01 + ProjCury_amount_02 + ProjCury_amount_03 + ProjCury_amount_04 + ProjCury_amount_05 + ProjCury_amount_06
                       ELSE 0
                     END)                'ytd_06',
                 Sum(CASE RIGHT(period, 2)
                       WHEN '07' THEN ProjCury_amount_01 + ProjCury_amount_02 + ProjCury_amount_03 + ProjCury_amount_04 + ProjCury_amount_05 + ProjCury_amount_06 + ProjCury_amount_07
                       ELSE 0
                     END)                'ytd_07',
                 Sum(CASE RIGHT(period, 2)
                       WHEN '08' THEN ProjCury_amount_01 + ProjCury_amount_02 + ProjCury_amount_03 + ProjCury_amount_04 + ProjCury_amount_05 + ProjCury_amount_06 + ProjCury_amount_07 + ProjCury_amount_08
                       ELSE 0
                     END)                'ytd_08',
                 Sum(CASE RIGHT(period, 2)
                       WHEN '09' THEN ProjCury_amount_01 + ProjCury_amount_02 + ProjCury_amount_03 + ProjCury_amount_04 + ProjCury_amount_05 + ProjCury_amount_06 + ProjCury_amount_07 + ProjCury_amount_08 + ProjCury_amount_09
                       ELSE 0
                     END)                'ytd_09',
                 Sum(CASE RIGHT(period, 2)
                       WHEN '10' THEN ProjCury_amount_01 + ProjCury_amount_02 + ProjCury_amount_03 + ProjCury_amount_04 + ProjCury_amount_05 + ProjCury_amount_06 + ProjCury_amount_07 + ProjCury_amount_08 + ProjCury_amount_09 + ProjCury_amount_10
                       ELSE 0
                     END)                'ytd_10',
                 Sum(CASE RIGHT(period, 2)
                       WHEN '11' THEN ProjCury_amount_01 + ProjCury_amount_02 + ProjCury_amount_03 + ProjCury_amount_04 + ProjCury_amount_05 + ProjCury_amount_06 + ProjCury_amount_07 + ProjCury_amount_08 + ProjCury_amount_09 + ProjCury_amount_10 + ProjCury_amount_11
                       ELSE 0
                     END)                'ytd_11',
                 Sum(CASE RIGHT(period, 2)
                       WHEN '12' THEN ProjCury_amount_01 + ProjCury_amount_02 + ProjCury_amount_03 + ProjCury_amount_04 + ProjCury_amount_05 + ProjCury_amount_06 + ProjCury_amount_07 + ProjCury_amount_08 + ProjCury_amount_09 + ProjCury_amount_10 + ProjCury_amount_11 + ProjCury_amount_12
                       ELSE 0
                     END)                'ytd_12',
                 Sum(CASE RIGHT(period, 2)
                       WHEN '13' THEN ProjCury_amount_01 + ProjCury_amount_02 + ProjCury_amount_03 + ProjCury_amount_04 + ProjCury_amount_05 + ProjCury_amount_06 + ProjCury_amount_07 + ProjCury_amount_08 + ProjCury_amount_09 + ProjCury_amount_10 + ProjCury_amount_11 + ProjCury_amount_12 + ProjCury_amount_13
                       ELSE 0
                     END)                'ytd_13',
                 Sum(CASE RIGHT(period, 2)
                       WHEN '14' THEN ProjCury_amount_01 + ProjCury_amount_02 + ProjCury_amount_03 + ProjCury_amount_04 + ProjCury_amount_05 + ProjCury_amount_06 + ProjCury_amount_07 + ProjCury_amount_08 + ProjCury_amount_09 + ProjCury_amount_10 + ProjCury_amount_11 + ProjCury_amount_12 + ProjCury_amount_13 + ProjCury_amount_14
                       ELSE 0
                     END)                'ytd_14',
                 Sum(CASE RIGHT(period, 2)
                       WHEN '15' THEN ProjCury_amount_01 + ProjCury_amount_02 + ProjCury_amount_03 + ProjCury_amount_04 + ProjCury_amount_05 + ProjCury_amount_06 + ProjCury_amount_07 + ProjCury_amount_08 + ProjCury_amount_09 + ProjCury_amount_10 + ProjCury_amount_11 + ProjCury_amount_12 + ProjCury_amount_13 + ProjCury_amount_14 + ProjCury_amount_15
                       ELSE 0
                     END)                'ytd_15',
                 Max(CASE RIGHT(period, 2)
                       WHEN '01' THEN rate
                       ELSE 0
                     END)                'rate_01',
                 Max(CASE RIGHT(period, 2)
                       WHEN '02' THEN rate
                       ELSE 0
                     END)                'rate_02',
                 Max(CASE RIGHT(period, 2)
                       WHEN '03' THEN rate
                       ELSE 0
                     END)                'rate_03',
                 Max(CASE RIGHT(period, 2)
                       WHEN '04' THEN rate
                       ELSE 0
                     END)                'rate_04',
                 Max(CASE RIGHT(period, 2)
                       WHEN '05' THEN rate
                       ELSE 0
                     END)                'rate_05',
                 Max(CASE RIGHT(period, 2)
                       WHEN '06' THEN rate
                       ELSE 0
                     END)                'rate_06',
                 Max(CASE RIGHT(period, 2)
                       WHEN '07' THEN rate
                       ELSE 0
                     END)                'rate_07',
                 Max(CASE RIGHT(period, 2)
                       WHEN '08' THEN rate
                       ELSE 0
                     END)                'rate_08',
                 Max(CASE RIGHT(period, 2)
                       WHEN '09' THEN rate
                       ELSE 0
                     END)                'rate_09',
                 Max(CASE RIGHT(period, 2)
                       WHEN '10' THEN rate
                       ELSE 0
                     END)                'rate_10',
                 Max(CASE RIGHT(period, 2)
                       WHEN '11' THEN rate
                       ELSE 0
                     END)                'rate_11',
                 Max(CASE RIGHT(period, 2)
                       WHEN '12' THEN rate
                       ELSE 0
                     END)                'rate_12',
                 Max(CASE RIGHT(period, 2)
                       WHEN '13' THEN rate
                       ELSE 0
                     END)                'rate_13',
                 Max(CASE RIGHT(period, 2)
                       WHEN '14' THEN rate
                       ELSE 0
                     END)                'rate_14',
                 Max(CASE RIGHT(period, 2)
                       WHEN '15' THEN rate
                       ELSE 0
                     END)                'rate_15'
          FROM   PJYTDAIC
          GROUP  BY LEFT(period, 4),
                    acct,
                    project,
                    pjt_entity) PJYTDAIC_delta
         LEFT JOIN PJPTDSUM
           ON PJPTDSUM.project = PJYTDAIC_delta.project
              AND PJPTDSUM.pjt_entity = PJYTDAIC_delta.pjt_entity
              AND PJPTDSUM.acct = PJYTDAIC_delta.acct 
