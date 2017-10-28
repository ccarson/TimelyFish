
CREATE VIEW [QQ_pjprojNamed]
AS
SELECT     P.project, P.project_desc AS [project description], P.status_pa AS [project status], 
                      P.MSPInterface AS [integrated with MSP], P.customer, dbo.NameFlip(NAME) AS [customer name], '(' + SUBSTRING(C.Phone, 1, 3) + ')' + SUBSTRING(C.Phone, 4, 3) 
                      + '-' + RTRIM(SUBSTRING(C.Phone, 7, 24)) AS [customer phone], P.contract, P.contract_type AS [contract type], 
                      P.purchase_order_num AS [purchase order], P.CpnyId AS company, P.gl_subacct AS subaccount, 
                      P.manager1 AS [project manager], dbo.NameFlip(pjemploy.emp_name) AS [project mgr name], P.manager2 AS [business manager],
                       dbo.NameFlip(pjemploy_1.emp_name) AS [business mgr name], B.approver AS [invoice approver], convert(date,P.start_date) AS [start date], 
                      convert(date,P.end_date) AS [end date], P.slsperid AS [salesperson], P.budget_type AS [budget type], 
                      P.alloc_method_cd AS [allocation method 1], P.alloc_method2_cd AS [allocation method 2], 
                      B.project_billwith AS [bill with project], P.billcuryid AS [billing currency], convert(date,X.PM_ID18) AS [PO order date], 
                      X.entered_pc AS [entered % complete], convert(date,X.revision_date) AS [% complete revision date], 
                      X.fee_percent AS [fee percent], X.rev_flag AS [revenue recognition flag], 
                      X.rev_type AS [revenue recognition type], X.work_comp_cd AS [workers comp code], 
                      X.work_location AS [work location], P.labor_gl_acct AS [labor G/L account], 
                      P.billcuryfixedrate AS [bill currency fixed rate], P.pm_id40 AS [manager line item review flag], 
                      P.rate_table_id AS [allocation rate table], P.status_18 AS [employee must be assigned], 
                      P.status_19 AS [employee must be on team], X.PM_ID14 AS [earnings type], 
                      X.PM_ID15 AS [prevailing wage code], X.PM_ID24 AS [revenue G/L account], 
                      X.rate_table_labor AS [rate table for labor costs], B.approval_sw AS [invoice approval required], B.biller, 
                      B.billings_cycle_cd AS [billings cycle code], B.bill_type_cd AS [billings rule], P.status_15 AS [create inv draft], 
                      P.status_16 AS [shipper inv method], P.budget_version AS [revenue budget rate type], 
                      P.status_14 AS [revenue budget calc method], B.inv_attach_cd AS [invoice attachment], 
                      B.inv_format_cd AS [invoice format], convert(date,B.last_bill_date) AS [last invoice date], B.pb_id20 AS [split billing type], 
                      B.retention_percent AS [retention percent], B.pb_id13 AS [invoice entry rate table], C.BillCity AS [customer city], 
                      C.BillState AS [customer state], P.shiptoid AS [customer ship to], P.probability, P.status_20, 
                      P.status_ap, P.status_ar, P.status_gl, P.status_in, P.status_lb, P.status_po, 
					  P.noteid, rtrim(isnull(PJNOTES.key_value,'')) [Comment],
                      P.pm_id01, P.pm_id02, P.pm_id03 AS [last change order num], P.pm_id04, P.pm_id05, 
                      P.pm_id06, P.pm_id07, convert(date,P.pm_id08) AS [pm_id08], convert(date,P.pm_id09) AS [pm_id09], P.pm_id10, P.pm_id31, 
                      P.pm_id32, P.pm_id33, P.pm_id34, P.pm_id35, P.pm_id36, 
                      P.pm_id37 AS [utilization type], P.pm_id38, convert(date,P.pm_id39) AS [pm_id39], P.user1, P.user2, P.user3, 
                      P.user4, X.PM_ID11, X.PM_ID12 AS [last used owner change order], 
                      X.PM_ID13 AS [revenue recog flags], X.PM_ID16, X.PM_ID17, convert(date,X.PM_ID19) AS [pm_id19], 
                      X.PM_ID20 AS [last used budget rev num], X.PM_ID21, X.PM_ID22, X.PM_ID23, 
                      X.PM_ID25, X.PM_ID26, X.PM_ID27, convert(date,X.PM_ID28) AS [pm_id28], convert(date,X.PM_ID29) AS [pm_id29], 
                      X.PM_ID30, convert(date,P.crtd_datetime) AS [create date], P.crtd_prog AS [create program], 
                      P.crtd_user AS [create user], convert(date,P.lupd_datetime) AS [last update date], P.lupd_prog AS [last update program], 
                      P.lupd_user AS [last update user]
FROM         PJPROJ P WITH (nolock) INNER JOIN
                      PJPROJEX X WITH (nolock) ON P.project = X.project LEFT OUTER JOIN
                      PJBILL B WITH (nolock) ON P.project = B.project LEFT OUTER JOIN
                      PJEMPLOY WITH (nolock) ON P.manager1 = PJEMPLOY.employee LEFT OUTER JOIN
                      PJEMPLOY AS PJEMPLOY_1 WITH (nolock) ON P.manager2 = PJEMPLOY_1.employee LEFT OUTER JOIN
 					  PJNOTES WITH (nolock) ON P.project = PJNOTES.key_value and PJNOTES.note_type_cd = 'PROJ' LEFT OUTER JOIN
                      Customer C WITH (nolock) ON P.customer = C.CustId


