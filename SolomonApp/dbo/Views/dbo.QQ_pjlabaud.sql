
CREATE VIEW [QQ_pjlabaud]
AS
SELECT     H.employee AS resource, CASE WHEN CHARINDEX('~', E.EMP_NAME) > 0 THEN CONVERT(CHAR(60), 
                      LTRIM(SUBSTRING(E.EMP_NAME, 1, CHARINDEX('~', E.EMP_NAME) - 1)) 
                      + ', ' + LTRIM(RTRIM(SUBSTRING(E.EMP_NAME, CHARINDEX('~', E.EMP_NAME) + 1, 60)))) 
                      ELSE E.EMP_NAME END AS [resource name], E.manager1 AS supervisor, H.approver, 
                      convert(date,H.pe_date) AS [period ending date], H.le_status AS [timecard status], H.le_type AS [timecard type], 
                      A.docnbr AS [timecard document#], A.linenbr AS [line number], A.ld_desc AS [line description], 
                      A.zaudit_type AS [change type], A.ld_id02 AS [change reason], convert(date,A.ld_id08) AS [post date], 
                      A.project, P.project_desc AS [project description], P.manager1 AS [project manager], 
                      A.pjt_entity AS task, A.SubTask_Name AS subtask, A.labor_class_cd AS [labor class], 
                      A.CpnyId_chrg AS [charged company], A.CpnyId_home AS [home company], A.gl_acct AS [G/L account], 
                      A.gl_subacct AS subaccount, A.total_hrs AS [hour total for line], A.total_amount AS [amount total], 
                      H.period_num AS period, H.week_num AS [week number], A.shift, A.union_cd AS [union code], 
                      A.earn_type_id AS [earn type], A.work_comp_cd AS [worker comp code], A.work_type AS [work type], 
                      A.labor_stdcost AS [labor std cost], A.ld_id01 AS [home subaccount], A.ld_id03 AS [prev wage group], 
                      A.ld_id04, A.ld_id05 AS [site ID], A.ld_id06 AS rate, A.ld_id07 AS [flat amount], 
                      convert(date,A.ld_id09) AS [ld_id09], A.ld_id10 AS [cert payroll], A.ld_id11, A.ld_id12, A.ld_id13, 
                      A.ld_id14, A.ld_id15 AS [PRP ref], A.ld_id16, A.ld_id17 AS [mgr review flag], 
                      A.ld_id18, A.ld_id19, convert(date,A.ld_id20) AS [ld_id20], A.ld_status AS [billable flag], 
                      A.rate_source AS [rate source], A.day1_hr1 AS [day 1 hours], A.day1_hr2 AS [day 1 overtime 1], 
                      A.day1_hr3 AS [day 1 overtime 2], A.day2_hr1 AS [day 2 hours], A.day2_hr2 AS [day 2 overtime 1], 
                      A.day2_hr3 AS [day 2 overtime 2], A.day3_hr1 AS [day 3 hours], A.day3_hr2 AS [day 3 overtime 1], 
                      A.day3_hr3 AS [day 3 overtime 2], A.day4_hr1 AS [day 4 hours], A.day4_hr2 AS [day 4 overtime 1], 
                      A.day4_hr3 AS [day 4 overtime 2], A.day5_hr1 AS [day 5 hours], A.day5_hr2 AS [day 5 overtime 1], 
                      A.day5_hr3 AS [day 5 overtime 2], A.day6_hr1 AS [day 6 hours], A.day6_hr2 AS [day 6 overtime 1], 
                      A.day6_hr3 AS [day 6 overtime 2], A.day7_hr1 AS [day 7 hours], A.day7_hr2 AS [day 7 overtime 1], 
                      A.day7_hr3 AS [day 7 overtime 2], A.user1, A.user2, A.user3, A.user4, 
                      convert(date,A.crtd_datetime) AS [create date], A.crtd_prog AS [create program], A.crtd_user AS [create user], 
                      convert(date,A.lupd_datetime) AS [last update date], A.lupd_prog AS [last update program], 
                      A.lupd_user AS [last update user]
FROM         PJLABAUD A WITH (nolock) LEFT OUTER JOIN
                      PJLABHDR H WITH (nolock) ON A.docnbr = H.docnbr LEFT OUTER JOIN
                      PJEMPLOY E WITH (nolock) ON H.employee = E.employee LEFT OUTER JOIN
                      PJPROJ P WITH (nolock) ON A.project = P.project

