CREATE VIEW dbo.vSiteFax
AS
--SELECT     dbo.Site.SiteID, dbo.Phone.PhoneNbr, dbo.ContactPhone.ContactID
--FROM         dbo.ContactPhone INNER JOIN
--                      dbo.Phone ON dbo.ContactPhone.PhoneID = dbo.Phone.PhoneID left outer JOIN
--                      dbo.Site ON dbo.ContactPhone.ContactID = dbo.Site.ContactID
--WHERE     (dbo.ContactPhone.PhoneTypeID = 7)

SELECT DISTINCT dbo.Site.SiteID,  PhoneNbr = CASE WHEN
                          (SELECT     Top 1 PhoneID
                            FROM          dbo.contactphone
                            WHERE      contactid = cp.contactid AND phonetypeid = 13) IS NULL THEN
                          (SELECT    Top 1 Phonenbr
                            FROM          dbo.Phone p JOIN
                                                   dbo.ContactPhone cph ON p.PhoneId = cph.PhoneId AND cph.ContactID = cp.Contactid AND cph.phonetypeid = 7) ELSE
                          (SELECT     Top 1 Phonenbr
                            FROM          dbo.Phone p JOIN
                                                   dbo.ContactPhone cph ON p.PhoneId = cph.PhoneId AND cph.ContactID = cp.Contactid AND cph.phonetypeid = 13) END,
			cp.ContactID
FROM         dbo.ContactPhone cp
left outer JOIN
                      dbo.Site ON cp.ContactID = dbo.Site.ContactID

