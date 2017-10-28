 /****** Object:  Stored Procedure dbo.Location_SiteID_WhseLoc_InvtId    Script Date: 4/17/98 10:58:18 AM ******/
/****** Object:  Stored Procedure dbo.Location_SiteID_WhseLoc_InvtId    Script Date: 4/16/98 7:41:52 PM ******/
Create Proc Location_SiteID_WhseLoc_InvtId @parm1 varchar ( 10), @parm2 varchar ( 10) , @parm3 varchar ( 30) as
Select InvtId, Sum(QtyAlloc), Sum(QtyOnHand), SiteId, WhseLoc from Location where SiteID = @parm1 and WhseLoc = @parm2 and InvtId = @parm3
	group by SiteID,WhseLoc,InvtID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Location_SiteID_WhseLoc_InvtId] TO [MSDSL]
    AS [dbo];

