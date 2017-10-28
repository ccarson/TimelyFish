 create procedure PJBILL_srules @parm1 varchar (16)  as
select pjbill.project,
       pjbill.project_billwith,
       pjbill.bill_type_cd,
       pjrules.bill_type_cd,
       pjrules.acct,
       pjrules.li_type
from   PJBILL, PJRULES
where  pjbill.project = @parm1 and
       pjbill.bill_type_cd = pjrules.bill_type_cd
order by pjbill.project


