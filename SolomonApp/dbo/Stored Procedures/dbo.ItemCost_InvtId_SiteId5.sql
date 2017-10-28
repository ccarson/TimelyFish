 Create Proc ItemCost_InvtId_SiteId5
	@parm1 	varchar ( 30),
	@parm2 	varchar ( 10),
	@parm3	varchar ( 1),
	@parm4 	varchar ( 25)
AS
	Select 	*
   	from 	ItemCost
   	where 	InvtId = @parm1
            and SiteId = @parm2
            and LayerType = @parm3
            and SpecificCostId Like @parm4
	order by InvtId, SiteId, SpecificCostId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ItemCost_InvtId_SiteId5] TO [MSDSL]
    AS [dbo];

