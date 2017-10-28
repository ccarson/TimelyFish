 /****** Object:  Stored Procedure dbo.ItemCost_InvtId_SiteId1    Script Date: 4/17/98 10:58:17 AM ******/
/****** Object:  Stored Procedure dbo.ItemCost_InvtId_SiteId1    Script Date: 4/16/98 7:41:52 PM ******/
Create Proc ItemCost_InvtId_SiteId1 @parm1 varchar ( 30), @parm2 varchar ( 10) as
        Select * from ItemCost
                    where InvtId = @parm1
                    and SiteId = @parm2
                    order by InvtId, SiteId, RcptDate, RcptNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ItemCost_InvtId_SiteId1] TO [MSDSL]
    AS [dbo];

