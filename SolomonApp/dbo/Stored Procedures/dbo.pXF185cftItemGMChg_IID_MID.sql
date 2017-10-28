CREATE PROCEDURE pXF185cftItemGMChg_IID_MID 
	@parm1 varchar (30), 
	@parm2 varchar (6) 
	AS 
	SELECT * 
	FROM cftItemGMChg 
	WHERE InvtId = @parm1 
	AND MillId = @parm2
	ORDER BY InvtId, MillId	

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF185cftItemGMChg_IID_MID] TO [MSDSL]
    AS [dbo];

