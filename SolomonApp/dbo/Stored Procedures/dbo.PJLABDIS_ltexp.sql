 create procedure  PJLABDIS_ltexp  @parm1 smalldatetime, @parm2 varchar(10)   as
select sum(amount), sum(worked_hrs), max(project), max(pjt_entity), pjlabdis.docnbr,
	hrs_type, linenbr, pjlabdis.employee, pjlabdis.pe_date, pjlabdis.gl_subacct, home_subacct, labor_class_cd,
	union_cd, work_type, earn_type_id, shift, rate_source, work_comp_cd, dl_id03, dl_id08, dl_id10, cpnyid_chrg, pjlabdis.CpnyId_home,
	max(pjemploy.emp_type_cd), max(pjlabhdr.le_type), dl_id12, dl_id14, dl_id16, dl_id18, dl_id20
from  PJLABDIS
	left outer join pjemploy
		on pjlabdis.employee = pjemploy.employee
	left outer join pjlabhdr
		on pjlabdis.docnbr  = pjlabhdr.docnbr
where pjlabdis.status_1 = '' and
	pjlabdis.pe_date <= @parm1 and
	pjlabdis.cpnyid_home = @parm2
group by pjlabdis.docnbr, hrs_type, linenbr, pjlabdis.employee,  pjlabdis.pe_date,
	pjlabdis.gl_subacct, home_subacct,	 labor_class_cd, union_cd, work_type,
	earn_type_id, shift, rate_source, work_comp_cd, dl_id03, dl_id08, dl_id10,
 	cpnyid_chrg, pjlabdis.CpnyId_home, pjlabdis.fiscalno, pjlabdis.status_1, dl_id12, dl_id14, dl_id16, dl_id18, dl_id20
Order by pjlabdis.status_1, pjlabdis.pe_date



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJLABDIS_ltexp] TO [MSDSL]
    AS [dbo];

