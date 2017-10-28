 CREATE PROC Inventory_Quantities_Total
	@Parm1 Char(30)
AS
	SELECT SUM(QtyAlloc),           SUM(QtyAvail), SUM(QtyCustOrd),          SUM(QtyInTransit),
	       SUM(QtyNotAvail),        SUM(QtyOnBO),  SUM(QtyOnDP),             SUM(QtyOnHand),
	       SUM(QtyOnKitAssyOrders), SUM(QtyOnPO),  SUM(QtyOnTransferOrders),
	       SUM(QtyShipNotInv),      SUM(TotCost)
	FROM   Itemsite
	WHERE  InvtID = @Parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Inventory_Quantities_Total] TO [MSDSL]
    AS [dbo];

