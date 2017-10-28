CREATE VIEW dbo.vCompanySites
AS
SELECT     FarmID = siteid, FarmName = contactname, Address1 = IsNull(a.address1, ''), Address2 = IsNull(a.address2, ''), City = IsNull(a.city, ''), a.state, 
                      PostalCode = IsNull(a.zip, ''), Country = 'USA', ContactFirstName = '', ContactLastName = '', ContactPhone = '', ContactEmail = '', 
                      AltContactFirstName = '', AltContactLastName = '', AltContactPhone = '', AltContactEmail = '', 
                      FarmTypeID = CASE FacilityTypeID WHEN 1 THEN 'Sow' WHEN 2 THEN 'Nursery' WHEN 5 THEN 'Wean-to-Finish' WHEN 6 THEN 'Finish' ELSE
                          (SELECT     '* ' + FacilityTypeDescription
                            FROM          FacilityType
                            WHERE      FacilityTypeID = v.FacilityTypeID) END, CapacityFinishers = 0, CapacitySows = 0, CapacityBoars = 0, CapacityNursery = 0, 
                      FarmLatitude = a.latitude, FarmLongitude = a.longitude, Category1 = '', SubCategory1 = ''
FROM         vsitewithcontactname v JOIN
                      contactaddress ca ON v.contactid = ca.contactid AND ca.addresstypeid = 1 JOIN
                      address a ON ca.addressid = a.addressid
WHERE     OwnershipID IN (1, 4) AND facilitytypeid < 8
