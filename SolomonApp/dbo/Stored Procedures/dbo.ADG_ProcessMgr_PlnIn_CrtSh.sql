
create procedure ADG_ProcessMgr_PlnIn_CrtSh
	@InvtIDParm		varchar(30),
	@TranStatusCode varchar(2)
as
	declare @SiteIDParm		varchar(10)
	declare @CpnyID			varchar(10)
	declare @ComputerName   	varchar(21)
	declare	@DelayMins		smallint
	declare	@CPSOnOff		smallint
	declare @InvtID			varchar(30)
	declare @SiteID			varchar(10)
	declare @ProcessPriority 	smallint

	select	@DelayMins = 0

	select	@CPSOnOff = CPSONOFF From INSetup (NOLOCK)
	select  @ProcessPriority = 1
	select  @SiteIDParm = '%'
	select  @ComputerName = ''

	DECLARE ItemSiteCursor SCROLL CURSOR FOR	
			select InvtID, SiteID, CpnyID from ItemSite i1 (nolock)  
			where i1.InvtID like @InvtIDParm  
			and i1.SiteID like @SiteIDParm  
			and (  
			 -- ItemSite records with any quantities  
			 QtyAlloc <> 0 or  
			 QtyAvail <> 0 or  
			 QtyCustOrd <> 0 or  
			 QtyIntransit <> 0 or  
			 QtyNotAvail <> 0 or  
			 QtyOnBO <> 0 or  
			 QtyOnDP <> 0 or  
			 QtyOnHand <> 0 or  
			 QtyOnKitAssyOrders <> 0 or  
			 QtyOnPO <> 0 or  
			 QtyOnTransferOrders <> 0 or  
			 QtyShipNotInv <> 0  
			  
			 or exists  
			  -- Plan records that are not plan type 10 or ones that are plan  
			  -- type 10 with a quantity  
			  (select *  
			  from SOPlan (nolock)  
			  where SOPlan.InvtID = i1.InvtID  
			  and SOPlan.SiteID = i1.SiteID  
			  and (SOPlan.PlanType <> 10 or (SOPlan.PlanType = 10 and Qty <> 0)))  
			  
			 or exists  
			  -- Open Sales Order lines with a reserving Behavior  
			  (select *  
			  from SOLine (nolock)  
			  where SOLine.InvtID = i1.InvtID  
			  and SOLine.SiteID = i1.SiteID  
			  and SOLine.Status = 'O')  
			  
			 or exists  
			  -- Open Workorders using the Kit item  
			  -- The main Sales Order query handles the components of the kit  
			  (select *  
			  from SOHeader (nolock)  
			  where SOHeader.BuildInvtID = i1.InvtID  
			  and SOHeader.BuildSiteID = i1.SiteID  
			  and SOHeader.Status = 'O')  
			  
			 or exists  
			  -- Open Transfers using the 'To' site  
			  -- The main Sales Order query handles the 'From' site  
			  (select *  
			  from SOLine (nolock)  
			  join SOHeader (nolock)  
			  on SOHeader.CpnyID = SOLine.CpnyID  
			  and SOHeader.OrdNbr = SOLine.OrdNbr  
			  where SOLine.InvtID = i1.InvtID  
			  and SOHeader.ShipSiteID = i1.SiteID  
			  and SOLine.Status = 'O'  
			  and SOHeader.Status = 'O')  
			  
			 or exists  
			  -- Open Shipper lines with a reserving Behavior  
			  (select *  
			  from SOShipLine (nolock)  
			  where SOShipLine.InvtID = i1.InvtID  
			  and SOShipLine.SiteID = i1.SiteID  
			  and SOShipLine.Status = 'O')  
			  
			 or exists  
			  -- Open (Shipper) Workorders using the Kit item  
			  -- The main Shipper query handles the components of the kit  
			  (select *  
			  from SOShipHeader (nolock)  
			  where SOShipHeader.BuildInvtID = i1.InvtID  
			  and SOShipHeader.SiteID = i1.SiteID  
			  and SOShipHeader.Status = 'O')  
			  
			 or exists  
			  -- Open (Shipper) Transfers using the 'To' site  
			  -- The main Sales Order query handles the 'From' site  
			  (select *  
			  from SOShipLine (nolock)  
			  join SOShipHeader (nolock)  
			  on SOShipHeader.CpnyID = SOShipLine.CpnyID  
			  and SOShipHeader.ShipperID = SOShipLine.ShipperID  
			  where SOShipLine.InvtID = i1.InvtID  
			  and SOShipHeader.ShipSiteID = i1.SiteID  
			  and SOShipLine.Status = 'O'  
			  and SOShipHeader.Status = 'O')  
			  
			 or exists  
			  -- Open Purchase Order lines  
			  (select *  
			  from PurOrdDet (nolock)  
			  where PurOrdDet.InvtID = i1.InvtID  
			  and PurOrdDet.SiteID = i1.SiteID  
			  and PurOrdDet.OpenLine = 1)  
			  )  
	OPEN ItemSiteCursor
	
	FETCH FIRST FROM ItemSiteCursor INTO @InvtID, @SiteID, @CpnyID
		
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		EXECUTE ADG_ProcessMgr_QueueInvt @CpnyID, @InvtID, @SiteID, @CPSOnOff, @ComputerName, @ProcessPriority	
		
		IF @TranStatusCode IN ('AC', 'NP')
			EXECUTE ADG_ProcessMgr_QueueShInvt @InvtID, @SiteID
		
		FETCH NEXT FROM ItemSiteCursor INTO @InvtID, @SiteID, @CpnyID
	END

	CLOSE ItemSiteCursor
	DEALLOCATE ItemSiteCursor
