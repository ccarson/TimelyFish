 Create Proc ItemCost_InvtId_SiteId4
	@parm1 	varchar ( 30),
	@parm2 	varchar ( 10),
	@parm3 	varchar ( 25),
	@parm4	varchar ( 1),
	@parm5 	varchar ( 15)
AS
  Select 	*
  from 		ItemCost
  where 	InvtId = @parm1
            	and SiteId = @parm2
		and (SpecificCostId = @parm3 or SpecificCostID Is Null)
            	and LayerType = @parm4
            	and RcptNbr like @parm5
  order by	InvtId, SiteId, SpecificCostId, RcptNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ItemCost_InvtId_SiteId4] TO [MSDSL]
    AS [dbo];

