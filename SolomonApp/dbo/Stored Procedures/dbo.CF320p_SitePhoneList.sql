Create Procedure CF320p_SitePhoneList @parm1 varchar (6), @parm2 varchar (6) as 

Create Table #PhoneList (
	ContactId	Char (6),
	ContName	Char (50),
	PhoneExt	Char (10),
	PhoneNbr	Char (10),
	PhoneType	Char (30),
	Role		Char (30),
	SpeedDial	Char (6),
	Tstamp		timestamp
)

Insert Into #PhoneList (ContactId, ContName, PhoneExt, PhoneNbr, PhoneType, Role, SpeedDial)
    Select c.ContactId, c.ContactName, Coalesce(p.Extension, ''), Coalesce(p.PhoneNbr, ''), 
	Coalesce(t.Description, ''), 'Site', Coalesce(p.SpeedDial, '') 
	from cftContact c Left Join cftContactPhone cp on c.ContactId = cp.ContactId
	Left Join cftPhoneType t on cp.PhoneTypeId = t.PhoneTypeId
	Left Join cftPhone p on cp.PhoneId = p.PhoneId
	Where c.ContactId = @parm1

Insert Into #PhoneList (ContactId, ContName, PhoneExt, PhoneNbr, PhoneType, Role, SpeedDial)
    Select c.ContactId, c.ContactName, Coalesce(p.Extension, ''), Coalesce(p.PhoneNbr, ''), 
	Coalesce(t.Description, ''), 'Site Mgr', Coalesce(p.SpeedDial, '') 
	from cftSite s Join cftContact c on s.SiteMgrContactId = c.ContactId
	Left Join cftContactPhone cp on c.ContactId = cp.ContactId
	Left Join cftPhoneType t on cp.PhoneTypeId = t.PhoneTypeId
	Left Join cftPhone p on cp.PhoneId = p.PhoneId
	Where s.ContactId = @parm1

Insert Into #PhoneList (ContactId, ContName, PhoneExt, PhoneNbr, PhoneType, Role, SpeedDial)
    Select c.ContactId, c.ContactName, Coalesce(p.Extension, ''), Coalesce(p.PhoneNbr, ''), 
	Coalesce(t.Description, ''), 'Barn ' + RTrim (b.BarnNbr) + ' Mgr', Coalesce(p.SpeedDial, '') 
	From cftBarn b Join cftContact c on b.BarnMgrContactID = c.ContactId
	Left Join cftContactPhone cp on c.ContactId = cp.ContactId
	Left Join cftPhoneType t on cp.PhoneTypeId = t.PhoneTypeId
	Left Join cftPhone p on cp.PhoneId = p.PhoneId
	Where b.ContactId = @parm1

Insert Into #PhoneList (ContactId, ContName, PhoneExt, PhoneNbr, PhoneType, Role, SpeedDial)
    Select c2.ContactId, c2.ContactName, Coalesce(p.Extension, ''), Coalesce(p.PhoneNbr, ''), 
	Coalesce(t.Description, ''), rc.SummaryOfDetail, Coalesce(p.SpeedDial, '') 
	From cftContact c Join cftRelatedContact rc on rc.ContactId = c.ContactId
	Join cftContact c2 on rc.RelatedContactId = c2.ContactId
	Left Join cftContactPhone cp on rc.RelatedContactId = cp.ContactId
	Left Join cftPhoneType t on cp.PhoneTypeId = t.PhoneTypeId
	Left Join cftPhone p on cp.PhoneId = p.PhoneId
	Where c.ContactId = @parm1

    Select * from #PhoneList Where ContactId Like @parm2 Order by PhoneType
