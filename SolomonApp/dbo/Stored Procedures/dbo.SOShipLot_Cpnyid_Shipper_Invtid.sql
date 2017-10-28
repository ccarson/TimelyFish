Create Proc SOShipLot_Cpnyid_Shipper_Invtid
@parm1 varchar ( 10),
@parm2 varchar ( 15), 
@parm3 varchar ( 30) as

Select lo.InvtId, lo.QtyPick, lo.QtyShip, li.SiteID, lo.WhseLoc, lo.LotSerNbr
from SOShipLot lo
	inner join soshipline li
		on lo.ShipperID = li.ShipperID
			and lo.CpnyID = li.CpnyID
			and lo.InvtID = li.InvtID
Where lo.CpnyID = @parm1
	and lo.ShipperID = @parm2
	and lo.InvtID = @parm3
Order by lo.LotSerRef
