
CREATE VIEW [dbo].[QQ_LineApprovals]
AS

SELECT 
	  [Type] = 'T',
	  PJLABHDR.docnbr [DocNbr],
	  PJLABHDR.employee [EmpID],
	  dbo.NameFlip(PJEMPLOY.emp_name)[EmpName],
	  PJPROJ.manager1 [Approver],
	  PJPROJ.manager2 [BusinessManager],
	  pjlabhdr.cpnyid_home [CompanyID],
	  PJLABHDR.pe_date [EndDate],
	  PJLABHDR.le_id02 [HeaderDescription],
	  PJLABHDR.le_status [Status],
	  PJLABHDR.noteid [NoteID],
	  (Select Sum( PJLABDET.total_hrs) from PJLABDET where PJLABDET.docnbr = PJLABHDR.docnbr ) [Total], 
	  PJLABHDR.le_id07 [MgrReviewCnt],
	  PJLABDET.project [Project],
	  PJLABDET.pjt_entity [Task],
	  PJLABDET.SubTask_Name [SubTask],
	  pjlabdet.gl_subacct [SubAcct],
	  PJLABDET.ld_id08 [Date],
	  PJLABDET.labor_class_cd [LaborClass],
	  '' [ExpType],
	  PJLABDET.earn_type_id [EarnTypeID],
	  '' [Units],
	  [Billable] = CASE WHEN PJLABDET.ld_status = 'N' THEN 'No' ELSE 'Yes' END,
	  (PJLABDET.day1_hr1 + PJLABDET.day1_hr2 + PJLABDET.day1_hr3) [Day1Hours],
	  (PJLABDET.day2_hr1 + PJLABDET.day2_hr2 + PJLABDET.day2_hr3) [Day2Hours],
	  (PJLABDET.day3_hr1 + PJLABDET.day3_hr2 + PJLABDET.day3_hr3) [Day3Hours],
	  (PJLABDET.day4_hr1 + PJLABDET.day4_hr2 + PJLABDET.day4_hr3) [Day4Hours],
	  (PJLABDET.day5_hr1 + PJLABDET.day5_hr2 + PJLABDET.day5_hr3) [Day5Hours],
	  (PJLABDET.day6_hr1 + PJLABDET.day6_hr2 + PJLABDET.day6_hr3) [Day6Hours],
	  (PJLABDET.day7_hr1 + PJLABDET.day7_hr2 + PJLABDET.day7_hr3) [Day7Hours],
	  CASE WHEN PJLABHDR.le_id01 = 'Y' THEN 0 ELSE 1 END [IsWeekly],
	  '' [Rate],
	  PJLABDET.ld_desc [Description],
	  PJPROJ.customer [CustomerID],
	  PJPROJ.[Contract],
	  PJLABDET.noteid [DetailNoteID],
	  PJLABDET.linenbr [LineNumber],
	  cast(PJLABDET.tstamp as bigint) [tstamp]

   FROM
	  pjlabhdr,
	  pjlabdet,
	  pjemploy,
	  PJPROJ
	WHERE
	  pjlabhdr.employee =  pjemploy.employee and
	  (pjlabhdr.le_status = 'C') and
	  PJLABHDR.le_id07 > 0 and
	  pjlabdet.ld_id17 = '1' and
	  pjlabhdr.docnbr = pjlabdet.docnbr and
	  pjproj.project = PJLABDET.project
union

	  Select 
	  [Type] = 'E',
 	  pjexphdr.docnbr [DocNbr],
	  pjexphdr.employee [EmpID],
	  dbo.NameFlip(PJEMPLOY.emp_name)[EmpName],
	  PJPROJ.manager1 [Approver],
	  PJPROJ.manager2 [BusinessManager],
	  pjexphdr.cpnyid_home [CompanyID],
	  pjexphdr.report_date [Date],
	  pjexphdr.desc_hdr [HeaderDescription],
	  pjexphdr.status_1 [Status],
	  pjexphdr.noteid [NoteID],
	  (Select Sum( pjexpdet.amt_employ) from pjexpdet where pjexphdr.docnbr = pjexpdet.docnbr ) [Total], 
	  pjexphdr.te_id06 [MgrReviewCnt],
	  pjexpdet.project [Project],
	  pjexpdet.pjt_entity [Task],
	  '' [SubTask],
	  pjexpdet.gl_subacct [SubAcct],
	  pjexpdet.exp_date [Date],
	  '' [LaborClass],
	  pjexpdet.exp_type [ExpType],
	  '' [EarnTypeID],
	  pjexpdet.units [Units],
	  [Billable] = CASE WHEN pjexpdet.status = 'N' THEN 'No' ELSE 'Yes' END,
	  '' [Day1Hours],
	  '' [Day2Hours],
	  '' [Day3Hours],
	  '' [Day4Hours],
	  '' [Day5Hours],
	  '' [Day6Hours],
	  '' [Day7Hours],
	  0 [IsWeekly],
	  pjexpdet.rate [Rate],
	  pjexpdet.desc_detail [Description],
	  PJPROJ.customer [CustomerID],
	  PJPROJ.[Contract],
	  pjexpdet.noteid [DetailNoteID],
	  pjexpdet.linenbr [LineNumber],
	  cast(pjexpdet.tstamp as bigint) [tstamp]
	  	  
From PJEXPHDR
	left outer join PJEMPLOY
		on pjexphdr.employee = pjemploy.employee,
		pjexpdet,
	  PJPROJ
Where
	(pjexphdr.status_1 = 'C')  and
	  pjexphdr.te_id06 > 0 and
	  pjexpdet.td_id14 = '1' and
	  pjexphdr.docnbr = pjexpdet.docnbr  and
	  pjproj.project = pjexpdet.project

union
	  SELECT 
	  [Type] = 'T',
	  PJLABHDR.docnbr [DocNbr],
	  PJLABHDR.employee [EmpID],
	  dbo.NameFlip(empname.emp_name)[EmpName],
	  pjdeleg.delegate_to_ID [Approver],
	  PJPROJ.manager2 [BusinessManager],
	  pjlabhdr.cpnyid_home [CompanyID],
	  PJLABHDR.pe_date [EndDate],
	  PJLABHDR.le_id02  + ' (Delegated)'  [HeaderDescription],
	  PJLABHDR.le_status [Status],
	  PJLABHDR.noteid [NoteID],
	  (Select Sum( PJLABDET.total_hrs) from PJLABDET where PJLABDET.docnbr = PJLABHDR.docnbr ) [Total], 
	  PJLABHDR.le_id07 [MgrReviewCnt],
	  PJLABDET.project [Project],
	  PJLABDET.pjt_entity [Task],
	  PJLABDET.SubTask_Name [SubTask],
	  pjlabdet.gl_subacct [SubAcct],
	  PJLABDET.ld_id08 [Date],
	  PJLABDET.labor_class_cd [LaborClass],
	  '' [ExpType],
	  PJLABDET.earn_type_id [EarnTypeID],
	  '' [Units],
	  [Billable] = CASE WHEN PJLABDET.ld_status = 'N' THEN 'No' ELSE 'Yes' END,
	  (PJLABDET.day1_hr1 + PJLABDET.day1_hr2 + PJLABDET.day1_hr3) [Day1Hours],
	  (PJLABDET.day2_hr1 + PJLABDET.day2_hr2 + PJLABDET.day2_hr3) [Day2Hours],
	  (PJLABDET.day3_hr1 + PJLABDET.day3_hr2 + PJLABDET.day3_hr3) [Day3Hours],
	  (PJLABDET.day4_hr1 + PJLABDET.day4_hr2 + PJLABDET.day4_hr3) [Day4Hours],
	  (PJLABDET.day5_hr1 + PJLABDET.day5_hr2 + PJLABDET.day5_hr3) [Day5Hours],
	  (PJLABDET.day6_hr1 + PJLABDET.day6_hr2 + PJLABDET.day6_hr3) [Day6Hours],
	  (PJLABDET.day7_hr1 + PJLABDET.day7_hr2 + PJLABDET.day7_hr3) [Day7Hours],
	  CASE WHEN PJLABHDR.le_id01 = 'Y' THEN 0 ELSE 1 END [IsWeekly],
	  '' [Rate],
	  PJLABDET.ld_desc + ' (Delegated)' [Description],
	  PJPROJ.customer [CustomerID],
	  PJPROJ.[Contract],
	  PJLABDET.noteid [DetailNoteID],
	  PJLABDET.linenbr [LineNumber],
	  cast(PJLABDET.tstamp as bigint) [tstamp]

   FROM
	  pjlabhdr,
	  pjlabdet,
	  pjemploy,
	  pjemploy empname,
	  PJPROJ,
	  pjdeleg
	WHERE
	  PJPROJ.manager1 =  pjemploy.employee and pjemploy.employee in (select pjdeleg.employee from pjdeleg 
																		where pjdeleg.Doc_type = 'PITM' and
																		pjdeleg.date_start <= GETDATE() and
																		pjdeleg.date_end >= GETDATE() and
																		pjdeleg.delegate_flag = 'Y') and
																		pjdeleg.employee = 	pjemploy.employee and 
																		pjdeleg.Doc_type = 'PITM' and
																		pjdeleg.date_start <= GETDATE() and
																		pjdeleg.date_end >= GETDATE() and
																		pjdeleg.delegate_flag = 'Y'	and		
																		empname.employee =  PJLABHDR.employee and
	  (pjlabhdr.le_status = 'C') and
	  PJLABHDR.le_id07 > 0 and
	  pjlabdet.ld_id17 = '1' and
	  pjlabhdr.docnbr = pjlabdet.docnbr and
	  pjproj.project = PJLABDET.project

union

	  Select 
	  [Type] = 'E',
 	  pjexphdr.docnbr [DocNbr],
	  pjexphdr.employee [EmpID],
	  dbo.NameFlip(empname.emp_name)[EmpName],
	  pjdeleg.delegate_to_ID [Approver],
	  PJPROJ.manager2 [BusinessManager],
	  pjexphdr.cpnyid_home [CompanyID],
	  pjexphdr.report_date [Date],
	  pjexphdr.desc_hdr + ' (Delegated)'  [HeaderDescription],
	  pjexphdr.status_1 [Status],
	  pjexphdr.noteid [NoteID],
	  (Select Sum( pjexpdet.amt_employ) from pjexpdet where pjexphdr.docnbr = pjexpdet.docnbr ) [Total], 
	  pjexphdr.te_id06 [MgrReviewCnt],
	  pjexpdet.project [Project],
	  pjexpdet.pjt_entity [Task],
	  '' [SubTask],
	  pjexpdet.gl_subacct [SubAcct],
	  pjexpdet.exp_date [Date],
	  '' [LaborClass],
	  pjexpdet.exp_type [ExpType],
	  '' [EarnTypeID],
	  pjexpdet.units [Units],
	  [Billable] = CASE WHEN pjexpdet.status = 'N' THEN 'No' ELSE 'Yes' END,
	  '' [Day1Hours],
	  '' [Day2Hours],
	  '' [Day3Hours],
	  '' [Day4Hours],
	  '' [Day5Hours],
	  '' [Day6Hours],
	  '' [Day7Hours],
	  0 [IsWeekly],
	  pjexpdet.rate [Rate],
	  pjexpdet.desc_detail  + ' (Delegated)' [Description],
	  PJPROJ.customer [CustomerID],
	  PJPROJ.[Contract],
	  pjexpdet.noteid [DetailNoteID],
	  pjexpdet.linenbr [LineNumber],
	  cast(pjexpdet.tstamp as bigint) [tstamp]
	  	  
From PJEXPHDR,
	 PJEMPLOY,
	 pjexpdet,
	 pjemploy empname,
	 PJPROJ,
	 pjdeleg

Where PJPROJ.manager1 =  pjemploy.employee and pjemploy.employee in (select pjdeleg.employee from pjdeleg 
								where pjdeleg.Doc_type = 'PITM' and
								pjdeleg.date_start <= GETDATE() and
								pjdeleg.date_end >= GETDATE() and
								pjdeleg.delegate_flag = 'Y')  and
								pjdeleg.employee = 	pjemploy.employee and 
								pjdeleg.Doc_type = 'PITM' and
								pjdeleg.date_start <= GETDATE() and
								pjdeleg.date_end >= GETDATE() and
								pjdeleg.delegate_flag = 'Y'	and		
								empname.employee =  pjexphdr.employee and
	(pjexphdr.status_1 = 'C')  and
	  pjexphdr.te_id06 > 0 and
	  pjexpdet.td_id14 = '1' and
	  pjexphdr.docnbr = pjexpdet.docnbr  and
	  pjproj.project = pjexpdet.project

