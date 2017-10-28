
create view vCF668SitePhoneDet as 

    Select c.ContactId, c.ContactName, Phone = Coalesce(p.PhoneNbr, ''), 
	HomephoneNbr = case (t.phonetypeid) when '002' then (Coalesce(p.PhoneNbr, '')) else '' end,
	CellphoneNbr = case (t.phonetypeid) when '003' then (Coalesce(p.PhoneNbr, '')) else '' end,
	Type = Coalesce(t.Description, ''), Site = 'Site'
	from cftContact c Left Join cftContactPhone cp on c.ContactId = cp.ContactId
	Left Join cftPhoneType t on cp.PhoneTypeId = t.PhoneTypeId
	Left Join cftPhone p on cp.PhoneId = p.PhoneId

