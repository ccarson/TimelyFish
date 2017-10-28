 
create view vr_08611_adjinv as

SELECT SUM(adjamt + adjdiscamt)  adjamt,  
       SUM(curyadjdamt + curyadjddiscamt) curyadjdamt,
       j.custid,
       j.adjddoctype,
       j.adjdrefnbr,
       r.RI_ID
  FROM ARAdjust j, rptruntime r
 WHERE r.begpernbr >= j.perappl 
 GROUP BY r.ri_id,
       j.custid,
       j.adjddoctype,
       j.adjdrefnbr


 
