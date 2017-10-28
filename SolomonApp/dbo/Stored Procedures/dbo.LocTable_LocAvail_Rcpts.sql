 Create Proc LocTable_LocAvail_Rcpts @parm0 varchar ( 30), @parm1 varchar ( 10), @parm2 varchar ( 30), @parm3 varchar ( 10) as
SELECT LocTable.*, Location.* FROM LocTable LEFT JOIN Location ON LocTable.SiteID = Location.SiteID AND LocTable.WhseLoc = Location.WhseLoc AND Location.InvtID LIKE @parm0 where LocTable.SiteID = @parm1 and
LocTable.ReceiptsValid In ('Y','W') and
((LocTable.InvtIDValid = 'Y' and LocTable.InvtID = @parm2) or
LocTable.InvtIDValid = 'W' or LocTable.InvtIDValid = 'N' or LocTable.InvtID = '')
 and LocTable.WhseLoc like @parm3
Order by LocTable.SiteID,LocTable.WhseLoc


