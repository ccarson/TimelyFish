 
create view vr_03681_adjvo as

SELECT SUM((adjamt+adjdiscamt)* CASE WHEN adjddoctype = 'AD' then -1 ELSE 1 END)  adjamt,  
       SUM((curyadjdamt+curyadjddiscamt)* CASE WHEN adjddoctype = 'AD' then -1 ELSE 1 END)  curyadjdamt,
       j.vendid,
       j.adjddoctype,
       j.adjdrefnbr,
       r.RI_ID
  FROM ApAdjust j, rptruntime r
 WHERE r.begpernbr >= j.perappl 
 GROUP BY r.ri_id,
       j.vendid,
       j.adjddoctype,
       j.adjdrefnbr


 
