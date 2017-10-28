 create proc DMG_UpdateAll_Get_WODemand_IS
	@InvtIDParm	varchar (30),
	@SiteIDParm	varchar (10)
as
	select		h.CpnyID, h.WONbr
	from		WOHeader h
	where		h.Status not in ('P')		 	-- Not Purge
		and exists (
			select *
			from WOMatlReq m
			where		m.WONbr = h.WONbr
				and m.InvtID like @InvtIDParm
				and m.InvtID like @SiteIDParm)

	order by	h.WONbr								-- For Demand cannot constrain on Proc Stage (PWOs)


