
CREATE VIEW dbo.vInternalTrucker
AS
SELECT     dbo.Contact.ContactName, dbo.InternalTrucker.DefaultPigTrailerID as DefaultTrailer, dbo.Contact.EMailAddress, dbo.Contact.ContactID, dbo.Contact.TranSchedMethodTypeID, TrackMiles
FROM         dbo.InternalTrucker INNER JOIN
                      dbo.Contact ON dbo.InternalTrucker.ContactID = dbo.Contact.ContactID
Union
Select '','','','9999','',''

