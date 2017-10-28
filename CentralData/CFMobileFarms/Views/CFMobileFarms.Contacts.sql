



CREATE VIEW [CFMobileFarms].[Contacts] 
AS
SELECT 
		c.ContactID as ContactID
	   ,CONVERT(nvarchar,isnull(c.ContactName,'')) as ContactName
	   ,CONVERT(nvarchar,isnull(c.ContactFirstName,'')) as ContactFirstName
	   ,CONVERT(nvarchar,isnull(c.ContactMiddleName,'')) as ContactMiddleName
	   ,CONVERT(nvarchar,isnull(c.ContactLastName,'')) as ContactLastName
	   ,CONVERT(nvarchar(50),isnull(c.EmailAddress,'')) as EmailAddress
	   ,CONVERT(tinyint,c.MobileAccess) as MobileAccess
	   ,CONVERT(tinyint,c.StatusTypeID) as StatusTypeID
       ,CONVERT(nvarchar(128), c.ContactID) as Id
	   ,CONVERT(timestamp, null)  as Version 
	   ,CONVERT(datetimeoffset(7), null) as CreatedAt
	   ,CONVERT(datetimeoffset(7), null) as UpdatedAt
	   ,CONVERT(bit, 0) as Deleted
       
FROM dbo.Contact c


GO
GRANT SELECT
    ON OBJECT::[CFMobileFarms].[Contacts] TO [hybridconnectionlogin_permissions]
    AS [HybridConnectionLogin];

