CREATE VIEW [dbo].[QQTransactionDetail]
AS
SELECT        RTRIM(dbo.PJTran.acct) AS AccountCategory, dbo.PJTran.alloc_flag AS AllocFlag, dbo.PJTran.amount AS BaseAmount, dbo.PJTran.batch_id AS BatchID, 
                         dbo.PJTran.batch_type AS BatchType, dbo.PJTran.CpnyId AS Company, dbo.PJTran.CuryId AS BillCurry, dbo.PJTran.CuryTranamt AS Amount, 
                         dbo.PJTran.ProjCury_amount as ProjCury_Amount, dbo.PJTran.employee AS EmployeeID, dbo.PJTran.fiscalno AS Period, dbo.PJTran.gl_acct AS GLAccount, dbo.PJTran.gl_subacct AS GLSubaccount, 
                         RTRIM(dbo.PJTran.pjt_entity) AS Task, dbo.PJTran.project, dbo.PJTran.system_cd AS SystemModule, dbo.PJTran.trans_date AS TransDate, 
                         RTRIM(dbo.PJTran.tr_comment) AS Comment, RTRIM(SUBSTRING
                             ((SELECT        control_data
                                 FROM            dbo.PJCONTRL
                                 WHERE        (control_type = 'ID') AND (control_code = 'TR01')), 2, 16)) AS ID1Caption, dbo.PJTran.tr_id01 AS ID1Value, RTRIM(SUBSTRING
                             ((SELECT        control_data
                                 FROM            dbo.PJCONTRL AS PJCONTRL_1
                                 WHERE        (control_type = 'ID') AND (control_code = 'TR02')), 2, 16)) AS ID2Caption, dbo.PJTran.tr_id02 AS ID2Value, RTRIM(SUBSTRING
                             ((SELECT        control_data
                                 FROM            dbo.PJCONTRL AS PJCONTRL_4
                                 WHERE        (control_type = 'ID') AND (control_code = 'TR03')), 2, 16)) AS ID3Caption, dbo.PJTran.tr_id03 AS ID3Value, RTRIM(SUBSTRING
                             ((SELECT        control_data
                                 FROM            dbo.PJCONTRL AS PJCONTRL_3
                                 WHERE        (control_type = 'ID') AND (control_code = 'TR04')), 2, 16)) AS ID4Caption, dbo.PJTran.tr_id04 AS ID4Value, RTRIM(SUBSTRING
                             ((SELECT        control_data
                                 FROM            dbo.PJCONTRL AS PJCONTRL_2
                                 WHERE        (control_type = 'ID') AND (control_code = 'TR08')), 2, 16)) AS ID8Caption, dbo.PJTran.tr_id05 AS LaborClass, dbo.PJTran.tr_id08 AS ID8Value, 
                         dbo.PJTran.tr_status AS Status, dbo.PJTran.units, dbo.PJTran.voucher_line AS SourceLineNum, dbo.PJTran.voucher_num AS SourceRefNum, 
                         dbo.NameFlip(dbo.PJEMPLOY.emp_name) AS Employee, dbo.Vendor.Name AS VendorName, dbo.PJTRANEX.equip_id AS EquipmentID, 
                         dbo.PJTRANEX.invtid AS InventoryID, dbo.PJTRANEX.siteid, dbo.PJTRANEX.whseloc AS Warehouse, PJACCT.id5_sw as TransClass
FROM            dbo.PJTran LEFT OUTER JOIN
                         dbo.PJEMPLOY ON dbo.PJTran.employee = dbo.PJEMPLOY.employee LEFT OUTER JOIN
                         dbo.Vendor ON dbo.PJTran.vendor_num = dbo.Vendor.VendId LEFT OUTER JOIN
                         dbo.PJACCT ON dbo.PJTran.acct = dbo.PJACCT.acct INNER JOIN
                         dbo.PJTRANEX LEFT OUTER JOIN
                         dbo.Inventory ON dbo.PJTRANEX.invtid = dbo.Inventory.InvtID ON dbo.PJTran.fiscalno = dbo.PJTRANEX.fiscalno AND 
                         dbo.PJTran.system_cd = dbo.PJTRANEX.system_cd AND dbo.PJTran.batch_id = dbo.PJTRANEX.batch_id AND 
                         dbo.PJTran.detail_num = dbo.PJTRANEX.detail_num
