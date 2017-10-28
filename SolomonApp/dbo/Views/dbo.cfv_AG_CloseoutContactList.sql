
--*************************************************************
--	Purpose: Developed to quickly find the Entity to whom the Site Closeout Reports should be
--  sent to.
--  Rules:
--  When the OwnershipType of the Site is 01(Company), 03(Company Managed),
--  04(Employee), 08(Company/Sublet) or 09(Contract/TNL); the Site Manager should be
--  the the recipient of the report.
--  When the OwnershipType of the Site is 02(Contract), 05(Non-CFF) or 07(Contract/Sublet);
--  the Primary Contact should be the recipient of the report.
--  All address Types are listed in this view, since there is some inconsistency on Contacts
--  as to whether they all have a mailing and/or physical address.
--*************************************************************
CREATE VIEW [dbo].[cfv_AG_CloseoutContactList]
AS
SELECT     C.StatusTypeID, 'LOC' + S.SiteID SiteNbr, Rtrim(C.ContactName) AS SiteName, 
                      CASE C1.ContactLastName WHEN '' THEN C1.ContactName ELSE Rtrim(C1.ContactFirstName) + ' ' + Rtrim(C1.ContactLastName) END FullName, 
                      Rtrim(A.Address1) Address1, Rtrim(A.City) + ', ' + Rtrim(A.State) + '  ' + Rtrim(A.Zip) CityStateZip, AT.Description AddressType, AT.AddressTypeID
FROM         cftSite S LEFT JOIN
                      cftContact C ON S.ContactID = C.ContactID LEFT JOIN
                      cftOwner O ON C.ContactID = O.SiteContactID LEFT JOIN
                      cftContact AS C1 ON O.OwnerContactID = C1.ContactID LEFT JOIN
                      cftContactAddress CA LEFT JOIN
                      cftAddress A ON CA.AddressID = A.AddressID LEFT JOIN
                      cftAddressType AT ON CA.AddressTypeID = AT.AddressTypeID ON C1.ContactID = CA.ContactID
WHERE     (S.OwnershipTypeID in ('02','05','07') AND O.PrimaryContactFlag = '-1')
UNION
SELECT     C.StatusTypeID, 'LOC' + S.SiteID SiteNbr, Rtrim(C.ContactName) AS SiteName, 
                      CASE C1.ContactLastName WHEN '' THEN C1.ContactName ELSE Rtrim(C1.ContactFirstName) + ' ' + Rtrim(C1.ContactLastName) END FullName, 
                      Rtrim(A.Address1) Address1, Rtrim(A.City) + ', ' + Rtrim(A.State) + '  ' + Rtrim(A.Zip) CityStateZip, AT.Description AddressType, AT.AddressTypeID
FROM         cftSite S LEFT JOIN
                      cftContact C ON S.ContactID = C.ContactID LEFT JOIN
                      cftContact C1 ON S.SiteMgrContactID = C1.ContactID LEFT JOIN
                      cftContactAddress CA LEFT JOIN
                      cftAddress A ON CA.AddressID = A.AddressID LEFT JOIN
                      cftAddressType AT ON CA.AddressTypeID = AT.AddressTypeID ON C1.ContactID = CA.ContactID
WHERE     (S.OwnershipTypeID in ('01','03','04','08','09','10'))
