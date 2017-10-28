
CREATE VIEW dbo.cfv_SITE_BARN_ROOM_BIN
AS
SELECT  --relationship where bin has roomid    
	Contact.ContactID
,	Contact.ContactName
,	Site.FacilityTypeID
,	Barn.BarnID
,	Barn.BarnNbr
,	Barn.StdCap
,	CASE
		WHEN Barn.BarnNbr LIKE '%ges%' THEN 'GES'
		WHEN Barn.BarnNbr LIKE '%far%' THEN 'FAR'
		WHEN Barn.BarnNbr LIKE '%bre%' THEN 'BRE'
		ELSE NULL
	END BarnType
,	Bin.BinNbr
,	BinType.BinTypeDescription
,	cftBinReading.BinReadingDate 'LastBinReadingDate'
,	cftBinReading.Tons 'CurrentBinQuantity'
,	Room.RoomNbr
,	Room.BarnCapPercentage
FROM		dbo.Contact Contact
LEFT JOIN	dbo.Site Site
	ON	Site.ContactID = Contact.ContactID
LEFT JOIN	dbo.Barn Barn
	ON	Barn.SiteID = Site.SiteID
LEFT JOIN	dbo.Room Room
	ON	Room.BarnID = Barn.BarnID
LEFT JOIN	dbo.Bin Bin
	ON	Bin.BarnID = Barn.BarnID
	AND	Bin.RoomID = Room.RoomID
LEFT JOIN	dbo.BinType BinType
	ON	BinType.BinTypeID = Bin.BinTypeID
LEFT JOIN	(SELECT BinNbr, SiteContactID, MAX(BinReadingDate) BinReadingDate FROM [$(SolomonApp)].dbo.cftBinReading cftBinReading GROUP BY BinNbr, SiteContactID) BinReadings
	ON	cast(BinReadings.SiteContactID as int) = Site.ContactID
	AND	BinReadings.BinNbr = Bin.BinNbr
LEFT JOIN	[$(SolomonApp)].dbo.cftBinReading cftBinReading
	ON	cftBinReading.SiteContactID = BinReadings.SiteContactID
	AND	cftBinReading.BinNbr = BinReadings.BinNbr
	AND	cftBinReading.BinReadingDate = BinReadings.BinReadingDate
WHERE room.roomnbr IS NOT NULL
AND Contact.ContactTypeID = 4 
AND (Contact.StatusTypeID <> 2 or Contact.StatusTypeID IS NULL)--InActive
AND (Barn.StatusTypeID <> 2 or Barn.StatusTypeID IS NULL) --InActive
AND (Room.StatusTypeID <> 2 or Room.StatusTypeID IS NULL) --InActive
AND (Bin.Active <> 0 or Bin.Active IS NULL)
GROUP BY Contact.ContactID, Contact.ContactName, Site.FacilityTypeID, barn.barnid, barn.barnnbr, barn.StdCap
,     CASE
            WHEN Barn.BarnNbr LIKE '%ges%' THEN 'GES'
            WHEN Barn.BarnNbr LIKE '%far%' THEN 'FAR'
			WHEN Barn.BarnNbr LIKE '%bre%' THEN 'BRE'
            ELSE NULL
      END,
Bin.BinNbr, BinType.BinTypeDescription, cftBinReading.BinReadingDate, cftBinReading.Tons, Room.RoomNbr, Room.BarnCapPercentage

UNION ALL
SELECT  --relationship where bin doesn't have roomid    
	Contact.ContactID
,	Contact.ContactName
,	Site.FacilityTypeID
,	Barn.BarnID
,	Barn.BarnNbr
,	Barn.StdCap
,	CASE
		WHEN Barn.BarnNbr LIKE '%ges%' THEN 'GES'
		WHEN Barn.BarnNbr LIKE '%far%' THEN 'FAR'
		WHEN Barn.BarnNbr LIKE '%bre%' THEN 'BRE'
		ELSE NULL
	END BarnType
,	Bin.BinNbr
,	BinType.BinTypeDescription
,	cftBinReading.BinReadingDate
,	cftBinReading.Tons
,	Room.RoomNbr
,	Room.BarnCapPercentage
FROM		dbo.Contact Contact
LEFT JOIN	dbo.Site Site
	ON	Site.ContactID = Contact.ContactID
LEFT JOIN	dbo.Barn Barn
	ON	Barn.SiteID = Site.SiteID
LEFT JOIN	dbo.Room Room
	ON	Room.BarnID = Barn.BarnID
LEFT JOIN	dbo.Bin Bin
	ON	Bin.BarnID = Barn.BarnID
LEFT JOIN	dbo.BinType BinType
	ON	BinType.BinTypeID = Bin.BinTypeID
LEFT JOIN	(SELECT BinNbr, SiteContactID, MAX(BinReadingDate) BinReadingDate FROM [$(SolomonApp)].dbo.cftBinReading cftBinReading GROUP BY BinNbr, SiteContactID) BinReadings
	ON	cast(BinReadings.SiteContactID as int) = Site.ContactID
	AND	BinReadings.BinNbr = Bin.BinNbr
LEFT JOIN	[$(SolomonApp)].dbo.cftBinReading cftBinReading
	ON	cftBinReading.SiteContactID = BinReadings.SiteContactID
	AND	cftBinReading.BinNbr = BinReadings.BinNbr
	AND	cftBinReading.BinReadingDate = BinReadings.BinReadingDate
WHERE Room.RoomNbr IS NULL
AND Contact.ContactTypeID = 4 
AND (Contact.StatusTypeID <> 2 or Contact.StatusTypeID IS NULL)--InActive
AND (Barn.StatusTypeID <> 2 or Barn.StatusTypeID IS NULL) --InActive
AND (Room.StatusTypeID <> 2 or Room.StatusTypeID IS NULL) --InActive
AND (Bin.Active <> 0 or Bin.Active IS NULL)
GROUP BY Contact.ContactID, Contact.ContactName, Site.FacilityTypeID, Barn.BarnID, Barn.BarnNbr, Barn.StdCap
,     CASE
            WHEN Barn.BarnNbr LIKE '%ges%' THEN 'GES'
            WHEN Barn.BarnNbr LIKE '%far%' THEN 'FAR'
			WHEN Barn.BarnNbr LIKE '%bre%' THEN 'BRE'
            ELSE NULL
      END,
Bin.BinNbr, BinType.BinTypeDescription, cftBinReading.BinReadingDate, cftBinReading.Tons, Room.RoomNbr, Room.BarnCapPercentage

GO
GRANT SELECT
    ON OBJECT::[dbo].[cfv_SITE_BARN_ROOM_BIN] TO PUBLIC
    AS [dbo];

