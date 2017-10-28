



CREATE PROCEDURE [dbo].[pXT120GetTruckerList]
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1' 
 AS

SELECT DISTINCT c.ContactID, ContactName
FROM cftContact c
LEFT JOIN cftContactType ct ON c.ContactTypeID = ct.ContactTypeID
LEFT JOIN cftContactRoleType crt ON c.ContactID = crt.ContactID
LEFT JOIN cftRoleType rt ON crt.RoleTypeID = rt.RoleTypeID
WHERE rt.RoleTypeID IN ('002', '011', '012')
AND ct.ContactTypeID = '01'
AND c.StatusTypeID = '1'
ORDER BY c.ContactName


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT120GetTruckerList] TO [MSDSL]
    AS [dbo];

