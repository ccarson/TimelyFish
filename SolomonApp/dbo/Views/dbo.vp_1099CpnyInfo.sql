 

CREATE VIEW vp_1099CpnyInfo AS  			
 
SELECT r.RI_ID RI_ID, 
       c2.Master_Fed_ID Master_Fed_ID,
       c2.CpnyID CpnyID

FROM RptCompany r INNER JOIN vs_Company c ON r.cpnyid = c.cpnyid
                  INNER JOIN vs_Company c2 ON c.master_FED_id = c2.master_Fed_ID
GROUP BY r.RI_ID, c2.master_fed_ID, c2.cpnyid

 
