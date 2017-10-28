
CREATE  view vCF668SitePhone (ContactID, ContactName, HomePhoneNbr, CellPhoneNbr)
as
select ContactID, max(ContactName), dbo.FormatPhone(max(homephonenbr)), dbo.FormatPhone(max(cellphonenbr))
 from vCF668SitePhoneDet group by contactid


