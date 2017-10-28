
CREATE VIEW [QQ_pjemploy]
AS
SELECT     E.employee AS [resource ID], CASE WHEN CHARINDEX('~', E.EMP_NAME) > 0 THEN CONVERT(CHAR(30), 
                      LTRIM(SUBSTRING(E.EMP_NAME, 1, CHARINDEX('~', E.EMP_NAME) - 1)) 
                      + ', ' + LTRIM(RTRIM(SUBSTRING(E.EMP_NAME, CHARINDEX('~', E.EMP_NAME) + 1, 30)))) 
                      ELSE E.EMP_NAME END AS [resource name], E.emp_status AS status, E.manager1 AS supervisor, 
                      CASE WHEN CHARINDEX('~', PJEMPLOY_1.EMP_NAME) > 0 THEN CONVERT(CHAR(30), LTRIM(SUBSTRING(PJEMPLOY_1.EMP_NAME, 1, 
                      CHARINDEX('~', PJEMPLOY_1.EMP_NAME) - 1)) + ', ' + LTRIM(RTRIM(SUBSTRING(PJEMPLOY_1.EMP_NAME, CHARINDEX('~', 
                      PJEMPLOY_1.EMP_NAME) + 1, 30)))) ELSE PJEMPLOY_1.EMP_NAME END AS [supervisor name], E.manager2 AS manager, 
                      CASE WHEN CHARINDEX('~', PJEMPLOY_2.EMP_NAME) > 0 THEN CONVERT(CHAR(30), LTRIM(SUBSTRING(PJEMPLOY_2.EMP_NAME, 1, 
                      CHARINDEX('~', PJEMPLOY_2.EMP_NAME) - 1)) + ', ' + LTRIM(RTRIM(SUBSTRING(PJEMPLOY_2.EMP_NAME, CHARINDEX('~', 
                      PJEMPLOY_2.EMP_NAME) + 1, 30)))) ELSE PJEMPLOY_2.EMP_NAME END AS [manager name], E.CpnyId AS company, 
                      E.gl_subacct AS [G/L subaccount], convert(date,E.date_hired) AS [date hired], convert(date,E.date_terminated) AS [date terminated], 
                      E.emp_type_cd AS [employee type], E.Subcontractor AS [subcontractor flag], E.placeholder AS [generic flag], 
                      E.MSPType AS [non-person flag], E.MSPInterface AS [integrated with MSP], 
                      E.stdday AS [hours worked per day], E.Stdweek AS [hours worked per week], E.em_id21 AS location, 
                      E.user_id AS [SL user ID], E.em_id01 AS [vendor ID], E.em_id03 AS [email name], 
                      E.exp_approval_max AS [max approval amt], E.em_id02, E.em_id04, E.em_id05, 
                      E.em_id06 AS [commun mail flag], E.em_id07 AS [advance balance], convert(date,E.em_id08) AS [last active month], 
                      convert(date,E.em_id09) AS [em_id09], E.em_id10, E.em_id11 AS [labor revenue acct], E.em_id12, 
                      E.em_id13 AS [PRP category], E.em_id14 AS [G/L cost account], E.em_id15, E.em_id16, 
                      E.em_id17 AS [BP security flag], E.em_id18 AS [PRP cost rate], convert(date,E.em_id19) AS [em_id19], 
                      E.em_id20 AS [PRP rate source], E.em_id22 AS [skill 1], E.em_id23 AS [skill 2], 
                      E.em_id24 AS [level], E.em_id25 AS [license-certification], E.user1, E.user2, 
                      E.user3, E.user4, convert(date,E.crtd_datetime) AS [create date], E.crtd_prog AS [create program], 
                      E.crtd_user AS [create user], convert(date,E.lupd_datetime) AS [last update date], E.lupd_prog AS [last update program], 
                      E.lupd_user AS [last update user]
FROM         PJEMPLOY E WITH (nolock) LEFT OUTER JOIN
                      PJEMPLOY AS PJEMPLOY_1 WITH (nolock) ON E.manager1 = PJEMPLOY_1.employee LEFT OUTER JOIN
                      PJEMPLOY AS PJEMPLOY_2 WITH (nolock) ON E.manager2 = PJEMPLOY_2.employee

