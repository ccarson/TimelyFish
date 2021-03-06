﻿
CREATE VIEW IC_PJActSum
AS
 SELECT PJACTSUM.project,
         PJACTSUM.acct,
         PJACTSUM.fsyear_num	 'Year',
         Sum(PJACTSUM.amount_01) 'TargetAmt01',
         Sum(PJACTSUM.amount_02) 'TargetAmt02',
         Sum(PJACTSUM.amount_03) 'TargetAmt03',
         Sum(PJACTSUM.amount_04) 'TargetAmt04',
         Sum(PJACTSUM.amount_05) 'TargetAmt05',
         Sum(PJACTSUM.amount_06) 'TargetAmt06',
         Sum(PJACTSUM.amount_07) 'TargetAmt07',
         Sum(PJACTSUM.amount_08) 'TargetAmt08',
         Sum(PJACTSUM.amount_09) 'TargetAmt09',
         Sum(PJACTSUM.amount_10) 'TargetAmt10',
         Sum(PJACTSUM.amount_11) 'TargetAmt11',
         Sum(PJACTSUM.amount_12) 'TargetAmt12',
         Sum(PJACTSUM.amount_13) 'TargetAmt13',
         Sum(PJACTSUM.amount_14) 'TargetAmt14',
         Sum(PJACTSUM.amount_15) 'TargetAmt15',
		 Sum(PJACTSUM.ProjCury_Amount_01) 'ProjCury_TargetAmt01',
         Sum(PJACTSUM.ProjCury_Amount_02) 'ProjCury_TargetAmt02',
         Sum(PJACTSUM.ProjCury_Amount_03) 'ProjCury_TargetAmt03',
         Sum(PJACTSUM.ProjCury_Amount_04) 'ProjCury_TargetAmt04',
         Sum(PJACTSUM.ProjCury_Amount_05) 'ProjCury_TargetAmt05',
         Sum(PJACTSUM.ProjCury_Amount_06) 'ProjCury_TargetAmt06',
         Sum(PJACTSUM.ProjCury_Amount_07) 'ProjCury_TargetAmt07',
         Sum(PJACTSUM.ProjCury_Amount_08) 'ProjCury_TargetAmt08',
         Sum(PJACTSUM.ProjCury_Amount_09) 'ProjCury_TargetAmt09',
         Sum(PJACTSUM.ProjCury_Amount_10) 'ProjCury_TargetAmt10',
         Sum(PJACTSUM.ProjCury_Amount_11) 'ProjCury_TargetAmt11',
         Sum(PJACTSUM.ProjCury_Amount_12) 'ProjCury_TargetAmt12',
         Sum(PJACTSUM.ProjCury_Amount_13) 'ProjCury_TargetAmt13',
         Sum(PJACTSUM.ProjCury_Amount_14) 'ProjCury_TargetAmt14',
         Sum(PJACTSUM.ProjCury_Amount_15) 'ProjCury_TargetAmt15'
  FROM   PJACTSUM
  GROUP  BY PJACTSUM.project,
            PJACTSUM.acct,
            PJACTSUM.fsyear_num
