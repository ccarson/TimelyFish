 create procedure PJEMPPJT_SMSP  @parm1 smalldatetime  as
SELECT M1.employee, M1.emp_name, M1.MSPRes_UID, M1.edate, r2.labor_rate
from
    (SELECT e.employee, e.emp_name, e.MSPRes_UID, MAX(r.effect_date)as edate
       FROM Pjemploy e
	   JOIN Pjemppjt r
		 ON e.employee = r.employee
        where e.mspinterface = 'Y' and
	  	   	e.mspres_UID <> 0 and
	  		r.project = 'na' and
      		r.effect_date <= @parm1
		group by e.employee, e.emp_name, e.MSPRes_UID) as M1,
	pjemppjt r2
where
M1.employee = r2.employee and
   M1.edate = r2.effect_date


