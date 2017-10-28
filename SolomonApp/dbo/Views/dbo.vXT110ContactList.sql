--*************************************************************
--	Purpose:List of Sites
--		
--	Author: Charity Anderson
--	Date: 4/7/2005
--	Usage: Health Service 
--	Parms: 
--*************************************************************

CREATE VIEW dbo.vXT110ContactList
AS

Select c.*
from cftContact c
JOIN cftSite s on c.ContactID=s.ContactID

