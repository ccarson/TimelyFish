 create proc DMG_SOSH_Del_LotSerMst
	@InvtID varchar(30),
	@SiteID varchar(10),
	@LotSerNbr varchar(25) as

delete from LotSerMst where InvtID = @InvtID and SiteID = @SiteID and LotSerNbr = @LotSerNbr and Status = 'H'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOSH_Del_LotSerMst] TO [MSDSL]
    AS [dbo];

