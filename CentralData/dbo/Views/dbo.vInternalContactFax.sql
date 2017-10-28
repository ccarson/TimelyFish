CREATE VIEW dbo.vInternalContactFax
AS
select distinct contactid, PhoneNbr = 
	case WHEN (Select PhoneID from dbo.contactphone where contactid = cp.contactid and phonetypeid = 13) is Null THEN
		(Select Top 1 Phonenbr From dbo.Phone p
			JOIN dbo.ContactPhone cph ON p.PhoneId = cph.PhoneId and cph.ContactID = cp.Contactid and cph.phonetypeid = 7)
	Else
		(Select Top 1 Phonenbr From dbo.Phone p
			JOIN dbo.ContactPhone cph ON p.PhoneId = cph.PhoneId and cph.ContactID = cp.Contactid and cph.phonetypeid = 13)
	END
 From dbo.ContactPhone cp
