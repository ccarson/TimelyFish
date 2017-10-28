
Create proc LotSerMst_SOShipLot_WhseLoc
@parm1 varchar(10), --Company ID
@parm2 varchar(15), --Shipper ID
@parm3 varchar(5),  --Shipper Detail LineRef
@parm4 varchar(30), --Inventory ID
@parm5 varchar(10), --Site ID
@parm6 varchar(25), --LotSer Number
@parm7 varchar(10)  --Whse Loc

AS

select LotSerMst.* from LotSerMst
join SOShipLot
		on soshiplot.InvtId = LotSerMst.InvtID
		and SOshiplot.LotSerNbr = LotSerMst.LotSerNbr
		and soshiplot.WhseLoc = LotSerMst.WhseLoc
		and soshiplot.CpnyID = @parm1
		and soshiplot.ShipperID = @parm2
		and soshiplot.LineRef = @parm3
		and soshiplot.InvtId = @parm4
where
	LotSerMst.SiteID = @parm5 
	and LotSerMst.LotSerNbr = @parm6
	and LotSerMst.WhseLoc like @parm7
	and (LotSerMst.QtyOnHand - LotSerMst.QtyShipNotInv) > 0
order by LotSerMst.WhseLoc, LotSerMst.LotSerNbr


GO
GRANT CONTROL
    ON OBJECT::[dbo].[LotSerMst_SOShipLot_WhseLoc] TO [MSDSL]
    AS [dbo];

