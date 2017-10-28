 create proc DMG_UpdateAll_GetItemSite
as
	select		invtid, siteid
	from		ItemSite
	order by	invtid, siteid


