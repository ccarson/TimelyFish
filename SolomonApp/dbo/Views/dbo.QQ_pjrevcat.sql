
CREATE VIEW [QQ_pjrevcat]
AS
SELECT     RC.project, P.project_desc AS [project description], RC.RevId AS [revision ID], RC.pjt_entity AS task, 
                      RC.Acct AS [account category], A.acct_type AS [account type], RC.Amount AS amount, RC.Units AS units, 
                      RH.status AS [revision status], RH.update_type AS [update type (O=Orig, E=EAC, F=FAC, A=O+E, B=O+E+F)], 
                      RH.RevisionType AS [revision type], RH.Revision_Desc AS [revision description], 
                      convert(date,RH.Post_Date) AS [approval date], RH.Post_Period AS [period posted to], RH.approver, 
                      RH.Preparer AS preparer, RH.Change_Order_Num AS [change order number], convert(date,RH.start_date) AS [project start date], 
                      convert(date,RH.end_date) AS [project end date], P.manager1 AS [project manager], P.status_pa AS [project status], 
                      P.budget_type AS [project budget type], P.CpnyId AS [project company], RC.rc_id01, RC.rc_id02, 
                      RC.rc_id03, RC.rc_id04, RC.rc_id05, RC.rc_id06, RC.rc_id07, convert(date,RC.rc_id08) AS [rc_id08], 
                      convert(date,RC.rc_id09) AS [rc_id09], RC.rc_id10, RC.user1, RC.user2, RC.user3, RC.user4, 
                      RC.User5, RC.User6, convert(date,RC.User7) AS [User7], convert(date,RC.User8) AS [User8], convert(date,RC.crtd_datetime) AS [create date], 
                      RC.crtd_prog AS [create program], RC.crtd_user AS [create user], convert(date,RC.lupd_datetime) AS [last update date], 
                      RC.lupd_prog AS [last update program], RC.lupd_user AS [last update user]
FROM         PJREVCAT RC WITH (nolock) INNER JOIN
                      PJREVHDR RH WITH (nolock) ON RC.project = RH.Project AND RC.RevId = RH.RevId INNER JOIN
                      PJPROJ P WITH (nolock) ON RC.project = P.project INNER JOIN
                      PJACCT A WITH (nolock) ON RC.Acct = A.acct

