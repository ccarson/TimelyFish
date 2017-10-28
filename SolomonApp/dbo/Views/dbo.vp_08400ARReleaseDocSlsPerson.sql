 

--APPTABLE
--USETHISSYNTAX


CREATE VIEW vp_08400ARReleaseDocSlsPerson AS
/********************************************************************************
*             Copyright Solomon Software, Inc. 1994-1999 All Rights Reserved
*
*    View Name: vp_08400ARReleaseDocSlsPerson
*
*++* Narrative:  Used to update salesperson history 
*     
*
*
*   Called by: pp_08400
* 
*/

SELECT PerNbr = 
        CASE 
        WHEN (SUBSTRING(c.PerNbr, 1, 4)) = SUBSTRING(d.PerPost, 1, 4)
        THEN c.PerNbr
        WHEN (SUBSTRING(c.PerNbr, 1, 4)) < SUBSTRING(d.PerPost, 1, 4)
        THEN (SUBSTRING(c.PerNbr, 1, 4)) + '00'
        WHEN (SUBSTRING(c.PerNbr, 1, 4)) > SUBSTRING(d.PerPost, 1, 4)
        THEN ' ' END, 
       d.DocDate, w.UserAddress, d.PerPost, 
       FiscYr = SUBSTRING(d.PerPost, 1, 4), 
       d.CustId, d.DocType, d.SlsPerID,
       OrigDocAmt = CASE d.DocType
        WHEN 'CM' THEN CONVERT(dec(28,3),d.OrigDocAmt) * - 1
        WHEN 'PA' THEN CONVERT(dec(28,3),d.OrigDocAmt) * - 1
        WHEN 'DA' THEN CONVERT(dec(28,3),d.OrigDocAmt) * - 1
        WHEN 'DM' THEN CONVERT(dec(28,3),d.OrigDocAmt) 
        WHEN 'IN' THEN CONVERT(dec(28,3),d.OrigDocAmt) 
        WHEN 'FI' THEN CONVERT(dec(28,3),d.OrigDocAmt) 
        WHEN 'RF' THEN CONVERT(dec(28,3),d.OrigDocAmt)
        WHEN 'SC' THEN CONVERT(dec(28,3),d.OrigDocAmt)
        WHEN 'SB' THEN CONVERT(dec(28,3),d.OrigDocAmt)
        WHEN 'RP' THEN 0
        WHEN 'CS' THEN CONVERT(dec(28,3),d.OrigDocAmt)
        WHEN 'NS' THEN 0
        WHEN 'NC' THEN CONVERT(dec(28,3),d.OrigDocAmt)
	ELSE CONVERT(dec(28,3),d.OrigDocAmt) END

  FROM ARSetup s(nolock), 
       WrkRelease w INNER JOIN ARDoc d
                          ON w.BatNbr = d.BatNbr
                    INNER JOIN SalesPerson c
                          ON d.SlsPerID = c.SlsPerID
 WHERE w.Module = 'AR'

UNION 

SELECT PerNbr = 
        CASE 
        WHEN (SUBSTRING(c.PerNbr, 1, 4)) = SUBSTRING(d.PerPost, 1, 4)
        THEN c.PerNbr
        WHEN (SUBSTRING(c.PerNbr, 1, 4)) < SUBSTRING(d.PerPost, 1, 4)
        THEN (SUBSTRING(c.PerNbr, 1, 4)) + '00'
        WHEN (SUBSTRING(c.PerNbr, 1, 4)) > SUBSTRING(d.PerPost, 1, 4)
        THEN ' '
        END, d.DocDate, w.UserAddress, d.PerPost, 
       FiscYr = SUBSTRING(d.PerPost, 1, 4), 
       d.CustId, 'DA', d.SlsPerID, 
       CONVERT(dec(28,3),d.DiscBal) * - 1
  FROM ARSetup s(nolock), 
       WrkRelease w INNER JOIN ARDoc d
                          ON w.BatNbr = d.BatNbr
                    INNER JOIN SalesPerson c
                          ON d.SlsPerID = c.SlsPerID
 WHERE w.Module = 'AR' AND d.DiscBal <> 0


 
