
create view vCF668SiteMgrPhoneDet as 

    Select s.ContactId, c.ContactName, phone = Coalesce(p.PhoneNbr, ''),
	HomephoneNbr = case (cp.phonetypeid) when '002' then (Coalesce(p.PhoneNbr, '')) else '' end,
	CellphoneNbr = case (cp.phonetypeid) when '003' then (Coalesce(p.PhoneNbr, '')) else '' end,
	Type = Coalesce(t.Description, ''), SiteMgr = 'Site Mgr'
	from cftSite s Join cftContact c on s.SiteMgrContactId = c.ContactId
	Left Join cftContactPhone cp on c.ContactId = cp.ContactId
	Left Join cftPhoneType t on cp.PhoneTypeId = t.PhoneTypeId
	Left Join cftPhone p on cp.PhoneId = p.PhoneId


 