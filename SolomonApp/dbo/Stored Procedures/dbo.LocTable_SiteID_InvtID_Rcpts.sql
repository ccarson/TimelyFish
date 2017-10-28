 /****** Object:  Stored Procedure dbo.LocTable_SiteID_InvtID_Rcpts    Script Date: 4/17/98 10:58:18 AM ******/
/****** Object:  Stored Procedure dbo.LocTable_SiteID_InvtID_Rcpts    Script Date: 4/16/98 7:41:52 PM ******/
Create Proc LocTable_SiteID_InvtID_Rcpts @parm1 varchar ( 10), @parm2 varchar ( 30), @parm3 varchar ( 10) as
Select * from LocTable where LocTable.SiteID = @parm1 and
LocTable.ReceiptsValid In ('Y','W') and
((LocTable.InvtIDValid = 'Y' and LocTable.InvtID = @parm2) or
LocTable.InvtIDValid = 'W' or LocTable.InvtIDValid = 'N' or LocTable.InvtID = '')
 and WhseLoc like @parm3
Order by SiteID,WhseLoc,InvtID


