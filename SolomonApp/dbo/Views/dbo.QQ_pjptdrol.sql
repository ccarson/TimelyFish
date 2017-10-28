
CREATE VIEW [QQ_pjptdrol]
AS
SELECT     R.project, P.project_desc AS [project description], P.customer, CASE WHEN CHARINDEX('~', 
                      NAME) > 0 THEN CONVERT(CHAR(30), LTRIM(SUBSTRING(NAME, 1, CHARINDEX('~', NAME) - 1)) + ', ' + LTRIM(RTRIM(SUBSTRING(NAME, 
                      CHARINDEX('~', NAME) + 1, 30)))) ELSE NAME END AS [customer name], P.CpnyId AS company, P.manager1 AS [project manager],
                       P.manager2 AS [business manager], P.slsperid AS salesperson, R.acct AS [account category], 
                      PJACCT.acct_type AS [account type], R.act_units AS [PTD units], R.act_amount AS [PTD amount], 
                      R.com_units AS [commitment units], R.com_amount AS [commitment amount], 
                      R.total_budget_units AS [original budget units], R.total_budget_amount AS [original budget amount], 
                      R.eac_units AS [EAC units], R.eac_amount AS [EAC amount], R.fac_units AS [FAC units], 
                      R.fac_amount AS [FAC amount], P.status_pa AS [project status], PJACCT.sort_num, R.user1, 
                      R.user2, R.user3, R.user4, convert(date,R.crtd_datetime) AS [create date], 
                      R.crtd_prog AS [create program], R.crtd_user AS [create user], convert(date,R.lupd_datetime) AS [last update date], 
                      R.lupd_prog AS [last update program], R.lupd_user AS [last update user]
FROM         PJPTDROL R WITH (nolock) RIGHT OUTER JOIN
                      PJPROJ P WITH (nolock) ON R.project = P.project LEFT OUTER JOIN
                      Customer WITH (nolock) ON P.customer = Customer.CustId RIGHT OUTER JOIN
                      PJACCT WITH (nolock) ON R.acct = PJACCT.acct

