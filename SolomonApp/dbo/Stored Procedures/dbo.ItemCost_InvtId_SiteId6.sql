 CREATE PROCEDURE ItemCost_InvtId_SiteId6
	@parm1 	varchar ( 30),
	@parm2 	varchar ( 10),
	@parm3 	varchar ( 25),
	@parm4	varchar ( 1),
	@parm5 	varchar ( 15),
	@parm6min	smalldatetime,
	@parm6max	smalldatetime

AS
  	SELECT 	*
 	FROM	ItemCost
  	WHERE 	InvtId = @parm1
            	and SiteId = @parm2
		and (SpecificCostId = @parm3 or SpecificCostID Is Null)
            	and LayerType = @parm4
            	and RcptNbr = @parm5
	        and RcptDate between @parm6min and @parm6max
	ORDER BY InvtId, SiteId, SpecificCostId, RcptNbr, RcptDate



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ItemCost_InvtId_SiteId6] TO [MSDSL]
    AS [dbo];

