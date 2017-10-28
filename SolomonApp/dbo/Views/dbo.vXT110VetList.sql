--*************************************************************
--	Purpose:List of Vets
--		
--	Author: Charity Anderson
--	Date: 4/7/2005
--	Usage: Health Service 
--	Parms: 
--*************************************************************

CREATE VIEW dbo.vXT110VetList
AS

Select c.*
from cftContact c
JOIN cftContactRoleType r on 
c.ContactID= r.ContactID
where r.RoleTypeID in (1)

