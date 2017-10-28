
--*************************************************************
--	Purpose:Contact's fax numbers for transportation
--	Author: Charity Anderson
--	Date: 2/18/2005
--	Usage: Pig Flow 
--	Parms: (view
--	      
--*************************************************************

CREATE VIEW dbo.vXT100ContactFax
	
AS

select distinct  contactid, PhoneNbr = 
	case WHEN (Select Top 1 PhoneID from dbo.cftcontactphone WITH (NOLOCK) where contactid = cp.contactid and phonetypeid = 13) is Null THEN
		(Select Top 1 Phonenbr From dbo.cftPhone p WITH (NOLOCK) 
			JOIN dbo.cftContactPhone cph ON p.PhoneId = cph.PhoneId and cph.ContactID = cp.Contactid and cph.phonetypeid = 7)
	Else
		(Select Top 1 Phonenbr From dbo.cftPhone p WITH (NOLOCK) 
			JOIN dbo.cftContactPhone cph WITH (NOLOCK)  ON p.PhoneId = cph.PhoneId and cph.ContactID = cp.Contactid and cph.phonetypeid = 13)
	END
 From dbo.cftContactPhone cp WITH (NOLOCK) 


