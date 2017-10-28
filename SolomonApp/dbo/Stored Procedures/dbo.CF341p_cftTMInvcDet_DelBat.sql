CREATE PROCEDURE CF341p_cftTMInvcDet_DelBat @parm1 varchar (10)  
	as
    	Delete FROM cftTMInvcDet 
	WHERE BatNbr = @parm1 
