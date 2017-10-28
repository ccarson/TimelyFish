CREATE PROCEDURE CF341p_cfvMills_TMillId @parm1 varchar (6) 
	as 
   	SELECT * FROM cfvMills 
	WHERE MillId Like @parm1 
	AND Exists (SELECT * FROM cftTMVendor WHERE MillId = cfvMills.MillId)
	ORDER BY MillId
