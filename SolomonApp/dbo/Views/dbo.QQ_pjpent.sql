
CREATE VIEW [QQ_pjpent]
AS
SELECT     P.project, PJPROJ.project_desc AS [project description], P.pjt_entity AS task, 
                      P.pjt_entity_desc AS [task description], pjproj.CpnyId AS [company], P.contract_type AS [contract type], PJPROJ.customer, CASE WHEN CHARINDEX('~', 
                      NAME) > 0 THEN CONVERT(CHAR(30), LTRIM(SUBSTRING(NAME, 1, CHARINDEX('~', NAME) - 1)) + ', ' + LTRIM(RTRIM(SUBSTRING(NAME, 
                      CHARINDEX('~', NAME) + 1, 30)))) ELSE NAME END AS [customer name], PJPROJ.contract, P.manager1 AS [task manager], 
                      PJPROJ.manager1 AS [project manager], PJPROJ.manager2 AS [business manager], convert(date,P.start_date) AS [start date], 
                      convert(date,P.end_date) AS [end date], P.labor_class_cd AS [labor class], P.status_pa AS [task status], 
                      P.MSPInterface AS [MSP interface], P.fips_num AS [tax code 1], P.pe_id35 AS [tax code 2], 
                      P.pe_id36 AS [tax code 3], P.pe_id01 AS [G/L subaccount], P.pe_id03 AS [earnings type], 
                      P.status_08 AS [allocate flag], X.ENTERED_PC AS [entered % complete], 
                      convert(date,X.REVISION_DATE) AS [%  complete revision date], X.fee_percent AS [fee percent], 
                      X.PE_ID11 AS [customer for split bill], X.PE_ID12 AS [unit of measure], X.PE_ID13 AS [work location], 
                      X.PE_ID14 AS [worker comp code], X.PE_ID15 AS [bill group], X.PE_ID17 AS [field % complete], 
                      convert(date,X.PE_ID18) AS [field % complete revision date], X.PE_ID20 AS [revenue recog flag], 
                      X.PE_ID23 AS [labor G/L account], X.PE_ID24 AS [revenue G/L account], P.pe_id40 AS [mgr review flag], 
                      P.status_ap, P.status_ar, P.status_gl, P.status_in, P.status_lb, P.status_po, 
                      P.pe_id02, P.pe_id04, P.pe_id05, P.pe_id06, P.pe_id07, convert(date,P.pe_id08) AS [pe_id08], 
                      convert(date,P.pe_id09) AS [pe_id09], P.pe_id10, P.pe_id31, P.pe_id32, P.pe_id33, P.pe_id34, 
                      P.pe_id37, P.pe_id38, convert(date,P.pe_id39) AS [pe_id39], P.user1, P.user2, P.user3, P.user4, 
                      X.PE_ID16, convert(date,X.PE_ID19) AS [pe_id19], X.PE_ID21, X.PE_ID22, X.PE_ID25, 
                      X.PE_ID26, X.PE_ID27, convert(date,X.PE_ID28) AS [pe_id28], convert(date,X.PE_ID29) AS [pe_id29], X.PE_ID30, 
                      convert(date,P.crtd_datetime) AS [create date], P.crtd_prog AS [create program], P.crtd_user AS [create user], 
                      convert(date,P.lupd_datetime) AS [last update date], P.lupd_prog AS [last update program], P.lupd_user AS [last update user]
FROM         PJPENT P WITH (nolock) LEFT OUTER JOIN
                      PJPENTEX X WITH (nolock) ON P.pjt_entity = X.PJT_ENTITY AND P.project = X.PROJECT LEFT OUTER JOIN
                      PJPROJ WITH (nolock) ON P.project = PJPROJ.project LEFT OUTER JOIN
                      Customer WITH (nolock) ON PJPROJ.customer = Customer.CustId
                      

