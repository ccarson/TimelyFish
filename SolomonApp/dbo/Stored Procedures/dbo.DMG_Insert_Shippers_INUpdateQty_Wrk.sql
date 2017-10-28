 CREATE PROCEDURE DMG_Insert_Shippers_INUpdateQty_Wrk
   	@ComputerName   varchar(21),
    @ShipperID      varchar(15),
   	@CpnyID         varchar(10),
	@Crtd_Prog		varchar(8),
	@Crtd_User		varchar(10)
AS
INSERT INTO INUpdateQty_Wrk (ComputerName, InvtID, SiteID, Crtd_DateTime, Crtd_Prog, Crtd_User,
		                     LUpd_DateTime, LUpd_Prog, LUpd_User, UpdateSO)
SELECT DISTINCT @ComputerName, l.InvtID, l.SiteID, Convert(SmallDateTime, GetDate()), @Crtd_Prog, @Crtd_User,
	            Convert(SmallDateTime, GetDate()), @Crtd_Prog, @Crtd_User, 1
  FROM SOShipHeader h JOIN SOShipLine l (NOLOCK)
                        ON h.ShipperID = l.ShipperID
		               AND h.CpnyID = l.CpnyID
                      JOIN Inventory i (NOLOCK)
		                ON l.InvtID = i.InvtID
                      JOIN SOType t
                        ON h.SOTypeID = t.SOTypeID
                       AND h.CpnyID = t.CpnyID
WHERE i.StkItem = 1
  AND h.ShipperID = @ShipperID
  AND h.Cpnyid = @CpnyID
  AND t.Behavior IN ('DM', 'INVC', 'CS')
  AND h.OrdNbr = ' '
  AND NOT EXISTS (SELECT *
                    FROM INUpdateQty_Wrk
		           WHERE ComputerName = @ComputerName
		             AND InvtID = l.InvtID
                     AND SiteID = l.SiteID)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_Insert_Shippers_INUpdateQty_Wrk] TO [MSDSL]
    AS [dbo];

