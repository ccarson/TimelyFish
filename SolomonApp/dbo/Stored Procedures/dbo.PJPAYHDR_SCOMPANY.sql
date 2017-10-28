 create Procedure PJPAYHDR_SCOMPANY @parm1 varchar (10)  , @parm2 char(100), @parm3 char(4)
 
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
		on 	pjpayhdr.vendid = vendor.vendid
	, pjproj, pjsubcon
WHERE pjpayhdr.status1 =  'C' and
	pjpayhdr.project = pjproj.project and
	pjpayhdr.project = pjsubcon.project and
	pjpayhdr.subcontract = pjsubcon.subcontract and
	pjsubcon.cpnyid like @parm1 and
	pjsubcon.cpnyid in	(select cpnyid from dbo.UserAccessCpny(@parm2)) and 
	pjpayhdr.curyID = @parm3
ORDER BY pjpayhdr.project, pjpayhdr.subcontract, pjpayhdr.payreqnbr


