CREATE TRIGGER 
	dbo.trInsContact ON dbo.Contact
FOR INSERT
AS
INSERT INTO 
    [$(SolomonApp)].dbo.cftContact( 
        ContactFirstName
      , ContactID
      , ContactLastName
      , ContactMiddleName
      , ContactName
      , ContactTypeID
      , Crtd_DateTime
      , Crtd_Prog,Crtd_User
      , CustomerFlag
      , EMailAddress
      , EmployeeFlag
      , Lupd_DateTime
      , Lupd_Prog
      , Lupd_User
      , StatusTypeID
      , Title
      , TranSchedMethTypeID
      , VendorFlag
      , VetFlag
      , ShortName )
SELECT 
    ISNULL( i.ContactFirstName, '' )
  , ContactID = REPLICATE( '0', 6 - LEN( RTRIM( CONVERT( CHAR(06), i.ContactID ) ) ) ) + RTRIM( CONVERT( CHAR(06), i.ContactID ) )
  , ISNULL( i.ContactLastName, '' )
  , ISNULL( i.ContactMiddleName, '' )
  , ISNULL( i.ContactName, '' )
  , ContactTypeID = REPLICATE( '0', 2 - LEN( RTRIM( CONVERT( VARCHAR(02), i.ContactTypeID ) ) ) ) + RTRIM( CONVERT( CHAR(2), i.ContactTypeID ) )
  , GETDATE()
  , ''
  , 'SYSADMIN'
  , ISNULL( i.CustomerFlag, 0 )
  , ISNULL( i.EMailAddress, '' )
  , ISNULL( i.EmployeeFlag, 0 )
  , GETDATE()
  , ''
  , 'SYSADMIN'
  , ISNULL( i.StatusTypeID, 0 )
  , CASE WHEN i.Title IS NULL THEN '' ELSE REPLICATE( '0', 2 - LEN( RTRIM( CONVERT( CHAR(02), i.Title ) ) ) ) + RTRIM( CONVERT( CHAR(02), i.Title ) ) END
  , CASE WHEN i.TranSchedMethodTypeID IS NULL THEN '' ELSE REPLICATE( '0', 2 - LEN( RTRIM( CONVERT( CHAR(02), i.TranSchedMethodTypeID ) ) ) ) + RTRIM( CONVERT( CHAR(02), i.TranSchedMethodTypeID ) ) END 
  , ISNULL( i.VendorFlag, 0 )
  , ISNULL( i.VetFlag, 0 )
  , ISNULL( i.ShortName, '' )
FROM 
    inserted AS i


UPDATE 
    dbo.Contact 
SET 
    SolomonContactID = REPLICATE( '0', 6 - LEN( RTRIM( CONVERT( CHAR(06), c.ContactID ) ) ) ) + RTRIM( CONVERT( CHAR(06), c.ContactID ) )
FROM 
    dbo.Contact AS c 
INNER JOIN 
    inserted AS i 
        ON c.ContactID = i.ContactID ;

GO


CREATE TRIGGER 
	dbo.trDelContact ON [dbo].[Contact] 
FOR DELETE
AS
Delete c FROM [$(SolomonApp)].dbo.cftContact c
JOIN Deleted d on 
c.ContactID=
replicate('0',6-len(rtrim(convert(char(6),d.ContactID))))
	 + rtrim(convert(char(6),d.ContactID)) ;

GO

CREATE TRIGGER 
	dbo.trUpdContact ON dbo.Contact
FOR UPDATE
AS

UPDATE 
    sc
SET 
    sc.ContactFirstName      = ISNULL( i.ContactFirstName, '' )
  , sc.ContactMiddleName     = ISNULL( i.ContactMiddleName, '' )
  , sc.ContactLastName       = ISNULL( i.ContactLastName, '' )
  , sc.ContactName           = ISNULL( i.ContactName, '' )
  , sc.ContactTypeID         = RIGHT( '00' + CAST( i.ContactTypeID AS VARCHAR(02) ), 2 )
  , sc.CustomerFlag          = ISNULL( i.CustomerFlag, '' )
  , sc.EMailAddress          = ISNULL( i.EMailAddress, '' )
  , sc.EmployeeFlag          = ISNULL( i.EmployeeFlag, '' )
  , sc.Lupd_DateTime         = GETDATE()
  , sc.Lupd_Prog             = 'trigger'
  , sc.Lupd_User             = 'sysadmin'
  , sc.ShortName             = ISNULL( i.ShortName, '' )
  , sc.StatusTypeID          = ISNULL( i.StatusTypeID, '' )
  , sc.Title                 = ISNULL( i.Title, '' )
  , sc.TranSchedMethTypeID   = RIGHT( '00' + CAST( i.TranSchedMethodTypeID AS VARCHAR(02) ), 2 )
  , sc.VendorFlag            = ISNULL( i.VendorFlag, '' )
  , sc.VetFlag               = ISNULL( i.VetFlag, '' )
FROM 
    [$(SolomonApp)].dbo.cftContact AS sc
INNER JOIN 
    inserted AS i
		ON sc.ContactID = i.ContactID ;
