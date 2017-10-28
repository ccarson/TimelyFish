
CREATE VIEW dbo.vMainContactPhone
AS
SELECT
ContactID, max(PhoneID) as PhoneID, PHoneTypeID
From 
dbo.ContactPhone cp 
where PHoneTypeID=1
group by ContactID, PhoneTypeID
