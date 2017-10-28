CREATE PROCEDURE CF341p_cftFOTMID_BIMDC @parm1 varchar (10), @parm2 varchar (10), @parm3 varchar (6), 
	@parm4 smalldatetime, @parm5 varchar (6) 
	as
    	SELECT f.*, i.* FROM cftFeedOrder f 
	Left Join cftTMInvcDet i on f.OrdNbr = i.OrdNbr
	WHERE (i.BatNbr = @parm1 or i.BatNbr Is Null) 
	AND (i.RefNbr = @parm2 or i.RefNbr Is Null) 
	AND f.MillId = @parm3 
	AND f.ContactId = @parm5 
	--AND f.DateSched <= @parm4 
	AND f.BatNbrAP = ''
	AND Not Exists (SELECT * FROM cftFOSetup WHERE f.Status = StatusCplt or f.Status = StatusCxl)
	ORDER BY f.OrdNbr
