 CREATE PROCEDURE DMG_LocTable_LocAvail
 	@parm1 varchar ( 30),
 	@parm2 varchar ( 10),
	@parm3 varchar ( 10)
AS
SELECT LocTable.*, Location.*
FROM LocTable
LEFT JOIN Location
ON LocTable.SiteID = Location.SiteID
AND LocTable.WhseLoc = Location.WhseLoc
AND Location.InvtID LIKE @parm1
WHERE LocTable.SiteID LIKE @parm2 AND LocTable.WhseLoc LIKE @parm3
ORDER BY LocTable.SiteID, LocTable.WhseLoc



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_LocTable_LocAvail] TO [MSDSL]
    AS [dbo];

