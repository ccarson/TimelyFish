
-- CREATED IN THE SOLOMONAPP database
--CREATED BY: TJONES FOR: George
--CREATED ON: 10/18/05
CREATE VIEW cfvAssetListWithInfo
	AS
 SELECT a.CompanyID, CompanyName = c.LongName, a.AssetID, a.CompAsstNo, 
	CompAsstNoPrefix = CASE 
		WHEN left(compasstno,5) Like '%-%' THEN '' 
		WHEN Len(RTrim(left(compAsstNo,5))) < 5 THEN '' 
		ELSE left(compasstno,5) END,
	a.PropType, PropTypeDescr = s.Name, 
	AssetDescr = a.Description, a.Location, SiteID = Right(RTrim(a.ExpenseGL),4), SiteName=co.ContactName, 
	a.ExpenseGL, a.AcquisitionDate, a.User3, a.IsInactive, b.AcqValue, DeprMethodID=b.DeprMethod, 
	DeprMethodDescr=s2.Name, b.EstimatedLife, b.SalvValue, b.DisposedAmount,
	b.CurrentYearToDate, b.CurrentLifeToDate, b.CurrentPeriodDepr, b.CurrentNetValue,
	p.ActivityCd
	FROM FAS_CFF.dbo.Asset a
	LEFT JOIN FAS_CFF.dbo.PartialsInfo p ON a.CompanyID = p.CompanyID AND a.AssetID = p.AssetID 
		AND p.Sequence = (Select Max(Sequence) FROM FAS_CFF.dbo.PartialsInfo WHERE CompanyID = p.CompanyID AND AssetID = p.AssetID)
	LEFT JOIN cftSite si ON Right(RTrim(a.ExpenseGL),4) = si.SiteID
	LEFT JOIN cftContact co ON si.ContactID = co.ContactID
	LEFT JOIN FAS_CFF.dbo.BookParts b ON a.CompanyID = b.CompanyID and a.AssetID = b.AssetID AND b.BookID = 1 
		AND b.Sequence = (Select Max(Sequence) FROM FAS_CFF.dbo.BookParts WHERE CompanyID = b.CompanyID AND AssetID = b.AssetID AND BookID = 1)
	JOIN FAS_CFF.dbo.Company c ON a.CompanyID = c.CompanyID
	LEFT JOIN FAS_CFF.dbo.Selection s ON a.PropType = s.Value AND s.AppID = 1 AND s.FieldID = 7  -- Propery Type
	LEFT JOIN FAS_CFF.dbo.Selection s2 ON b.DeprMethod = s2.Value AND s2.AppID = 1 AND s2.FieldID = 29
	WHERE convert(varchar(30),a.CompanyID) <> c.LongName  --filter out bogus assets
