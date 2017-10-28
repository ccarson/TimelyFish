
CREATE VIEW [QQ_pjinvdet]
AS
SELECT     D.draft_num AS [draft number], H.invoice_num AS [invoice number], D.project, 
                      P.project_desc AS [project description], D.pjt_entity AS task, D.SubTask_Name AS subtask, 
                      H.project_billwith AS [master bill project], D.acct AS [account category], D.acct_rev AS [acct cat for revenue], 
                      D.li_type AS [line type], D.employee AS resource, CASE WHEN CHARINDEX('~', E.EMP_NAME) 
                      > 0 THEN CONVERT(CHAR(60), LTRIM(SUBSTRING(E.EMP_NAME, 1, CHARINDEX('~', E.EMP_NAME) - 1)) 
                      + ', ' + LTRIM(RTRIM(SUBSTRING(E.EMP_NAME, CHARINDEX('~', E.EMP_NAME) + 1, 60)))) 
                      ELSE E.EMP_NAME END AS [resource name], D.comment AS [line description], D.amount, D.units, 
                      D.CuryId AS [currency ID], D.CuryRate AS [currency rate], D.CuryTranamt AS [currency amount], 
                      D.bill_status AS [line bill status], D.fiscalno AS [fiscal period], convert(date,H.invoice_date) AS [invoice date], 
                      H.inv_status AS [invoice status], H.invoice_type AS [invoice type], convert(date,D.source_trx_date) AS [source trans date], 
                      P.customer, D.CpnyId AS company, P.manager1 AS [project manager], H.approver_id AS approver, 
                      H.slsperid AS saleperson, D.ShipperID AS [shipper ID], D.ShipperLineRef AS [shipper line], 
                      D.adj_amount AS [adjust amount], D.adj_units AS [adjust units], D.hold_amount AS [hold amount], 
                      D.hold_units AS [hold units], D.orig_rate AS [original rate], D.orig_units AS [original units], 
                      D.orig_amount AS [original amount], D.cost_amt AS [cost before markup], 
                      D.CuryOrig_amount AS [currency original amt], D.CuryHold_amount AS [currency hold amt], 
                      D.CuryAdj_amount AS [currency adjust amt], D.gl_acct AS [G/L account], D.gl_subacct AS [G/L subaccount], 
                      D.gl_offset_cpnyid AS [G/L offset company], D.gl_offset_acct AS [G/L offset account], 
                      D.gl_offset_subacct AS [G/L offset subacct], D.hold_status AS [hold status], D.labor_class_cd AS [labor class], 
                      D.rate_type_cd AS [rate type code], D.subcontract, D.taxId AS [tax id], D.in_id16 AS [tax id 2], 
                      D.in_id17 AS [tax id 3], D.taxcatid AS [tax category], D.taxitembasis AS [tax item basis], 
                      D.TranClass AS [trans class], D.unit_of_measure AS [unit of measure], D.vendor_num AS vendor, 
                      D.in_id01, D.in_id02, D.in_id03, D.in_id04, D.in_id05, D.in_id06, 
                      D.in_id07, convert(date,D.in_id08) AS [in_id08], convert(date,D.in_id09) AS [in_id09], D.in_id10, D.in_id11 AS [A/P batch and voucher], 
                      D.in_id12 AS [key of source tran], D.in_id13, D.in_id14, D.in_id15 AS [split bill customer], 
                      D.in_id18, D.in_id19, convert(date,D.in_id20) AS [in_id20], D.source_trx_id AS [record primary key], 
                      H.ih_id11 AS [AIA application num], D.user1, D.user2, D.user3, D.user4, 
                      convert(date,D.crtd_datetime) AS [create date], D.crtd_prog AS [create program], D.crtd_user AS [create user], 
                      convert(date,D.lupd_datetime) AS [last update date], D.lupd_prog AS [last update program], 
                      D.lupd_user AS [last update user]
FROM         PJInvDet D WITH (nolock) LEFT OUTER JOIN
                      PJINVHDR H WITH (nolock) ON D.draft_num = H.draft_num LEFT OUTER JOIN
                      PJPROJ P WITH (nolock) ON D.project = P.project LEFT OUTER JOIN
                      PJEMPLOY E WITH (nolock) ON D.employee = E.employee

