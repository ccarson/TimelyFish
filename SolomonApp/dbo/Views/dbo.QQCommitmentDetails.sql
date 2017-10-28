CREATE VIEW [dbo].[QQCommitmentDetails]
AS
SELECT        PJCOMDET.project AS Project, purchase_order_num AS PONum, batch_type AS Type, CASE WHEN po_date <> '' THEN po_date ELSE NULL END AS PODate, name AS VendorName, 
                         part_number AS InventoryID, descr AS InventoryDescription, Amount, projcury_amount as ProjCury_Amt,Units AS QTY, system_cd AS Module, cd_id04 AS SourceBatch, CpnyId AS Company, 
                         voucher_num AS VoucherNum, CASE WHEN request_date <> '' THEN request_date ELSE NULL END AS RequestDate, CASE WHEN promise_date <> '' THEN promise_date ELSE NULL END AS PromiseDate, 
                         gl_acct AS GLAcct, gl_subacct AS GLSubAcct, rtrim(tr_comment) AS Comment, batch_Id AS PJTBatchID, voucher_line AS SourceLineNum, 
                         sub_line_item AS SubLineItem, dbo.NameFlip(cd_id01) AS Employee, cd_id05 AS LaborClass, cd_id06 AS Rate, CASE WHEN ProjCuryMultiDiv = 'M' THEN cd_id06*ProjCuryRate ELSE cd_id06/ProjCuryRate END AS CuryRate, CASE WHEN cd_id08 <> ''THEN cd_id08 ELSE NULL END 
                         AS DocDate, rtrim(pjt_entity) AS Task, rtrim(acct) AS AccountCategory
FROM            PJCOMDET LEFT OUTER JOIN
                         VENDOR ON PJCOMDET.vendor_num = VENDOR .vendid LEFT OUTER JOIN
                         INVENTORY ON PJCOMDET.part_number = INVENTORY.invtid
