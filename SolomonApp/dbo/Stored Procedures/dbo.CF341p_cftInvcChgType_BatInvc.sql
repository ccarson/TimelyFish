CREATE PROCEDURE CF341p_cftInvcChgType_BatInvc @parm1 varchar (10), @parm2 varchar (10) 
	as
    	SELECT i.*, c.* FROM cftTMInvcChg i 
	Left Join cftTMChrgType c on i.ChrgId = c.ChrgId 
	WHERE i.BatNbr = @parm1 
	AND i.RefNbr = @parm2
	ORDER BY i.BatNbr, i.RefNbr, i.ChrgId

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF341p_cftInvcChgType_BatInvc] TO [MSDSL]
    AS [dbo];

