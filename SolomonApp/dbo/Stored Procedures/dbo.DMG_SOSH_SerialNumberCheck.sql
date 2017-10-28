 create proc DMG_SOSH_SerialNumberCheck
	@InvtID varchar(30),
	@SiteID varchar(10),
	@LotSerNbr varchar(25),
	@OrdNbr varchar(15),
	@ShipperID varchar(15),
	@SerAssign varchar(1),
	@QtySign smallint
as

select convert(smallint, case
	when exists(
    	select *
    	from SOShipLot sol
    	inner join SOShipHeader soh on soh.CpnyID = sol.CpnyID and soh.ShipperID = sol.ShipperID
    	where sol.ShipperID <> @ShipperID and sol.InvtID = @InvtID and soh.SiteID = @SiteID and sol.LotSerNbr = @LotSerNbr and soh.Cancelled = 0 and soh.Status = 'O')
	then 15422
	when exists(
    	select *
    	from SOLot sol
		inner join SOSched sos on sos.CpnyID = sol.CpnyID and sos.OrdNbr = sol.OrdNbr and sos.LineRef = sol.LineRef and sos.SchedRef = sol.SchedRef
    	inner join SOHeader soh on soh.CpnyID = sol.CpnyID and soh.OrdNbr = sol.OrdNbr
    	where sol.OrdNbr <> @OrdNbr and sol.InvtID = @InvtID and sos.SiteID = @SiteID and sol.LotSerNbr = @LotSerNbr and soh.Cancelled = 0 and soh.Status = 'O')
	then 15422
	when @SerAssign = 'U' and @QtySign = 1 and
	exists(
    	select *
	    from LotSerMst lsm
    	where lsm.InvtID = @InvtID and lsm.SiteID = @SiteID and lsm.LotSerNbr = @LotSerNbr)
    and (@ShipperID = '' or not exists(
	    select *
    	from SOShipLot sol
    	inner join SOShipHeader soh on soh.CpnyID = sol.CpnyID and soh.ShipperID = sol.ShipperID
    	where sol.ShipperID = @ShipperID and sol.InvtID = @InvtID and soh.SiteID = @SiteID and sol.LotSerNbr = @LotSerNbr and soh.Cancelled = 0 and soh.Status = 'O'))
    and (@OrdNbr =  '' or not exists(
	    select *
    	from SOLot sol
		inner join SOSched sos on sos.CpnyID = sol.CpnyID and sos.OrdNbr = sol.OrdNbr and sos.LineRef = sol.LineRef and sos.SchedRef = sol.SchedRef
	    inner join SOHeader soh on soh.CpnyID = sol.CpnyID and soh.OrdNbr = sol.OrdNbr
    	where sol.OrdNbr = @OrdNbr and sol.InvtID = @InvtID and sos.SiteID = @SiteID and sol.LotSerNbr = @LotSerNbr and soh.Cancelled = 0 and soh.Status = 'O'))
	then 15450
	when @SerAssign = 'U' and @QtySign = -1 and not exists(
    	select *
    	from LotSerMst lsm
	    where lsm.InvtID = @InvtID and lsm.SiteID = @SiteID and lsm.LotSerNbr = @LotSerNbr)
  	then 15450
	when @SerAssign = 'R' and @QtySign = 1 and not exists (
    	select * from LotSerMst lsm
    	where lsm.InvtID = @InvtID and lsm.SiteID = @SiteID and lsm.LotSerNbr = @LotSerNbr and lsm.Status = 'A' and (lsm.QtyOnHand - lsm.QtyShipNotInv) > 0 )
  	then 15450
	when @SerAssign = 'R' and @QtySign = -1 and exists (
    	select * from LotSerMst lsm
    	where lsm.InvtID = @InvtID and lsm.SiteID = @SiteID and lsm.LotSerNbr = @LotSerNbr and lsm.Status = 'A' and (lsm.QtyOnHand - lsm.QtyShipNotInv) > 0 )
  	then 15406
	else 0 end)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOSH_SerialNumberCheck] TO [MSDSL]
    AS [dbo];

