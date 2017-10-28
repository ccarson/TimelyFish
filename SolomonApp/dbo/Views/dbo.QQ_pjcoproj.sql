
CREATE VIEW [QQ_pjcoproj]
AS
SELECT     CP.project, P.project_desc AS [project description], CP.change_order_num AS [change order number], 
                      CP.co_desc AS [change order description], CP.reqd_reason AS [reason for change], 
                      CP.status1 AS [change order status], P.customer, CASE WHEN CHARINDEX('~', C.NAME) 
                      > 0 THEN CONVERT(CHAR(30), LTRIM(SUBSTRING(C.NAME, 1, CHARINDEX('~', C.NAME) - 1)) 
                      + ', ' + LTRIM(RTRIM(SUBSTRING(C.NAME, CHARINDEX('~', C.NAME) + 1, 30)))) ELSE C.NAME END AS [customer name], 
                      P.CpnyId AS company, P.gl_subacct AS [G/L subaccount], P.manager1 AS [project manager], 
                      P.manager2 AS [business manager], P.slsperid AS [sales person], P.status_pa AS [project status], 
                      CP.co_type AS [Billable ([B]])], CP.reqd_by AS [requested by], CP.owner_co AS [owner change order num], 
                      CP.owner_ref AS [owner reference], CP.arch_pjt AS [architect's project number], 
                      convert(date,CP.date_co) AS [changer order date], convert(date,CP.date_auth) AS [approval date], 
                      CP.impact_days_reqd AS [impact days requested], CP.impact_days_apprv AS [impact days approved], 
                      CP.amt_pending AS [pending amount], CP.amt_revenue AS [revenue budget], CP.amt_funded AS [funded amount], 
                      CP.amt_original AS [original amount], CP.amt_quote AS [quote amount], CP.probability, 
                      CP.co_id14 AS [Billling Item Number], CP.co_cat_cd AS [change order category], 
                      CP.co_approval_cd AS [review type], CP.fund_source AS [fund source], CP.auth_by AS [authorized by], 
                      CP.apprv_arch_for AS [approving architect], CP.apprv_arch_by AS [architect approval by], 
                      convert(date,CP.apprv_arch_date) AS [architect approval date], CP.apprv_cont_for AS [approving contractor], 
                      CP.apprv_cont_by AS [contractor approval by], convert(date,CP.apprv_cont_date) AS [contractor approval date], 
                      CP.apprv_othr_for AS [approving other company], CP.apprv_othr_by AS [other approval by], 
                      convert(date,CP.apprv_othr_date) AS [other approval date], CP.apprv_ownr_for AS [approving owner], 
                      CP.apprv_ownr_by AS [owner approval by], convert(date,CP.apprv_ownr_date) AS [ownerapproval date], CP.co_id01, 
                      CP.co_id02, CP.co_id03, CP.co_id04, CP.co_id05, CP.co_id06, CP.co_id07, 
                      convert(date,CP.co_id08) AS [co_id08], convert(date,CP.co_id09) AS [co_id09], CP.co_id10, CP.co_id11, CP.co_id12, CP.co_id13, 
                      CP.co_id15, CP.co_id16, CP.co_id17, convert(date,CP.co_id18) AS [co_id18], convert(date,CP.co_id19) AS [co_id19], CP.co_id20, 
                      CP.user1, CP.user2, CP.user3, CP.user4, CP.user5, CP.user6, 
                      CP.user7, CP.user8, convert(date,CP.crtd_datetime) AS [create date], CP.crtd_prog AS [create program], 
                      CP.crtd_user AS [create user], convert(date,CP.lupd_datetime) AS [last update date], CP.lupd_prog AS [last update program], 
                      CP.lupd_user AS [last update user]
FROM         PJCOPROJ CP WITH (nolock) INNER JOIN
                      PJPROJ P WITH (nolock) ON CP.project = P.project LEFT OUTER JOIN
                      Customer C WITH (nolock) ON P.customer = C.CustId

