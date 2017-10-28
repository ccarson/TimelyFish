 CREATE PROC DMG_SerialNumber_Check2
 	@InvtID varchar(30),
        @SiteID varchar(10),
        @LotSerNbr varchar (25),
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
  when @SerAssign = 'U' and @QtySign = 1 and exists(
    select *
    from SOShipLot sol
    inner join SOShipHeader soh on soh.CpnyID = sol.CpnyID and soh.ShipperID = sol.ShipperID
    left join LotSerMst lsm on lsm.InvtID = sol.InvtID and lsm.SiteID = soh.SiteID and lsm.LotSerNbr = sol.LotSerNbr and lsm.QtyAlloc = 0 and lsm.QtyShipNotInv = 0
    where sol.ShipperID <> @ShipperID and sol.InvtID = @InvtID and soh.SiteID = @SiteID and sol.LotSerNbr = @LotSerNbr and soh.Cancelled = 0 and (soh.Status = 'O' or lsm.InvtID is not null)) and
    not exists(
    select *
    from SOShipLot sol
    inner join SOShipHeader soh on soh.CpnyID = sol.CpnyID and soh.ShipperID = sol.ShipperID
    where sol.ShipperID = @ShipperID and sol.InvtID = @InvtID and soh.SiteID = @SiteID and sol.LotSerNbr = @LotSerNbr and soh.Cancelled = 0 and soh.Status = 'O')
  then 15487
  when @SerAssign = 'U' and @QtySign = -1 and exists(
    select *
    from SOShipLot sol
    inner join SOShipHeader soh on soh.CpnyID = sol.CpnyID and soh.ShipperID = sol.ShipperID
    left join LotSerMst lsm on lsm.InvtID = sol.InvtID and lsm.SiteID = soh.SiteID and lsm.LotSerNbr = sol.LotSerNbr
    where sol.ShipperID <> @ShipperID and sol.InvtID = @InvtID and soh.SiteID = @SiteID and sol.LotSerNbr = @LotSerNbr and soh.Cancelled = 0 and (soh.Status = 'O' or lsm.InvtID is null))
  then 15450
  when @SerAssign = 'R' and @QtySign = 1 and not exists (
    select * from LotSerMst lsm
    where lsm.InvtID = @InvtID and lsm.SiteID = @SiteID and lsm.LotSerNbr = @LotSerNbr and lsm.Status = 'A')
  then 15450
  when @SerAssign = 'R' and @QtySign = 1 and not exists (
    select * from LotSerMst lsm
    where lsm.InvtID = @InvtID and lsm.SiteID = @SiteID and lsm.LotSerNbr = @LotSerNbr and lsm.Status = 'A' and (lsm.QtyOnHand - lsm.QtyShipNotInv) > 0 )
  then 15487
  when @SerAssign = 'R' and @QtySign = -1 and exists (
    select * from LotSerMst lsm
    where lsm.InvtID = @InvtID and lsm.SiteID = @SiteID and lsm.LotSerNbr = @LotSerNbr and (lsm.QtyOnHand - lsm.QtyShipNotInv) > 0 )
  then 15450
  else 0 end)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SerialNumber_Check2] TO [MSDSL]
    AS [dbo];

