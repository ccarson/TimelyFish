CREATE VIEW cfvCurrentPigGroupInvByRoom
AS
SELECT pg.SiteContactID, pg.PigGroupID, pg.BarnNbr, RoomNbr = IsNull(pgr.RoomNbr,''), PigGenderTypeID = IsNull(pgr.PigGenderTypeID,pg.PigGenderTypeID),
	PigQty = Round((SELECT Sum(QTY) FROM cfvPigGroupInv WHERE PigGroupID = pg.PigGroupID) * IsNull((r.BrnCapPrct / (Select Sum(BrnCapPrct) FROM cftRoom WHERE ContactID = pg.SiteContactID AND BarnNbr = pg.BarnNbr AND RoomNbr In(SELECT RoomNbr FROM cftPigGroup
Room WHERE PigGroupID = pg.PigGroupID))),1),0)
	FROM cftPigGroup pg
	LEFT JOIN cftPigGroupRoom pgr ON pg.PigGroupID = pgr.PigGroupID
	LEFT JOIN cftRoom r ON r.ContactID = pg.SiteContactID AND r.BarnNbr = pg.BarnNbr AND r.RoomNbr = pgr.RoomNbr
	WHERE pg.PGStatusID  = ('A')

 