 create procedure DMG_CustContactUpdate
	@CustID		varchar(15),
	@Type		varchar(2),
	@ContactID	varchar(10),
	@Name		varchar(60),
	@ContactUpdate	smallint
as
	set nocount on

	-- If the record doesn't exist
	if (select count(*) from CustContact where CustID = @CustID and Type = @Type and ContactID = @ContactID) = 0
			insert	CustContact(Addr1,Addr2,City,ContactID,Country,Crtd_DateTime,Crtd_Prog,Crtd_User,
			CustID,EmailAddr,Fax,LUpd_DateTime,LUpd_Prog,LUpd_User,Name,NoteID,OrderLimit,Phone,POReqdAmt,
			S4Future01,S4Future02,S4Future03,S4Future04,S4Future05,S4Future06,S4Future07,S4Future08,S4Future09,S4Future10,S4Future11,S4Future12,
			Salut,State,Type,
			User1,User10,User2,User3,User4,User5,User6,User7,User8,User9,
			WebSite,Zip)
		values	('','','',@ContactID,'',getdate(),'SOBO','SYSADMIN',
			@CustID,'','',getdate(),'SOBO','SYSADMIN',@Name,0,0,'',0,
			'','',0,0,0,0,0,0,0,0,'','',
			'','',@Type,
			'',0,'','','',0,0,'','',0,
			'','')
	else begin
		if @ContactUpdate <> 0
			update	CustContact
			set	Name = @Name
			where	CustID = @CustID
			and	Type = @Type
			and	ContactID = @ContactID
	end

	set nocount off



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_CustContactUpdate] TO [MSDSL]
    AS [dbo];

