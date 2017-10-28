 /****** Object:  Stored Procedure dbo.LocTable_SiteID_InvtID_Sales    Script Date: 4/17/98 10:58:18 AM ******/
/****** Object:  Stored Procedure dbo.LocTable_SiteID_InvtID_Sales    Script Date: 4/16/98 7:41:52 PM ******/
Create Proc LocTable_SiteID_InvtID_Sales @parm1 varchar ( 10), @parm2 varchar ( 30), @parm3 varchar ( 10) as
 Select * from LocTable LT,Location where LT.SiteID = @parm1
 and LT.SalesValid <> 'N' and ((LT.InvtIDValid = 'Y' and LT.InvtID = @parm2)
 or LT.InvtIDValid <> 'Y') and LT.SiteID = Location.SiteID and LT.InvtID = Location.InvtID
 and LT.WhseLoc like @parm3 Order by LT.WhseLoc


