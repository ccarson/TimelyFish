
CREATE VIEW [QQ_pjsubdet]
AS
SELECT     D.project, P.project_desc AS [project description], D.subcontract, 
                      C.subcontract_desc AS [subcontract description], C.vendid AS vendor, CASE WHEN CHARINDEX('~', 
                      V.VEND_NAME) > 0 THEN CONVERT(CHAR(30), LTRIM(SUBSTRING(V.VEND_NAME, 1, CHARINDEX('~', V.VEND_NAME) - 1)) 
                      + ', ' + LTRIM(RTRIM(SUBSTRING(V.VEND_NAME, CHARINDEX('~', V.VEND_NAME) + 1, 30)))) 
                      ELSE V.VEND_NAME END AS [vendor name], D.sub_line_item AS [line item number], D.pjt_entity AS task, 
                      D.line_desc AS [line item description], D.revised_amt AS amount, D.revised_units AS units, 
                      D.cpnyId AS company, D.acct AS [account category], D.gl_acct AS [G/L account], 
                      D.gl_subacct AS [G/L subaccount], D.labor_class_cd AS [labor class], D.original_amt AS [original amount], 
                      D.original_units AS [original units], D.co_pend_amt AS [change order pending amt], 
                      D.co_pend_units AS [change order pending units], D.vouch_amt AS [vouchered amount], 
                      D.vouch_units AS [vouchered units], D.unit_of_measure AS [unit of measure], 
                      C.sub_type_cd AS [subcontract type], C.status_sub AS [subcontract status], C.status_pay AS [pay status], 
                      C.termsid AS terms, C.specialty_cd AS [specialty code], P.customer AS [customer/owner], 
                      convert(date,C.date_start_org) AS [original start date], convert(date,C.date_start_act) AS [actual start date], 
                      convert(date,C.date_end_org) AS [original end date], convert(date,C.date_end_rev) AS [revised end date], 
                      C.extension_days AS [extension days], convert(date,C.date_start_ant) AS [anticipated start date], 
                      convert(date,C.date_comp_ant) AS [anticipated completion date], convert(date,C.date_comp_act) AS [actual completion date], 
                      convert(date,C.date_cont_exe) AS [contract execution date], convert(date,C.date_start_auth) AS [authorized start date], 
                      C.last_payreqnbr AS [last payment request number], C.last_change_order AS [last change order number], 
                      C.status_reason AS [status reason], D.retention_method AS [retention method], 
                      D.retention_percent AS [retention percent], D.status1 AS [payment cap flag], D.sd_id01, 
                      D.sd_id02, D.sd_id03, D.sd_id04, D.sd_id05, D.sd_id06, D.sd_id07, 
                      convert(date,D.sd_id08) AS [sd_id08], convert(date,D.sd_id09) AS [sd_id09], D.sd_id10, D.sd_id11, D.sd_id12, D.sd_id13, 
                      D.sd_id14, D.sd_id15, D.sd_id16, D.sd_id17, convert(date,D.sd_id18) AS [sd_id18], convert(date,D.sd_id19) AS [sd_id19], 
                      D.sd_id20, D.user1, D.user2, D.user3, D.user4, D.user5, 
                      D.user6, D.user7, D.user8, convert(date,D.crtd_datetime) AS [create date], 
                      D.crtd_prog AS [create program], D.crtd_user AS [create user], convert(date,D.lupd_datetime) AS [last update date], 
                      D.lupd_prog AS [last update program], D.lupd_user AS [last update user]
FROM         PJSUBDET D WITH (nolock) INNER JOIN
                      PJSUBCON C WITH (nolock) ON D.project = C.project AND D.subcontract = C.subcontract INNER JOIN
                      PJPROJ P WITH (nolock) ON D.project = P.project INNER JOIN
                      PJSUBVEN V WITH (nolock) ON C.vendid = V.vendid

