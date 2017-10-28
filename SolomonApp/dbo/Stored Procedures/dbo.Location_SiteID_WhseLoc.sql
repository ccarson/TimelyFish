 /****** Object:  Stored Procedure dbo.Location_SiteID_WhseLoc    Script Date: 4/17/98 10:58:18 AM ******/
/****** Object:  Stored Procedure dbo.Location_SiteID_WhseLoc    Script Date: 4/16/98 7:41:52 PM ******/
Create Proc Location_SiteID_WhseLoc @parm1 varchar ( 10), @parm2 varchar ( 10) as
Select * from Location where SiteID = @parm1 and WhseLoc = @parm2

Order by SiteID,WhseLoc,InvtID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Location_SiteID_WhseLoc] TO [MSDSL]
    AS [dbo];

