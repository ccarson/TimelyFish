 CREATE PROC AccessRights_Screen_UserId3 @ScrnNbr varchar(5), @UserId varchar(24), @CpnyID varchar(10)
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
AS

SELECT CONVERT(varchar(10),COALESCE(MAX(seclevel),0)) 
  FROM (select vc.cpnyname,
               vc.databasename,
               vc.active,
               vc.cpnyid cpnyid,
               substring(screennumber,1,5) scrn,
               coalesce(vg.userid,va.userid) userid,
               convert(char,max(viewrights + updaterights + insertrights + deleterights + initrights)) seclevel
          from vs_company vc, vs_accessdetrights va
                       left outer join vs_usergrp vg
                                    on vg.groupid = va.userid and va.rectype = 'G'
          where isnull(nullif(va.companyid,'[ALL] '),vc.cpnyid) = vc.cpnyid
            and substring(va.screennumber ,1,5)= @ScrnNbr
          group by cpnyname,vc.databasename,active,cpnyid, screennumber,coalesce(vg.userid,va.userid)) as m
 where m.userid = @Userid and m.scrn = @scrnNbr and (m.cpnyid = @cpnyID or m.cpnyid = '[ALL]')

