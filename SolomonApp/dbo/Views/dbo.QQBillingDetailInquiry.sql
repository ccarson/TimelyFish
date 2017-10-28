
CREATE VIEW [dbo].[QQBillingDetailInquiry]
AS
SELECT        dbo.PJInvDet.acct AS AccountCategory, dbo.PJInvDet.amount AS BaseAmount, dbo.PJInvDet.bill_status AS Status, RTRIM(dbo.PJInvDet.comment) 
                         AS Comment, dbo.PJInvDet.CpnyId AS CompanyID, dbo.PJInvDet.CuryId AS BillCury, dbo.PJInvDet.CuryTranamt AS Amount, 
                         dbo.PJInvDet.draft_num AS DraftNum, dbo.PJInvDet.employee AS EmployeeID, dbo.PJInvDet.fee_rate AS Rate, dbo.PJInvDet.hold_status AS HoldStatus, 
                         dbo.PJInvDet.labor_class_cd AS LaborClass, 
                         CASE li_type WHEN 'I' THEN 'Item' WHEN 'O' THEN 'Other' WHEN 'R' THEN 'Retention' WHEN 'T' THEN 'Tax' WHEN 'D' THEN 'Deposite' WHEN 'A' THEN 'Apply Deposite'
                          END AS Type, dbo.PJInvDet.pjt_entity AS Task, dbo.PJInvDet.project, dbo.PJInvDet.ShipperID, dbo.PJInvDet.ShipperLineRef, 
                         dbo.PJInvDet.source_trx_date AS TransDate, dbo.PJInvDet.taxId, dbo.PJInvDet.units, dbo.PJInvDet.vendor_num AS VendorNum, 
                         dbo.PJINVHDR.invoice_num AS InvoiceNum, dbo.PJINVHDR.invoice_date AS InvoiceDate, dbo.NameFlip(dbo.PJEMPLOY.emp_name) 
                         AS EmployeeName, PJACCT.id5_sw as TransClass
FROM            dbo.PJInvDet LEFT OUTER JOIN
                         dbo.PJINVHDR ON dbo.PJInvDet.draft_num = dbo.PJINVHDR.draft_num LEFT OUTER JOIN
                         dbo.PJEMPLOY ON dbo.PJInvDet.employee = dbo.PJEMPLOY.employee  LEFT OUTER JOIN
						 dbo.PJACCT ON dbo.PJInvDet.acct = dbo.PJACCT.acct 
