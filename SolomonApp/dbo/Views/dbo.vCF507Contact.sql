
--*************************************************************
-- Purpose:Contacts with RoleTypes
-- Author: Charity Anderson
-- Date: 8/3/2004
-- Usage: PigTransportRecord app Contact PV
-- Parms:
--*************************************************************
--*************************************************************
-- Removed fully qualified database name from the tables
-- Date: 02/07/2007
-- Author: Dave Killion
--*************************************************************

CREATE VIEW vCF507Contact
AS
Select c.*,
r.RoleTYpeID from .dbo.cftContact c
JOIN .dbo.cftContactRoleType r on
c.ContactID= r.ContactID


