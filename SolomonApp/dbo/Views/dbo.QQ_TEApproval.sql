CREATE VIEW [dbo].[QQ_TEApproval]
AS

SELECT 
	  [Type] = 'T',
	  PJLABHDR.docnbr [DocNbr],
	  PJLABHDR.employee [EmpID],
	  [EmpName] =  CASE 
						  WHEN CHARINDEX('~', PJEMPLOY.emp_name) > 0 THEN 
							 LTRIM(RIGHT(RTRIM(PJEMPLOY.emp_name), LEN(PJEMPLOY.emp_name) - CHARINDEX('~', PJEMPLOY.emp_name))) + ' ' + SUBSTRING(PJEMPLOY.emp_name, 1, (CHARINDEX('~', PJEMPLOY.emp_name) - 1))
						  ELSE
							 PJEMPLOY.emp_name
					 END,
	  pjlabhdr.approver [Approver],
	  pjlabhdr.cpnyid_home [CompanyID],
	  PJLABHDR.pe_date [Date],
	  PJLABHDR.le_id02 [Description],
	  PJLABHDR.le_status [Status],
	  PJLABHDR.noteid [NoteID],
	  [Total] = CASE 
					WHEN EXISTS (select * from PJLABDET where PJLABDET.docnbr = PJLABHDR.docnbr) THEN 
							(Select Sum( PJLABDET.total_hrs) from PJLABDET where PJLABDET.docnbr = PJLABHDR.docnbr )
						ELSE
							0
					END,
	  '' [ExpType],
	  0 [Advance],
	  cast(PJLABHDR.tstamp as bigint) [tstamp]
   FROM
	  pjlabhdr,
	  pjemploy
	WHERE
	  pjlabhdr.employee =  pjemploy.employee and
	  (pjlabhdr.le_status = 'C') and
	  ((SELECT SUBSTRING(PJCONTRL.control_data,1,1) as [ManagerReview]
	    FROM PJCONTRL where 
		PJCONTRL.control_code = 'MANAGER-REVIEW' and PJCONTRL.control_type = 'PA') <> 'Y' or pjlabhdr.le_id07 = 0) 
union

	  Select 
	  [Type] = 'E',
 	  pjexphdr.docnbr [DocNbr],
	  pjexphdr.employee [EmpID],
	  [EmpName] =  CASE 
						  WHEN CHARINDEX('~', PJEMPLOY.emp_name) > 0 THEN 
							 LTRIM(RIGHT(RTRIM(PJEMPLOY.emp_name), LEN(PJEMPLOY.emp_name) - CHARINDEX('~', PJEMPLOY.emp_name))) + ' ' + SUBSTRING(PJEMPLOY.emp_name, 1, (CHARINDEX('~', PJEMPLOY.emp_name) - 1))
						  ELSE
							 PJEMPLOY.emp_name
					 END,
	  pjexphdr.approver [Approver],
	  pjexphdr.cpnyid_home [CompanyID],
	  pjexphdr.report_date [Date],
	  pjexphdr.desc_hdr [Description],
	  pjexphdr.status_1 [Status],
	  pjexphdr.noteid [NoteID],
	  [Total] = CASE 
					WHEN EXISTS (select * from pjexpdet where pjexphdr.docnbr = pjexpdet.docnbr ) THEN 
							(Select Sum( pjexpdet.amt_employ) from pjexpdet where pjexphdr.docnbr = pjexpdet.docnbr )
						ELSE
							0
					END,
	  pjexphdr.status_2 [ExpType],
	  pjexphdr.advance_amt [Advance],
	  cast(pjexphdr.tstamp as bigint) [tstamp]
From PJEXPHDR
	left outer join PJEMPLOY
		on pjexphdr.employee = pjemploy.employee
Where
	(pjexphdr.status_1 = 'C')  and
	  ((SELECT SUBSTRING(PJCONTRL.control_data,1,1) as [ManagerReview]
	    FROM PJCONTRL where 
		PJCONTRL.control_code = 'MANAGER-REVIEW' and PJCONTRL.control_type = 'PA') <> 'Y' or pjexphdr.te_id06 = 0) 
union
SELECT 
	  [Type] = 'T',
	  PJLABHDR.docnbr  [DocNbr],
	  PJLABHDR.employee [EmpID],
	  [EmpName] =  CASE 
						  WHEN CHARINDEX('~', empname.emp_name) > 0 THEN 
							 LTRIM(RIGHT(RTRIM(empname.emp_name), LEN(empname.emp_name) - CHARINDEX('~', empname.emp_name))) + ' ' + SUBSTRING(empname.emp_name, 1, (CHARINDEX('~', empname.emp_name) - 1))
						  ELSE
							 empname.emp_name
					 END,
	  pjdeleg.delegate_to_ID [Approver],
	  pjlabhdr.cpnyid_home [CompanyID],
	  PJLABHDR.pe_date [Date],
	  PJLABHDR.le_id02  + ' (Delegated)'  [Description],
	  PJLABHDR.le_status [Status],
	  PJLABHDR.noteid [NoteID],
	  [Total] = CASE 
					WHEN EXISTS (select * from PJLABDET where PJLABDET.docnbr = PJLABHDR.docnbr) THEN 
							(Select Sum( PJLABDET.total_hrs) from PJLABDET where PJLABDET.docnbr = PJLABHDR.docnbr )
						ELSE
							0
					END,
	  '' [ExpType],
	  0 [Advance],
	  cast(PJLABHDR.tstamp as bigint) [tstamp]
   FROM
	  pjlabhdr,
	  pjemploy,
  	  pjemploy empname,
	  pjdeleg
	WHERE
	  pjlabhdr.Approver =  pjemploy.employee and pjemploy.employee in (select pjdeleg.employee from pjdeleg 
																		where pjdeleg.Doc_type = 'PTIM' and
																		pjdeleg.date_start <= GETDATE() and
																		pjdeleg.date_end >= GETDATE() and
																		pjdeleg.delegate_flag = 'Y') 	and 
																		pjdeleg.employee = pjemploy.employee and 
																		pjdeleg.Doc_type = 'PTIM' and
																		pjdeleg.date_start <= GETDATE() and
																		pjdeleg.date_end >= GETDATE() and
																		pjdeleg.delegate_flag = 'Y'			and
																		empname.employee =  PJLABHDR.employee and
	  (pjlabhdr.le_status = 'C') and
	  ((SELECT SUBSTRING(PJCONTRL.control_data,1,1) as [ManagerReview]
	    FROM PJCONTRL where 
		PJCONTRL.control_code = 'MANAGER-REVIEW' and PJCONTRL.control_type = 'PA') <> 'Y' or pjlabhdr.le_id07 = 0) 
union

	  Select 
	  [Type] = 'E',
 	  pjexphdr.docnbr [DocNbr],
	  pjexphdr.employee [EmpID],
	  [EmpName] =  CASE 
						  WHEN CHARINDEX('~', empname.emp_name) > 0 THEN 
							 LTRIM(RIGHT(RTRIM(empname.emp_name), LEN(empname.emp_name) - CHARINDEX('~', empname.emp_name))) + ' ' + SUBSTRING(empname.emp_name, 1, (CHARINDEX('~', empname.emp_name) - 1))
						  ELSE
							 empname.emp_name
					 END,
	  pjdeleg.delegate_to_ID [Approver],
	  pjexphdr.cpnyid_home [CompanyID],
	  pjexphdr.report_date [Date],
	  pjexphdr.desc_hdr  + ' (Delegated)' [Description],
	  pjexphdr.status_1 [Status],
	  pjexphdr.noteid [NoteID],
	  [Total] = CASE 
					WHEN EXISTS (select * from pjexpdet where pjexphdr.docnbr = pjexpdet.docnbr ) THEN 
							(Select Sum( pjexpdet.amt_employ) from pjexpdet where pjexphdr.docnbr = pjexpdet.docnbr )
						ELSE
							0
					END,
	  pjexphdr.status_2 [ExpType],
	  pjexphdr.advance_amt [Advance],
	  cast(pjexphdr.tstamp as bigint) [tstamp]
From PJEXPHDR
	left outer join PJEMPLOY
		on pjexphdr.approver = pjemploy.employee,
		pjemploy empname,
		pjdeleg
Where
	(pjexphdr.status_1 = 'C')  and pjemploy.employee in (select pjdeleg.employee from pjdeleg 
																		where pjdeleg.Doc_type = 'PEXP' and
																		pjdeleg.date_start <= GETDATE() and
																		pjdeleg.date_end >= GETDATE() and
																		pjdeleg.delegate_flag = 'Y') and 
																		pjdeleg.employee = 	pjemploy.employee and 
																		pjdeleg.Doc_type = 'PEXP' and
																		pjdeleg.date_start <= GETDATE() and
																		pjdeleg.date_end >= GETDATE() and
																		pjdeleg.delegate_flag = 'Y'			and
																		empname.employee =  pjexphdr.employee and
	  ((SELECT SUBSTRING(PJCONTRL.control_data,1,1) as [ManagerReview]
	    FROM PJCONTRL where 
		PJCONTRL.control_code = 'MANAGER-REVIEW' and PJCONTRL.control_type = 'PA') <> 'Y' or pjexphdr.te_id06 = 0) 
