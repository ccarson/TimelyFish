 CREATE PROC DMG_Insert_INUpdateQty_Wrk
	@ComputerName 	varchar(21),
	@InvtID		varchar(30),
	@SiteID		varchar(10),
	@Crtd_Prog	varchar(8),
	@Crtd_User	varchar(10)

AS
	IF NOT EXISTS
		(SELECT ComputerName FROM INUpdateQty_Wrk
			WHERE ComputerName = @ComputerName
				and InvtID = @InvtID
				and SiteID = @SiteID
		)
		INSERT INTO INUpdateQty_Wrk
			(ComputerName, InvtID, SiteID,
				Crtd_DateTime, Crtd_Prog, Crtd_User,
				LUpd_DateTime, LUpd_Prog, LUpd_User,
				UpdateWOSupply)
			VALUES
			(@ComputerName, @InvtID, @SiteID,
				Convert(SmallDateTime, GetDate()), @Crtd_Prog, @Crtd_User,
				Convert(SmallDateTime, GetDate()), @Crtd_Prog, @Crtd_User, 1)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_Insert_INUpdateQty_Wrk] TO [MSDSL]
    AS [dbo];

