 Create Procedure PJREVHDR_SAPPR @parm1 varchar (10), @parm2 Varchar(10),  @parm3 varchar(100)
  
  WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1' 
  as
SELECT pjrevhdr.*,
	pjproj.*,
	pjemploy.*,
	pjemploy1.employee, pjemploy1.emp_name,
	pjemploy3.employee, pjemploy3.emp_name,
	pjemploy4.employee, pjemploy4.emp_name,
	pjemploy5.employee, pjemploy5.emp_name
FROM pjrevhdr
	left outer join pjemploy
		on pjrevhdr.approver = pjemploy.employee
	left outer join pjemploy pjemploy1
		on pjrevhdr.preparer = pjemploy1.employee
	left outer join pjemploy pjemploy3
		on pjrevhdr.approved_by1 = pjemploy3.employee
	left outer join pjemploy pjemploy4
		on pjrevhdr.approved_by2 = pjemploy4.employee
	left outer join pjemploy pjemploy5
		on pjrevhdr.approved_by3 = pjemploy5.employee
	, pjproj
WHERE pjrevhdr.approver = @parm1 and
	pjrevhdr.project = pjproj.project and
	pjrevhdr.status in ( 'C ', 'A ' ) and
	pjproj.cpnyID like @parm2 and
	pjproj.CpnyId in
(select cpnyid from dbo.UserAccessCpny(@parm3))
ORDER BY pjrevhdr.project, revid


