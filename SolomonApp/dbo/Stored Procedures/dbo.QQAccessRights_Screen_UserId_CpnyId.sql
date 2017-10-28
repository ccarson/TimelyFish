--Returns the level of access a user has to a screen for a company
CREATE PROCEDURE QQAccessRights_Screen_UserId_CpnyId @ScrnNbr varchar(7), @UserId varchar(47), @CpnyId varchar(10)
AS
SELECT isnull(MAX(seclevel),0) FROM
(select vc.cpnyname,
vc.databasename,
vc.active,
vc.cpnyid cpnyid,
screennumber scrn,
isnull(vg.userid,va.userid) userid,
max(viewrights + updaterights + insertrights + deleterights + initrights) seclevel
from vs_company vc,
vs_accessdetrights va

left outer join vs_usergrp vg
on
vg.groupid = va.userid and va.rectype = 'G'
where isnull(nullif(va.companyid,'[ALL] '),vc.cpnyid) = vc.cpnyid
--and va.userid = @UserId
and va.screennumber = @ScrnNbr
group by cpnyname,vc.databasename,active,cpnyid, screennumber,isnull(vg.userid,va.userid)
) as m

where m.userid = @Userid and m.scrn = @scrnNbr and (m.cpnyid = @CpnyId or m.cpnyid = '[ALL]')

