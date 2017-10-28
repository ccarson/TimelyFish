 

CREATE VIEW PJvETask

AS 

SELECT distinct pjpent.project, 
	 pjpent.pjt_entity,
	 pjpent.pjt_entity_desc, 
	 pjpent.mspinterface, 
	 pjpent.status_pa, 
	 pjpent.status_lb, 
	 pjpentem.employee,
	 pjpent.status_ap 

FROM pjpent left outer join pjpentem on 
	 pjpent.project = pjpentem.project and 
	 pjpent.pjt_entity = pjpentem.pjt_entity 


 
