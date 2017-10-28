 Create Proc ItemCost_InvtId_SiteId @parm1 varchar ( 30), @parm2 varchar ( 10), @parm3 varchar (25) as
        Select *
             from ItemCost
             where InvtId = @parm1
               and SiteId = @parm2
               and SpecificCostId Like @parm3
             order by InvtId, SiteId, SpecificCostId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ItemCost_InvtId_SiteId] TO [MSDSL]
    AS [dbo];

