
CREATE VIEW PJvYTDSummary
AS
 SELECT PJYTDAIC.Acct,
         PJYTDAIC.Project,
         PJYTDAIC.pjt_entity,
         RIGHT(PJYTDAIC.period, 2)      'Period',
         LEFT(PJYTDAIC.period, 4)       'Year',
         PJYTDAIC.rate,
         PJYTDAIC.Amount_bf             'Beg_Amt',
         PJYTDAIC.amount_01,
         PJYTDAIC.amount_02,
         PJYTDAIC.amount_03,
         PJYTDAIC.amount_04,
         PJYTDAIC.amount_05,
         PJYTDAIC.amount_06,
         PJYTDAIC.amount_07,
         PJYTDAIC.amount_08,
         PJYTDAIC.amount_09,
         PJYTDAIC.amount_10,
         PJYTDAIC.amount_11,
         PJYTDAIC.amount_12,
         PJYTDAIC.amount_13,
         PJYTDAIC.amount_14,
         PJYTDAIC.amount_15,                       
         Isnull(PJPTDSUM.eac_amount, 0) 'EAC_Amt',
		 PJYTDAIC.ProjCury_Amount_bf    'ProjCury_Beg_Amt',
         PJYTDAIC.ProjCury_Amount_01,
         PJYTDAIC.ProjCury_Amount_02,
         PJYTDAIC.ProjCury_Amount_03,
         PJYTDAIC.ProjCury_Amount_04,
         PJYTDAIC.ProjCury_Amount_05,
         PJYTDAIC.ProjCury_Amount_06,
         PJYTDAIC.ProjCury_Amount_07,
         PJYTDAIC.ProjCury_Amount_08,
         PJYTDAIC.ProjCury_Amount_09,
         PJYTDAIC.ProjCury_Amount_10,
         PJYTDAIC.ProjCury_Amount_11,
         PJYTDAIC.ProjCury_Amount_12,
         PJYTDAIC.ProjCury_Amount_13,
         PJYTDAIC.ProjCury_Amount_14,
         PJYTDAIC.ProjCury_Amount_15,                       
         Isnull(PJPTDSUM.ProjCury_eac_amount, 0) 'ProjCury_EAC_Amt',
         RptCompany.CpnyID 'CpnyID',
         RptCompany.CpnyName 'CpnyName'
  FROM   PJYTDAIC
         LEFT OUTER JOIN PJPTDSUM
           ON PJYTDAIC.project = PJPTDSUM.project
              AND PJYTDAIC.pjt_entity = PJPTDSUM.pjt_entity
              AND PJYTDAIC.acct = PJPTDSUM.acct
        Inner Join PJPROJ ON
        PJYTDAIC.project = PJPROJ.project
        INNER JOIN RptCompany ON
        PJPROJ.CpnyId = RptCompany.CpnyID

