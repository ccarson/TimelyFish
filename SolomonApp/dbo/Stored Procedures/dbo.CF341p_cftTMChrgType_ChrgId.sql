CREATE PROCEDURE CF341p_cftTMChrgType_ChrgId @parm1 varchar (5) 
	as
	SELECT * FROM cftTMChrgType 
	WHERE ChrgId Like @parm1
	ORDER BY ChrgId
