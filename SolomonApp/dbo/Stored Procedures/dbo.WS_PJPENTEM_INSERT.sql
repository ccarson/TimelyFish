CREATE PROCEDURE WS_PJPENTEM_INSERT
@Actual_amt float, @Actual_units float, @Budget_amt float, @Budget_units float, @Comment char(50), @crtd_datetime smalldatetime, 
@crtd_prog char(8), @crtd_user char(10), @Date_start smalldatetime, @Date_end smalldatetime, @Employee char(10), 
@lupd_datetime smalldatetime, @lupd_prog char(8), @lupd_user char(10), @MSPSync char(1), @noteid int, @Pjt_entity char(32), 
@ProjCury_Actual_amt float, @ProjCury_Budget_amt float, @ProjCury_Revadj_amt float, @ProjCury_Revenue_amt float, @ProjCuryEffDate smalldatetime,
@ProjCuryId char(4), @ProjCuryMultiDiv char(1), @ProjCuryRate float, @ProjCuryRateType char(6),
@Project char(16), @Revadj_amt float, @Revenue_amt float, @SubTask_Name char(50), @SubTask_UID int, @Tk_id01 char(30), @Tk_id02 char(30), 
@Tk_id03 char(16), @Tk_id04 char(16), @Tk_id05 char(4), @Tk_id06 float, @Tk_id07 float, @Tk_id08 smalldatetime, @Tk_id09 smalldatetime, 
@Tk_id10 int, @User1 char(30), @User2 char(30), @User3 float, @User4 float
AS
BEGIN
INSERT INTO [PJPENTEM]
([Actual_amt], [Actual_units], [Budget_amt], [Budget_units], [Comment], [crtd_datetime], [crtd_prog], [crtd_user], [Date_start], 
[Date_end], [Employee], [lupd_datetime], [lupd_prog], [lupd_user], [MSPSync], [noteid], [Pjt_entity], 
[ProjCury_Actual_amt], [ProjCury_Budget_amt], [ProjCury_Revadj_amt], [ProjCury_Revenue_amt], [ProjCuryEffDate],
[ProjCuryId], [ProjCuryMultiDiv], [ProjCuryRate], [ProjCuryRateType],
[Project], [Revadj_amt], 
[Revenue_amt], [SubTask_Name], [SubTask_UID], [Tk_id01], [Tk_id02], [Tk_id03], [Tk_id04], [Tk_id05], [Tk_id06], [Tk_id07], [Tk_id08], 
[Tk_id09], [Tk_id10], [User1], [User2], [User3], [User4])
VALUES
(@Actual_amt, @Actual_units, @Budget_amt, @Budget_units, @Comment, @crtd_datetime, @crtd_prog, @crtd_user, @Date_start, @Date_end, 
@Employee, @lupd_datetime, @lupd_prog, @lupd_user, @MSPSync, @noteid, @Pjt_entity, 
@ProjCury_Actual_amt, @ProjCury_Budget_amt, @ProjCury_Revadj_amt, @ProjCury_Revenue_amt, @ProjCuryEffDate,
@ProjCuryId, @ProjCuryMultiDiv, @ProjCuryRate, @ProjCuryRateType,
@Project, @Revadj_amt, @Revenue_amt, @SubTask_Name, 
@SubTask_UID, @Tk_id01, @Tk_id02, @Tk_id03, @Tk_id04, @Tk_id05, @Tk_id06, @Tk_id07, @Tk_id08, @Tk_id09, @Tk_id10, @User1, @User2, 
@User3, @User4);
END
