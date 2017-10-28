CREATE  View cfvSitewithStatus
/* Used in programs:  CF300, CF303, CF320, CF330, CF340
   Referenced in:  CF301
*/
as    
Select c.ContactId, c.ContactName, 
	s.SolomonProjectID
	from cftSite s 
		JOIN cftContact c on c.ContactId = s.ContactId
	where c.StatusTypeID=1 
