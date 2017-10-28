


CREATE procedure [dbo].[cfp_Sky_UpdateAllocatedIN]
	@InvtID		Varchar(30),
	@SiteID		Varchar(10),
	@NewAlloc	float
AS

/* 
	Created 2/5/2015 by BMD
	Created to run after Scribe AR/IN batch process runs.  This updates the quantity allocated numbers so inventory looks correct in inventory inquiry screens.
*/

	Declare @WhseLoc	Varchar(10),	
			@ProgID		Varchar(8),	
			@UserID		Varchar(10),	
			@OldBucket	smallint,
			@NewBucket	smallint,
			@OldAlloc	float,	
			@CpnyID		Varchar(10),
			@Expensed	Varchar(5)
	
	set 	@WhseLoc=	'00'
	set 	@ProgID	=	'SCRIBE'
	set 	@UserID	=	''
	set 	@OldBucket	=2
	set 	@NewBucket	=2
	set 	@CpnyID		='CFF'

	select @Expensed=CASE When classid='EX' then 'TRUE' else 'FALSE' End
	  from Inventory where InvtID=@InvtID
	  
	-- If the item is expensed we don't track consumption and don't need to update allocations.
	if @Expensed = 'TRUE'
		return(0)

	select @UserID=SYSTEM_USER

	select @OldAlloc=case when QtyAllocIN is null then 0 else QtyAllocIN End
	  from ItemSite 
	 where InvtID = @InvtID and SiteID=@SiteID

	if @@error != 0 
		Begin
			return(@@error)
		End
	
	set @OldAlloc=ISNULL(@OldAlloc,0)
	
	set @NewAlloc=isnull(@NewAlloc,0)+@OldAlloc
	
	begin tran
	exec [dbo].[ADG_UpdateAlloc_Location] @InvtID,	@SiteID	,	@WhseLoc,	@ProgID	,	@UserID	,	@OldBucket,	@NewBucket,	@OldAlloc,	@NewAlloc
	if @@error != 0 
		Begin
			rollback tran
			return(@@error)
		End
	exec [dbo].[ADG_UpdateAlloc_ItemSite]	@InvtID,	@SiteID,	@CpnyID,	@ProgID,	@UserID,	@OldBucket,	@NewBucket,	@OldAlloc,	@NewAlloc
	if @@error != 0 
		Begin
			rollback tran
			return(@@error)
		End
	
	commit tran
	
	return 0




GO
GRANT CONTROL
    ON OBJECT::[dbo].[cfp_Sky_UpdateAllocatedIN] TO [MSDSL]
    AS [dbo];

