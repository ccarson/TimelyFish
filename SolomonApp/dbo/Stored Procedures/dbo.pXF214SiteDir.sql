CREATE PROCEDURE pXF214SiteDir
	@ContactID varchar(6)
 AS 
 SELECT *
	FROM cftSiteDir sd
	JOIN cftContact ct ON sd.ContactID=ct.ContactID
	WHERE ct.ContactID LIKE @ContactID
	Order by ct.ContactName
 
