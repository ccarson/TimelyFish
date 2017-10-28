
CREATE VIEW [QQ_pjexpaud]
AS
SELECT     H.employee AS resource, CASE WHEN CHARINDEX('~', E.EMP_NAME) > 0 THEN CONVERT(CHAR(60), 
                      LTRIM(SUBSTRING(E.EMP_NAME, 1, CHARINDEX('~', E.EMP_NAME) - 1)) 
                      + ', ' + LTRIM(RTRIM(SUBSTRING(E.EMP_NAME, CHARINDEX('~', E.EMP_NAME) + 1, 60)))) 
                      ELSE E.EMP_NAME END AS [resource name], A.docnbr, E.manager1 AS supervisor, H.approver, 
                      convert(date,H.report_date) AS [report date], H.status_1 AS [report status], H.status_2 AS [report type], 
                      H.advance_amt AS [advance or repay amount], A.desc_detail AS [detailed description], 
                      convert(date,A.exp_date) AS [date of expense], A.exp_type AS [expense type], T.desc_exp AS [expense type description], 
                      A.linenbr, A.zaudit_type, A.td_id02 AS [change reason], A.project, 
                      P.project_desc AS [project descritpion], P.manager1 AS [project manager], A.pjt_entity AS task, 
                      H.CpnyId_home AS [home company], A.CpnyId_chrg AS [charged company], A.gl_acct AS [G/L account], 
                      A.gl_subacct AS subaccount, A.vendor_num AS [vendor to be paid], A.units, 
                      A.amt_employ AS [amount paid by employee], A.amt_company AS [amount paid by company], 
                      A.CuryId AS [currency id], A.CuryTranamt AS [currency amount], A.CuryRate AS [currency rate], 
                      A.payment_cd AS [payment code], A.status AS [non-billable flag], A.td_id14 AS [mgr review flag], 
                      A.td_id03 AS [recon ref], A.td_id01, A.td_id04, A.td_id05, A.td_id06, 
                      A.td_id07, convert(date,A.td_id08) AS [td_id08], convert(date,A.td_id09) AS [td_id09], A.td_id10, A.td_id11, A.td_id12, 
                      A.td_id13, A.td_id15, A.user1, A.user2, A.user3, A.user4, 
                      convert(date,A.crtd_datetime) AS [create date], A.crtd_prog AS [create program], A.crtd_user AS [create user], 
                      convert(date,A.lupd_datetime) AS [last update date], A.lupd_prog AS [last update program], 
                      A.lupd_user AS [last update user]
FROM         PJEXPTYP T WITH (nolock) RIGHT OUTER JOIN
                      PJEXPAUD A WITH (nolock) ON T.exp_type = A.exp_type LEFT OUTER JOIN
                      PJPROJ P WITH (nolock) ON A.project = P.project LEFT OUTER JOIN
                      PJEXPHDR H WITH (nolock) LEFT OUTER JOIN
                      PJEMPLOY E WITH (nolock) ON H.employee = E.employee ON A.docnbr = H.docnbr

