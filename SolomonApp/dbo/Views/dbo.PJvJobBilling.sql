CREATE VIEW [dbo].[PJvJobBilling]
AS
SELECT     dbo.PJINVDET.CuryTranamt AS amount, dbo.PJINVDET.fiscalno, dbo.PJINVDET.source_trx_date, dbo.PJINVDET.labor_class_cd, dbo.PJINVDET.pjt_entity, pjinvdet.bill_status,
                      dbo.PJINVDET.project_billwith, dbo.PJINVDET.project, dbo.PJPROJ.project_desc, dbo.PJPROJ.purchase_order_num, dbo.PJPROJ.status_pa, 
                      dbo.PJPROJ.contract_type, dbo.PJPROJ.start_date, dbo.PJPROJ.end_date, dbo.PJCODE.code_value_desc, dbo.PJREPCOL.report_code, 
                      dbo.PJREPCOL.column_nbr, dbo.PJINVDET.units, dbo.PJPROJ.gl_subacct, dbo.Customer.Name AS Cust_name, dbo.PJINVDET.employee, 
                      dbo.PJEMPLOY.emp_name, dbo.PJPROJ.manager1, dbo.PJvProjectManager.PM01, dbo.PJvProjectManager.PM01_Name, pjacct.sort_num,
                      pjinvdet.acct, pjproj.contract, PJJOBSUMMARYWrk.ri_id, dbo.PJPROJ.CpnyId, dbo.RptCompany.CpnyName
FROM          dbo.PJvProjectManager RIGHT OUTER JOIN
                      dbo.PJPROJ ON dbo.PJvProjectManager.project = dbo.PJPROJ.project INNER JOIN 
                      dbo.rptcompany ON dbo.PJPROJ.CpnyId = dbo.RptCompany.CpnyID LEFT OUTER JOIN 
                      dbo.Customer ON dbo.PJPROJ.customer = dbo.Customer.CustId RIGHT OUTER JOIN
                      dbo.PJINVDET ON dbo.PJPROJ.project = dbo.PJINVDET.project INNER JOIN
					  dbo.PJJOBSUMMARYWrk ON dbo.PJINVDET.project = dbo.PJJOBSUMMARYWrk.project and
						dbo.PJINVDET.pjt_entity = dbo.PJJOBSUMMARYWrk.pjt_entity LEFT OUTER JOIN
                      dbo.PJEMPLOY ON dbo.PJINVDET.employee = dbo.PJEMPLOY.employee LEFT OUTER JOIN
                      dbo.PJREPCOL ON dbo.PJINVDET.acct = dbo.PJREPCOL.acct LEFT OUTER JOIN
                      dbo.PJCODE ON dbo.PJINVDET.labor_class_cd = dbo.PJCODE.code_value LEFT OUTER JOIN
                      dbo.PJACCT ON dbo.PJINVDET.acct = dbo.PJACCT.acct
where (pjcode.code_type = 'LABC' and pjcode.code_value <> '') or (pjcode.code_value is null)
