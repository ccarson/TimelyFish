CREATE VIEW [dbo].[cfv_kron01_contact_xref]
AS
select 
Message = 'This VIEW needs to be recompiled to include references to CFSE-KRON02 linked server' ; 

--k.LastName as KronLname, k.FirstName as KronFname
--, k.Location as KronLoc	
--, c.ContactLastName, c.ContactFirstName	--, c.ContactMiddleName
--, c.ContactID, c.EmployeeFlag, c.StatusTypeID	
--, s.ContactID as contact_site_contactid , s.contactname as contact_site_name 	
--, rc.SummaryOfDetail rc_description, rc.RelatedContactID as Rc_key , rc.ContactID as RC_contactid, rc.RelatedID as RC_site_contactid	
--, rcd.RelatedContactDetailID as rcd_key, rcd.RelatedContactID rcd_rc_key, rcd.RelatedContactRelationshipTypeID	
--, rcrt.RelatedContactRelationshipDescription	
--, PermitID, permittypeid, PermitNbr, SiteContactID, ExpirationDate	
--from [cfse-kron01].wfcsuite.dbo.cfv_FTEAssigned k (nolock)	
--left join contact c (nolock) on c.contactlastname = k.lastname	
--and c.contactfirstname = k.firstname	
--and c.ContactTypeID = 3	
--left join RelatedContact rc (nolock) on rc.ContactID = c.ContactID	
--left join Contact s (nolock) on s.contactid = rc.RelatedID and s.ContactTypeID = 4	
--left join RelatedContactDetail rcd (nolock)	
--on rcd.RelatedContactID = rc.RelatedContactID	
--left join RelatedContactRelationshipType rcrt (nolock)	
--on rcrt.RelatedContactRelationshipTypeID = rcd.RelatedContactRelationshipTypeID	
--left join Permit p (nolock) on p.SiteContactID = s.ContactID	
---- and p.PermitTypeID in (12,27,31)	
--where k.EmployeeStatus <> 'Terminated'	
--and k.Locationid not in (62,66,59, 381, 58,57, 55, 64,52,54,65,234,63,60)	

