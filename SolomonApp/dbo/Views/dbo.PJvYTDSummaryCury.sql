
CREATE VIEW PJvYTDSummaryCury
AS
  SELECT PJYTDAIC.Acct,
         PJYTDAIC.Project,
         PJYTDAIC.pjt_entity,
         RIGHT(PJYTDAIC.period, 2)               AS 'Period',
         LEFT(PJYTDAIC.period, 4)                AS 'Year',
         PJYTDAIC.rate,
         PJYTDAIC.ProjCury_amount_bf             AS 'Beg_Amt',
         PJYTDAIC.ProjCury_amount_01             AS 'amount_01',
         PJYTDAIC.ProjCury_amount_02             AS 'amount_02',
         PJYTDAIC.ProjCury_amount_03             AS 'amount_03',
         PJYTDAIC.ProjCury_amount_04             AS 'amount_04',
         PJYTDAIC.ProjCury_amount_05             AS 'amount_05',
         PJYTDAIC.ProjCury_amount_06             AS 'amount_06',
         PJYTDAIC.ProjCury_amount_07             AS 'amount_07',
         PJYTDAIC.ProjCury_amount_08             AS 'amount_08',
         PJYTDAIC.ProjCury_amount_09             AS 'amount_09',
         PJYTDAIC.ProjCury_amount_10             AS 'amount_10',
         PJYTDAIC.ProjCury_amount_11             AS 'amount_11',
         PJYTDAIC.ProjCury_amount_12             AS 'amount_12',
         PJYTDAIC.ProjCury_amount_13             AS 'amount_13',
         PJYTDAIC.ProjCury_amount_14             AS 'amount_14',
         PJYTDAIC.ProjCury_amount_15             AS 'amount_15',
         Isnull(PJPTDSUM.ProjCury_eac_amount, 0) AS 'EAC_Amt',
         RptCompany.CpnyID                       AS 'CpnyID',
         RptCompany.CpnyName                     AS 'CpnyName'
  FROM   PJYTDAIC
         LEFT OUTER JOIN PJPTDSUM
           ON PJYTDAIC.project = PJPTDSUM.project
              AND PJYTDAIC.pjt_entity = PJPTDSUM.pjt_entity
              AND PJYTDAIC.acct = PJPTDSUM.acct
         INNER JOIN PJPROJ
           ON PJYTDAIC.project = PJPROJ.project
         INNER JOIN RptCompany
           ON PJPROJ.CpnyId = RptCompany.CpnyID

