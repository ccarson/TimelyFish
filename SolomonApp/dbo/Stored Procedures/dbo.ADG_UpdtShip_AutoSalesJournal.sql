 create proc ADG_UpdtShip_AutoSalesJournal
as
	SELECT DfltAccrueRev, AutoSalesJournal FROM SOSetup (NOLOCK)


