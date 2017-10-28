 

create view vs_share_usercpny
as

select vc.cpnyname,
       vc.databasename,
       vc.active,
       vc.cpnyid cpnyid,
       screennumber,
       substring(screennumber,1,5) scrn,
       coalesce(vg.userid,va.userid) userid,
       convert(char,max(viewrights + updaterights + insertrights + deleterights + initrights)) seclevel
  from vs_company vc,
       vs_accessdetrights va
    
       left outer join vs_usergrp vg 
       on   
       vg.groupid = va.userid and va.rectype = 'G'                 
       where  isnull(nullif(va.companyid,'[ALL] '),vc.cpnyid) = vc.cpnyid
       group by cpnyname,vc.databasename,active,cpnyid, screennumber,coalesce(vg.userid,va.userid)


 
