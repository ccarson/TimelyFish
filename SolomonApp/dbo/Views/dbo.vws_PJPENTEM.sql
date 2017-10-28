CREATE VIEW vws_PJPENTEM AS

  SELECT p.Actual_amt, p.Actual_units, p.Budget_amt, p.Budget_units, p.Comment, 
         p.crtd_datetime, p.crtd_prog, p.crtd_user, p.Date_start, p.Date_end, 
         p.Employee, p.lupd_datetime, p.lupd_prog, p.lupd_user, p.MSPSync, 
         p.noteid, p.Pjt_entity, 
         p.ProjCury_Actual_amt, p.ProjCury_Budget_amt , p.ProjCury_Revadj_amt, 
         p.ProjCury_Revenue_amt, p.ProjCuryEffDate, p.ProjCuryId, 
         p.ProjCuryMultiDiv, p.ProjCuryRate, p.ProjCuryRateType,
         p.Project, p.Revadj_amt, p.Revenue_amt, 
         p.SubTask_Name, p.SubTask_UID, p.Tk_id01, p.Tk_id02, p.Tk_id03, 
         p.Tk_id04, p.Tk_id05, p.Tk_id06, p.Tk_id07, p.Tk_id08, 
         p.Tk_id09, p.Tk_id10, p.User1, p.User2, p.User3, 
         p.User4, p.tstamp, j.CpnyId,j.manager1,j.manager2
    FROM PJPENTEM p JOIN PJProj j
                      ON p.Project = j.project
