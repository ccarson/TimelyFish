--*************************************************************
--	Purpose:Contacts with RoleTypes
--	Author: Charity Anderson
--	Date: 8/3/2004
--	Usage: PigTransportRecord app Contact PV
--	Parms:
--*************************************************************
Create VIEW vXP135Contact
AS
Select c.*,
r.RoleTYpeID from dbo.cftContact c
JOIN dbo.cftContactRoleType r on 
c.ContactID= r.ContactID
