CREATE VIEW cfvGroupFeedCalcDet
As

SELECT v.ContactID, c.ContactName, v.PigGroupID, vi.PigGenderTypeID, v.RoomNbr, MaxStage = Max(StageOrd),
	MaxInvtID = (SELECT TOP 1 InvtID 
			FROM cfvFeedOrderWithStatusCalcs 
			WHERE PigGroupID = v.PigGroupID 
			AND StageOrd = (Select Max(StageOrd) FROM cfvFeedOrderWithStatusCalcs WHERE PigGroupID = v.PigGroupID AND RoomNbr = v.RoomNbr)
			ORDER BY OrdOrDelvDate, OrdNbr  DESC),
	CumulativeFeedQty = Sum(Qty),
	MaxStageQty = (SELECT Sum(Qty) FROM cfvFeedOrderWithStatusCalcs WHERE PigGroupID = v.PigGroupID AND RoomNbr = v.RoomNbr
				AND StageOrd = (Select Max(StageOrd) FROM cfvFeedOrderWithStatusCalcs WHERE PigGroupID = v.PigGroupID AND RoomNbr = v.RoomNbr)),
	vi.PigQty
	FROM cfvFeedOrderWithStatusCalcs v
	JOIN cftContact c ON v.ContactID = c.ContactID
	JOIN cftPigGroup pg ON v.PigGroupID = pg.PigGroupID
	LEFT JOIN cfvCurrentPigGroupInvByRoom vi ON v.PigGroupID = vi.PigGroupID and v.RoomNbr = vi.RoomNbr
	WHERE pg.PGStatusID = 'A'
	AND pg.PigProdPhaseID In('FIN','WTF')
	AND PigSystemID = '00'  -- Commercial System
	GROUP BY v.ContactID, c.ContactName, v.PigGroupID, vi.PigGenderTypeID, v.RoomNbr, vi.PigQty
