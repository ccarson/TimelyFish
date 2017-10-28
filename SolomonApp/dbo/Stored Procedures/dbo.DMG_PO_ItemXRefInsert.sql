 create procedure DMG_PO_ItemXRefInsert
	@AlternateID	varchar(30),
	@AltIDType	varchar(1),
	@EntityID	varchar(15),
	@InvtID		varchar(30),
	@TranDesc	varchar(60),
	@ProgID		varchar(8),
	@UserID		varchar(10)
as
	set nocount on

	if (
	select	count(*)
	from	ItemXRef (NOLOCK)
	where	AlternateID = @AlternateID
	and	AltIDType = @AltIDType
	and	EntityID = @EntityID
	and	InvtID = @InvtID
	) = 0
	begin
		insert ItemXref(
				AlternateID,AltIDType,
				Crtd_DateTime,Crtd_Prog,Crtd_User,
				Descr,EntityID,InvtID,
				LUpd_DateTime,LUpd_Prog,LUpd_User,
				NoteID,
				S4Future01,S4Future02,S4Future03,S4Future04,S4Future05,S4Future06,S4Future07,S4Future08,S4Future09,S4Future10,S4Future11,S4Future12,
				Sequence,Unit,UnitPrice,
				User1,User2,User3,User4,User5,User6,User7,User8
				)
		values		(
				@AlternateID,@AltIDType,
				cast(getdate() as smalldatetime),@ProgID,@UserID,
				@TranDesc,@EntityID,@InvtID,
				0,'','',
				0,
				'','',0,0,0,0,0,0,0,0,'','',
				0,'',0,
				'','',0,0,'','',0,0
				)
	end

	set nocount off



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_PO_ItemXRefInsert] TO [MSDSL]
    AS [dbo];

