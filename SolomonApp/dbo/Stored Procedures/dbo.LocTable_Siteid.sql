 /****** Object:  Stored Procedure dbo.LocTable_Siteid    Script Date: 4/17/98 10:58:18 AM ******/
/****** Object:  Stored Procedure dbo.LocTable_Siteid    Script Date: 4/16/98 7:41:52 PM ******/
Create Proc LocTable_Siteid @parm1 varchar ( 10), @parm2 varchar ( 10) as
Select * from LocTable where Siteid = @parm1 and WhseLoc like @parm2
Order by SiteID, WhseLoc


