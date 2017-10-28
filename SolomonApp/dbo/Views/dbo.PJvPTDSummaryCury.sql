
CREATE VIEW PJvPTDSummaryCury
AS
  SELECT PJPTDAIC.Acct,
         PJPTDAIC.project,
         PJPTDAIC.pjt_entity,
         PJPTDAIC.fsyear_num,
         PJPTDAIC.rate_01,
         PJPTDAIC.rate_02,
         PJPTDAIC.rate_03,
         PJPTDAIC.rate_04,
         PJPTDAIC.rate_05,
         PJPTDAIC.rate_06,
         PJPTDAIC.rate_07,
         PJPTDAIC.rate_08,
         PJPTDAIC.rate_09,
         PJPTDAIC.rate_10,
         PJPTDAIC.rate_11,
         PJPTDAIC.rate_12,
         PJPTDAIC.rate_13,
         PJPTDAIC.rate_14,
         PJPTDAIC.rate_15,
         PJPTDAIC.ProjCury_amount_bf             AS 'Beg_Amt',
         PJPTDAIC.ProjCury_amount_01             AS 'amount_01',
         PJPTDAIC.ProjCury_amount_02             AS 'amount_02',
         PJPTDAIC.ProjCury_amount_03             AS 'amount_03',
         PJPTDAIC.ProjCury_amount_04             AS 'amount_04',
         PJPTDAIC.ProjCury_amount_05             AS 'amount_05',
         PJPTDAIC.ProjCury_amount_06             AS 'amount_06',
         PJPTDAIC.ProjCury_amount_07             AS 'amount_07',
         PJPTDAIC.ProjCury_amount_08             AS 'amount_08',
         PJPTDAIC.ProjCury_amount_09             AS 'amount_09',
         PJPTDAIC.ProjCury_amount_10             AS 'amount_10',
         PJPTDAIC.ProjCury_amount_11             AS 'amount_11',
         PJPTDAIC.ProjCury_amount_12             AS 'amount_12',
         PJPTDAIC.ProjCury_amount_13             AS 'amount_13',
         PJPTDAIC.ProjCury_amount_14             AS 'amount_14',
         PJPTDAIC.ProjCury_amount_15             AS 'amount_15',
         Isnull(PJPTDSUM.ProjCury_eac_amount, 0) AS 'EAC_Amt'
  FROM   PJPTDAIC
         LEFT OUTER JOIN PJPTDSUM
           ON PJPTDAIC.project = PJPTDSUM.project
              AND PJPTDAIC.pjt_entity = PJPTDSUM.pjt_entity
              AND PJPTDAIC.acct = PJPTDSUM.acct 
