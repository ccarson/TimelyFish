Create View [cftMarketSaleType]
  as 
  Select [Crtd_DateTime],
	[Crtd_Prog],
	[Crtd_User],
	[Description],
	[LoadTimeMinutes],
	[Lupd_DateTime],
	[Lupd_Prog],
	[Lupd_User],
	[MarketSaleTypeID],
	[NoteID],
	[MarketTotalType],
	[TrailerWashFlg],
	tstamp
  From [cftMarketSaleTypeData]
  Union All
  Select Null, Null, Null, Null, Null, Null, Null, Null, Null, Null, Null, Null, Null from cftMarketSaleTypeData where 0=1
