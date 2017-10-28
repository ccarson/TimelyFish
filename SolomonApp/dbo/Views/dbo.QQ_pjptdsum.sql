
CREATE VIEW [QQ_pjptdsum]
AS
SELECT     S.project, P.project_desc AS [project description], S.pjt_entity AS task, 
                      P.customer, CASE WHEN CHARINDEX('~', NAME) > 0 THEN CONVERT(CHAR(30), LTRIM(SUBSTRING(NAME, 1, CHARINDEX('~', NAME) - 1)) 
                      + ', ' + LTRIM(RTRIM(SUBSTRING(NAME, CHARINDEX('~', NAME) + 1, 30)))) ELSE NAME END AS [customer name], P.CpnyId AS company, 
                      P.manager1 AS [project manager], P.manager2 AS [business manager], P.slsperid AS salesperson, 
                      S.acct AS [account category], PJACCT.acct_type AS [account type], S.act_units AS [PTD units], 
                      S.act_amount AS [PTD amount], S.com_units AS [commitment units], 
                      S.com_amount AS [commitment amount], S.total_budget_units AS [original budget units], 
                      S.total_budget_amount AS [original budget amount], S.eac_units AS [EAC units], 
                      S.eac_amount AS [EAC amount], S.fac_units AS [FAC units], S.fac_amount AS [FAC amount], 
                      P.status_pa AS [project status], PJACCT.sort_num, S.user1, S.user2, S.user3, 
                      S.user4, convert(date,S.crtd_datetime) AS [create date], S.crtd_prog AS [create program], 
                      S.crtd_user AS [create user], convert(date,S.lupd_datetime) AS [last update date], S.lupd_prog AS [last update program], 
                      S.lupd_user AS [last update user]
FROM         PJPTDSUM S WITH (nolock) RIGHT OUTER JOIN
                      PJPROJ P WITH (nolock) ON S.project = P.project RIGHT OUTER JOIN
                      Customer WITH (nolock) ON P.customer = Customer.CustId LEFT OUTER JOIN
                      PJACCT WITH (nolock) ON S.acct = PJACCT.acct

