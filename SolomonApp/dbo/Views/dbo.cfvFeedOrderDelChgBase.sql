
CREATE  VIEW cfvFeedOrderDelChgBase (MillID, DelSub, CpnyId, OrdNbr, RevFlg, OneWayMiles, LoadPct,
					BaseDelChg, BaseMileageRate)
As	
select fo.MillId, fs.GLSub, fo.CpnyID, fo.ordnbr, RevFlg = CASE Reversal WHEN 0 THEN 1 ELSE -1 END,
	mm.onewaymiles, (fo.qtydel/2000)/(Select MaxLoad from cftFOSetup), 
	fs.delchg, fs.milerate
	from cftFeedOrder fo 
	join cftMilesMatrix mm ON  fo.ContAddrID = mm.AddressIDTo AND fo.MillAddrID = mm.AddressIDFrom
	Join cftMillsite fs ON fo.MillID = fs.MillID


 