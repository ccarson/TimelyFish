 /****** Object:  Stored Procedure dbo.ItemCost_InvtId_SiteId_3    Script Date: 4/17/98 10:58:17 AM ******/
/****** Object:  Stored Procedure dbo.ItemCost_InvtId_SiteId_3    Script Date: 4/16/98 7:41:52 PM ******/
Create Proc ItemCost_InvtId_SiteId_3
		@parm1 varchar ( 30),
		@parm2 varchar ( 10),
		@parm3 varchar ( 25),
		@parm4 varchar ( 15),
		@parm5 smalldatetime,
		@parm6 smalldatetime
as
        Select * from ItemCost
                    where InvtId = @parm1
                    and SiteId = @parm2
                    and (SpecificCostId = @parm3 OR SpecificCostId = '')
                    and RcptNbr like @parm4
                    and RcptDate between @parm5 and @parm6
                    order by InvtId, SiteId, SpecificCostId, RcptNbr, RcptDate



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ItemCost_InvtId_SiteId_3] TO [MSDSL]
    AS [dbo];

