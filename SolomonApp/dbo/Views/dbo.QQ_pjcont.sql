
CREATE VIEW [QQ_pjcont]
AS
SELECT     C.contract, C.contract_desc AS [contract description], P.project, P.project_desc AS [project description], 
                      P.CpnyId AS company, P.gl_subacct AS [G/L subaccount], P.manager1 AS [project manager], 
                      CASE WHEN CHARINDEX('~', E.EMP_NAME) > 0 THEN CONVERT(CHAR(30), LTRIM(SUBSTRING(E.EMP_NAME, 1, CHARINDEX('~', 
                      E.EMP_NAME) - 1)) + ', ' + LTRIM(RTRIM(SUBSTRING(E.EMP_NAME, CHARINDEX('~', E.EMP_NAME) + 1, 30)))) 
                      ELSE E.EMP_NAME END AS [project manager name], P.manager2 AS [business manager], P.slsperid AS [sales person],
                       P.status_pa AS [project status], C.manager_cont AS [contract manager], CASE WHEN CHARINDEX('~', E1.EMP_NAME) 
                      > 0 THEN CONVERT(CHAR(30), LTRIM(SUBSTRING(E1.EMP_NAME, 1, CHARINDEX('~', E1.EMP_NAME) - 1)) 
                      + ', ' + LTRIM(RTRIM(SUBSTRING(E1.EMP_NAME, CHARINDEX('~', E1.EMP_NAME) + 1, 30)))) 
                      ELSE E1.EMP_NAME END AS [contract manager name], C.customer, CASE WHEN CHARINDEX('~', CU.NAME) 
                      > 0 THEN CONVERT(CHAR(30), LTRIM(SUBSTRING(CU.NAME, 1, CHARINDEX('~', CU.NAME) - 1)) 
                      + ', ' + LTRIM(RTRIM(SUBSTRING(CU.NAME, CHARINDEX('~', CU.NAME) + 1, 30)))) ELSE CU.NAME END AS [customer name], 
                      C.manager_acct AS [contract accountant], C.status1 AS [contract status], C.prime_type_cd AS [contract type], 
                      C.termsid AS terms, C.cust_ref AS [customer reference], convert(date,C.date_cont_exe) AS [contract execution date], 
                      convert(date,C.date_start_act) AS [actual start date], convert(date,C.date_comp_act) AS [actual completion date], 
                      convert(date,C.date_start_ant) AS [anticiapted start date], convert(date,C.date_comp_ant) AS [anticipated completion date], 
                      convert(date,C.date_start_auth) AS [authorized start date], convert(date,C.date_start_org) AS [original start date], 
                      convert(date,C.date_end_org) AS [original end date], convert(date,C.date_end_rev) AS [revised end date], C.extension_days AS [days extended], 
                      C.change_flag AS [change notice req], C.change_days AS [chg notice # of days], C.cn_id01, C.cn_id02, 
                      C.cn_id03, C.cn_id04, C.cn_id05, C.cn_id06, C.cn_id07, convert(date,C.cn_id08) AS [cn_id08], 
                      convert(date,C.cn_id09) AS [cn_id09], C.cn_id10, C.cn_id11, C.cn_id12, C.cn_id13, C.cn_id14, 
                      C.cn_id15, C.cn_id16, C.cn_id17, convert(date,C.cn_id18) AS [cn_id18], convert(date,C.cn_id19) AS [cn_id19], C.cn_id20, 
                      C.user1, C.user2, C.user3, C.user4, C.user5, C.user6, C.user7, 
                      C.user8, convert(date,C.crtd_datetime) AS [create date], C.crtd_prog AS [create program], C.crtd_user AS [create user], 
                      convert(date,C.lupd_datetime) AS [last update date], C.lupd_prog AS [last update program], C.lupd_user AS [last update user]
FROM         PJEMPLOY E WITH (nolock) INNER JOIN
                      PJPROJ P WITH (nolock) ON E.employee = P.manager1 RIGHT OUTER JOIN
                      PJCONT C WITH (nolock) ON P.contract = C.contract LEFT OUTER JOIN
                      PJEMPLOY E1 WITH (nolock) ON C.manager_cont = E1.employee LEFT OUTER JOIN
                      Customer CU ON C.customer = CU.CustId

