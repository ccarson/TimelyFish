CREATE VIEW dbo.vPigMovementDestination
AS
Select Distinct c.ContactID,ContactName
from  dbo.Contact c
JOIN  dbo.ContactRoleType r on 
c.ContactID= r.ContactID
where r.RoleTypeID in (3,18,20,4)
UNION 
Select 9999,''

