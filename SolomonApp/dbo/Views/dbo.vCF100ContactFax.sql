--*************************************************************
--	Purpose:Contact's fax numbers for transportation
--	Author: Charity Anderson
--	Date: 2/18/2005
--	Usage: Pig Flow 
--	Parms: (view
--	      
--*************************************************************

CREATE VIEW dbo.vCF100ContactFax
	
AS

select distinct contactid, PhoneNbr = 
	case WHEN (Select PhoneID from dbo.cftcontactphone where contactid = cp.contactid and phonetypeid = 13) is Null THEN
		(Select Top 1 Phonenbr From dbo.cftPhone p
			JOIN dbo.cftContactPhone cph ON p.PhoneId = cph.PhoneId and cph.ContactID = cp.Contactid and cph.phonetypeid = 7)
	Else
		(Select Top 1 Phonenbr From dbo.cftPhone p
			JOIN dbo.cftContactPhone cph ON p.PhoneId = cph.PhoneId and cph.ContactID = cp.Contactid and cph.phonetypeid = 13)
	END
 From dbo.cftContactPhone cp
