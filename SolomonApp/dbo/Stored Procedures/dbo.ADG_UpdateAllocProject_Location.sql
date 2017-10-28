
Create Proc ADG_UpdateAllocProject_Location
	@InvtID		Varchar(30),
	@SiteID		Varchar(10),
	@WhseLoc	Varchar(10),
        @CpnyID         Varchar(10),
	@ProgID		Varchar(8),
	@UserID		Varchar(10),
        @Qty            Float
        
As

	
	insert	Location
	(
		CountStatus, Crtd_DateTime, Crtd_Prog, Crtd_User,
		InvtID, LUpd_DateTime, LUpd_Prog, LUpd_User, NoteId,
		QtyAlloc, QtyOnHand, QtyShipNotInv, QtyWORlsedDemand,
		S4Future01, S4Future02, S4Future03, S4Future04,
		S4Future05, S4Future06, S4Future07, S4Future08,
		S4Future09, S4Future10, S4Future11, S4Future12,
		Selected, SiteID, User1, User2, User3, User4,
		User5, User6, User7, User8, WhseLoc
	)
	select
		'A', getdate(), @ProgID, @UserID,
		@InvtID, getdate(), @ProgID, @UserID, 0,
		0, 0, 0, 0,
		'', '', 0, 0,
		0, 0, '', '',
		0, 0, '', '',
		0, @SiteID, '', '', 0, 0,
		'', '', '', '', @WhseLoc

	from	Inventory (nolock)
	where	InvtID = @InvtID
	and	not exists (	select	InvtID, SiteID, WhseLoc
				from	Location
				where	InvtID = @InvtID
				and	SiteID = @SiteID
				and	WhseLoc = @WhseLoc)
if @@error != 0 return(@@error)

update Location set
	QtyAllocIN = convert(dec(25,9),QtyAllocIN) + @qty,
	PrjINQtyAllocIN = convert(dec(25,9),PrjINQtyAllocIN) + @qty,
      	LUpd_Prog = @ProgId,
	LUpd_User = @UserId,
	LUpd_DateTime = getdate()
where InvtID = @InvtID and SiteID = @SiteID and WhseLoc = @WhseLoc
if @@error != 0 return(@@error)


GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_UpdateAllocProject_Location] TO [MSDSL]
    AS [dbo];

