
CREATE VIEW [dbo].[TMTimecard]
AS 

SELECT pjlabdet.day1_hr1,
       pjlabdet.day1_hr2,
       pjlabdet.day1_hr3,
       pjlabdet.day2_hr1,
       pjlabdet.day2_hr2,
       pjlabdet.day2_hr3,
       pjlabdet.day3_hr1,
       pjlabdet.day3_hr2,
       pjlabdet.day3_hr3,
       pjlabdet.day4_hr1,
       pjlabdet.day4_hr2,
       pjlabdet.day4_hr3,
       pjlabdet.day5_hr1,
       pjlabdet.day5_hr2,
       pjlabdet.day5_hr3,
       pjlabdet.day6_hr1,
       pjlabdet.day6_hr2,
       pjlabdet.day6_hr3,
       pjlabdet.day7_hr1,
       pjlabdet.day7_hr2,
       pjlabdet.day7_hr3,
       pjlabhdr.docnbr,
       pjlabhdr.employee employeeNumber,
       (convert(varchar, pjlabhdr.pe_date, 101)) pe_date,
       pjlabhdr.le_status,
       pjlabdet.ld_desc,
       pjlabdet.gl_acct,
       pjlabdet.labor_class_cd,
       pjemploy.manager1,
       pjemploy.manager2,
       pjemploy.cpnyid,
       pjlabdet.union_cd,
       pjlabdet.shift,
       pjlabdet.work_comp_cd,
       pjlabdet.work_type,
       pjlabdet.earn_type_id,
       pjlabdet.cpnyid_chrg,
       pjlabdet.project,
       pjlabdet.pjt_entity,
       subacct.descr,
       pjlabdet.ld_id08,
       pjlabdet.ld_id01,
       pjlabdet.ld_id02,
       pjlabdet.ld_id03,
       pjlabdet.ld_id04,
       pjlabdet.ld_id05,
       pjlabdet.ld_id06,
       pjlabdet.ld_id07,
       pjlabdet.ld_id09,
       pjlabdet.ld_id10,
       pjlabdet.subtask_name,
       pjlabhdr.le_id01,
       pjlabdet.ld_id17,
       pjlabhdr.cpnyid_home,
	   RTrim(vs_company.CpnyName) as CmpnyName,
	   PJCODE.code_value_desc laborClassName,
	   TempSalaryRate.rateSource,
	   Case 
		WHEN pjlabhdr.le_status = 'I' Then 'In Process'
		WHEN pjlabhdr.le_status = 'P' Then 'Posted'
		WHEN pjlabhdr.le_status = 'C' Then 'Completed'
		WHEN pjlabhdr.le_status = 'A' Then 'Approved'
		WHEN pjlabhdr.le_status = 'R' Then 'Rejected'
		Else pjlabhdr.le_status 
	End as [HdrStatus],
	Case
		WHEN ld_id17 = '1' Then 'Needs Approval'
		Else 'Not Required'
	End as [PMReviewNeeded],
	dbo.SLTransform( pjlabdet.gl_subacct, '001' ) as gl_subacct_pjlabdet,
	dbo.SLTransform( pjemploy.gl_subacct, '001' ) as  gl_subacct_pjemploy,
	dbo.NameFlip( pjemploy.emp_name ) AS employeeName,
	dbo.NameFlip( supervisor.emp_name ) AS emp_name_supervisor
FROM   (((pjlabhdr pjlabhdr
          INNER JOIN pjemploy pjemploy
					ON pjlabhdr.employee = pjemploy.employee)
         LEFT OUTER JOIN pjlabdet pjlabdet
                    ON pjlabhdr.docnbr = pjlabdet.docnbr)
        LEFT OUTER JOIN pjemploy supervisor
                    ON pjemploy.manager1 = supervisor.employee)
       LEFT OUTER JOIN subacct SubAcct
                    ON pjemploy.gl_subacct = subacct.sub
		LEft OUTER JOIN [vs_company] 
					ON pjlabhdr.CpnyId_home = vs_company.CpnyID
		LEFT OUTER JOIN PJCODE
					ON PJCODE.code_value = pjlabdet.labor_class_cd AND PJCODE.code_type = 'LABC' /* Hard Code, Labor Class code type */
		LEFT OUTER JOIN (Select code_value codeValue, code_value_desc rateSource from PJCODE where code_type = 'RATE') As TempSalaryRate /* because two unrelated things come from multiple rows of the table */ 
					ON  codeValue = pjlabdet.rate_source 
WHERE  ( pjlabdet.day1_hr1 <> 0
          OR pjlabdet.day1_hr2 <> 0
          OR pjlabdet.day1_hr3 <> 0
          OR pjlabdet.day2_hr1 <> 0
          OR pjlabdet.day2_hr2 <> 0
          OR pjlabdet.day2_hr3 <> 0
          OR pjlabdet.day3_hr1 <> 0
          OR pjlabdet.day3_hr2 <> 0
          OR pjlabdet.day3_hr3 <> 0
          OR pjlabdet.day4_hr1 <> 0
          OR pjlabdet.day4_hr2 <> 0
          OR pjlabdet.day4_hr3 <> 0
          OR pjlabdet.day5_hr1 <> 0
          OR pjlabdet.day5_hr2 <> 0
          OR pjlabdet.day5_hr3 <> 0
          OR pjlabdet.day6_hr1 <> 0
          OR pjlabdet.day6_hr2 <> 0
          OR pjlabdet.day6_hr3 <> 0
          OR pjlabdet.day7_hr1 <> 0
          OR pjlabdet.day7_hr2 <> 0
          OR pjlabdet.day7_hr3 <> 0 ) 


