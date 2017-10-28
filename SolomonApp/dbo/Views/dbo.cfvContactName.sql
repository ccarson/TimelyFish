CREATE VIEW cfvContactName
	AS
	SELECT ContactID As SolomonContactId, ContactName, Tstamp 
	FROM cftContact (NOLOCK)
	WHERE ContactTypeID = '04'
