 create proc DMG_SOSH_NSACheck
	@InvtID varchar(30),
	@SiteID varchar(10),
	@LotSerNbr varchar(25)
as

select convert(smallint, case

        when exists (

    	select * from LotSerMst lsm, LocTable lct
    	where lct.SiteID = lsm.SiteID and lct.WhseLoc = lsm.WhseLoc
        and lsm.InvtID = @InvtID and lsm.SiteID = @SiteID and lsm.LotSerNbr = @LotSerNbr
        and lct.SalesValid = 'N' and lsm.Status = 'A')

        and not exists (
    	select * from LotSerMst lsm, LocTable lct
    	where lct.SiteID = lsm.SiteID and lct.WhseLoc = lsm.WhseLoc
        and lsm.InvtID = @InvtID and lsm.SiteID = @SiteID and lsm.LotSerNbr = @LotSerNbr
        and lct.SalesValid <> 'N' and lsm.Status = 'A')
  	then 15577
	else 0 end)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOSH_NSACheck] TO [MSDSL]
    AS [dbo];

