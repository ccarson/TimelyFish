
/****** Object:  View dbo.vCF668SiteMgrPhone    Script Date: 2/3/2006 8:51:14 AM ******/
CREATE  view vCF668SiteMgrPhone (ContactID, ContactName, HomePhoneNbr, CellPhoneNbr)
as
select ContactID, max(ContactName), dbo.FormatPhone(max(homephonenbr)), dbo.FormatPhone(max(cellphonenbr))
 from vCF668SiteMgrPhoneDet group by contactid

