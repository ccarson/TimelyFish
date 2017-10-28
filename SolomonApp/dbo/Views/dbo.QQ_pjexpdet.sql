
CREATE VIEW [QQ_pjexpdet]
AS
SELECT     H.employee AS resource, CASE WHEN CHARINDEX('~', E.EMP_NAME) > 0 THEN CONVERT(CHAR(60), 
                      LTRIM(SUBSTRING(E.EMP_NAME, 1, CHARINDEX('~', E.EMP_NAME) - 1)) 
                      + ', ' + LTRIM(RTRIM(SUBSTRING(E.EMP_NAME, CHARINDEX('~', E.EMP_NAME) + 1, 60)))) 
                      ELSE E.EMP_NAME END AS [resource name], E.manager1 AS supervisor, H.approver, 
                      H.docnbr AS [report document#], convert(date,H.report_date) AS [report date], H.status_1 AS [report status], 
                      H.status_2 AS [report type], H.advance_amt AS [advance or repay amount], 
                      D.desc_detail AS [detailed description], convert(date,D.exp_date) AS [date of expense], D.exp_type AS [expense type], 
                      T.desc_exp AS [expense type description], D.project, P.project_desc AS [project descritpion], 
                      P.manager1 AS [project manager], D.pjt_entity AS task, H.CpnyId_home AS [home company], 
                      D.CpnyId_chrg AS [charged company], D.gl_acct AS [G/L account], D.gl_subacct AS subaccount, 
                      D.vendor_num AS [vendor to be paid], D.units, D.amt_employ AS [amount paid by employee], 
                      D.amt_company AS [amount paid by company], D.CuryId AS [currency id], 
                      D.CuryTranamt AS [currency amount], D.CuryRate AS [currency rate], D.tax_flag AS [tax flag], 
                      D.tax_amount AS [tax amount], D.taxid AS [tax id], D.taxcatid AS [tax category], 
                      D.taxitembasis AS [tax item basis], D.payment_cd AS [payment code], D.status AS [non-billable flag], 
                      D.td_id14 AS [mgr review flag], D.td_id03 AS [recon ref], D.td_id01, D.td_id02, 
                      D.td_id04, D.td_id05, D.td_id06, D.td_id07, convert(date,D.td_id08) AS [td_id08], convert(date,D.td_id09) AS [td_id09], 
                      D.td_id10, D.td_id11, D.td_id12, D.td_id13, D.td_id15, D.user1, 
                      D.user2, D.user3, D.user4, convert(date,D.crtd_datetime) AS [create date], 
                      D.crtd_prog AS [create program], D.crtd_user AS [create user], convert(date,D.lupd_datetime) AS [last update date], 
                      D.lupd_prog AS [last update program], D.lupd_user AS [last update user]
FROM         PJEXPTYP T WITH (nolock) RIGHT OUTER JOIN
                      PJEXPDET D WITH (nolock) ON T.exp_type = D.exp_type LEFT OUTER JOIN
                      PJPROJ P WITH (nolock)  ON D.project = P.project RIGHT OUTER JOIN
                      PJEXPHDR H WITH (nolock) LEFT OUTER JOIN
                      PJEMPLOY E WITH (nolock) ON H.employee = E.employee ON D.docnbr = H.docnbr

