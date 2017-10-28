 

CREATE VIEW vw_cpny_access AS

select distinct
       vc.cpnyname,
       vc.databasename,
       vc.active,
       vc.cpnyid cpnyid,
       substring(screennumber,1,5) scrn,
       coalesce(vg.userid,va.userid) userid,
       convert(char,max(viewrights + updaterights + insertrights + deleterights + initrights)) seclevel
       from vs_company vc
       left outer join 
       vs_accessdetrights va
       on isnull(nullif(va.companyid,'[ALL] '),vc.cpnyid) = vc.cpnyid
       left outer join vs_usergrp vg 
       on vg.groupid = va.userid and va.rectype = 'G'                 
       group by cpnyname,vc.databasename,active,cpnyid, screennumber,coalesce(vg.userid,va.userid)
					 
