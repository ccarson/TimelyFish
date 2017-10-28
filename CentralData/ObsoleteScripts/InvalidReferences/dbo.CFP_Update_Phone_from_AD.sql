-- =============================================
-- Author:		Ripley, Steve
-- Create date: 2014-06-19
-- Description:	Pulls data from AD and updates the phone table
-- =============================================
CREATE PROCEDURE [dbo].[CFP_Update_Phone_from_AD] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

-- create a temp table with the AD information about Christensenfarm contacts
-- cfse-dc02.se.christensenfarms.com
 SELECT * 
 into #ADtemp
 FROM OPENQUERY( ADSI, 
'SELECT sAMAccountName, userPrincipalName, company, department, Name, givenName, SN, Mail, telephoneNumber, mobile, 
l, physicalDeliveryOfficeName, postalCode, streetAddress, facsimileTelephoneNumber, msExchHideFromAddressLists, distinguishedName, info
FROM ''LDAP://dc=se,dc=christensenfarms,dc=com''
WHERE 
objectClass = ''user''
AND
objectCategory = ''Person'' 
AND (mobile = ''*'' OR telephoneNumber = ''*'' OR facsimileTelephoneNumber = ''*'' OR mail = ''*'' )
ORDER BY userPrincipalName
')

-- insert phone numbers that currently do not exist in the phone table
insert into [dbo].[Phone]
select xx.phonenbr,null,null
from
(
select replace(replace(replace(replace(mobile,'-',''),'(',''),')',''),' ','') phonenbr from  #adtemp t (nolock) where mobile is not null
union
select substring(replace(replace(replace(replace(t.telephonenumber,'-',''),'(',''),')',''),' ',''),1,10) phonenbr from  #adtemp t (nolock) where telephonenumber is not null
except
select phonenbr from [dbo].[Phone]) xx
-- inserted 204 rows


/*Update the telephone numbers that were changed in ActiveDirectory */
update [dbo].[ContactPhone] 
 set phoneid = src.phoneid
--select tgt.phoneid old_phoneid, src.phoneid new_phoneid, src.contactid, src.contactname
--, tgt.phonetypeid old_type
from [dbo].[ContactPhone]  tgt
 join 
 ( select adp.phoneid, acp.phonetypeid, c.contactid, c.contactname
from #adtemp t
join dbo.employee e (nolock)
	on e.userid = t.samaccountname
join contact c (nolock)
	on c.contactid = e.contactid
join contactphone cp (nolock)
	on cp.contactid = e.contactid and cp.phonetypeid = 27 
join phone p (nolock)
	on p.phoneid = cp.phoneid
left join phone adp (nolock)
	on adp.phonenbr = substring(replace(replace(replace(replace(t.telephonenumber,'-',''),'(',''),')',''),' ',''),1,10) 
left join contactphone acp (nolock)
	on acp.phoneid = adp.phoneid and acp.phonetypeid = 27 and acp.contactid = c.contactid
where t.telephonenumber is not null
and p.phonenbr <> substring(replace(replace(replace(replace(t.telephonenumber,'-',''),'(',''),')',''),' ',''),1,10)
) src
	on src.contactid = tgt.contactid
where tgt.phonetypeid = 27

/*Update the mobile telephone numbers that were changed in ActiveDirectory*/
update [dbo].[ContactPhone] 
 set phoneid = src.phoneid
--select tgt.phoneid old_phoneid, src.phoneid new_phoneid, src.contactid, src.contactname
--, tgt.phonetypeid old_type
from [dbo].[ContactPhone]  tgt
 join 
 ( select adp.phoneid, acp.phonetypeid, c.contactid, c.contactname
from #adtemp t
join dbo.employee e (nolock)
	on e.userid = t.samaccountname
join contact c (nolock)
	on c.contactid = e.contactid
join contactphone cp (nolock)
	on cp.contactid = e.contactid and cp.phonetypeid = 26 
join phone p (nolock)
	on p.phoneid = cp.phoneid
left join phone adp (nolock)
	on adp.phonenbr = substring(replace(replace(replace(replace(t.mobile,'-',''),'(',''),')',''),' ',''),1,10) 
left join contactphone acp (nolock)
	on acp.phoneid = adp.phoneid and acp.phonetypeid = 26 and acp.contactid = c.contactid
where t.mobile is not null
and p.phonenbr <> substring(replace(replace(replace(replace(t.mobile,'-',''),'(',''),')',''),' ',''),1,10)
) src
	on src.contactid = tgt.contactid
where tgt.phonetypeid = 26


-- insert missing AD telephone numbers
insert into dbo.contactphone
(contactid, phoneid, phonetypeid) 
select distinct ins.contactid,p.phoneid, 27 as phonetypeid
from
(
select  t.samaccountname, c.contactid, c.contactname,27 as phonetypeid
from #adtemp t
join dbo.employee e (nolock)
	on e.userid = t.samaccountname
join contact c (nolock)
	on c.contactid = e.contactid
where t.telephonenumber is not null
except
select  t.samaccountname, c.contactid, c.contactname, cp.phonetypeid
from #adtemp t
join dbo.employee e (nolock)
	on e.userid = t.samaccountname
join contact c (nolock)
	on c.contactid = e.contactid
join contactphone cp (nolock)
	on cp.contactid = e.contactid and cp.phonetypeid = 27 
where t.telephonenumber is not null
) ins
join #adtemp ad
	on ad.samaccountname = ins.samaccountname
left join phone p (nolock)
	on p.phonenbr = substring(replace(replace(replace(replace(ad.telephonenumber,'-',''),'(',''),')',''),' ',''),1,10)
order by ins.contactid


-- insert missing AD mobile numbers
insert into dbo.contactphone
(contactid, phoneid, phonetypeid)
select distinct ins.contactid,p.phoneid, 26 as phonetypeid
from
(
select  t.samaccountname, c.contactid, c.contactname,26 as phonetypeid
from #adtemp t
join dbo.employee e (nolock)
	on e.userid = t.samaccountname
join contact c (nolock)
	on c.contactid = e.contactid
where t.mobile is not null
except
select  t.samaccountname, c.contactid, c.contactname, cp.phonetypeid
from #adtemp t
join dbo.employee e (nolock)
	on e.userid = t.samaccountname
join contact c (nolock)
	on c.contactid = e.contactid
join contactphone cp (nolock)
	on cp.contactid = e.contactid and cp.phonetypeid = 26 
where t.mobile is not null
) ins
join #adtemp ad
	on ad.samaccountname = ins.samaccountname
left join phone p (nolock)
	on p.phonenbr = substring(replace(replace(replace(replace(ad.mobile,'-',''),'(',''),')',''),' ',''),1,10)
order by ins.contactid





END




