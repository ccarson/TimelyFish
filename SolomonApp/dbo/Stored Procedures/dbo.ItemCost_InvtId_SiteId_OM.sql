 Create Proc ItemCost_InvtId_SiteId_OM
	@parm1 	varchar ( 30),
	@parm2 	varchar ( 10),
	@parm3 	varchar ( 25)

AS

  Select 	*
  from 		vp_ItemCost_OM
  where 	InvtId = @parm1
            	and SiteId = @parm2
		and SpecificCostId Like @parm3
  order by	InvtId, SiteId, SpecificCostId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ItemCost_InvtId_SiteId_OM] TO [MSDSL]
    AS [dbo];

