CREATE VIEW [dbo].[TM410]
AS 

SELECT pjexphdr.docnbr, pjexphdr.status_2, 
 pjexphdr.status_1, pjexphdr.desc_hdr, 
 pjexphdr.report_date, pjexphdr.tripnbr, 
 pjexphdr.advance_amt, pjexpdet.exp_date, 
 pjexpdet.desc_detail, pjexpdet.exp_type, 
 pjexpdet.project, pjexpdet.payment_cd, 
 pjexpdet.units, pjexpdet.rate, pjexpdet.amt_employ, 
 pjexpdet.amt_company, pjexphdr.approver, pjexpdet.[status], 
 pjexpdet.vendor_num, pjexphdr.CpnyId_home, 
 pjexpdet.CpnyId_chrg, pjexpdet.gl_acct, pjemploy.emp_name, 
 pjemploy.employee, pjexphdr.gl_subacct, SubAcct.Descr,
  pjexpdet.pjt_entity, dbo.NameFlip( approver.emp_name ) AS ApproverName, 
  pjexpdet.CuryId, pjexpdet.CuryRate, pjexpdet.CuryTranamt,
  pjcode.code_value_desc, pjcode.code_type, pjcode.code_value,
  pjproj.project_desc,
  	CASE
		WHEN pjexpdet.curyID = '' THEN glsetup.BaseCuryID
		ELSE pjexpdet.CuryID
	END as Currency, 
	glsetup.FiscalPerEnd00,
	pjexptyp.desc_exp, dbo.NameFlip(pjemploy.emp_name) as EmployeeName,
	CASE 
		WHEN pjexphdr.status_2 = 'R' Then 'Repayment Amount'
        WHEN pjexphdr.status_2 = 'A' Then 'Advance Amount'
        ELSE 'Advance Used' 
	END as AdvancedUsedCaption,
	CASE 
		WHEN pjexpdet.payment_cd = '****' then pjexpdet.amt_employ
		else pjexpdet.amt_company
	End as BaseAmt,
	Case 
		When RTrim(pjexpdet.CpnyId_chrg) = '' and RTrim(pjexpdet.gl_acct) = '' Then ' '
		Else RTrim(pjexpdet.gl_acct) +  ' / ' + rTrim(pjexpdet.CpnyId_chrg) 
	End as cpnyglacctdata,
	CASE
		WHEN pjexpdet.CuryRate = 0 then 1
		else pjexpdet.CuryRate
	end as RptCuryRate,
	dbo.SLTransform( pjexpdet.gl_subacct, '001' ) as DetailSubAccount,
	dbo.NameFlip( pjemploy.emp_name ) + ' - ' + dbo.SLTransform( pjemploy.employee, '109') as Employeedata,
	dbo.SLTransform( pjexphdr.gl_subacct, '001' ) as EmpSubAccount,
	dbo.SLTransform( pjexphdr.gl_subacct, '001' )  + ' ' + subacct.Descr as EmpSubAccountData,
	Case 
		WHEN pjexpdet.payment_cd = '****' Then 'Employee Paid'
		Else ' '
	end as PaymentMethod,
	'sssss' as ProjectCaption,
	Case
		When pjexphdr.status_2 = 'R' Then 'Employee Repayment'
		When pjexphdr.status_2 = 'A' Then 'Employee Advance Request'
	    Else 'Expense Report'
	end as ReportName,
	Case 
		WHEN pjexphdr.status_1 = 'I' Then 'In Process'
		WHEN pjexphdr.status_1 = 'P' Then 'Posted'
		WHEN pjexphdr.status_1 = 'C' Then 'Completed'
		WHEN pjexphdr.status_1 = 'A' Then 'Approved'
		WHEN pjexphdr.status_1 = 'R' Then 'Rejected'
		Else pjexphdr.status_1 
	End as [HdrStatus],
	Case
	    When Len(RTrim(pjexpdet.pjt_entity)) > 15 Then pjexpdet.pjt_entity
		Else dbo.SLTransform(pjexpdet.pjt_entity, '115')
	End as TaskData,
	Case
	    When Len(RTrim(pjexpdet.project)) > 10 Then pjexpdet.project
		Else dbo.SLTransform(pjexpdet.project, '114')
	End as ProjectData,
	CASE
	    When RTrim(pjexpdet.project) = '' and RTrim(pjexpdet.pjt_entity) = '' Then ' '
		Else dbo.SLTransform(pjexpdet.project, '114') + ' / ' + dbo.SLTransform(pjexpdet.pjt_entity, '115')
	End as ProjectTaskData,
	vs_company.CpnyName as CmpnyName
 FROM   (((PJEXPHDR pjexphdr 
 INNER JOIN [PJEMPLOY] as pjemploy ON  pjexphdr.employee=pjemploy.employee) 
 LEFT OUTER JOIN [PJEXPDET] as pjexpdet ON pjexphdr.docnbr=pjexpdet.docnbr) 
 LEFT OUTER JOIN [SubAcct] as SubAcct ON pjexphdr.gl_subacct=SubAcct.Sub) 
 LEFT OUTER JOIN [PJEMPLOY] as approver ON pjexphdr.approver=approver.employee
 LEFT OUTER JOIN [PJCode] as PJCode ON pjexpdet.Payment_cd=pjcode.Code_value and pjcode.Code_type = 'TEPM'
 LEFT OUTER JOIN [Pjproj] as pjproj on pjexpdet.project=pjproj.project
 LEFT OUTER JOIN [Glsetup] on 1 = Glsetup.[Init]
 LEFT OUTER JOIN [pjexptyp] on pjexpdet.exp_type=pjexptyp.exp_type
 LEft OUTER JOIN [vs_company] on pjexphdr.CpnyId_home = vs_company.CpnyID

