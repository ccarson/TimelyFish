 Create Procedure PJPAYHDR_SAPPR @parm1 varchar (10), @parm2 varchar (10), @parm3 char(100), @parm4 char(4)
 
 WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1' 
 as
SELECT pjpayhdr.*,
	pjproj.project,
	pjproj.gl_subacct,
	pjproj.cpnyID,
	pjsubcon.*,
	vendor.vendid,
	vendor.Name
FROM pjpayhdr
	left outer join vendor
		on pjpayhdr.vendid = vendor.vendid
	, pjproj, pjsubcon
WHERE pjpayhdr.approver = @parm1 and
	pjpayhdr.status1 =  'C' and
	pjpayhdr.project = pjproj.project and
	pjpayhdr.project = pjsubcon.project and
	pjpayhdr.subcontract = pjsubcon.subcontract and
	pjsubcon.cpnyid like @parm2 and
	pjsubcon.cpnyid in	(select cpnyid from dbo.UserAccessCpny(@parm3)) and
	pjpayhdr.curyid = @parm4
ORDER BY pjpayhdr.project, pjpayhdr.subcontract, pjpayhdr.payreqnbr


