CREATE VIEW [dbo].[vws_PJPENTEMPLN] AS

  SELECT p.Crtd_Datetime, p.Crtd_Prog, p.Crtd_User, p.Datetime_End, p.Datetime_Start, 
         p.Employee, p.[Hours], p.Lupd_Datetime, p.Lupd_Prog, p.Lupd_User, p.Noteid, 
         p.Period, p.Pjt_entity, p.Pl_id01, p.Pl_id02, p.Pl_id03, p.Pl_id04, p.Pl_id05,
         p.Pl_id06, p.Pl_id07, p.Pl_id08, p.Pl_id09, p.Pl_id10, p.Project,
         p.S4Future01, p.S4Future02, p.S4Future03, p.S4Future04, p.S4Future05, p.S4Future06,
         p.S4Future07, p.S4Future08, p.S4Future09, p.S4Future10, p.S4Future11, p.S4Future12,
         p.Status, p.Timeslot,
         p.User1, p.User2, p.User3, p.User4, p.User5, p.User6, p.User7, p.User8,
         p.tstamp, j.CpnyId, j.manager1, j.manager2
    FROM PJPENTEMPLN p JOIN PJProj j
                      ON p.Project = j.project

