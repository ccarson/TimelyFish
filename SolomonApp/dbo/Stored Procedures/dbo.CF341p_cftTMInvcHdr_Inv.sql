CREATE PROCEDURE CF341p_cftTMInvcHdr_Inv @parm1 varchar (15), @parm2 varchar (10) 
	as 
	SELECT * FROM cftTMInvcHdr 
	WHERE VendID = @parm1 
	AND InvcNbr Like @parm2
	ORDER BY VendID, InvcNbr
