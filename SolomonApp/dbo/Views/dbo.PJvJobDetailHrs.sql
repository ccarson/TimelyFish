 

CREATE VIEW [dbo].[PJvJobDetailHrs]
AS
SELECT     dbo.PJTRAN.amount, dbo.PJTRAN.gl_acct, dbo.PJTRAN.fiscalno, dbo.PJTRAN.gl_subacct, dbo.PJEMPLOY.emp_name, dbo.PJCODE.code_type, 
                      dbo.PJCODE.code_value, dbo.PJCODE.code_value_desc, PM_INFO_1.emp_name AS PM_NAME_1, dbo.PJACCT.acct, dbo.PJACCT.acct_desc, 
                      dbo.PJACCT.acct_group_cd, dbo.PJACCT.acct_status, dbo.PJACCT.acct_type, dbo.PJPROJ.contract_type, dbo.PJPROJ.contract, 
                      dbo.PJPROJ.customer, dbo.PJTRAN.system_cd, dbo.PJTRAN.trans_date, dbo.PJTRAN.tr_id05, dbo.PJTRAN.units, dbo.PJTRAN.vendor_num, 
                      dbo.PJTRAN.voucher_line, dbo.PJTRAN.voucher_num, dbo.PJPROJ.manager1, dbo.Customer.Name AS CUSTOMER_NAME, dbo.PJPROJ.project, 
                      dbo.PJPROJ.purchase_order_num, dbo.PJPROJ.project_desc, dbo.PJPROJ.start_date, dbo.PJPROJ.end_date, 
                      PM_INFO_1.employee AS PM_EMP_ID_1, dbo.PJACCT.sort_num, dbo.PJTRAN.pjt_entity, dbo.PJPROJ.status_pa, PJTRAN.EMPLOYEE, 
                      pjrepcol.report_code, dbo.PJPROJ.CpnyId, dbo.RptCompany.CpnyName, dbo.PJTRAN.projcury_amount, dbo.PJPROJ.projcuryid
FROM         dbo.PJCODE RIGHT OUTER JOIN
                      dbo.PJTRAN ON dbo.PJCODE.code_value = dbo.PJTRAN.tr_id05 LEFT OUTER JOIN
                      dbo.PJEMPLOY ON dbo.PJTRAN.employee = dbo.PJEMPLOY.employee LEFT OUTER JOIN
                      dbo.PJACCT ON dbo.PJTRAN.acct = dbo.PJACCT.acct LEFT OUTER JOIN
                      dbo.PJPROJ LEFT OUTER JOIN
                      dbo.Customer ON dbo.PJPROJ.customer = dbo.Customer.CustId LEFT OUTER JOIN
                      dbo.PJEMPLOY PM_INFO_1 ON dbo.PJPROJ.manager1 = PM_INFO_1.employee ON dbo.PJTRAN.project = dbo.PJPROJ.project 
                      LEFT OUTER JOIN dbo.PJREPCOL ON dbo.PJTRAN.acct = dbo.PJREPCOL.acct INNER JOIN 
                      dbo.RptCompany ON dbo.PJPROJ.cpnyID = dbo.RptCompany.CpnyID
where (pjcode.code_type = 'LABC' and pjcode.code_value <> '') or (pjcode.code_value is null)
