 

CREATE view vp_03400Curydiffvo as 

/***** File Name: 0306vp_03400CuryDiffVo.Sql					*****/
/***** Last Modified by DCR on 12/12/98 at 4:30pm 	*****/

/*****************************************************************/
/***** Finds Base Currency rounding Differences for VO/AD/AC *****/
/*****************************************************************/
SELECT   UserAddress,d.BatNbr,d.doctype,d.refnbr,min(t.linenbr) linenbr ,
         ROUND(MIN(origdocamt) - SUM(t.TranAmt),c.DecPl) RoundDiff
FROM Wrkrelease w,APDoc d, Aptran t,Currncy c, glsetup s (NOLOCK)
WHERE w.Module = 'AP' AND w.BatNbr = d.BatNbr and s.basecuryid = c.curyid  
  AND d.DocType IN ('VO', 'AD', 'AC', 'PP') 
  AND d.batnbr = t.batnbr and d.refnbr = t.refnbr and d.doctype = t.trantype
 
GROUP BY UserAddress,d.BatNbr,d.doctype,d.refnbr,c.Decpl
 
HAVING ROUND(MIN(origdocamt),c.DecPl) <> ROUND(SUM(t.TranAmt),c.DecPl)



 
