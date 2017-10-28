 Create Procedure ItemSite_CheckSiteIDDelete
	@parmSiteID varchar (10)
as
Select * From ItemSite where SiteID = @parmSiteID and
	(QtyOnHand <> 0 Or
         QtyOnPO <> 0 Or
         QtyOnKitAssyOrders <> 0 Or
         QtyOnTransferOrders <> 0 Or
         QtyWOFirmSupply <> 0 Or
         QtyWORlsedSupply <> 0 Or
         QtyCustOrd <> 0 Or
         QtyOnBO <> 0 Or
         QtyAlloc <> 0 Or
         QtyShipNotInv <> 0 Or
         QtyWOFirmDemand <> 0 Or
         QtyWORlsedDemand <> 0 Or
         TotCost <> 0)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ItemSite_CheckSiteIDDelete] TO [MSDSL]
    AS [dbo];

