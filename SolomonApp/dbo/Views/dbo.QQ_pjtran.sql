
CREATE VIEW [QQ_pjtran]
AS
SELECT     T.project, P.project_desc AS [project description], P.customer, T.pjt_entity AS task, 
                      T.SubTask_Name AS subtask, T.CpnyId AS company, T.acct AS [account category], 
                      convert(date,T.trans_date) AS [transaction date], T.amount, T.units, T.BaseCuryId AS [base currency ID], 
                      T.CuryId AS [currency ID], T.CuryTranamt AS [currency amount], T.employee AS resource, CASE WHEN CHARINDEX('~', 
                      PJEMPLOY.EMP_NAME) > 0 THEN CONVERT(CHAR(60), LTRIM(SUBSTRING(PJEMPLOY.EMP_NAME, 1, CHARINDEX('~', PJEMPLOY.EMP_NAME) - 1)) 
                      + ', ' + LTRIM(RTRIM(SUBSTRING(PJEMPLOY.EMP_NAME, CHARINDEX('~', PJEMPLOY.EMP_NAME) + 1, 60)))) 
                      ELSE PJEMPLOY.EMP_NAME END AS [resource name], P.manager1 AS [project manager], CASE WHEN CHARINDEX('~', 
                      PJEMPLOY_1.EMP_NAME) > 0 THEN CONVERT(CHAR(60), LTRIM(SUBSTRING(PJEMPLOY_1.EMP_NAME, 1, CHARINDEX('~', 
                      PJEMPLOY_1.EMP_NAME) - 1)) + ', ' + LTRIM(RTRIM(SUBSTRING(PJEMPLOY_1.EMP_NAME, CHARINDEX('~', PJEMPLOY_1.EMP_NAME) + 1, 60)))) 
                      ELSE PJEMPLOY_1.EMP_NAME END AS [project mgr name], T.tr_status AS [transaction status], 
                      T.tr_comment AS [transaction comment], T.gl_acct AS [G/L account], T.gl_subacct AS subaccount, 
                      T.tr_id05 AS [labor class], T.fiscalno AS [fiscal period], T.system_cd AS [system code], T.batch_id AS [batch ID], 
                      T.batch_type AS [batch type], T.bill_batch_id AS [doc num from T&E], T.vendor_num AS [vendor number], 
                      T.voucher_num AS [refnbr from source trans], T.alloc_flag AS [allocation flag], T.voucher_line AS [line from source trans],
                       T.tr_id02 AS [invoice number], T.tr_id03 AS [po number], X.invtid AS [inventory ID], 
                      T.detail_num AS [detail number], T.subcontract, T.unit_of_measure AS [unit of measure], 
                      X.equip_id AS [equipment ID], X.lotsernbr AS [lot serial number], X.ordnbr AS [sales order num], 
                      X.orderlineref AS [sales order line], X.shipperid AS [shipper ID], X.shipperlineref AS [shipper line], 
                      X.siteid AS [site ID], X.whseloc AS [warehouse location], T.user1, T.user2, T.user3, 
                      T.user4, T.tr_id01, T.tr_id04 AS [source batch num], T.tr_id06, T.tr_id07, 
                      convert(date,T.tr_id08) AS [invoice date], convert(date,T.tr_id09) AS [tr_id09], T.tr_id10, T.tr_id23, T.tr_id24 AS [hrs type+shift+earn type], 
                      T.tr_id25, T.tr_id26 AS [utilization period], T.tr_id27, T.tr_id28 AS [oiginal cost of allocated trans], 
                      convert(date,T.tr_id29) AS [tr_id29], T.tr_id30 AS [pjinvdet trans id], T.tr_id31, T.tr_id32, 
                      X.tr_id12 AS [key of originating trans], X.tr_id13, X.tr_id14, X.tr_id15 AS [WO info], 
                      X.tr_id16 AS [payroll work loc], X.tr_id17, X.tr_id18, X.tr_id19, 
                      X.tr_id20 AS [offset cpny, acct, sub], X.tr_id21, convert(date,X.tr_id22) AS [timecard period end], 
                      convert(date,T.crtd_datetime) AS [create date], T.crtd_prog AS [create program], T.crtd_user AS [create user], 
                      convert(date,T.lupd_datetime) AS [last update date], T.lupd_prog AS [last update program], T.lupd_user AS [last update user]
FROM         PJTran T WITH (nolock) INNER JOIN
                      PJTranEX X WITH (nolock) ON T.batch_id = X.batch_id AND T.fiscalno = X.fiscalno AND T.system_cd = X.system_cd AND T.detail_num = X.detail_num INNER JOIN
                      PJPROJ P WITH (nolock) ON T.project = P.project LEFT OUTER JOIN
                      PJEMPLOY WITH (nolock) ON T.employee = PJEMPLOY.employee LEFT OUTER JOIN
                      PJEMPLOY AS PJEMPLOY_1 WITH (nolock) ON P.manager1 = PJEMPLOY_1.employee

