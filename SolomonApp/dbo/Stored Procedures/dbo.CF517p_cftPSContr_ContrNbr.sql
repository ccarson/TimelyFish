Create Procedure CF517p_cftPSContr_ContrNbr @parm1 varchar (10) as 
    Select * from cftPSContr Where ContrNbr Like @parm1
	Order by ContrNbr			
