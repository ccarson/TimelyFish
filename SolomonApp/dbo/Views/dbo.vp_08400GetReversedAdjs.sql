 

Create view vp_08400GetReversedAdjs
AS

select
rpbatnbr = g.s4future11,
n.AdjBatnbr,
n.CuryAdjgAmt,
n.AdjAmt, 
n.CuryAdjgDiscAmt,
n.curyRGOLAmt,
n.AdjDiscAmt,
n.Adjgrefnbr,

Adjgdoctype = (Case When pa.doctype = 'VT' then 'VT'
                             else n.Adjgdoctype end),
n.Custid,
n.adjddoctype,
n.adjdrefnbr,
n.recordid,
invbankacct = inv.bankacct,
invbanksub = inv.banksub,
pabankacct = pa.bankacct,
pabanksub = pa.banksub,
w.useraddress

  FROM Wrkrelease w INNER LOOP JOIN aradjust g ON w.batnbr = g.s4future11
                                              AND w.module = 'AR'
                    INNER LOOP JOIN aradjust n ON n.adjbatnbr = g.adjbatnbr 
                                          AND n.custid     =g.custid
					  AND g.adjgdoctype = 'RP'
                                          AND n.adjgrefnbr = g.adjgrefnbr 
					  AND n.adjddoctype = g.adjddoctype 
					  AND n.adjdrefnbr = g.adjdrefnbr
                                          AND n.adjamt > 0 and g.adjamt < 0
                    INNER LOOP JOIN ardoc inv ON n.custid = inv.custid 
                                         AND n.adjddoctype = inv.doctype 
					 AND n.adjdrefnbr = inv.refnbr

                    INNER LOOP JOIN ardoc pa  ON n.adjgrefnbr = pa.refnbr
                                         AND n.custid = pa.custid
where 	((pa.doctype = n.adjgdoctype) or
	  (pa.doctype = 'VT') or (pa.doctype = 'PA' and n.adjgdoctype = 'SB'))
  
	 


 
