
CREATE VIEW [QQ_pjlabdet]
AS
SELECT     H.employee AS resource, CASE WHEN CHARINDEX('~', E.EMP_NAME) > 0 THEN CONVERT(CHAR(60), 
                      LTRIM(SUBSTRING(E.EMP_NAME, 1, CHARINDEX('~', E.EMP_NAME) - 1)) 
                      + ', ' + LTRIM(RTRIM(SUBSTRING(E.EMP_NAME, CHARINDEX('~', E.EMP_NAME) + 1, 60)))) 
                      ELSE E.EMP_NAME END AS [resource name], E.manager1 AS supervisor, H.Approver AS approver, 
                      convert(date,H.pe_date) AS [period ending date], H.le_status AS [timecard status], H.le_type AS [timecard type], 
                      D.docnbr AS [timecard document#], D.ld_desc AS [line description], convert(date,D.ld_id08) AS [post date], 
                      D.project, P.project_desc AS [project description], P.manager1 AS [project manager], 
                      D.pjt_entity AS task, D.SubTask_Name AS subtask, D.labor_class_cd AS [labor class], 
                      D.CpnyId_chrg AS [charged company], D.CpnyId_home AS [home company], D.gl_acct AS [G/L account], 
                      D.gl_subacct AS subaccount, D.total_hrs AS [hour total for line], D.total_amount AS [amount total], 
                      H.period_num AS period, H.week_num AS [week number], D.shift, D.union_cd AS [union code], 
                      D.earn_type_id AS [earn type], D.work_comp_cd AS [worker comp code], D.work_type AS [work type], 
                      D.labor_stdcost AS [labor std cost], D.ld_id01 AS [home subaccount], D.ld_id03 AS [prev wage group], 
                      D.ld_id04, D.ld_id05 AS [site ID], D.ld_id06 AS rate, D.ld_id07 AS [flat amount], 
                      convert(date,D.ld_id09) AS [ld_id09], D.ld_id10 AS [cert payroll], D.ld_id11, D.ld_id12, D.ld_id13, 
                      D.ld_id14, D.ld_id15 AS [PRP ref], D.ld_id16, D.ld_id17 AS [mgr review flag], 
                      D.ld_id18, D.ld_id19, convert(date,D.ld_id20) AS [ld_id20], D.ld_status AS [billable flag], 
                      D.rate_source AS [rate source], D.day1_hr1 AS [day 1 hours], D.day1_hr2 AS [day 1 overtime 1], 
                      D.day1_hr3 AS [day 1 overtime 2], D.day2_hr1 AS [day 2 hours], D.day2_hr2 AS [day 2 overtime 1], 
                      D.day2_hr3 AS [day 2 overtime 2], D.day3_hr1 AS [day 3 hours], D.day3_hr2 AS [day 3 overtime 1], 
                      D.day3_hr3 AS [day 3 overtime 2], D.day4_hr1 AS [day 4 hours], D.day4_hr2 AS [day 4 overtime 1], 
                      D.day4_hr3 AS [day 4 overtime 2], D.day5_hr1 AS [day 5 hours], D.day5_hr2 AS [day 5 overtime 1], 
                      D.day5_hr3 AS [day 5 overtime 2], D.day6_hr1 AS [day 6 hours], D.day6_hr2 AS [day 6 overtime 1], 
                      D.day6_hr3 AS [day 6 overtime 2], D.day7_hr1 AS [day 7 hours], D.day7_hr2 AS [day 7 overtime 1], 
                      D.day7_hr3 AS [day 7 overtime 2], D.user1, D.user2, D.user3, D.user4, 
                      convert(date,D.crtd_datetime) AS [create date], D.crtd_prog AS [create program], D.crtd_user AS [create user], 
                      convert(date,D.lupd_datetime) AS [last update date], D.lupd_prog AS [last update program], 
                      D.lupd_user AS [last update user]
FROM         PJLABDET D WITH (nolock) LEFT OUTER JOIN
                      PJLABHDR H WITH (nolock) ON D.docnbr = H.docnbr LEFT OUTER JOIN
                      PJEMPLOY E WITH (nolock) ON H.employee = E.employee LEFT OUTER JOIN
                      PJPROJ P WITH (nolock) ON D.project = P.project

