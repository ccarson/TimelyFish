
Create Procedure EDSC_UpdateContainerLotSerNbr
	@CpnyID varchar(10),
	@ShipperID varchar(15)
	
AS

--The purpose of this stored proc is to update automatically-created 
--ED Container Details with LotSerNbr values from Shipper SOShipLot records.
--Containers are created when the Shipper is created from the Sales Order.
--Serial Numbers may not yet be assigned when the Shipper is initially created.
--This proc is designed to be called from applications where SOShipLot
--Lot Serial Numbers are being updated.
--
--Note:  There is no exact foreign key match between the SOShipLot and EDContainer,
--so this routine is assuming that the EDContainerDet records were originally created
--from the SOShipLot records in InvtID order, and is using that ordering to match 
--them to the SOShipLot records when copying Lot Serial Number.
--
--Note:  This proc assumes that any needed EDContainerDet records have already been
--created, and will exit if none are found, or if all EDContainerDet records for items
--being tracked by a Lot or Serial number have been assigned a LotSerNbr value. 
--
--Note:  This proc will only do the update if all SOShipLot records for items
--being tracked by a Lot or Serial number have been assigned a LotSerNbr value. 
--
--Note:  This proc assumes that DB Transaction is begun before this proc is called
--and ended after this proc returns.

Set NOCOUNT ON

Declare @EDCDCount int
Declare @SOSLCount int
Declare @SOSLLineRef varchar(5)
Declare @SOSLInvtID varchar(30)
Declare @SOSLLotSerNbr varchar(25)
Declare @EDCDContainerID varchar(10)
Declare @EDCDLineNbr smallint


--Check whether Shipper has any Container Details where the Inventory
--Item is tracked by LotSerNbr and the LotSerNbr value is not yet assigned.
--If none are found, exit.
select @EDCDCount = COUNT(*) from EDContainerDet
join Inventory on Inventory.InvtID = EDContainerDet.InvtID
where EDContainerDet.CpnyID = @CpnyID
and EDContainerDet.ShipperID = @ShipperID
and EDContainerDet.LotSerNbr = ''
and (Inventory.LotSerTrack = 'SI' or Inventory.LotSerTrack = 'LI')

if @EDCDCount = 0 GoTo ExitProc

--Check whether all LotSerNbrs have been assigned for all 
--LotSerNbr-tracked Items on Shipper.
--If not, exit.
select @SOSLCount = COUNT(*) from SOShipLot
join Inventory on Inventory.InvtID = SOShipLot.InvtId
where SOShipLot.CpnyID = @CpnyID
and SOShipLot.ShipperID = @ShipperID
and SOShipLot.LotSerNbr = ''
and (Inventory.LotSerTrack = 'SI' or Inventory.LotSerTrack = 'LI')

if @SOSLCount <> 0 GoTo ExitProc

Declare SOShipLot_csr CURSOR FOR
SELECT SOShipLot.InvtID, SOShipLot.LotSerNbr, SOShipLot.LineRef 
FROM SOShipLot
JOIN Inventory on Inventory.InvtID = SOShipLot.InvtID
where SOShipLot.CpnyID = @CpnyID
and SOShipLot.ShipperID = @ShipperID
and SOShipLot.LotSerNbr <> ''
and (Inventory.LotSerTrack = 'SI' or Inventory.LotSerTrack = 'LI')
ORDER BY SOShipLot.InvtID, SOShipLot.LotSerNbr

Open SOShipLot_csr

Fetch Next from SOShipLot_csr
into @SOSLInvtID, @SOSLLotSerNbr, @SOSLLineRef

While (@@FETCH_STATUS = 0) Begin

	select @EDCDCount = COUNT(*) from EDContainerDet
	where EDContainerDet.CpnyID = @CpnyID
	and EDContainerDet.ShipperID = @ShipperID
	and EDContainerDet.InvtID = @SOSLInvtID
	and EDContainerDet.LotSerNbr = @SOSLLotSerNbr

	if @EDCDCount = 0 Begin
		select Top(1) @EDCDContainerID = EDContainerDet.ContainerID, @EDCDLineNbr = EDContainerDet.LineNbr
		from EDContainerDet
		where EDContainerDet.CpnyID = @CpnyID
		and EDContainerDet.ShipperID = @ShipperID
		and EDContainerDet.InvtID = @SOSLInvtID
		and EDContainerDet.LineRef = @SOSLLineRef
		and EDContainerDet.LotSerNbr = ''
		Order By EDContainerDet.ContainerID, EDContainerDet.LineNbr
		
		if @@ROWCOUNT > 0 Begin
			Update EDContainerDet
			Set EDContainerDet.LotSerNbr = @SOSLLotSerNbr
			Where EDContainerDet.ContainerID = @EDCDContainerID
			and EDContainerDet.LineNbr = @EDCDLineNbr
		end
	end
	
	Fetch Next from SOShipLot_csr
	into @SOSLInvtID, @SOSLLotSerNbr, @SOSLLineRef		
End

CLOSE SOShipLot_csr
DEALLOCATE SOShipLot_csr

ExitProc:

