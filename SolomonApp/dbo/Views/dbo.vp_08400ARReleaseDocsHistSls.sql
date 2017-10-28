 

--APPTABLE
--USETHISSYNTAX

CREATE VIEW vp_08400ARReleaseDocsHistSls AS
/********************************************************************************
*             Copyright Solomon Software, Inc. 1994-1999 All Rights Reserved
*
*    View Name: vp_08400ARReleaseDocsHistSls
*
*++* Narrative:  
*     
*
*
*   Called by: pp_08400
* 
*/

SELECT 	v.UserAddress, v.FiscYr, v.SlsPerID,

        PTDRcpt00 = SUM(CASE WHEN v.Period = '01' 
                       AND v.DocType IN ('PA', 'PP', 'CS') THEN v.HistBal ELSE 0 END),
        PTDRcpt01 = SUM(CASE WHEN v.Period = '02' 
                       AND v.DocType IN ('PA', 'PP', 'CS') THEN v.HistBal ELSE 0 END),
        PTDRcpt02 = SUM(CASE WHEN v.Period = '03' 
                       AND v.DocType IN ('PA', 'PP', 'CS') THEN v.HistBal ELSE 0 END),
        PTDRcpt03 = SUM(CASE WHEN v.Period = '04' 
                       AND v.DocType IN ('PA', 'PP', 'CS') THEN v.HistBal ELSE 0 END),
        PTDRcpt04 = SUM(CASE WHEN v.Period = '05' 
                       AND v.DocType IN ('PA', 'PP', 'CS') THEN v.HistBal ELSE 0 END),
        PTDRcpt05 = SUM(CASE WHEN v.Period = '06' 
                       AND v.DocType IN ('PA', 'PP', 'CS') THEN v.HistBal ELSE 0 END),
        PTDRcpt06 = SUM(CASE WHEN v.Period = '07' 
                       AND v.DocType IN ('PA', 'PP', 'CS') THEN v.HistBal ELSE 0 END),
        PTDRcpt07 = SUM(CASE WHEN v.Period = '08' 
                       AND v.DocType IN ('PA', 'PP', 'CS') THEN v.HistBal ELSE 0 END),
        PTDRcpt08 = SUM(CASE WHEN v.Period = '09' 
                       AND v.DocType IN ('PA', 'PP', 'CS') THEN v.HistBal ELSE 0 END),
        PTDRcpt09 = SUM(CASE WHEN v.Period = '10' 
                       AND v.DocType IN ('PA', 'PP', 'CS') THEN v.HistBal ELSE 0 END),
        PTDRcpt10 = SUM(CASE WHEN v.Period = '11' 
                       AND v.DocType IN ('PA', 'PP', 'CS') THEN v.HistBal ELSE 0 END),
        PTDRcpt11 = SUM(CASE WHEN v.Period = '12' 
                       AND v.DocType IN ('PA', 'PP', 'CS') THEN v.HistBal ELSE 0 END),
        PTDRcpt12 = SUM(CASE WHEN v.Period = '13' 
                       AND v.DocType IN ('PA', 'PP', 'CS') THEN v.HistBal ELSE 0 END),

        PTDSales00 = SUM(CASE WHEN v.Period = '01' 
                        AND v.DocType IN ('IN','SB','CM','CS') THEN v.HistBal ELSE 0 END),
        PTDSales01 = SUM(CASE WHEN v.Period = '02' 
                        AND v.DocType IN ('IN','SB','CM','CS') THEN v.HistBal ELSE 0 END),
        PTDSales02 = SUM(CASE WHEN v.Period = '03' 
                        AND v.DocType IN ('IN','SB','CM','CS') THEN v.HistBal ELSE 0 END),
        PTDSales03 = SUM(CASE WHEN v.Period = '04' 
                        AND v.DocType IN ('IN','SB','CM','CS') THEN v.HistBal ELSE 0 END),
        PTDSales04 = SUM(CASE WHEN v.Period = '05' 
                        AND v.DocType IN ('IN','SB','CM','CS') THEN v.HistBal ELSE 0 END),
        PTDSales05 = SUM(CASE WHEN v.Period = '06' 
                        AND v.DocType IN ('IN','SB','CM','CS') THEN v.HistBal ELSE 0 END),
        PTDSales06 = SUM(CASE WHEN v.Period = '07' 
                        AND v.DocType IN ('IN','SB','CM','CS') THEN v.HistBal ELSE 0 END),
        PTDSales07 = SUM(CASE WHEN v.Period = '08' 
                        AND v.DocType IN ('IN','SB','CM','CS') THEN v.HistBal ELSE 0 END),
        PTDSales08 = SUM(CASE WHEN v.Period = '09' 
                        AND v.DocType IN ('IN','SB','CM','CS') THEN v.HistBal ELSE 0 END),
        PTDSales09 = SUM(CASE WHEN v.Period = '10' 
                        AND v.DocType IN ('IN','SB','CM','CS') THEN v.HistBal ELSE 0 END),
        PTDSales10 = SUM(CASE WHEN v.Period = '11' 
                        AND v.DocType IN ('IN','SB','CM','CS') THEN v.HistBal ELSE 0 END),
        PTDSales11 = SUM(CASE WHEN v.Period = '12' 
                        AND v.DocType IN ('IN','SB','CM','CS') THEN v.HistBal ELSE 0 END),
        PTDSales12 = SUM(CASE WHEN v.Period = '13' 
                        AND v.DocType IN ('IN','SB','CM','CS') THEN v.HistBal ELSE 0 END),

        YtdRcpt =  SUM(CASE WHEN v.DocType IN ('PA', 'PP', 'CS') THEN v.HistBal ELSE 0 END), 
        YtdSales = SUM(CASE WHEN v.DocType IN ('IN','SB','CM','CS') THEN v.HistBal ELSE 0 END)

  FROM vp_08400ARbalancesHistSls v 
 GROUP BY v.UserAddress, v.FiscYr, v.SlsPerID



 
