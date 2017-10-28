
CREATE VIEW [QQ_pjacct]
AS
SELECT     P.acct AS [account category], P.acct_desc AS description, PJ_Account.gl_acct AS [G/L account], 
                      P.acct_status AS status, P.acct_type AS [account type], P.acct_group_cd AS [account group], 
                      PJ_Account.units_sw AS [unit required flag], PJ_Account.employ_sw AS [employee required flag], P.id4_sw AS [MSP flag], 
                      P.id1_sw AS [budgeting switch], P.id2_sw AS [budget template switch], P.id3_sw AS [account class for rev rec], 
                      P.id5_sw AS [transaction class], P.ca_id03 AS [tax category ID], substring(P.ca_id01, 7, 6) AS [ptd indirect group], 
                      left(P.ca_id01, 6) AS [ytd indirect group], P.ca_id06 AS [target rate], P.sort_num AS [sort order], P.ca_id02, 
                      P.ca_id04, P.ca_id05, P.ca_id07, convert(date,P.ca_id08) AS [ca_id08], convert(date,P.ca_id09) AS [ca_id09], P.ca_id10, 
                      P.ca_id16, P.ca_id17, P.ca_id18, P.ca_id19, P.ca_id20, P.user1, P.user2, P.user3, 
                      P.user4, convert(date,P.crtd_datetime) AS [create date], P.crtd_prog AS [create program], P.crtd_user AS [create user], 
                      convert(date,P.lupd_datetime) AS [last update date], P.lupd_prog AS [last update program], P.lupd_user AS [last update user]
FROM         PJACCT P WITH (nolock) LEFT OUTER JOIN
                      PJ_Account WITH (nolock) ON P.acct = PJ_Account.acct
                    
