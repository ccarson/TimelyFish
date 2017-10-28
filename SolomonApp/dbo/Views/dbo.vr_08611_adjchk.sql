 

CREATE view vr_08611_adjchk
as
SELECT SUM(adjamt- curyrgolamt)  adjamt, 
       SUM(curyadjgamt)  curyadjgamt,
       j.custid,
       j.adjgdoctype,
       j.adjgrefnbr,
       r.RI_ID
  FROM ARAdjust j,
       rptruntime r
 WHERE r.begpernbr >= j.perappl 
 GROUP BY r.ri_id,
       j.custid,
       j.adjgdoctype,
       j.adjgrefnbr



 
