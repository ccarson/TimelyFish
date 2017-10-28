 

CREATE View IRItemSiteReplenVar_ItemSite AS
Select 
	Inventory.InvtID,
	Site.SiteID,
	Convert	(Int,		Coalesce(
					NullIf(ItemSite.IRDaysSupply , 0),
					NullIf(Site.IRDaysSupply , 0),
					NullIf(Inventory.IRDaysSupply , 0),
					NullIf(SIMatlTypes.IRDaysSupply , 0),
					0
					)
		) 'IRDaysSupply',
	Convert	(Char(10),	Coalesce(
					(Case When (RTrim(IsNull(ItemSite.IRDemandID,' ')) > '') Then ItemSite.IRDemandID Else Null End),
					(Case When (RTrim(IsNull(Site.IRDemandID,' ')) > '') Then Site.IRDemandID Else Null End),
					(Case When (RTrim(IsNull(Inventory.IRDemandID,' ')) > '') Then Inventory.IRDemandID Else Null End),
					(Case When (RTrim(IsNull(SIMatlTypes.IRDemandID,' ')) > '') Then SIMatlTypes.IRDemandID Else Null End),
					' '
					)
		) 'IRDemandID',
	Convert	(Char(10),	Coalesce(
					(Case When (RTrim(IsNull(ItemSite.IRLeadTimeID,' ')) > '') Then ItemSite.IRLeadTimeID Else Null End),
					(Case When (RTrim(IsNull(Site.IRLeadTimeID,' ')) > '') Then Site.IRLeadTimeID Else Null End),
					(Case When (RTrim(IsNull(Inventory.IRLeadTimeID,' ')) > '') Then Inventory.IRLeadTimeID Else Null End),
					(Case When (RTrim(IsNull(SIMatlTypes.IRLeadTimeID,' ')) > '') Then SIMatlTypes.IRLeadTimeID Else Null End),
					' '
					)
		) 'IRLeadTimeID',
	Convert	(Char(30),	Coalesce(
					(Case When (RTrim(IsNull(ItemSite.IRModelInvtID,' ')) > '') Then ItemSite.IRModelInvtID Else Null End),
					(Case When (RTrim(IsNull(Inventory.IRModelInvtID,' ')) > '') Then Inventory.IRModelInvtID Else Null End),
					' '
					)
		) 'IRModelInvtID',
	Convert	(Char(15),	Coalesce(
					(Case When (RTrim(IsNull(ItemSite.PrimVendID,' ')) > '') Then ItemSite.PrimVendID Else Null End),
					(Case When (RTrim(IsNull(Site.IRPrimaryVendID,' ')) > '') Then Site.IRPrimaryVendID Else Null End),
					(Case When (RTrim(IsNull(Inventory.Supplr1,' ')) > '') Then Inventory.Supplr1 Else Null End),
					(Case When (RTrim(IsNull(SIMatlTypes.IRPrimaryVendID,' ')) > '') Then SIMatlTypes.IRPrimaryVendID Else Null End),
					' '
					)
		) 'IRPrimaryVendID',
	Convert	(Char(1),	Coalesce(
					(Case When (RTrim(IsNull(ItemSite.ReplMthd, '0')) > '0') Then ItemSite.ReplMthd Else Null End),
					(Case When (RTrim(IsNull(Site.ReplMthd,'0')) > '0') Then Site.ReplMthd Else Null End),
					(Case when (RTrim(IsNull(Inventory.ReplMthd, '0')) > '0') Then Inventory.ReplMthd Else Null End),
					(Case When (RTrim(IsNull(SIMatlTypes.ReplMthd, '0')) > '0') Then SIMatlTypes.ReplMthd Else Null End),
					'0'
					)
		) 'ReplMthd',
	Convert	(Char(1),	Coalesce(
					(Case When (Convert(Int,IsNull(ItemSite.IRSourceCode,0)) > 0) Then ItemSite.IRSourceCode Else Null End),
					(Case When (Convert(Int,IsNull(Inventory.IRSourceCode,0)) > 0) Then Inventory.IRSourceCode Else Null End),
					(Case When (Convert(Int,IsNull(Site.IRSourceCode,0)) > 0) Then Site.IRSourceCode Else Null End),
					(Case When (Convert(Int,IsNull(SIMatlTypes.IRSourceCode,0)) > 0) Then SIMatlTypes.IRSourceCode Else Null End),
					0
					)
		) 'IRSourceCode',
	Convert	(Float,	Coalesce(
					NullIf(ItemSite.IRSftyStkDays,0.0),
					NullIf(Site.IRSftyStkDays,0.0),
					NullIf(Inventory.IRSftyStkDays,0.0),
					NullIf(SIMatlTypes.IRSftyStkDays,0.0),
					0
					)
		) 'IRSftyStkDays',
	Convert	(Float,	Coalesce(
					NullIf(ItemSite.IRSftyStkPct,0.0),
					NullIf(Site.IRSftyStkPct,0.0),
					NullIf(Inventory.IRSftyStkPct,0.0),
					NullIf(SIMatlTypes.IRSftyStkPct,0.0),
					0
					)
		) 'IRSftyStkPct',
	Convert	(Char(1),	Coalesce(
					(Case When (Convert(Int,IsNull(ItemSite.IRSftyStkPolicy,0)) > 0) Then ItemSite.IRSftyStkPolicy Else Null End),
					(Case When (Convert(Int,IsNull(Site.IRSftyStkPolicy,0)) > 0) Then Site.IRSftyStkPolicy Else Null End),
					(Case When (Convert(Int,IsNull(Inventory.IRSftyStkPolicy,0 )) > 0) Then Inventory.IRSftyStkPolicy Else Null End),
					(Case when (Convert(Int,IsNull(SIMatlTypes.IRSftyStkPolicy,0)) > 0) Then SIMatlTypes.IRSftyStkPolicy Else Null End),
					0
					)
		) 'IRSftyStkPolicy',
	Convert	(SmallInt,	Coalesce(
						NullIf(ItemSite.IRSeasonEndDay,0),
						NullIf(Site.IRSeasonEndDay,0),
						NullIf(Inventory.IRSeasonEndDay,0),
						NullIf(SIMatlTypes.IRSeasonEndDay,0),
						0
						)
		) 'IRSeasonEndDay',
	Convert	(SmallInt,	Coalesce(
						NullIf(ItemSite.IRSeasonEndMon,0),
						NullIf(Site.IRSeasonEndMon,0),
						NullIf(Inventory.IRSeasonEndMon,0),
						NullIf(SIMatlTypes.IRSeasonEndMon,0),
						0
					)
		) 'IRSeasonEndMon',
	Convert	(SmallInt,	Coalesce(
						NullIf(ItemSite.IRSeasonStrtDay,0),
						NullIf(Site.IRSeasonStrtDay,0),
						NullIf(Inventory.IRSeasonStrtDay,0),
						NullIf(SIMatlTypes.IRSeasonStrtDay,0),
						0
					)
		) 'IRSeasonStrtDay',
	Convert	(SmallInt,	Coalesce(
						NullIf(ItemSite.IRSeasonStrtMon,0),
						NullIf(Site.IRSeasonStrtMon,0),
						NullIf(Inventory.IRSeasonStrtMon,0),
						NullIf(SIMatlTypes.IRSeasonStrtMon,0),
						0
					)
		) 'IRSeasonStrtMon',
	Convert	(Float,	Coalesce(
					NullIf(ItemSite.IRServiceLevel,0.0),
					NullIf(Site.IRServiceLevel,0.0),
					NullIf(Inventory.IRServiceLevel,0.0),
					NullIf(SIMatlTypes.IRServiceLevel,0.0),
					0
					)
		) 'IRServiceLevel',
	Convert	(Char(10),	Coalesce(
					(Case When (RTrim(IsNull(ItemSite.IRTransferSiteID,' ')) > '') Then ItemSite.IRTransferSiteID Else Null End),
					(Case When (RTrim(IsNull(Inventory.IRTransferSiteID,' ')) > '') Then Inventory.IRTransferSiteID Else Null End),
					(Case When (RTrim(IsNull(Site.IRTransferSiteID,' ')) > '') Then Site.IRTransferSiteID Else Null End),
					(Case When (RTrim(IsNull(SIMatlTypes.IRTransferSiteID,' ')) > '') Then SIMatlTypes.IRTransferSiteID Else Null End),
					' '
					)
		) 'IRTransferSiteID',
	Convert	(Char(10),	Coalesce(
					(Case When (RTrim(IsNull(ItemSite.Buyer,' ')) > '') Then ItemSite.Buyer Else Null End),
					(Case When (RTrim(IsNull(Inventory.Buyer,' ')) > '') Then Inventory.Buyer Else Null End),
					(Case When (RTrim(IsNull(SIMatlTypes.Buyer,' ')) > '') Then SIMatlTypes.Buyer Else Null End),
					' '
					)
		) 'Buyer',
	Convert	(Char(15),	Coalesce(
					(Case When (RTrim(IsNull(ItemSite.S4Future01,' ')) > '') Then ItemSite.S4Future01 Else Null End),
					(Case When (RTrim(IsNull(Site.S4Future02,' ')) > '') Then Site.S4Future02 Else Null End),
					(Case When (RTrim(IsNull(Inventory.S4Future01,' ')) > '') Then Inventory.S4Future01 Else Null End),
					(Case When (RTrim(IsNull(SIMatlTypes.S4Future01,' ')) > '') Then SIMatlTypes.S4Future01 Else Null End),
					' '
					)
		) 'ShipViaID',
	Convert	(Float,	Coalesce(
					NullIf(ItemSite.IRTargetOrdReq,0.0),
					NullIf(Site.IRTargetOrdReq,0.0),
					NullIf(Inventory.IRTargetOrdReq,0.0),
					NullIf(SIMatlTypes.IRTargetOrdReq,0.0),
					0
					)
		) 'IRTargetOrdReq',
	Convert	(Char(1),	Coalesce(
					(Case When (Convert(Int,IsNull(ItemSite.IRTargetOrdMethod,0)) > 0) Then ItemSite.IRTargetOrdMethod Else Null End),
					(Case When (Convert(Int,IsNull(Site.IRTargetOrdMethod,0)) > 0) Then Site.IRTargetOrdMethod Else Null End),
					(Case when (Convert(Int,IsNull(Inventory.IRTargetOrdMethod,0)) > 0) Then Inventory.IRTargetOrdMethod Else Null End),
					(Case When (Convert(Int,IsNull(SIMatlTypes.IRTargetOrdMethod,0)) > 0) Then SIMatlTypes.IRTargetOrdMethod Else Null End),
					0
					)
		) 'IRTargetOrdMethod',
	Convert	(Float,	Coalesce(
					NullIf(ItemSite.LastCost,0.0),
					NullIf(Inventory.LastCost,0.0),
					0
					)
		) 'LastCost',
	Convert	(Char(1),	Coalesce(
					(Case When (Convert(Int,IsNull(Inventory.IRCalcPolicy,0)) > 0) Then Inventory.IRCalcPolicy Else Null End),
					(Case When (Convert(Int,IsNull(Site.IRCalcPolicy,0)) > 0) Then Site.IRCalcPolicy Else Null End),
					(Case when (Convert(Int,IsNull(SIMatlTypes.IRCalcPolicy,0)) > 0) Then SIMatlTypes.IRCalcPolicy Else Null End),
					1
					)
		) 'IRCalcPolicy',
	
		Inventory.tstamp 'tstamp'

From 
	ItemSite
	Inner Join Inventory On ItemSite.InvtID = Inventory.InvtID
	Inner JOIN Site On ItemSite.SiteID = Site.SiteID
	Left Outer Join SIMatlTypes On SIMatlTypes.MaterialType = Inventory.MaterialType


 
