CREATE PROCEDURE CF341p_cftTMInvcDet_DelInvc @parm1 varchar (10), @parm2 varchar (10)  
	as
    	Delete FROM cftTMInvcDet 
	WHERE BatNbr = @parm1 
	AND RefNbr = @parm2

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF341p_cftTMInvcDet_DelInvc] TO [MSDSL]
    AS [dbo];

