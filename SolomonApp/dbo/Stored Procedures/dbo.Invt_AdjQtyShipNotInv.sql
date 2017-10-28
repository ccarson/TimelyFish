 
 create proc Invt_AdjQtyShipNotInv  
	 @InvtID   varchar(30),  
	 @SiteID   varchar(10),  
	 @WhseLoc  varchar(10),  
	 @LotSerNbr  varchar(25),   
	 @QtyShip  float,  
	 @ProgID   varchar(8),  
	 @UserID   varchar(10)
as  
 set nocount on  
  
 declare @QtyPrec smallint  
 declare @StkItem smallint  
  
 -- Exit if no quantity is being adjusted.  
 if (@QtyShip = 0)  
	return  
  
 -- Fetch information from Inventory.  
 select @StkItem = StkItem  
	from Inventory (nolock)  
	where InvtID = @InvtID  
  
 -- Exit if the item is not a stock item.  
 if (@StkItem = 0)  
	return  
	
 -- Get the precision.  
 select @QtyPrec = (select DecPlQty from INSetup (nolock))  
  
 -- LotSerMst  
 if (rtrim(@LotSerNbr) > '')  
 begin  
	update LotSerMst  
	set ShipConfirmQty = round((ShipConfirmQty + @QtyShip), @QtyPrec),
		LUpd_DateTime = GetDate(),  
		LUpd_Prog = @ProgID,  
		LUpd_User = @UserID  
	where InvtID = @InvtID  
		and SiteID = @SiteID  
		and  WhseLoc = @WhseLoc  
		and LotSerNbr = @LotSerNbr  
 end  
  
 -- Location  
 update Location  
 set ShipConfirmQty = round((ShipConfirmQty + @QtyShip), @QtyPrec),  
	LUpd_DateTime = GetDate(),  
	LUpd_Prog = @ProgID,  
	LUpd_User = @UserID  
	where InvtID = @InvtID  
		and SiteID = @SiteID  
		and  WhseLoc = @WhseLoc    
	

GO
GRANT CONTROL
    ON OBJECT::[dbo].[Invt_AdjQtyShipNotInv] TO [MSDSL]
    AS [dbo];

