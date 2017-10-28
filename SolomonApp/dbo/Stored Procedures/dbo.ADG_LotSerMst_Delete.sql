 CREATE PROCEDURE ADG_LotSerMst_Delete

	@InvtID		varchar(30),
	@LotSerNbr	varchar(25),
	@SiteID		varchar(10),
	@WhseLoc  	varchar(10)
AS
	DELETE FROM LotSerMst
	WHERE	InvtID = @InvtID AND
		LotSerNbr = @LotSerNbr AND
		SiteID = @SiteID AND
		WhseLoc = @WhseLoc AND
		Status = 'H'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_LotSerMst_Delete] TO [MSDSL]
    AS [dbo];

