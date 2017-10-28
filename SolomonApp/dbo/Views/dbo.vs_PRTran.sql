 

CREATE VIEW vs_PRTran AS 
    select e.EmpId, e.Name, t.Batnbr, 'NO' as CurrBatNbr
      from Employee e INNER JOIN PRTran t 
        ON e.EmpId      =  t.EmpId
       and t.Batnbr     <> '' 
       and t.TimeShtFlg =  1 
     group by e.EmpId, e.Name, BatNbr
     UNION
    select e.EmpId, e.Name, '' as BatNbr, 'YES' as CurrBatNbr
      from Employee e

 
